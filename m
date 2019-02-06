Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28AA6C282CB
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 00:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BCD2184E
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 00:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfBFA4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:56:43 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40698 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfBFA4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Feb 2019 19:56:43 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.91 #2 (Red Hat Linux))
        id 1grBW2-0005wO-MZ; Wed, 06 Feb 2019 00:56:38 +0000
Date:   Wed, 6 Feb 2019 00:56:38 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Jann Horn <jannh@google.com>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/18] io_uring: add file set registration
Message-ID: <20190206005638.GU2217@ZenIV.linux.org.uk>
References: <20190129192702.3605-1-axboe@kernel.dk>
 <20190129192702.3605-14-axboe@kernel.dk>
 <CAG48ez2kLWUEambWesQQaeVn_u=PtjuMeDUc49yamhYspfd7Sg@mail.gmail.com>
 <20190204025612.GR2217@ZenIV.linux.org.uk>
 <785c6db4-095e-65b0-ded5-72b41af5174e@kernel.dk>
 <2b2137ed-8107-f7b6-f0ca-202dcfb87c97@kernel.dk>
 <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40b27e78-9ee8-1395-feb3-a73aac87c9a7@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 05, 2019 at 12:08:25PM -0700, Jens Axboe wrote:
> Proof is in the pudding, here's the main commit introducing io_uring
> and now wiring it up to the AF_UNIX garbage collection:
> 
> http://git.kernel.dk/cgit/linux-block/commit/?h=io_uring&id=158e6f42b67d0abe9ee84886b96ca8c4b3d3dfd5
> 
> How does that look?

In a word - wrong.  Some theory: garbage collector assumes that there is
a subset of file references such that
	* for all files with such references there's an associated unix_sock.
	* all such references are stored in SCM_RIGHTS datagrams that can be
found by the garbage collector (currently: for data-bearing AF_UNIX sockets -
queued SCM_RIGHTS datagrams, for listeners - SCM_RIGHTS datagrams sent via
yet-to-be-accepted connections).
	* there is an efficient way to count those references for given file
(->inflight of the corresponding unix_sock).
	* removal of those references would render the graph acyclic.
	* file can _NOT_ be subject to syscalls unless there are references
to it outside of that subset.

unix_inflight() moves a reference into the subset
unix_notinflight() moves a reference out of the subset
activity that might add such references ought to call wait_for_unix_gc() first
(basically, to stall the massive insertions when gc is running).

Note that unix_gc() does *NOT* work in terms of dropping file references -
the primary effect is locating the SCM_RIGHTS datagrams that can be disposed
of and taking them out.  It simply won't do anything to your file references,
no matter what.  Add a printk into your ->release() and try to register io_uring
descriptor into itself, then close it.  And observe ->release() not being
called for that object.  Ever.

PS: The algorithm used by unix_gc() is basically this -

	grab unix_gc_lock (giving exclusion with unix_inflight/unix_notinflight
			   and stabilizing ->inflight counters)

	Candidates = {}
	for all unix_sock u such that u->inflight > 0
		if file corresponding to u has no other references
			Candidates += u

	/* everything else already is reachable; due to unix_gc_lock these
	   can't die or get syscall-visible references under us */
	Might_Die = Candidates

	/* invariant to maintain: for u in Candidates u->inflight will be equal
	   to the number of references from SCM_RIGHTS datagrams *except*
	   those immediately reachable from elements of Might_Die */

	for all u in Candidates
		for each file reference v in SCM_RIGHTS datagrams
					immediately reachable from u
			if v in Candidates
				v->inflight--

	To_Scan = ()	// stuff reachable from those must live
	for all u in Might_Die
		if u->inflight > 0
			queue u into To_Scan

	while To_Scan is non-empty
		u = dequeue(To_Scan)
		Might_Die -= u
		for each file reference v in SCM_RIGHTS datagrams
					immediately reachable from u
			if v in Candidates
				v->inflight++	// maintain the invariant
				if v in Might_Die
					queue v into To_Scan

	/* at that point nothing in Might_Die is reachable from the outside */

	/* restore the original values of ->inflight */
	for all u in Might_Die
		for each file reference v in SCM_RIGHTS datagrams
					immediately reachable from u
			if v in Candidates
				v->inflight++

	hitlist = ()
	for all u in Might_Die
		for each SCM_RIGHTS datagram D immediately reachable from u
			if D contains references to something in Candidates
				move D to hitlist
	/* all those datagrams would've never become reachable */

	drop unix_gc_lock

	discard all datagrams in hitlist.
