Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54C2C6783B
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A0E2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A0E2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbeLLA2B (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:28:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbeLLA2B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12F02309178B;
        Wed, 12 Dec 2018 00:28:01 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF67C19748;
        Wed, 12 Dec 2018 00:28:00 +0000 (UTC)
Date:   Tue, 11 Dec 2018 19:27:59 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: for-next hangs on test srp/012
Message-ID: <20181212002759.GC20445@redhat.com>
References: <1544569107.185366.391.camel@acm.org>
 <0688562b-7776-7efe-10dd-caf2a6a4f274@kernel.dk>
 <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACVXFVObwybJ1hmekS_bJ05zrOawoG33MQDVda+W1ATa+SqNCw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 12 Dec 2018 00:28:01 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 11 2018 at  7:19pm -0500,
Ming Lei <tom.leiming@gmail.com> wrote:

> On Wed, Dec 12, 2018 at 8:04 AM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 12/11/18 3:58 PM, Bart Van Assche wrote:
> > > Hi Jens,
> > >
> > > If I run the following subset of blktests:
> > >
> > >   while :; do ./check -q srp && ./check -q nvmeof-mp; done
> > >
> > > against today's for-next branch (commit dd2bf2df85a7) then after some
> > > time the following hang is reported:
> > >
> > > INFO: task fio:14869 blocked for more than 120 seconds.
> > >       Not tainted 4.20.0-rc6-dbg+ #1
> > > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > fio             D25272 14869  14195 0x00000000
> > > Call Trace:
> > >  __schedule+0x401/0xe50
> > >  schedule+0x4e/0xd0
> > >  io_schedule+0x21/0x50
> > >  blk_mq_get_tag+0x46d/0x640
> > >  blk_mq_get_request+0x7c0/0xa00
> > >  blk_mq_make_request+0x241/0xa70
> > >  generic_make_request+0x411/0x950
> > >  submit_bio+0x9b/0x250
> > >  blkdev_direct_IO+0x7fb/0x870
> > >  generic_file_direct_write+0x119/0x210
> > >  __generic_file_write_iter+0x11c/0x280
> > >  blkdev_write_iter+0x13c/0x220
> > >  aio_write+0x204/0x310
> > >  io_submit_one+0x9c6/0xe70
> > >  __x64_sys_io_submit+0x115/0x340
> > >  do_syscall_64+0x71/0x210
> > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > >
> > > When that hang occurs my list-pending-block-requests script does not show
> > > any pending requests:
> > >
> > > # list-pending-block-requests
> > > dm-0
> > > loop0
> > > loop1
> > > loop2
> > > loop3
> > > loop4
> > > loop5
> > > loop6
> > > loop7
> > > nullb0
> > > nullb1
> > > sda
> > > sdb
> > > sdc
> > > sdd
> > > vda
> > > vdb
> > >
> > > Enabling fail_if_no_path mode did not resolve the hang so I don't think
> > > that the root cause is in any of the dm drivers used in this test:
> > >
> > > # dmsetup ls | while read dm rest; do dmsetup message $dm 0 fail_if_no_path; done; dmsetup remove_all; dmsetup table
> > > 360014056e756c6c62300000000000000: 0 65536 multipath 0 1 alua 1 1 service-time 0 1 2 8:16 1 1
> > >
> > > The same test passes against kernel v4.20-rc6.
> >
> > What device is this being run on?
> 
> I saw this issue on usb storage too.
> 
> Seems it is introduced by commit ea86ea2cdced ("sbitmap: ammortize cost of
> clearing bits"). When the IO hang happens, .cleared is 2, and .busy is 0 on
> the sched_tag's sbitmap queue.

You saw this running the same tests as Bart?
