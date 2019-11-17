Return-Path: <SRS0=vxC1=ZJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4453C33C9A
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 04:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD9120869
	for <linux-block@archiver.kernel.org>; Sun, 17 Nov 2019 04:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQ0Yj3LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfKQEMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 23:12:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57871 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725839AbfKQEMx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 23:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573963972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5x1Akht5a1uogovRlgVYj+rZ+sQ5riNnKd295qdi94=;
        b=WQ0Yj3LIIBBl3OwWJE7UwK8OG0LuD3r48T0TcQeyrtlxbR5YMKLOQK9eIvsG7QdgtfcYhz
        VdDcTgmHc4XfSovJcBVhCHcpDF4ps3NauBNS3sZaXTttUDF45GYXBxxTFEZdeuaE6TKdmd
        UzZGbb2GoRUw6DiNGfpoYNryWJR4VO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-doqWw9rSM3yhDWgT29wYjg-1; Sat, 16 Nov 2019 23:12:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B7C921005500;
        Sun, 17 Nov 2019 04:12:46 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 48A7A60900;
        Sun, 17 Nov 2019 04:12:37 +0000 (UTC)
Date:   Sun, 17 Nov 2019 12:12:33 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH RFC 0/3] blk-mq/nvme: use blk_mq_alloc_request() for
 NVMe's connect request
Message-ID: <20191117041233.GA30615@ming.t460p>
References: <20191115104238.15107-1-ming.lei@redhat.com>
 <8f4402a0-967d-f12d-2f1a-949e1dda017c@grimberg.me>
 <20191116071754.GB18194@ming.t460p>
 <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
MIME-Version: 1.0
In-Reply-To: <4a39a98e-19bc-0a9a-3d92-ceab2c656037@acm.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: doqWw9rSM3yhDWgT29wYjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 16, 2019 at 05:24:05PM -0800, Bart Van Assche wrote:
> On 2019-11-15 23:17, Ming Lei wrote:
> > Now blk-mq takes a static queue mapping between CPU and hw queues, give=
n
> > CPU hotplug may happen any time, so the specified hw queue may become
> > inactive any time.
>=20
> Hi Ming,
>=20
> I can trigger a race between blk_mq_alloc_request_hctx() and
> CPU-hotplugging by running blktests. The patch below fixes that race
> on my setup. Does this patch also fix the race(s) that you ran into?

The following problem has been triggered in my regular test for years,
is it same with yours?

[ 2248.751675] nvme nvme1: creating 2 I/O queues.
[ 2248.752351] BUG: unable to handle page fault for address: 0000607d064434=
a8
[ 2248.753348] #PF: supervisor write access in kernel mode
[ 2248.754106] #PF: error_code(0x0002) - not-present page
[ 2248.754846] PGD 0 P4D 0
[ 2248.755230] Oops: 0002 [#1] PREEMPT SMP PTI
[ 2248.755838] CPU: 7 PID: 16293 Comm: kworker/u18:3 Not tainted 5.4.0-rc7_=
96b95eff4a59_master+ #1
[ 2248.757089] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-2=
0180724_192412-buildhw-07.phx2.fedoraproject.org-1.fc29 04/01/2014
[ 2248.758863] Workqueue: nvme-reset-wq nvme_loop_reset_ctrl_work [nvme_loo=
p]
[ 2248.759857] RIP: 0010:blk_mq_get_request+0x2a8/0x31c
[ 2248.760654] Code: c7 83 08 01 00 00 00 00 00 00 48 c7 83 10 01 00 00 00 =
00 00 00 48 8b 55 18 45 84 ed 74 0c 31 c0 41 81 e5 00 08 06 00 0f 95 c0 <48=
> ff 44 c2 68 c7 83 d4 00 00 00 01 00 00 00 f7 45 10 00 00 06 00
[ 2248.763375] RSP: 0018:ffffc900012dbc80 EFLAGS: 00010246
[ 2248.764130] RAX: 0000000000000000 RBX: ffff888170d70000 RCX: 00000000000=
00017
[ 2248.765156] RDX: 0000607d06443440 RSI: 0000020bb36c554e RDI: 0000020bb38=
37c3f
[ 2248.766034] RBP: ffffc900012dbcc0 R08: 00000000f461df07 R09: 00000000000=
000a8
[ 2248.767084] R10: ffffc900012dbe50 R11: 0000000000000002 R12: 00000000000=
00000
[ 2248.768109] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[ 2248.769134] FS:  0000000000000000(0000) GS:ffff88827bd80000(0000) knlGS:=
0000000000000000
[ 2248.770294] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2248.771125] CR2: 0000607d064434a8 CR3: 0000000272866001 CR4: 00000000007=
60ee0
[ 2248.772152] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2248.773179] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2248.774204] PKRU: 55555554
[ 2248.774603] Call Trace:
[ 2248.774983]  blk_mq_alloc_request_hctx+0xc5/0x10e
[ 2248.775674]  nvme_alloc_request+0x42/0x71
[ 2248.776263]  __nvme_submit_sync_cmd+0x49/0x1b2
[ 2248.776910]  nvmf_connect_io_queue+0x12c/0x195 [nvme_fabrics]
[ 2248.777663]  ? nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
[ 2248.778481]  nvme_loop_connect_io_queues+0x2f/0x54 [nvme_loop]
[ 2248.779325]  nvme_loop_reset_ctrl_work+0x62/0xd4 [nvme_loop]
[ 2248.780144]  process_one_work+0x1a8/0x2a1
[ 2248.780727]  ? process_scheduled_works+0x2c/0x2c
[ 2248.781398]  process_scheduled_works+0x27/0x2c
[ 2248.782046]  worker_thread+0x1b1/0x23f
[ 2248.782594]  kthread+0xf5/0xfa
[ 2248.783048]  ? kthread_unpark+0x62/0x62
[ 2248.783608]  ret_from_fork+0x35/0x40

>=20
> Thanks,
>=20
> Bart.
>=20
>=20
> Subject: [PATCH] blk-mq: Fix a race between blk_mq_alloc_request_hctx() a=
nd
>  CPU hot-plugging
>=20
> ---
>  block/blk-mq.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 20a71dcdc339..16057aa2307f 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -442,13 +442,15 @@ struct request *blk_mq_alloc_request_hctx(struct re=
quest_queue *q,
>  =09if (WARN_ON_ONCE(!(flags & BLK_MQ_REQ_NOWAIT)))
>  =09=09return ERR_PTR(-EINVAL);
>=20
> -=09if (hctx_idx >=3D q->nr_hw_queues)
> -=09=09return ERR_PTR(-EIO);
> -
>  =09ret =3D blk_queue_enter(q, flags);
>  =09if (ret)
>  =09=09return ERR_PTR(ret);
>=20
> +=09if (hctx_idx >=3D q->nr_hw_queues) {
> +=09=09blk_queue_exit(q);
> +=09=09return ERR_PTR(-EIO);
> +=09}
> +

Not sure how this patch can make a difference since blk_queue_enter()
never checks if hctx is active, the problem is that the hctx represented
by 'hctx_idx' becomes inactive when calling blk_mq_alloc_request_hctx()(
all CPUs of this hctx becomes offline).

The problem simply is in the following code:

        cpu =3D cpumask_first_and(alloc_data.hctx->cpumask, cpu_online_mask=
);
        alloc_data.ctx =3D __blk_mq_get_ctx(q, cpu);

        rq =3D blk_mq_get_request(q, NULL, &alloc_data);
        blk_queue_exit(q);

'cpu' becomes 'nr_cpu_ids', then kernel oops will be triggered in
blk_mq_get_request().


Thanks,
Ming

