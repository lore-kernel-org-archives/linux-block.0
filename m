Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314FFC43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A2C206BA
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 09:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHdQezA7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfKLJzc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Nov 2019 04:55:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27790 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbfKLJzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Nov 2019 04:55:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573552530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ptk0X5mXPNakPNdGPE08lMxmub/r7zP3b9BmHcPezI=;
        b=gHdQezA7MLoThpdEr4EoP5zU2WXnO/hN3JMaC7UpOkLlnn6svAMHytIrKe2tUjWWn/g+ra
        zT1hX10StsCrew+ZgZpmbmEPD+qngCVlaKAWFV7e2s7EtT7ApfZ7lz0vvohWE36mb1kju2
        FmAAojNowADkoZYE1My53dlyv1H3y2w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-GHDd0IR8NEuxrvBXYpR9MQ-1; Tue, 12 Nov 2019 04:55:29 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E9E4DB60;
        Tue, 12 Nov 2019 09:55:28 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 285EA62671;
        Tue, 12 Nov 2019 09:55:21 +0000 (UTC)
Date:   Tue, 12 Nov 2019 17:55:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Junichi Nomura <j-nomura@ce.jp.nec.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] block: check bi_size overflow before merge
Message-ID: <20191112095518.GB26804@ming.t460p>
References: <20191112071957.GA10061@jeru.linux.bs1.fc.nec.co.jp>
 <20191112084617.GA26804@ming.t460p>
 <56841826-f00a-0ff3-ecae-c0d4360fb232@suse.de>
MIME-Version: 1.0
In-Reply-To: <56841826-f00a-0ff3-ecae-c0d4360fb232@suse.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: GHDd0IR8NEuxrvBXYpR9MQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 12, 2019 at 10:03:18AM +0100, Hannes Reinecke wrote:
> On 11/12/19 9:46 AM, Ming Lei wrote:
> > On Tue, Nov 12, 2019 at 07:19:58AM +0000, Junichi Nomura wrote:
> >> __bio_try_merge_page() may merge a page to bio without bio_full() chec=
k
> >> and cause bi_size overflow.
> >>
> >> The overflow typically ends up with sd_init_command() warning on zero
> >> segment request with call trace like this:
> >>
> >>     ------------[ cut here ]------------
> >>     WARNING: CPU: 2 PID: 1986 at drivers/scsi/scsi_lib.c:1025 scsi_ini=
t_io+0x156/0x180
> >>     CPU: 2 PID: 1986 Comm: kworker/2:1H Kdump: loaded Not tainted 5.4.=
0-rc7 #1
> >>     Workqueue: kblockd blk_mq_run_work_fn
> >>     RIP: 0010:scsi_init_io+0x156/0x180
> >>     RSP: 0018:ffffa11487663bf0 EFLAGS: 00010246
> >>     RAX: 00000000002be0a0 RBX: ffff8e6e9ff30118 RCX: 0000000000000000
> >>     RDX: 00000000ffffffe1 RSI: 0000000000000000 RDI: ffff8e6e9ff30118
> >>     RBP: ffffa11487663c18 R08: ffffa11487663d28 R09: ffff8e6e9ff30150
> >>     R10: 0000000000000001 R11: 0000000000000000 R12: ffff8e6e9ff30000
> >>     R13: 0000000000000001 R14: ffff8e74a1cf1800 R15: ffff8e6e9ff30000
> >>     FS:  0000000000000000(0000) GS:ffff8e6ea7680000(0000) knlGS:000000=
0000000000
> >>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>     CR2: 00007fff18cf0fe8 CR3: 0000000659f0a001 CR4: 00000000001606e0
> >>     Call Trace:
> >>      sd_init_command+0x326/0xb40 [sd_mod]
> >>      scsi_queue_rq+0x502/0xaa0
> >>      ? blk_mq_get_driver_tag+0xe7/0x120
> >>      blk_mq_dispatch_rq_list+0x256/0x5a0
> >>      ? elv_rb_del+0x24/0x30
> >>      ? deadline_remove_request+0x7b/0xc0
> >>      blk_mq_do_dispatch_sched+0xa3/0x140
> >>      blk_mq_sched_dispatch_requests+0xfb/0x170
> >>      __blk_mq_run_hw_queue+0x81/0x130
> >>      blk_mq_run_work_fn+0x1b/0x20
> >>      process_one_work+0x179/0x390
> >>      worker_thread+0x4f/0x3e0
> >>      kthread+0x105/0x140
> >>      ? max_active_store+0x80/0x80
> >>      ? kthread_bind+0x20/0x20
> >>      ret_from_fork+0x35/0x40
> >>     ---[ end trace f9036abf5af4a4d3 ]---
> >>     blk_update_request: I/O error, dev sdd, sector 2875552 op 0x1:(WRI=
TE) flags 0x0 phys_seg 0 prio class 0
> >>     XFS (sdd1): writeback error on sector 2875552
> >>
> >> __bio_try_merge_page() should check the overflow before actually doing
> >> merge.
> >>
> >> Fixes: 07173c3ec276c ("block: enable multipage bvecs")
> >> Signed-off-by: Jun'ichi Nomura <j-nomura@ce.jp.nec.com>
> >> Cc: Ming Lei <ming.lei@redhat.com>
> >> Cc: Jens Axboe <axboe@kernel.dk>
> >>
> >> diff --git a/block/bio.c b/block/bio.c
> >> --- a/block/bio.c
> >> +++ b/block/bio.c
> >> @@ -751,7 +751,7 @@ bool __bio_try_merge_page(struct bio *bio, struct =
page *page,
> >>  =09if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
> >>  =09=09return false;
> >> =20
> >> -=09if (bio->bi_vcnt > 0) {
> >> +=09if (bio->bi_vcnt > 0 && !bio_full(bio, len)) {
> >>  =09=09struct bio_vec *bv =3D &bio->bi_io_vec[bio->bi_vcnt - 1];
> >> =20
> >>  =09=09if (page_is_mergeable(bv, page, len, off, same_page)) {
> >>
> >=20
> > Looks fine:
> >=20
> > Reviewed-by: Ming Lei <ming.lei@redhat.com>
> >=20
> Oh f**k.
> That is the bug I've been hunting for years now.

The bad commit is merged in Feb. 2019, just wondering why you have hunt
it for years? :-)

--
Ming

