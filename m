Return-Path: <SRS0=nCGH=T5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD99C28CC0
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 15:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F7023891
	for <linux-block@archiver.kernel.org>; Wed, 29 May 2019 15:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti65hIx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfE2Pd7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 May 2019 11:33:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36406 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfE2Pd7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 May 2019 11:33:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id s17so2125736wru.3;
        Wed, 29 May 2019 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zNy2VDR1+r1PdJdLbGiys+EFVvE0AtAmxW0yOhma1M=;
        b=Ti65hIx7CjQS8x1mlu2JcNDKZO30Ed/PSkkHQkoQ5Md7Kmo6IQvLmkf+eAeB5XYNIx
         RbjGebr6ApqGYJEvGKSdsAVvcyzgOdZ0brZQ5wDPlXfrfO/l8KInWKI2hro5AWDLzYn9
         LeK+WpEo7Uzu9d4NHPtGu1/a54Kl2QxgUGsoPATTuRhWLqOU51Zhb35wLGAEH9KBUmfM
         dpQhxav3QVkCuhCbVhqF0JcbedLxiEbAkLNjEYlZabBBkh2c/eJNGudRZ5iamJRas0W9
         x3th9u/fB5u23y9Ssi1P4wXodCgc0aQml/iwGsRwmvjEmSqou/BRdM1EAqK6FU1IqCTv
         08BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zNy2VDR1+r1PdJdLbGiys+EFVvE0AtAmxW0yOhma1M=;
        b=SIth043D1NbUVVag9/Dvoqa6ZPFBFuQEU02xbR1pi2aJDzPwjdI7sNOMnwb/kywqYZ
         iJlkL6ZOWVWsE7Jy8AgeKYzDMw/YdSLfp4XXIxvusrUOULQ+DgIZ9NWXmJZ1f6UczY6J
         DSqVeYc1xwD4IUpuxW0rk9Lm+/T8s/9117xoNlF4F6IG/1ucxEYU0trPTJTdWoOSTfdy
         30FsySxHfZ5pkbMPLWIkYZsUWAEb+BsZw15IE/zILBh2zogVf228EkMCuPr/qphwgZba
         b2QuLfB1/FAROBdw/2XQ4ekM+XZEko0s7hIQvH3B0wPHyWib+283I0wNbt2uKMeKhLOT
         Zmtw==
X-Gm-Message-State: APjAAAXdos/oF7cvkBFBKmXU2cgl3lXrxvIA1FWnWmWNgzhTc87Mto8s
        wO02uNolCsypnR+eFxj925DmogVme+obAATSKIQ=
X-Google-Smtp-Source: APXvYqw6halF5YyiSt667R9o8dvjyKE4cTpf85zxkedVu5eT9kRgklN/VufRffapVW1fnM+AEERxkNCDoE6BtNuN6GI=
X-Received: by 2002:a5d:68cd:: with SMTP id p13mr17472972wrw.0.1559144037132;
 Wed, 29 May 2019 08:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190527150207.11372-1-ming.lei@redhat.com> <20190527150207.11372-6-ming.lei@redhat.com>
 <45daceb4-fb88-a835-8cc6-cd4c4d7cf42d@huawei.com> <20190529022852.GA21398@ming.t460p>
 <20190529024200.GC21398@ming.t460p> <5bc07fd5-9d2b-bf9c-eb77-b8cebadb9150@huawei.com>
 <20190529101028.GA15496@ming.t460p>
In-Reply-To: <20190529101028.GA15496@ming.t460p>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 29 May 2019 23:33:44 +0800
Message-ID: <CACVXFVODeFDPHxWkdnY5CZoOJ0did4mi_ap-aXk0oo+Cp05aUQ@mail.gmail.com>
Subject: Re: [PATCH V2 5/5] blk-mq: Wait for for hctx inflight requests on CPU unplug
To:     Ming Lei <ming.lei@redhat.com>
Cc:     John Garry <john.garry@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 29, 2019 at 6:11 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, May 29, 2019 at 10:42:00AM +0100, John Garry wrote:
> > On 29/05/2019 03:42, Ming Lei wrote:
> > > On Wed, May 29, 2019 at 10:28:52AM +0800, Ming Lei wrote:
> > > > On Tue, May 28, 2019 at 05:50:40PM +0100, John Garry wrote:
> > > > > On 27/05/2019 16:02, Ming Lei wrote:
> > > > > > Managed interrupts can not migrate affinity when their CPUs are offline.
> > > > > > If the CPU is allowed to shutdown before they're returned, commands
> > > > > > dispatched to managed queues won't be able to complete through their
> > > > > > irq handlers.
> > > > > >
> > > > > > Wait in cpu hotplug handler until all inflight requests on the tags
> > > > > > are completed or timeout. Wait once for each tags, so we can save time
> > > > > > in case of shared tags.
> > > > > >
> > > > > > Based on the following patch from Keith, and use simple delay-spin
> > > > > > instead.
> > > > > >
> > > > > > https://lore.kernel.org/linux-block/20190405215920.27085-1-keith.busch@intel.com/
> > > > > >
> > > > > > Some SCSI devices may have single blk_mq hw queue and multiple private
> > > > > > completion queues, and wait until all requests on the private completion
> > > > > > queue are completed.
> > > > >
> > > > > Hi Ming,
> > > > >
> > > > > I'm a bit concerned that this approach won't work due to ordering: it seems
> > > > > that the IRQ would be shutdown prior to the CPU dead notification for the
> > > >
> > > > Managed IRQ shutdown is run in irq_migrate_all_off_this_cpu(), which is
> > > > called in the callback of takedown_cpu(). And the CPU dead notification
> > > > is always sent after that CPU becomes offline, see cpuhp_invoke_callback().
> > >
> > > Hammm, looks we both say same thing.
> > >
> > > Yeah, it is too late to drain requests in the cpu hotplug DEAD handler,
> > > maybe we can try to move managed IRQ shutdown after sending the dead
> > > notification.
> > >
> >
> > Even if the IRQ is shutdown later, all CPUs would still be dead, so none
> > available to receive the interrupt or do the work for draining the queue.
> >
> > > I need to think of it further.
> >
> > It would seem that we just need to be informed of CPU offlining earlier, and
> > plug the drain in there.
>
> Yes, looks blk-mq has to be notified before unplugging CPU for this
> issue.
>
> And we should be careful to handle the multiple reply queue case, given the queue
> shouldn't be stopped or quieseced because other reply queues are still active.
>
> The new CPUHP state for blk-mq should be invoked after the to-be-offline
> CPU is quiesced and before it becomes offline.

Hi John,

Thinking of this issue further, so far, one doable solution is to
expose reply queues
as blk-mq hw queues, as done by the following patchset:

https://lore.kernel.org/linux-block/20180205152035.15016-1-ming.lei@redhat.com/

In which global host-wide tags are shared for all blk-mq hw queues.

Also we can remove all the reply_map stuff in drivers, then solve the problem of
draining in-flight requests during unplugging CPU in a generic approach.

Last time, it was reported that the patchset causes performance regression,
which is actually caused by duplicated io accounting in
blk_mq_queue_tag_busy_iter(),
which should be fixed easily.

What do you think of this approach?

Thanks,
Ming Lei
