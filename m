Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7473BCA9EAE
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 10:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487AC214B2
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 10:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCZ2LY+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfJ2KF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Oct 2019 06:05:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727351AbfJ2KF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Oct 2019 06:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572343524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xycbJ7NBU8ypqpxpCnRitZXhzBJnbol7J3rweISRAKI=;
        b=SCZ2LY+2LodPqX6oHn4+MCu+kKn8PiBircAepwJDis+2lx57qwBHZYjM1BtAPXH5yIKUvG
        lbasdWvuzE7483yHu5z263yh0Pf0/7DxrB+7HVKsSzPEJObsMOmg7b5szsYrw605S3quSL
        WKZ4lNYzGfyDa1KuxrZHMdP3NXt0tKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-BnSkDrsAMBKiq6TUF-2TwQ-1; Tue, 29 Oct 2019 06:05:23 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 721FA5E6;
        Tue, 29 Oct 2019 10:05:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D1E5C1B2;
        Tue, 29 Oct 2019 10:05:14 +0000 (UTC)
Date:   Tue, 29 Oct 2019 18:05:09 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH V4 0/5] blk-mq: improvement on handling IO during CPU
 hotplug
Message-ID: <20191029100509.GC20854@ming.t460p>
References: <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
 <20191028104238.GA14008@ming.t460p>
 <a5e25466-c4db-c254-be37-45a9ca85851c@huawei.com>
 <20191029015009.GD22088@ming.t460p>
 <a5a7c039-ff1b-b898-884d-f415318ccb7f@huawei.com>
MIME-Version: 1.0
In-Reply-To: <a5a7c039-ff1b-b898-884d-f415318ccb7f@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: BnSkDrsAMBKiq6TUF-2TwQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Oct 29, 2019 at 09:22:26AM +0000, John Garry wrote:
> On 29/10/2019 01:50, Ming Lei wrote:
> > On Mon, Oct 28, 2019 at 11:55:42AM +0000, John Garry wrote:
> > > > >=20
> > > > > For the SCSI commands which timeout, I notice that
> > > > > scsi_set_blocked(reason=3DSCSI_MLQUEUE_EH_RETRY) was called 30 se=
conds
> > > > > earlier.
> > > > >=20
> > > > >    scsi_set_blocked+0x20/0xb8
> > > > >    __scsi_queue_insert+0x40/0x90
> > > > >    scsi_softirq_done+0x164/0x1c8
> > > > >    __blk_mq_complete_request_remote+0x18/0x20
> > > > >    flush_smp_call_function_queue+0xa8/0x150
> > > > >    generic_smp_call_function_single_interrupt+0x10/0x18
> > > > >    handle_IPI+0xec/0x1a8
> > > > >    arch_cpu_idle+0x10/0x18
> > > > >    do_idle+0x1d0/0x2b0
> > > > >    cpu_startup_entry+0x24/0x40
> > > > >    secondary_start_kernel+0x1b4/0x208
> > > >=20
> > > > Could you investigate a bit the reason why timeout is triggered?
> > >=20
> > > Yeah, it does seem a strange coincidence that the SCSI command even f=
ailed
> > > and we have to retry, since these should be uncommon events. I'll che=
ck on
> > > this LLDD error.
> > >=20
> > > >=20
> > > > Especially we suppose to drain all in-flight requests before the
> > > > last CPU of this hctx becomes offline, and it shouldn't be caused b=
y
> > > > the hctx becoming dead, so still need you to confirm that all
> > > > in-flight requests are really drained in your test.
> > >=20
> > > ok
> > >=20
> > > Or is it still
> > > > possible to dispatch to LDD after BLK_MQ_S_INTERNAL_STOPPED is set?
> > >=20
> > > It shouldn't be. However it would seem that this IO had been dispatch=
ed to
> > > the LLDD, the hctx dies, and then we attempt to requeue on that hctx.
> >=20
> > But this patch does wait for completion of in-flight request before
> > shutdown the last CPU of this hctx.
> >=20
>=20
> Hi Ming,
>=20
> It may actually be a request from a hctx which is not shut down which err=
ors
> and causes the time out. I'm still checking.

If that is the case, blk_mq_hctx_drain_inflight_rqs() will wait for
completion of this request.

The only chance it is missed is that the last CPU of this hctx becomes
offline just when this request stays in request list after it is
retried from EH.

>=20
> BTW, Can you let me know exactly where you want the debug for "Or
> blk_mq_hctx_next_cpu() may still run WORK_CPU_UNBOUND schedule after
> all CPUs are offline, could you add debug message in that branch?"

You can add the following debug message, then reproduce the issue and
see if the debug log is dumped.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 06081966549f..5a98a7b79c0d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1452,6 +1452,10 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx=
 *hctx)
 =09=09 */
 =09=09hctx->next_cpu =3D next_cpu;
 =09=09hctx->next_cpu_batch =3D 1;
+
+=09=09printk(KERN_WARNING "CPU %d, schedule from (dead) hctx %s\n",
+=09=09=09raw_smp_processor_id(),
+=09=09=09cpumask_empty(hctx->cpumask) ? "inactive": "active");
 =09=09return WORK_CPU_UNBOUND;
 =09}
=20

Thanks,
Ming

