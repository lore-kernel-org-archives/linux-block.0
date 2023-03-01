Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C3CC64ED6
	for <linux-block@archiver.kernel.org>; Wed,  1 Mar 2023 04:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjCAEf5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Feb 2023 23:35:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCAEf4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2023 23:35:56 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E262E827;
        Tue, 28 Feb 2023 20:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1qllLySs/K2FAIUkeg+7LYst0u8+3BaJfRN7QCh55SY=; b=rigVAISJSL2T7VTZ/17rxRCh1k
        J50h177oGgnzulvADT4/34FyZA/Zqiv7hB4/u0fbO+4PtMrg/N5k0i+gvLRw8yvdvznjydj605GXf
        mb1U4Sty3y8m70uB25ZsDSaqHY8+i7W8SdxHvOXPsvv5dSb1MqRKvb9HNC3zTQ+NoNHHEHjM6hs0V
        eKY6dOnXeQv4XRvwY1vaHGBQ1bZ+Ax4Jyan+J4HQNSly1xqb68qPR7ROoX8liKAsjT9Pc0TFu5+GJ
        bUbFDgBN5Kbg/GfuRZiatrj+Elc9UWjo0+JuPihJaNSbwGDPHeDddrXcsv4Tu3grpqdaVGo4uis1u
        PuqAW6gw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXEBw-001NHV-4h; Wed, 01 Mar 2023 04:35:48 +0000
Date:   Wed, 1 Mar 2023 04:35:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <Y/7WJMNLjrQ+/+Vs@casper.infradead.org>
References: <Y/7L74P6jSWwOvWt@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/7L74P6jSWwOvWt@mit.edu>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Feb 28, 2023 at 10:52:15PM -0500, Theodore Ts'o wrote:
> For example, most cloud storage devices are doing read-ahead to try to
> anticipate read requests from the VM.  This can interfere with the
> read-ahead being done by the guest kernel.  So being able to tell
> cloud storage device whether a particular read request is stemming
> from a read-ahead or not.  At the moment, as Matthew Wilcox has
> pointed out, we currently use the read-ahead code path for synchronous
> buffered reads.  So plumbing this information so it can passed through
> multiple levels of the mm, fs, and block layers will probably be
> needed.

This shouldn't be _too_ painful.  For example, the NVMe driver already
does the right thing:

        if (req->cmd_flags & (REQ_FAILFAST_DEV | REQ_RAHEAD))
                control |= NVME_RW_LR;

        if (req->cmd_flags & REQ_RAHEAD)
                dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;

(LR is Limited Retry; FREQ_PREFETCH is "Speculative read. The command
is part of a prefetch operation")

The only problem is that the readahead code doesn't tell the filesystem
whether the request is sync or async.  This should be a simple matter
of adding a new 'bool async' to the readahead_control and then setting
REQ_RAHEAD based on that, rather than on whether the request came in
through readahead() or read_folio() (eg see mpage_readahead()).

Another thing to fix is that SCSI doesn't do anything with the REQ_RAHEAD
flag, so I presume T10 has some work to do (maybe they could borrow the
Access Frequency field from NVMe, since that was what the drive vendors
told us they wanted; maybe they changed their minds since).
