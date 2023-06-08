Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1548DC7EE29
	for <linux-block@archiver.kernel.org>; Thu,  8 Jun 2023 18:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjFHSF1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFHSF0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Jun 2023 14:05:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC919B
        for <linux-block@vger.kernel.org>; Thu,  8 Jun 2023 11:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686247480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2V4P6kTkBUFeZZcuUFI0t5gfsCSMHu4aVkHeopJwkoA=;
        b=Zvyw0WGHbTtsRsvNM+wdV9buM3TTlSNsY+q5F1LtlakSq7T+ZMG3Fu73sz1/4l4bvgNky8
        MHRyJgknJRkVvbFQMNnG/qHreSOGAveuUDexh+4KxO38qEOzzN1Ts8G69lKYNiJpj0cF7+
        lhoTBdLTOM0MT4uFjDfJsQrEeRCHaaU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-uRbiGFfnOcqk-nWk75YL8Q-1; Thu, 08 Jun 2023 14:04:39 -0400
X-MC-Unique: uRbiGFfnOcqk-nWk75YL8Q-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f42bcef2acso4023165e9.2
        for <linux-block@vger.kernel.org>; Thu, 08 Jun 2023 11:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686247477; x=1688839477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2V4P6kTkBUFeZZcuUFI0t5gfsCSMHu4aVkHeopJwkoA=;
        b=LMmNaBS476Uc4glTdHLNfxjiTbbbdrn3ML7Zt3cxmUwa9+mwGqGTG+W0IQ8n8izsKV
         MM6WMc/q5kv9OmhVDwIzC7wB9hQUftJpnSwTNkj0Fm+LWFwFrINuCNEtNrEbxHZOY1V9
         /PJmgGO9Ucj9TbGAbS3RbHHn1Fv3nzg3BF2GBIJcKYgAaZzZ235SYKw1W38pLR8LkwD/
         VZjwK4TCQ7Q0p/fJIJ1ks1iJEdTHGKnJLQVWt/YJf6Ix40L6Hb1K+KPsd2qimuPKYMDA
         94+ZoBqby/K5nq+7pIj2acIfn+Slk/g27yyl8FYW2iwe1Lja8CfN7Sv4yLuzvEwqJosC
         S1/Q==
X-Gm-Message-State: AC+VfDzmFj33VDJoium3uqsTsh8ZcIdlLiAatYrKe4h9jIfzfUi4QihR
        SeLD197tUEuhPD5MM6tbXo9gPHd1rFx1xIQ6vfQKQ4i7CRnq9PbDzsHaZDyCpyGy4f8g3Zwo0sy
        uj2Fk+nU48fGJlVPs+tZKqRmXn/QuHgs=
X-Received: by 2002:adf:dc52:0:b0:30a:e5da:272d with SMTP id m18-20020adfdc52000000b0030ae5da272dmr6453800wrj.0.1686247477695;
        Thu, 08 Jun 2023 11:04:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52cXpF8MAZAe4gFdhkA2EPvUBra7Hh9ccT9UVfyClq15kQ6yJheJv5yMU+SgarVISLR0kucg==
X-Received: by 2002:adf:dc52:0:b0:30a:e5da:272d with SMTP id m18-20020adfdc52000000b0030ae5da272dmr6453790wrj.0.1686247477342;
        Thu, 08 Jun 2023 11:04:37 -0700 (PDT)
Received: from redhat.com ([2.55.4.169])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d650f000000b0030adfa48e1esm2219957wru.29.2023.06.08.11.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:04:36 -0700 (PDT)
Date:   Thu, 8 Jun 2023 14:04:33 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Suwan Kim <suwan.kim027@gmail.com>
Cc:     "Roberts, Martin" <martin.roberts@intel.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: virtio-blk: support completion batching for the IRQ path -
 failure
Message-ID: <20230608140341-mutt-send-email-mst@kernel.org>
References: <BN9PR11MB53545DD1516BFA0FB23F95458353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusa7goyDs1HaMVYDvvXT7ePfB7cAQt3EewT+t=-kKNf5eg@mail.gmail.com>
 <BN9PR11MB535433DFB3A1CFAD097C13278353A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <BN9PR11MB53545EDF64FC43EF8854D0628350A@BN9PR11MB5354.namprd11.prod.outlook.com>
 <CAFNWusbOKhZtVBRu88Ebo3=Cv9rdsX2aAf6_5hfnge=iryR3DQ@mail.gmail.com>
 <20230608104537-mutt-send-email-mst@kernel.org>
 <CAFNWusZZbFD+RLeJdno3vT6BAguq3jDB2EX8H8z5vPBE5sp54g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFNWusZZbFD+RLeJdno3vT6BAguq3jDB2EX8H8z5vPBE5sp54g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 09, 2023 at 12:12:16AM +0900, Suwan Kim wrote:
> On Thu, Jun 8, 2023 at 11:46 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 08, 2023 at 11:07:21PM +0900, Suwan Kim wrote:
> > > On Thu, Jun 8, 2023 at 7:16 PM Roberts, Martin <martin.roberts@intel.com> wrote:
> > > >
> > > > The rq_affinity change does not resolve the issue; just reduces its occurrence rate; I am still seeing hangs with it set to 2.
> > > >
> > > > Martin
> > > >
> > > >
> > > >
> > > > From: Roberts, Martin
> > > > Sent: Wednesday, June 7, 2023 3:46 PM
> > > > To: Suwan Kim <suwan.kim027@gmail.com>
> > > > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation.org>; linux-block@vger.kernel.org
> > > > Subject: RE: virtio-blk: support completion batching for the IRQ path - failure
> > > >
> > > >
> > > >
> > > > It is the change indicated that breaks it - changing the IRQ handling to batching.
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > From reports such as,
> > > >
> > > > [PATCH 1/1] blk-mq: added case for cpu offline during send_ipi in rq_complete (kernel.org)
> > > https://lore.kernel.org/lkml/20220929033428.25948-1-mj0123.lee@samsung.com/T/
> > > >
> > > > [RFC] blk-mq: Don't IPI requests on PREEMPT_RT - Patchwork (linaro.org)
> > > https://patches.linaro.org/project/linux-rt-users/patch/20201023110400.bx3uzsb7xy5jtsea@linutronix.de/
> > > >
> > > >
> > > >
> > > > I’m thinking the issue has something to do with which CPU the IRQ is running on.
> > > >
> > > >
> > > >
> > > > So, I set,
> > > >
> > > > # echo 2 > /sys/block/vda/queue/rq_affinity
> > > >
> > > > # echo 2 > /sys/block/vdb/queue/rq_affinity
> > > >
> > > > …
> > > >
> > > > # echo 2 > /sys/block/vdp/queue/rq_affinity
> > > >
> > > >
> > > >
> > > >
> > > >
> > > > and the system (running 16 disks, 4 queues/disk) has not yet hung (running OK for several hours)…
> > > >
> > > >
> > > >
> > > > Martin
> > > >
> > >
> > > Hi Martin,
> > >
> > > Both codes (original code and your simple path) execute
> > > blk_mq_complete_send_ipi()
> > > at blk_mq_complete_request_remote(). So maybe missing request completion
> > > on other vCPU is not the cause...
> > >
> > > The difference between the original code and your simple path is that
> > > the original code calls blk_mq_end_request_batch() at virtblk_done()
> > > to process request at block layer
> > > and your code calls blk_mq_end_request() at virtblk_done() to do same thing.
> > >
> > > The original code :
> > > virtblk_handle_req() first collects all requests from virtqueue in while loop
> > > and pass it to blk_mq_end_request_batch() at once
> > >
> > > Your simple path:
> > > virtblk_handle_req() get single request from virtqueue and pass it to
> > > blk_mq_end_request() and do it again in while loop until there in no request
> > > in virtqueue
> > >
> > >
> > > I think we need to focus on the difference between blk_mq_end_request()
> > > and blk_mq_end_request_batch()
> > >
> > > Regards,
> > > Suwan Kim
> > >
> >
> > Yes but linux release is imminent and regressions are bad.
> > What do you suggest for now? If there's no better idea
> > I'll send a revert patch and we'll see in the next linux version.
> >
> >
> 
> It is better to revert this commit. I have no good idea to debug it for now.
> I will try to reproduce it in my machine.
> 
> Regards,
> Suwan Kim


Can you post a revert please? And Martin can test and confirm
that resolves the issue for him.

> > >
> > >
> > > >
> > > >
> > > > -----Original Message-----
> > > > From: Suwan Kim <suwan.kim027@gmail.com>
> > > > Sent: Wednesday, June 7, 2023 3:21 PM
> > > > To: Roberts, Martin <martin.roberts@intel.com>
> > > > Cc: mst@redhat.com; virtualization <virtualization@lists.linux-foundation.org>; linux-block@vger.kernel.org
> > > > Subject: Re: virtio-blk: support completion batching for the IRQ path - failure
> > > >
> > > >
> > > >
> > > > On Wed, Jun 7, 2023 at 6:14 PM Roberts, Martin <martin.roberts@intel.com> wrote:
> > > >
> > > > >
> > > >
> > > > > Re: virtio-blk: support completion batching for the IRQ path · torvalds/linux@07b679f · GitHub
> > > >
> > > > >
> > > >
> > > > > Signed-off-by: Suwan Kim suwan.kim027@gmail.com
> > > >
> > > > >
> > > >
> > > > > Signed-off-by: Michael S. Tsirkin mst@redhat.com
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > This change appears to have broken things…
> > > >
> > > > >
> > > >
> > > > > We now see applications hanging during disk accesses.
> > > >
> > > > >
> > > >
> > > > > e.g.
> > > >
> > > > >
> > > >
> > > > > multi-port virtio-blk device running in h/w (FPGA)
> > > >
> > > > >
> > > >
> > > > > Host running a simple ‘fio‘ test.
> > > >
> > > > >
> > > >
> > > > > [global]
> > > >
> > > > >
> > > >
> > > > > thread=1
> > > >
> > > > >
> > > >
> > > > > direct=1
> > > >
> > > > >
> > > >
> > > > > ioengine=libaio
> > > >
> > > > >
> > > >
> > > > > norandommap=1
> > > >
> > > > >
> > > >
> > > > > group_reporting=1
> > > >
> > > > >
> > > >
> > > > > bs=4K
> > > >
> > > > >
> > > >
> > > > > rw=read
> > > >
> > > > >
> > > >
> > > > > iodepth=128
> > > >
> > > > >
> > > >
> > > > > runtime=1
> > > >
> > > > >
> > > >
> > > > > numjobs=4
> > > >
> > > > >
> > > >
> > > > > time_based
> > > >
> > > > >
> > > >
> > > > > [job0]
> > > >
> > > > >
> > > >
> > > > > filename=/dev/vda
> > > >
> > > > >
> > > >
> > > > > [job1]
> > > >
> > > > >
> > > >
> > > > > filename=/dev/vdb
> > > >
> > > > >
> > > >
> > > > > [job2]
> > > >
> > > > >
> > > >
> > > > > filename=/dev/vdc
> > > >
> > > > >
> > > >
> > > > > ...
> > > >
> > > > >
> > > >
> > > > > [job15]
> > > >
> > > > >
> > > >
> > > > > filename=/dev/vdp
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > i.e. 16 disks; 4 queues per disk; simple burst of 4KB reads
> > > >
> > > > >
> > > >
> > > > > This is repeatedly run in a loop.
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > After a few, normally <10 seconds, fio hangs.
> > > >
> > > > >
> > > >
> > > > > With 64 queues (16 disks), failure occurs within a few seconds; with 8 queues (2 disks) it may take ~hour before hanging.
> > > >
> > > > >
> > > >
> > > > > Last message:
> > > >
> > > > >
> > > >
> > > > > fio-3.19
> > > >
> > > > >
> > > >
> > > > > Starting 8 threads
> > > >
> > > > >
> > > >
> > > > > Jobs: 1 (f=1): [_(7),R(1)][68.3%][eta 03h:11m:06s]
> > > >
> > > > >
> > > >
> > > > > I think this means at the end of the run 1 queue was left incomplete.
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > ‘diskstats’ (run while fio is hung) shows no outstanding transactions.
> > > >
> > > > >
> > > >
> > > > > e.g.
> > > >
> > > > >
> > > >
> > > > > $ cat /proc/diskstats
> > > >
> > > > >
> > > >
> > > > > ...
> > > >
> > > > >
> > > >
> > > > > 252       0 vda 1843140071 0 14745120568 712568645 0 0 0 0 0 3117947 712568645 0 0 0 0 0 0
> > > >
> > > > >
> > > >
> > > > > 252      16 vdb 1816291511 0 14530332088 704905623 0 0 0 0 0 3117711 704905623 0 0 0 0 0 0
> > > >
> > > > >
> > > >
> > > > > ...
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > Other stats (in the h/w, and added to the virtio-blk driver ([a]virtio_queue_rq(), [b]virtblk_handle_req(), [c]virtblk_request_done()) all agree, and show every request had a completion, and that virtblk_request_done() never gets called.
> > > >
> > > > >
> > > >
> > > > > e.g.
> > > >
> > > > >
> > > >
> > > > > PF= 0                         vq=0           1           2           3
> > > >
> > > > >
> > > >
> > > > > [a]request_count     -   839416590   813148916   105586179    84988123
> > > >
> > > > >
> > > >
> > > > > [b]completion1_count -   839416590   813148916   105586179    84988123
> > > >
> > > > >
> > > >
> > > > > [c]completion2_count -           0           0           0           0
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > PF= 1                         vq=0           1           2           3
> > > >
> > > > >
> > > >
> > > > > [a]request_count     -   823335887   812516140   104582672    75856549
> > > >
> > > > >
> > > >
> > > > > [b]completion1_count -   823335887   812516140   104582672    75856549
> > > >
> > > > >
> > > >
> > > > > [c]completion2_count -           0           0           0           0
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > i.e. the issue is after the virtio-blk driver.
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > This change was introduced in kernel 6.3.0.
> > > >
> > > > >
> > > >
> > > > > I am seeing this using 6.3.3.
> > > >
> > > > >
> > > >
> > > > > If I run with an earlier kernel (5.15), it does not occur.
> > > >
> > > > >
> > > >
> > > > > If I make a simple patch to the 6.3.3 virtio-blk driver, to skip the blk_mq_add_to_batch()call, it does not fail.
> > > >
> > > > >
> > > >
> > > > > e.g.
> > > >
> > > > >
> > > >
> > > > > kernel 5.15 – this is OK
> > > >
> > > > >
> > > >
> > > > > virtio_blk.c,virtblk_done() [irq handler]
> > > >
> > > > >
> > > >
> > > > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> > > >
> > > > >
> > > >
> > > > >                           blk_mq_complete_request(req);
> > > >
> > > > >
> > > >
> > > > >                  }
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > kernel 6.3.3 – this fails
> > > >
> > > > >
> > > >
> > > > > virtio_blk.c,virtblk_handle_req() [irq handler]
> > > >
> > > > >
> > > >
> > > > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> > > >
> > > > >
> > > >
> > > > >                           if (!blk_mq_complete_request_remote(req)) {
> > > >
> > > > >
> > > >
> > > > >                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> > > >
> > > > >
> > > >
> > > > >                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
> > > >
> > > > >
> > > >
> > > > >                                    }
> > > >
> > > > >
> > > >
> > > > >                           }
> > > >
> > > > >
> > > >
> > > > >                  }
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > If I do, kernel 6.3.3 – this is OK
> > > >
> > > > >
> > > >
> > > > > virtio_blk.c,virtblk_handle_req() [irq handler]
> > > >
> > > > >
> > > >
> > > > >                  if (likely(!blk_should_fake_timeout(req->q))) {
> > > >
> > > > >
> > > >
> > > > >                           if (!blk_mq_complete_request_remote(req)) {
> > > >
> > > > >
> > > >
> > > > >                                    virtblk_request_done(req); //force this here...
> > > >
> > > > >
> > > >
> > > > >                                   if (!blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr), virtblk_complete_batch)) {
> > > >
> > > > >
> > > >
> > > > >                                            virtblk_request_done(req);    //this never gets called... so blk_mq_add_to_batch() must always succeed
> > > >
> > > > >
> > > >
> > > > >                                    }
> > > >
> > > > >
> > > >
> > > > >                           }
> > > >
> > > > >
> > > >
> > > > >                  }
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > > > Perhaps you might like to fix/test/revert this change…
> > > >
> > > > >
> > > >
> > > > > Martin
> > > >
> > > > >
> > > >
> > > > >
> > > >
> > > >
> > > >
> > > > Hi Martin,
> > > >
> > > >
> > > >
> > > > There are many changes between 6.3.0 and 6.3.3.
> > > >
> > > > Could you try to find a commit which triggers the io hang?
> > > >
> > > > Is it ok with 6.3.0 kernel or with reverting
> > > >
> > > > "virtio-blk: support completion batching for the IRQ path" commit?
> > > >
> > > >
> > > >
> > > > We need to confirm which commit is causing the error.
> > > >
> > > >
> > > >
> > > > Regards,
> > > >
> > > > Suwan Kim
> >

