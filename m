Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BADC7EE25
	for <linux-block@archiver.kernel.org>; Thu,  8 Jun 2023 14:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjFHOrk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jun 2023 10:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjFHOri (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 10:47:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99041213C
        for <linux-block@vger.kernel.org>; Thu,  8 Jun 2023 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686235613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BzPWzeBSXLWcqJWUGgOyhtXDtzFvOKEEJL0THkxADz0=;
        b=JgLW/HOAzF84nCxyC+EFRaqiLLMGXiZLcaFDwd86HVezrTtOSk5dQ90fqufibNYozNfBfn
        dZ5DlHQWfkC1jL89arvTn9DFJjyeokyuSr3jFiDVIDgSqCBovdm0EaR1ffTP5k1H7z4qUN
        3k9nbh/lN7VG0BI1Y5pyct1J+Rj0w1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-_J739lxEOGGl01dN4K9mRw-1; Thu, 08 Jun 2023 10:46:52 -0400
X-MC-Unique: _J739lxEOGGl01dN4K9mRw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30ae7bd987dso311630f8f.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jun 2023 07:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686235611; x=1688827611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzPWzeBSXLWcqJWUGgOyhtXDtzFvOKEEJL0THkxADz0=;
        b=AjOonKgYCwPNssjPpo/ORv/1P4+NmYw9V9t0JAk97hVAF04ishQ5qnu2YMepai2pMs
         5AYytqgPvdvRVNdeGPhfU2MaEX92IMCx6fijGonF3RsG7axJ6hkEcRgfEB8xbJjZS2Of
         WdrmpHjNL0I2MgQr8XSOKoxH9LwL7mCiHI1ipPM0zGYmNIypX/pCMi8OB9fLvRoKaVcP
         jI4LkOErgSnuXW2mrn9Ql9Iu1534d7NHZvg9de1lDXGZyogbG62x4hgWMv49yzcprQNE
         OvVHOlo7MHR+D/K6vhLDfOxArhzizVj43+KKxYs7P9enFFg5I6jJFy6/a09HgHMnF0Nx
         /5qQ==
X-Gm-Message-State: AC+VfDwCIptAdzPKctDtYeSS8RC/fMo55eVyNG4MSPXP58QlKbV95oCZ
        lPdLh0/gcFAwtntRnzjChsvccoTl5L2SuiM4A6yxJJK4ya0E2YCTN/9wQDX4N8Va4UPDkOJDNBH
        WHr9TgvY0sxQYl2FALtFG/bk=
X-Received: by 2002:adf:fe04:0:b0:30e:59a2:42c0 with SMTP id n4-20020adffe04000000b0030e59a242c0mr5084594wrr.11.1686235610980;
        Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AaVaor0HUixD1BUg6Pn4MIEMgyGeZdhps2oVA1MXS+5jSz/cuObFR1X7VxjaAY/mioTCApA==
X-Received: by 2002:adf:fe04:0:b0:30e:59a2:42c0 with SMTP id n4-20020adffe04000000b0030e59a242c0mr5084582wrr.11.1686235610632;
        Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id q2-20020adffec2000000b0030632833e74sm1810260wrs.11.2023.06.08.07.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 07:46:50 -0700 (PDT)
Date:   Thu, 8 Jun 2023 10:46:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     "Roberts, Martin" <martin.roberts@intel.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: virtio-blk: support completion batching for the IRQ path -
 failure
Message-ID: <20230608104537-mutt-send-email-mst@kernel.org>
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 08, 2023 at 11:07:21PM +0900, Suwan Kim wrote:
> On Thu, Jun 8, 2023 at 7:16 PM Roberts, Martin <martin.roberts@intel.com> wrote:
> >
> > The rq_affinity change does not resolve the issue; just reduces its occurrence rate; I am still seeing hangs with it set to 2.
> >
> > Martin
> >
> >
> >
> > From: Roberts, Martin
> > Sent: Wednesday, June 7, 2023 3:46 PM
> > To: Suwan Kim <suwan.kim027@gmail.com>
> > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation.org>; linux-block@vger.kernel.org
> > Subject: RE: virtio-blk: support completion batching for the IRQ path - failure
> >
> >
> >
> > It is the change indicated that breaks it - changing the IRQ handling to batching.
> >
> >
> >
> >
> >
> >
> >
> > From reports such as,
> >
> > [PATCH 1/1] blk-mq: added case for cpu offline during send_ipi in rq_complete (kernel.org)
> https://lore.kernel.org/lkml/20220929033428.25948-1-mj0123.lee@samsung.com/T/
> >
> > [RFC] blk-mq: Don't IPI requests on PREEMPT_RT - Patchwork (linaro.org)
> https://patches.linaro.org/project/linux-rt-users/patch/20201023110400.bx3uzsb7xy5jtsea@linutronix.de/
> >
> >
> >
> > I’m thinking the issue has something to do with which CPU the IRQ is running on.
> >
> >
> >
> > So, I set,
> >
> > # echo 2 > /sys/block/vda/queue/rq_affinity
> >
> > # echo 2 > /sys/block/vdb/queue/rq_affinity
> >
> > …
> >
> > # echo 2 > /sys/block/vdp/queue/rq_affinity
> >
> >
> >
> >
> >
> > and the system (running 16 disks, 4 queues/disk) has not yet hung (running OK for several hours)…
> >
> >
> >
> > Martin
> >
> 
> Hi Martin,
> 
> Both codes (original code and your simple path) execute
> blk_mq_complete_send_ipi()
> at blk_mq_complete_request_remote(). So maybe missing request completion
> on other vCPU is not the cause...
> 
> The difference between the original code and your simple path is that
> the original code calls blk_mq_end_request_batch() at virtblk_done()
> to process request at block layer
> and your code calls blk_mq_end_request() at virtblk_done() to do same thing.
> 
> The original code :
> virtblk_handle_req() first collects all requests from virtqueue in while loop
> and pass it to blk_mq_end_request_batch() at once
> 
> Your simple path:
> virtblk_handle_req() get single request from virtqueue and pass it to
> blk_mq_end_request() and do it again in while loop until there in no request
> in virtqueue
> 
> 
> I think we need to focus on the difference between blk_mq_end_request()
> and blk_mq_end_request_batch()
> 
> Regards,
> Suwan Kim
> 

Yes but linux release is imminent and regressions are bad.
What do you suggest for now? If there's no better idea
I'll send a revert patch and we'll see in the next linux version.


> 
> 
> >
> >
> > -----Original Message-----
> > From: Suwan Kim <suwan.kim027@gmail.com>
> > Sent: Wednesday, June 7, 2023 3:21 PM
> > To: Roberts, Martin <martin.roberts@intel.com>
> > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation.org>; linux-block@vger.kernel.org
> > Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
> >
> >
> >
> > On Wed, Jun 7, 2023 at 6:14 PM Roberts, Martin <martin.roberts@intel.com> wrote:
> >
> > >
> >
> > > Re: virtio-blk: support completion batching for the IRQ path · torvalds/linux@07b679f · GitHub
> >
> > >
> >
> > > Signed-off-by: Suwan Kim suwan.kim027@gmail.com
> >
> > >
> >
> > > Signed-off-by: Michael S. Tsirkin mst@redhat.com
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > This change appears to have broken things…
> >
> > >
> >
> > > We now see applications hanging during disk accesses.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > multi-port virtio-blk device running in h/w (FPGA)
> >
> > >
> >
> > > Host running a simple ‘fio‘ test.
> >
> > >
> >
> > > [global]
> >
> > >
> >
> > > thread=1
> >
> > >
> >
> > > direct=1
> >
> > >
> >
> > > ioengine=libaio
> >
> > >
> >
> > > norandommap=1
> >
> > >
> >
> > > group_reporting=1
> >
> > >
> >
> > > bs=4K
> >
> > >
> >
> > > rw=read
> >
> > >
> >
> > > iodepth=128
> >
> > >
> >
> > > runtime=1
> >
> > >
> >
> > > numjobs=4
> >
> > >
> >
> > > time_based
> >
> > >
> >
> > > [job0]
> >
> > >
> >
> > > filename=/dev/vda
> >
> > >
> >
> > > [job1]
> >
> > >
> >
> > > filename=/dev/vdb
> >
> > >
> >
> > > [job2]
> >
> > >
> >
> > > filename=/dev/vdc
> >
> > >
> >
> > > ...
> >
> > >
> >
> > > [job15]
> >
> > >
> >
> > > filename=/dev/vdp
> >
> > >
> >
> > >
> >
> > >
> >
> > > i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
> >
> > >
> >
> > > This is repeatedly run in a loop.
> >
> > >
> >
> > >
> >
> > >
> >
> > > After a few, normally <10 seconds, fio hangs.
> >
> > >
> >
> > > With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
> >
> > >
> >
> > > Last message:
> >
> > >
> >
> > > fio-3.19
> >
> > >
> >
> > > Starting 8 threads
> >
> > >
> >
> > > Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
> >
> > >
> >
> > > I think this means at the end of the run 1 queue was left incomplete.
> >
> > >
> >
> > >
> >
> > >
> >
> > > ‘diskstats’ (run while fio is hung) shows no outstanding transactions.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > $ cat /proc/diskstats
> >
> > >
> >
> > > ...
> >
> > >
> >
> > > 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
> >
> > >
> >
> > > 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
> >
> > >
> >
> > > ...
> >
> > >
> >
> > >
> >
> > >
> >
> > > Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > PF= 0                         vq=0           1           2           3
> >
> > >
> >
> > > [a]request_count     -   839416590   813148916   105586179    84988123
> >
> > >
> >
> > > [b]completion1_count -   839416590   813148916   105586179    84988123
> >
> > >
> >
> > > [c]completion2_count -           0           0           0           0
> >
> > >
> >
> > >
> >
> > >
> >
> > > PF= 1                         vq=0           1           2           3
> >
> > >
> >
> > > [a]request_count     -   823335887   812516140   104582672    75856549
> >
> > >
> >
> > > [b]completion1_count -   823335887   812516140   104582672    75856549
> >
> > >
> >
> > > [c]completion2_count -           0           0           0           0
> >
> > >
> >
> > >
> >
> > >
> >
> > > i.e. the issue is after the virtio-blk driver.
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > This change was introduced in kernel 6.3.0.
> >
> > >
> >
> > > I am seeing this using 6.3.3.
> >
> > >
> >
> > > If I run with an earlier kernel (5.15), it does not occur.
> >
> > >
> >
> > > If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
> >
> > >
> >
> > > e.g.
> >
> > >
> >
> > > kernel 5.15 – this is OK
> >
> > >
> >
> > > virtio_blk.c,virtblk_done() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           blk_mq_complete_request(req);
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > > kernel 6.3.3 – this fails
> >
> > >
> >
> > > virtio_blk.c,virtblk_handle_req() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           if (!blk_mq_complete_request_remote(req)) {
> >
> > >
> >
> > >                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> >
> > >
> >
> > >                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
> >
> > >
> >
> > >                                    }
> >
> > >
> >
> > >                           }
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > > If I do, kernel 6.3.3 – this is OK
> >
> > >
> >
> > > virtio_blk.c,virtblk_handle_req() [irq handler]
> >
> > >
> >
> > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> >
> > >
> >
> > >                           if (!blk_mq_complete_request_remote(req)) {
> >
> > >
> >
> > >                                    virtblk_request_done(req); //force this here...
> >
> > >
> >
> > >                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> >
> > >
> >
> > >                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
> >
> > >
> >
> > >                                    }
> >
> > >
> >
> > >                           }
> >
> > >
> >
> > >                  }
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > >
> >
> > > Perhaps you might like to fix/test/revert this change…
> >
> > >
> >
> > > Martin
> >
> > >
> >
> > >
> >
> >
> >
> > Hi Martin,
> >
> >
> >
> > There are many changes between 6.3.0 and 6.3.3.
> >
> > Could you try to find a commit which triggers the io hang?
> >
> > Is it ok with 6.3.0 kernel or with reverting
> >
> > "virtio-blk: support completion batching for the IRQ path" commit?
> >
> >
> >
> > We need to confirm which commit is causing the error.
> >
> >
> >
> > Regards,
> >
> > Suwan Kim

