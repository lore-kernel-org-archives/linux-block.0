Return-Path: <SRS0=V/uB=YN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A8CA9EA9
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF472190F
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 10:14:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddE3dD6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfJTKO2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 06:14:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44786 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726063AbfJTKO2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571566466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LesbO839e3tnjUR1zN7tDDthZ2+qlDF+NaQ4SbDCDag=;
        b=ddE3dD6t976W57/IDQBGkybPUbzSU1tNGTgs/svcHOveT9C/GkpQ0bm9SCmo3y1cZVekvv
        /hQZDWtdzbn3KqJy8tfei4faVLLJFhCfiYcKsK8I8k4MOGoxkVJCBM8RLSoAWdSPWKlFhF
        xqWYGSCZXhUtpxjv7ZDFEzYGs8OKGi4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-IRak0tIiPpeqXX7fI-khJA-1; Sun, 20 Oct 2019 06:14:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAE6C2B7;
        Sun, 20 Oct 2019 10:14:20 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3A005C240;
        Sun, 20 Oct 2019 10:14:13 +0000 (UTC)
Date:   Sun, 20 Oct 2019 18:14:08 +0800
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
Message-ID: <20191020101404.GA5103@ming.t460p>
References: <20191014015043.25029-1-ming.lei@redhat.com>
 <d30420d7-74d9-4417-1bbe-8113848e74fa@huawei.com>
 <20191016120729.GB5515@ming.t460p>
 <9dbc14ab-65cd-f7ac-384c-2dbe03575ee7@huawei.com>
 <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
MIME-Version: 1.0
In-Reply-To: <55a84ea3-647d-0a76-596c-c6c6b2fc1b75@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: IRak0tIiPpeqXX7fI-khJA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 17, 2019 at 04:40:12PM +0100, John Garry wrote:
> On 16/10/2019 17:19, John Garry wrote:
> > On 16/10/2019 13:07, Ming Lei wrote:
> > > On Wed, Oct 16, 2019 at 09:58:27AM +0100, John Garry wrote:
> > > > On 14/10/2019 02:50, Ming Lei wrote:
> > > > > Hi,
> > > > >=20
> > > > > Thomas mentioned:
> > > > >     "
> > > > >      That was the constraint of managed interrupts from the very
> > > > > beginning:
> > > > >=20
> > > > >       The driver/subsystem has to quiesce the interrupt line and =
the
> > > > > associated
> > > > >       queue _before_ it gets shutdown in CPU unplug and not fiddl=
e
> > > > > with it
> > > > >       until it's restarted by the core when the CPU is plugged in
> > > > > again.
> > > > >     "
> > > > >=20
> > > > > But no drivers or blk-mq do that before one hctx becomes dead(all
> > > > > CPUs for one hctx are offline), and even it is worse, blk-mq stil=
ls
> > > > > tries
> > > > > to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead()=
.
> > > > >=20
> > > > > This patchset tries to address the issue by two stages:
> > > > >=20
> > > > > 1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE
> > > > >=20
> > > > > - mark the hctx as internal stopped, and drain all in-flight requ=
ests
> > > > > if the hctx is going to be dead.
> > > > >=20
> > > > > 2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx
> > > > > becomes dead
> > > > >=20
> > > > > - steal bios from the request, and resubmit them via
> > > > > generic_make_request(),
> > > > > then these IO will be mapped to other live hctx for dispatch
> > > > >=20
> > > > > Please comment & review, thanks!
> > > > >=20
> > > > > John, I don't add your tested-by tag since V3 have some changes,
> > > > > and I appreciate if you may run your test on V3.
> > > >=20
> > > > Hi Ming,
> > > >=20
> > > > So I got around to doing some testing. The good news is that issue
> > > > which we
> > > > were experiencing in v3 series seems to have has gone away - alot m=
ore
> > > > stable.
> > > >=20
> > > > However, unfortunately, I did notice some SCSI timeouts:
> > > >=20
> > > > 15508.615074] CPU2: shutdown
> > > > [15508.617778] psci: CPU2 killed.
> > > > [15508.651220] CPU1: shutdown
> > > > [15508.653924] psci: CPU1 killed.
> > > > [15518.406229] sas: Enter sas_scsi_recover_host busy: 63 failed: 63
> > > > Jobs: 1 (f=3D1): [R] [0.0% done] [0[15518.412239] sas: sas_scsi_fin=
d_task:
> > > > aborting task 0x00000000a7159744
> > > > KB/0KB/0KB /s] [0/0/0 iops] [eta [15518.421708] sas:
> > > > sas_eh_handle_sas_errors: task 0x00000000a7159744 is done
> > > > [15518.431266] sas: sas_scsi_find_task: aborting task 0x00000000d39=
731eb
> > > > [15518.442539] sas: sas_eh_handle_sas_errors: task 0x00000000d39731=
eb is
> > > > done
> > > > [15518.449407] sas: sas_scsi_find_task: aborting task 0x000000009f7=
7c9bd
> > > > [15518.455899] sas: sas_eh_handle_sas_errors: task 0x000000009f77c9=
bd is
> > > > done
> > > >=20
> > > > A couple of things to note:
> > > > - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for=
 when
> > > > inflights rqs !=3D0, and I don't see them for this timeout
> > > > - 0 datarate reported from fio
> > > >=20
> > > > I'll have a look...
> > >=20
> > > What is the output of the following command?
> > >=20
> > > (cd /sys/kernel/debug/block/$SAS_DISK && find . -type f -exec grep -a=
H
> > > . {} \;)
> > I assume that you want this run at about the time SCSI EH kicks in for
> > the timeout, right? If so, I need to find some simple sysfs entry to
> > tell me of this occurrence, to trigger the capture. Or add something. M=
y
> > script is pretty dump.
> >=20
> > BTW, I did notice that we the dump_stack in __blk_mq_run_hw_queue()
> > pretty soon before the problem happens - maybe a clue or maybe coincide=
nce.
> >=20
>=20
> I finally got to capture that debugfs dump at the point the SCSI IOs
> timeout, as attached. Let me know if any problem receiving it.
>=20
> Here's a kernel log snippet at that point (I added some print for the
> timeout):
>=20
> 609] psci: CPU6 killed.
> [  547.722217] CPU5: shutdown
> [  547.724926] psci: CPU5 killed.
> [  547.749951] irq_shutdown
> [  547.752701] IRQ 800: no longer affine to CPU4
> [  547.757265] CPU4: shutdown
> [  547.759971] psci: CPU4 killed.
> [  547.790348] CPU3: shutdown
> [  547.793052] psci: CPU3 killed.
> [  547.818330] CPU2: shutdown
> [  547.821033] psci: CPU2 killed.
> [  547.854285] CPU1: shutdown
> [  547.856989] psci: CPU1 killed.
> [  575.925307] scsi_timeout req=3D0xffff0023b0dd9c00 reserved=3D0
> [  575.930794] scsi_timeout req=3D0xffff0023b0df2700 reserved=3D0

From the debugfs log, 66 requests are dumped, and 63 of them has
been submitted to device, and the other 3 is in ->dispatch list
via requeue after timeout is handled.

You mentioned that:

" - I added some debug prints in blk_mq_hctx_drain_inflight_rqs() for when
 inflights rqs !=3D0, and I don't see them for this timeout"

There might be two reasons:

1) You are still testing a multiple reply-queue device? As I
mentioned last times, it is hard to map reply-queue into blk-mq
hctx correctly.

2) concurrent dispatch to device, which can be observed by the
following patch.

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 06081966549f..3590f6f947eb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -679,6 +679,8 @@ void blk_mq_start_request(struct request *rq)
 {
        struct request_queue *q =3D rq->q;

+       WARN_ON_ONCE(test_bit(BLK_MQ_S_INTERNAL_STOPPED, &rq->mq_hctx->stat=
e));
+
        trace_block_rq_issue(q, rq);

        if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {

However, I think it is hard to be 2#, since the current CPU is the last
CPU in hctx->cpu_mask.


Thanks,
Ming

