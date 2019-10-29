Return-Path: <SRS0=FPpm=YW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEE9CA9EC0
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 01:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3962221721
	for <linux-block@archiver.kernel.org>; Tue, 29 Oct 2019 01:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqKUACb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbfJ2Bu2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Oct 2019 21:50:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43303 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727364AbfJ2Bu2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Oct 2019 21:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572313827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVHONl7yjJBla4/AnLrbww4CmGj4mlbMPxZ9EJNJ4Qw=;
        b=VqKUACb3COQZgmJhPtZJ/GRa419TY3iiD7M3AyVy2iX7Q2aWjwLw8GyRqzprH8IPzUSoZV
        J6IYxRJjM6xES+wPZ0qX+A0ez6oR69roy3Qfza2sclZNZPNB+JN+pdorM1HaLUFxlwW8B+
        valeA3O+Euubxk5FlA0nZCh4Yoc6wI8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-PoOJTGUzN1ey9Pdm_IlwYw-1; Mon, 28 Oct 2019 21:50:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC6831005509;
        Tue, 29 Oct 2019 01:50:21 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3BAEB600C1;
        Tue, 29 Oct 2019 01:50:14 +0000 (UTC)
Date:   Tue, 29 Oct 2019 09:50:09 +0800
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
Message-ID: <20191029015009.GD22088@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <f1ba3d36-fef4-25c5-720c-deb5c5bd7a86@huawei.com>
 <20191028104238.GA14008@ming.t460p>
 <a5e25466-c4db-c254-be37-45a9ca85851c@huawei.com>
MIME-Version: 1.0
In-Reply-To: <a5e25466-c4db-c254-be37-45a9ca85851c@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: PoOJTGUzN1ey9Pdm_IlwYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 28, 2019 at 11:55:42AM +0000, John Garry wrote:
> > >=20
> > > For the SCSI commands which timeout, I notice that
> > > scsi_set_blocked(reason=3DSCSI_MLQUEUE_EH_RETRY) was called 30 second=
s
> > > earlier.
> > >=20
> > >   scsi_set_blocked+0x20/0xb8
> > >   __scsi_queue_insert+0x40/0x90
> > >   scsi_softirq_done+0x164/0x1c8
> > >   __blk_mq_complete_request_remote+0x18/0x20
> > >   flush_smp_call_function_queue+0xa8/0x150
> > >   generic_smp_call_function_single_interrupt+0x10/0x18
> > >   handle_IPI+0xec/0x1a8
> > >   arch_cpu_idle+0x10/0x18
> > >   do_idle+0x1d0/0x2b0
> > >   cpu_startup_entry+0x24/0x40
> > >   secondary_start_kernel+0x1b4/0x208
> >=20
> > Could you investigate a bit the reason why timeout is triggered?
>=20
> Yeah, it does seem a strange coincidence that the SCSI command even faile=
d
> and we have to retry, since these should be uncommon events. I'll check o=
n
> this LLDD error.
>=20
> >=20
> > Especially we suppose to drain all in-flight requests before the
> > last CPU of this hctx becomes offline, and it shouldn't be caused by
> > the hctx becoming dead, so still need you to confirm that all
> > in-flight requests are really drained in your test.
>=20
> ok
>=20
> Or is it still
> > possible to dispatch to LDD after BLK_MQ_S_INTERNAL_STOPPED is set?
>=20
> It shouldn't be. However it would seem that this IO had been dispatched t=
o
> the LLDD, the hctx dies, and then we attempt to requeue on that hctx.

But this patch does wait for completion of in-flight request before
shutdown the last CPU of this hctx.


Thanks,
Ming

