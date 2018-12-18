Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A80C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 670CD218A3
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 17:08:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YVaM41mj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeLRRII (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 12:08:08 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:39103 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeLRRIH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 12:08:07 -0500
Received: by mail-it1-f194.google.com with SMTP id a6so5224355itl.4
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 09:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=PyVa7G1yqNkefC78aIk/iM6m2e8V9AxDVFi8mwXaaAs=;
        b=YVaM41mj/C/URwbmO1W/xJQFc2z4QXp70s48QNZ+VLnD3Zjz6ANCwkTyExZ0tUsaOT
         WHA27bcB26yBbw6bcBtnbe1+0qZiq/vlufCnmjKBPlPyFT9NTwARPjW7O4MHpYv/phMG
         +SEi94PWsNN9D9S9n8mkAW0wns9bp5iyZjsQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=PyVa7G1yqNkefC78aIk/iM6m2e8V9AxDVFi8mwXaaAs=;
        b=P0NytvYaOV7C2IIrAkWIyF9R7xG9wNPpDOeWwRqX46/Fi7XWlXC1VV01miRRfZJsmj
         PeFR6Et6DIx6LFEbappJqiTgum07Qd1rxmL7Zhl93oRiDLyTeAQ6cBouDZMTTdFkF/sa
         rDC7MAR5cURbpxeoxPde08xKZsnSnBKNQsYFwQ59Qtpw6tqM8/9vPn5NFxqrXXtXhXey
         HdX13aGkdpAB1T/XFxDD0ZwG0Ni64X8unHnw2L6yB7Jt6cZyWOqPtW+Z8NXLZngdn0Ou
         bTdmXq0ngAFmREEoxvmQImMnQSHPlfpA4DQ8mcDAoWf6Yn37j2Cyj+1ixsmQmUOHLOJK
         VV4Q==
X-Gm-Message-State: AA+aEWa4yL1/7BOMpysAZe5Q088bVT7qCILGo1M9CsRtH6qr6AsAG72e
        MvRjP77/FPB5QbOwtSJ2mPM3XCJNm1hmVmkUYrhFgw==
X-Google-Smtp-Source: AFSGD/WN6Of5k3Ni5SWi5VEcVE3ZfpVAU4VhXCm1GlmRotIWTMa3tnF7h2Ma+VwOhlKH3BJEjkg5ITxKqNA0s8sxcEQ=
X-Received: by 2002:a05:660c:3c7:: with SMTP id c7mr3405578itl.131.1545152886482;
 Tue, 18 Dec 2018 09:08:06 -0800 (PST)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <CAHsXFKHSjBHZy9tyhdEjYJcLJeE6SqdeBPcoeq=bCaRfzvMqgw@mail.gmail.com>
 <1545149754.185366.449.camel@acm.org> <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
In-Reply-To: <ae741e1b-ec2d-075e-82b0-a1e09d0553fd@kernel.dk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKTtuNko6E02tULaIEHowzteDaHmgFdiSnEAolTOMKj5z9FEA==
Date:   Tue, 18 Dec 2018 22:38:01 +0530
Message-ID: <41bb993fdc71d02a884cc2b793403ca7@mail.gmail.com>
Subject: RE: [PATCH V2] blk-mq: Set request mapping to NULL in blk_mq_put_driver_tag
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> >
> > Other block drivers (e.g. ib_srp, skd) do not need this to work
> > reliably.
> > It has been explained to you that the bug that you reported can be
> > fixed by modifying the mpt3sas driver. So why to fix this by modifying
> > the block layer? Additionally, what prevents that a race condition
> > occurs between the block layer clearing hctx->tags->rqs[rq->tag] and
> > scsi_host_find_tag() reading that same array element? I'm afraid that
> > this is an attempt to paper over a real problem instead of fixing the
> > root
> cause.
>
> I have to agree with Bart here, I just don't see how the mpt3sas use case
> is
> special. The change will paper over the issue in any case.

Hi Jens, Bart

One of the key requirement for iterating whole tagset  using
scsi_host_find_tag is to block scsi host. Once we are done that, we should
be good. No race condition is possible if that part is taken care.
Without this patch, if driver still receive scsi command from the
hctx->tags->rqs which is really not outstanding.  I am finding this is
common issue for many scsi low level drivers.

Just for example <fnic> - fnic_is_abts_pending() function has below code -

        for (tag = 0; tag < fnic->fnic_max_tag_id; tag++) {
                sc = scsi_host_find_tag(fnic->lport->host, tag);
                /*
                 * ignore this lun reset cmd or cmds that do not belong to
                 * this lun
                 */
                if (!sc || (lr_sc && (sc->device != lun_dev || sc ==
lr_sc)))
                        continue;

Above code also has similar exposure of kernel panic like <mpt3sas> driver
while accessing sc->device.

Panic is more obvious if we have add/removal of scsi device before looping
through scsi_host_find_tag().

Avoiding block layer changes is also attempted in <mpt3sas> but our problem
is to convert that code common for non-mq and mq.
Temporary to unblock this issue, We have fixed <mpt3sas> using driver
internals scsiio_tracker() instead of piggy back in scsi_command.

Kashyap

>
> --
> Jens Axboe
