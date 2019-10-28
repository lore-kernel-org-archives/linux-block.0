Return-Path: <SRS0=tc1V=YV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732F2CA9EBC
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 10:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BBC4214D9
	for <linux-block@archiver.kernel.org>; Mon, 28 Oct 2019 10:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOnypPm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732920AbfJ1Km5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 06:42:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60992 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732891AbfJ1Km5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 06:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572259376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvInt6CQf5719IWHR2YQYLJEi4kZqbz9xN4X6Jtzh2E=;
        b=EOnypPm2gN04o9um2RtTpg8OzpoEYiSMgu0Smj5V2jF4mL2cKLzhX6jaAoQ5UBbN5ylggR
        zJqALXLW7ZCFcKYaEgZE1NJOBDz+wGbDjiPlIo8Acn1gUuXryfWudBxYkSlWpYjDDm6bqt
        M8KmERGaHYr9J2u1+6naiOg/6QQqnvc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-1EMdUd9_PBSEaD0WYgJNYA-1; Mon, 28 Oct 2019 06:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A37AE100551D;
        Mon, 28 Oct 2019 10:42:50 +0000 (UTC)
Received: from ming.t460p (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE0460E1C;
        Mon, 28 Oct 2019 10:42:43 +0000 (UTC)
Date:   Mon, 28 Oct 2019 18:42:38 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191028104238.GA14008@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
MIME-Version: 1.0
In-Reply-To: <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 1EMdUd9_PBSEaD0WYgJNYA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 25, 2019 at 05:33:35PM +0100, John Garry wrote:
> > > There might be two reasons:
> > >=20
> > > 1) You are still testing a multiple reply-queue device?
> >=20
> > As before, I am testing by exposing mutliple queues to the SCSI
> > midlayer. I had to make this change locally, as on mainline we still
> > only expose a single queue and use the internal reply queue when
> > enabling managed interrupts.
> >=20
> > As I
> > > mentioned last times, it is hard to map reply-queue into blk-mq
> > > hctx correctly.
> >=20
> > Here's my branch, if you want to check:
> >=20
> > https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4-m=
q-v4
> >=20
> > It's a bit messy (sorry), but you can see that the reply-queue in the
> > LLDD is removed in commit 087b95af374.
> >=20
> > I am now thinking of actually making this change to the LLDD in mainlin=
e
> > to avoid any doubt in future.
> >=20
> > >=20
> > > 2) concurrent dispatch to device, which can be observed by the
> > > following patch.
> > >=20
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 06081966549f..3590f6f947eb 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -679,6 +679,8 @@ void blk_mq_start_request(struct request *rq)
> > > =A0{
> > > =A0=A0=A0=A0=A0=A0=A0 struct request_queue *q =3D rq->q;
> > >=20
> > > +=A0=A0=A0=A0=A0=A0 WARN_ON_ONCE(test_bit(BLK_MQ_S_INTERNAL_STOPPED,
> > > &rq->mq_hctx->state));
> > > +
> > > =A0=A0=A0=A0=A0=A0=A0 trace_block_rq_issue(q, rq);
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0 if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)=
) {
> > >=20
> > > However, I think it is hard to be 2#, since the current CPU is the la=
st
> > > CPU in hctx->cpu_mask.
> > >=20
> >=20
> > I'll try it.
> >=20
>=20
> Hi Ming,
>=20
> I am looking at this issue again.
>=20
> I am using https://lore.kernel.org/linux-scsi/1571926881-75524-1-git-send=
-email-john.garry@huawei.com/T/#t
> with expose_mq_experimental set. I guess you're going to say that this
> series is wrong, but I think it's ok for this purpose.
>=20
> Forgetting that for a moment, maybe I have found an issue.
>=20
> For the SCSI commands which timeout, I notice that
> scsi_set_blocked(reason=3DSCSI_MLQUEUE_EH_RETRY) was called 30 seconds
> earlier.
>=20
>  scsi_set_blocked+0x20/0xb8
>  __scsi_queue_insert+0x40/0x90
>  scsi_softirq_done+0x164/0x1c8
>  __blk_mq_complete_request_remote+0x18/0x20
>  flush_smp_call_function_queue+0xa8/0x150
>  generic_smp_call_function_single_interrupt+0x10/0x18
>  handle_IPI+0xec/0x1a8
>  arch_cpu_idle+0x10/0x18
>  do_idle+0x1d0/0x2b0
>  cpu_startup_entry+0x24/0x40
>  secondary_start_kernel+0x1b4/0x208

Could you investigate a bit the reason why timeout is triggered?

Especially we suppose to drain all in-flight requests before the
last CPU of this hctx becomes offline, and it shouldn't be caused by
the hctx becoming dead, so still need you to confirm that all
in-flight requests are really drained in your test. Or is it still
possible to dispatch to LDD after BLK_MQ_S_INTERNAL_STOPPED is set?

In theory, it shouldn't be possible, given we drain in-flight request
on the last CPU of this hctx.

Or blk_mq_hctx_next_cpu() may still run WORK_CPU_UNBOUND schedule after
all CPUs are offline, could you add debug message in that branch?

>=20
> I also notice that the __scsi_queue_insert() call, above, seems to retry =
to
> requeue the request on a dead rq in calling
> __scsi_queue_insert()->blk_mq_requeue_requet()->__blk_mq_requeue_request(=
),
> ***:
>=20
> [ 1185.235243] psci: CPU1 killed.
> [ 1185.238610] blk_mq_hctx_notify_dead cpu1 dead
> request_queue=3D0xffff0023ace24f60 (id=3D19)
> [ 1185.246530] blk_mq_hctx_notify_dead cpu1 dead
> request_queue=3D0xffff0023ace23f80 (id=3D17)
> [ 1185.254443] blk_mq_hctx_notify_dead cpu1 dead
> request_queue=3D0xffff0023ace22fa0 (id=3D15)
> [ 1185.262356] blk_mq_hctx_notify_dead cpu1 dead
> request_queue=3D0xffff0023ace21fc0 (id=3D13)***
> [ 1185.270271] blk_mq_hctx_notify_dead cpu1 dead
> request_queue=3D0xffff0023ace20fe0 (id=3D11)
> [ 1185.939451] scsi_softirq_done NEEDS_RETRY rq=3D0xffff0023b7416000
> [ 1185.945359] scsi_set_blocked reason=3D0x1057
> [ 1185.949444] __blk_mq_requeue_request request_queue=3D0xffff0023ace21fc=
0
> id=3D13 rq=3D0xffff0023b7416000***
>=20
> [...]
>=20
> [ 1214.903455] scsi_timeout req=3D0xffff0023add29000 reserved=3D0
> [ 1214.908946] scsi_timeout req=3D0xffff0023add29300 reserved=3D0
> [ 1214.914424] scsi_timeout req=3D0xffff0023add29600 reserved=3D0
> [ 1214.919909] scsi_timeout req=3D0xffff0023add29900 reserved=3D0
>=20
> I guess that we're retrying as the SCSI failed in the LLDD for some reaso=
n.
>=20
> So could this be the problem - we're attempting to requeue on a dead requ=
est
> queue?

If there are any in-flight requests originated from hctx which is going
to become dead, they should have been drained before CPU becomes offline.

Thanks,=20
Ming

