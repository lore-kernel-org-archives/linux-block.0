Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB58ACA9EAF
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 10:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7593E2089C
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 10:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HXMftxCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfJUKYX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:24:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726767AbfJUKYX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 06:24:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571653461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AASnd2C2OCMJ5oJFII409Vh3AnLFw6suxXNUc55YgxY=;
        b=HXMftxCFvR2owbsUOg6+TCaOgNxlc2capg+t+bbO+3N7+AtYQ39c5iyJMpxQASp4Rv2cTl
        pa6YcLffMEdp5sKVidpG6Vixul/Cn6C1HGekDeGITTFbuMToWGnyVJCvUzKvBJzbqiiip4
        es6WBvNEGZk53BafXFh3tLWyqBvFPvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-nthj6ocPMJyL95uZFLrRpg-1; Mon, 21 Oct 2019 06:24:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2921E1005500;
        Mon, 21 Oct 2019 10:24:15 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CD501001B20;
        Mon, 21 Oct 2019 10:24:07 +0000 (UTC)
Date:   Mon, 21 Oct 2019 18:24:02 +0800
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
Message-ID: <20191021102401.GB22635@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
 <20191020101404.GA5103@ming.t460p>
 <10aac76a-26bb-bcda-c6ea-b39ca66d6740@huawei.com>
 <20191021093448.GA22635@ming.t460p>
 <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
MIME-Version: 1.0
In-Reply-To: <9e6e86a5-7247-4648-9df9-61f81d2df413@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: nthj6ocPMJyL95uZFLrRpg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 10:47:05AM +0100, John Garry wrote:
> On 21/10/2019 10:34, Ming Lei wrote:
> > On Mon, Oct 21, 2019 at 10:19:18AM +0100, John Garry wrote:
> > > On 20/10/2019 11:14, Ming Lei wrote:
> > > > > > ght? If so, I need to find some simple sysfs entry to
> > > > > > > > tell me of this occurrence, to trigger the capture. Or add =
something. My
> > > > > > > > script is pretty dump.
> > > > > > > >=20
> > > > > > > > BTW, I did notice that we the dump_stack in __blk_mq_run_hw=
_queue()
> > > > > > > > pretty soon before the problem happens - maybe a clue or ma=
ybe coincidence.
> > > > > > > >=20
> > > > > >=20
> > > > > > I finally got to capture that debugfs dump at the point the SCS=
I IOs
> > > > > > timeout, as attached. Let me know if any problem receiving it.
> > > > > >=20
> > > > > > Here's a kernel log snippet at that point (I added some print f=
or the
> > > > > > timeout):
> > > > > >=20
> > > > > > 609] psci: CPU6 killed.
> > > > > > [  547.722217] CPU5: shutdown
> > > > > > [  547.724926] psci: CPU5 killed.
> > > > > > [  547.749951] irq_shutdown
> > > > > > [  547.752701] IRQ 800: no longer affine to CPU4
> > > > > > [  547.757265] CPU4: shutdown
> > > > > > [  547.759971] psci: CPU4 killed.
> > > > > > [  547.790348] CPU3: shutdown
> > > > > > [  547.793052] psci: CPU3 killed.
> > > > > > [  547.818330] CPU2: shutdown
> > > > > > [  547.821033] psci: CPU2 killed.
> > > > > > [  547.854285] CPU1: shutdown
> > > > > > [  547.856989] psci: CPU1 killed.
> > > > > > [  575.925307] scsi_timeout req=3D0xffff0023b0dd9c00 reserved=
=3D0
> > > > > > [  575.930794] scsi_timeout req=3D0xffff0023b0df2700 reserved=
=3D0
> > > > > From the debugfs log, 66 requests are dumped, and 63 of them has
> > > > been submitted to device, and the other 3 is in ->dispatch list
> > > > via requeue after timeout is handled.
> > > >=20
> > >=20
> > > Hi Ming,
> > >=20
> > > > You mentioned that:
> > > >=20
> > > > " - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() f=
or when
> > > >  inflights rqs !=3D0, and I don't see them for this timeout"
> > > >=20
> > > > There might be two reasons:
> > > >=20
> > > > 1) You are still testing a multiple reply-queue device?
> > >=20
> > > As before, I am testing by exposing mutliple queues to the SCSI midla=
yer. I
> > > had to make this change locally, as on mainline we still only expose =
a
> > > single queue and use the internal reply queue when enabling managed
> > > interrupts.
> > >=20
> > > As I
> > > > mentioned last times, it is hard to map reply-queue into blk-mq
> > > > hctx correctly.
> > >=20
> > > Here's my branch, if you want to check:
> > >=20
> > > https://github.com/hisilicon/kernel-dev/commits/private-topic-sas-5.4=
-mq-v4
> > >=20
> > > It's a bit messy (sorry), but you can see that the reply-queue in the=
 LLDD
> > > is removed in commit 087b95af374.
> > >=20
> > > I am now thinking of actually making this change to the LLDD in mainl=
ine to
> > > avoid any doubt in future.
> >=20
> > As I mentioned last time, you do share tags among all MQ queues on your=
 hardware
> > given your hardware is actually SQ HBA, so commit 087b95af374 is defini=
tely
> > wrong, isn't it?
> >=20
>=20
> Yes, we share tags among all queues, but we generate the tag - known as I=
PTT
> - in the LLDD now, as we can no longer use the request tag (as it is not
> unique per all queues):
>=20
> https://github.com/hisilicon/kernel-dev/commit/087b95af374be6965583c16730=
32fb33bc8127e8#diff-f5d8fff19bc539a7387af5230d4e5771R188
>=20
> As I said, the branch is messy and I did have to fix 087b95af374.

Firstly this way may waste lots of memory, especially the queue depth is
big, such as, hisilicon V3's queue depth is 4096.

Secondly, you have to deal with queue busy efficiently and correctly,
for example, your real hw tags(IPTT) can be used up easily, and how
will you handle these dispatched request?

Finally, you have to evaluate the performance effect, this is highly
related with how to deal with out-of-IPTT.

I'd suggest you to fix the stuff and post them out for review.

Thanks,
Ming

