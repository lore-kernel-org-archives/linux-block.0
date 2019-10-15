Return-Path: <SRS0=Qtc1=YI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6A2C10F14
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 14:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9104620640
	for <linux-block@archiver.kernel.org>; Tue, 15 Oct 2019 14:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732916AbfJOOug (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:50:36 -0400
Received: from gentwo.org ([3.19.106.255]:48154 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732736AbfJOOuf (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Oct 2019 10:50:35 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id EE7CD3F1C2; Tue, 15 Oct 2019 14:50:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id ED97C3E959;
        Tue, 15 Oct 2019 14:50:34 +0000 (UTC)
Date:   Tue, 15 Oct 2019 14:50:34 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Hannes Reinecke <hare@suse.de>
cc:     Matthew Wilcox <willy@infradead.org>,
        Naohiro Aota <naohiro.aota@wdc.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Project idea: Swap to zoned block devices
In-Reply-To: <d9919d4e-4487-c0e5-c483-cebb5b8a4fc8@suse.de>
Message-ID: <alpine.DEB.2.21.1910151449170.2977@www.lameter.com>
References: <20191015043827.160444-1-naohiro.aota@wdc.com> <20191015113548.GD32665@bombadil.infradead.org> <d9919d4e-4487-c0e5-c483-cebb5b8a4fc8@suse.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 15 Oct 2019, Hannes Reinecke wrote:

> On 10/15/19 1:35 PM, Matthew Wilcox wrote:
> > On Tue, Oct 15, 2019 at 01:38:27PM +0900, Naohiro Aota wrote:
> >> A zoned block device consists of a number of zones. Zones are
> >> either conventional and accepting random writes or sequential and
> >> requiring that writes be issued in LBA order from each zone write
> >> pointer position. For the write restriction, zoned block devices are
> >> not suitable for a swap device. Disallow swapon on them.
> >
> > That's unfortunate.  I wonder what it would take to make the swap code be
> > suitable for zoned devices.  It might even perform better on conventional
> > drives since swapout would be a large linear write.  Swapin would be a
> > fragmented, seeky set of reads, but this would seem like an excellent
> > university project.
> >
> The main problem I'm seeing is the eviction of pages from swap.
> While swapin is easy (as you can do random access on reads), evict pages
> from cache becomes extremely tricky as you can only delete entire zones.
> So how to we mark pages within zones as being stale?
> Or can we modify the swapin code to always swap in an entire zone and
> discard it immediately?

On swapout you would change the block number on the swap device to the
latest and increment it?

Mark the prio block number as unused and then at some convenient time scan
the map and see if you can somehow free up a zone?

