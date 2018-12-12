Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A5C67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989B320873
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 02:34:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989B320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbeLLCeb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 21:34:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbeLLCea (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 21:34:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2B5A13082A2F;
        Wed, 12 Dec 2018 02:34:30 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE978611DB;
        Wed, 12 Dec 2018 02:34:25 +0000 (UTC)
Date:   Tue, 11 Dec 2018 21:34:24 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, sandeen@redhat.com,
        fstests@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: xfstests generic/347 was never correct [was: Re: dm: fix inflight IO
 check]
Message-ID: <20181212023424.GA21119@redhat.com>
References: <4fec4b01-35f9-8008-22ec-2ac8af58b854@kernel.dk>
 <20181211003204.GA14673@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211003204.GA14673@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Dec 2018 02:34:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Dec 10 2018 at  7:32pm -0500,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Mon, Dec 10 2018 at  5:45pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > After switching to percpu inflight counters, the inflight check
> > is totally buggy. It's perfectly valid for some counters to be
> > non-zero while having a total inflight IO count of 0, that's how
> > these kinds of counters work (inc on one CPU, dec on another).
> > Fix the md_in_flight() check to sum all counters before returning
> > a false positive, potentially.
> > 
> > While at it, remove the inflight read for IO completion. We don't
> > need it, just wake anyone that's waiting for the IO count to drop
> > to zero. The caller needs to re-check that value anyway when woken,
> > which it does.
> > 
> > Fixes: 6f75723190d8 ("dm: remove the pending IO accounting")
> > Reported-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> I'm seeing that device-mapper-test-suite's "resize_io" test doesn't
> pass.  Glad this resolves the xfstest issue but I think more work is
> needed, so I'll build any additional changes on this fix.

Turns out the device-mapper-test-suite 'resize_io' issue I was seeing is
just a long lingering race that just got much more likely on my newer
testbed.  This fixes what I was seeing:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.20&id=f6c367585d0d851349d3a9e607c43e5bea993fa1

But pivoting back to xfstests generic/347: that test was broken from the
start, if it ever _really_ worked it would've been a bug in dm-thinp.
And even after Jens' fix (above) the test still just times out after 60
secs while in out-of-data-space (OODS) mode and gives a false "Passed
all 1 tests".

generic/347 exhausting the thin-pool's data space and then issuing
"sync" will cause IO to hang for 60 secs unless, in parallel, another
process comes along and grows the thin-pool to have more data space.
But even if xfstests' _dmthin_grow function were to be issued in 
parallel with another process it'll fail because it uses
_dmthin_reload_table which "dmsetup suspend"s the thin device (that was
just used by XFS to fill the thin-pool) _without_ using the --noflush
flag for "dmsetup suspend".  So the thin device will wait forever for
its  outstanding IO to finish before generic/347's _dmthin_grow will be
able to resize the thin-pool.  Leading to deadlock.  Or until the 60
secs (dm_thin_pool.ko "no_space_timeout" modparam default) causes the
thin-pool to switch from OODS "queue IO" to OODS "error IO" mode:

# tail -f /var/log/messages &
# ./check generic/347
Dec 11 21:12:57 thegoat kernel: XFS (dm-1): Mounting V5 Filesystem
Dec 11 21:12:57 thegoat kernel: XFS (dm-1): Ending clean mount
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 thegoat 4.20.0-rc6.snitm+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/mapper/test-metadata
MOUNT_OPTIONS -- /dev/mapper/test-metadata /scratch

Dec 11 21:12:58 thegoat kernel: device-mapper: thin: 253:4: reached low water mark for data device: sending event.
Dec 11 21:12:58 thegoat kernel: device-mapper: thin: 253:4: switching pool to out-of-data-space (queue IO) mode
Dec 11 21:14:01 thegoat kernel: device-mapper: thin: 253:4: switching pool to out-of-data-space (error IO) mode
Dec 11 21:14:01 thegoat kernel: xfs_destroy_ioend: 136 callbacks suppressed
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1354752
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1358592
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1362432
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1366272
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1370112
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1373952
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1377792
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1381632
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1385472
Dec 11 21:14:01 thegoat kernel: XFS (dm-5): writeback error on sector 1389312
Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: switching pool to write mode
Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: growing the data device from 1000 to 1200 blocks
Dec 11 21:14:02 thegoat kernel: device-mapper: thin: 253:4: reached low water mark for data device: sending event.
Dec 11 21:14:02 thegoat kernel: XFS (dm-5): Unmounting Filesystem
 65s
Ran: generic/347
Passed all 1 tests

Dec 11 21:14:02 thegoat kernel: XFS (dm-1): Unmounting Filesystem

SO generic/347 needs to account for 2 things:
1) issue $XFS_IO_PROG IO in the background with other process(es)
2) in parallel, in main generic/347 shell, run _dmthin_grow but the
"thin" device must be suspended with dmsetup suspend --noflush

Eric Sandeen: can you or someone else xfstests inclined use this info to
fix generic/347 please?

Thanks,
Mike
