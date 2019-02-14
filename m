Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4958C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85A0121B68
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 18:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4nLKrWH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391102AbfBNSff (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:35:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39365 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfBNSff (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 13:35:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id n8so12217304otl.6;
        Thu, 14 Feb 2019 10:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZPffygpbzAIrA6qiombVt6omSPrZ204apL0F6W9Y0lA=;
        b=o4nLKrWH5/JS6AoRWA4Rs11/G9oEUtrUbRFNebPR7HNQbIprHqRX//Tcaux2+K9eb3
         IWTq0qvnSYWtV43Tr/V6ndVgyIIgPyTe9k+oOazpGfn8FdeT9eNKu7HU0T7fPI17qUbb
         Ahd+zvfDIjLDytVndSCl59bgv6lWb6Di3qbVF5GtxOI9v3D80l+KzdgQ1h+Gnwgh31Ad
         J4tOQbu08eX/v10zzjvhTi9OezCkgArPljJ9GgA8CENJ4Ae4TTcxR1Ndijs6oRaKhZfe
         tLQergfSFjB/RIisQMvgHUzf+SDezY+vBPshPcodS1O40SKgDJ0Zj3FQLcUsK6hVe+FQ
         ZSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZPffygpbzAIrA6qiombVt6omSPrZ204apL0F6W9Y0lA=;
        b=lhJObWMcPWsrjHXqJT45rdg0rQPKaeSRR1L7zdgCywA/za+QEPFrFz8gkP4tCpsakc
         B/A8ZD6OxH7PQ8Yztd8XJigLTGY7CEecKLJii7Dss6F2ZArPXTXFHVuTNq1FNAT/JTO1
         TIPmZsa4y6PL3tfxjh17raXdY0rSa96LHMmMvyqDTcCxqBkUyuqu+OMNPAMlU57epk1p
         jLMvYi2IVi3UHb941Ohn80kaOHJAq+1byogaXsjoV1/MIkyQq1T7PofLj/v665YJR2vl
         x8gdoPvQk+7qslBd8wDzV3+96Vzuz6vaMzs8iZInIah/jLGb208XgXzynKRNwl6IhMB/
         uptg==
X-Gm-Message-State: AHQUAuaXVFtPetP3EbWNs87w6GFFX+AFgq14fBGSEFCLqhewTeLRgOwJ
        4hpvuJDyGh32vRt8wduRkwb3kn5KP8lQI4YhjNz55g==
X-Google-Smtp-Source: AHgI3IY6bRO5WW8ZElp74U3yCER0TpLY4DIONrmAQ/skNCR4Mkn+oR1dkJoaRAohz0aQuQj1NiDbozPmASShpOzvJFg=
X-Received: by 2002:a9d:6b94:: with SMTP id b20mr3152589otq.42.1550169334527;
 Thu, 14 Feb 2019 10:35:34 -0800 (PST)
MIME-Version: 1.0
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com> <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com> <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
In-Reply-To: <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
From:   Mikael Pettersson <mikpelinux@gmail.com>
Date:   Thu, 14 Feb 2019 19:35:22 +0100
Message-ID: <CAM43=SOwS8A1Tv33QtQU=qmYVBMbpsaz67QOdKcD5ZHQg=wBQw@mail.gmail.com>
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     Jens Axboe <axboe@kernel.dk>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linux SPARC Kernel Mailing List 
        <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Feb 10, 2019 at 5:05 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 2/10/19 8:44 AM, James Bottomley wrote:
> > On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
> >> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
> >> <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> >>> I think the reason for this is that the block mq path doesn't feed
> >>> the kernel entropy pool correctly, hence the need to install an
> >>> entropy gatherer for systems that don't have other good random
> >>> number sources.
> >>
> >> That does sound plausible, I admit I didn't even consider the
> >> possibility that the old block I/O path also was an entropy source.
> >
> > In theory, the new one should be as well since the rotational entropy
> > collector is on the SCSI completion path.   I'd seen the same problem
> > but had assumed it was something someone had done to our internal
> > entropy pool and thus hadn't bisected it.
>
> The difference is that the old stack included ADD_RANDOM by default,
> so this check:
>
>         if (blk_queue_add_random(q))
>                 add_disk_randomness(req->rq_disk);
>
> in scsi_end_request() would be true, and we'd add the randomness. For
> sd, it seems to set it just fine for non-rotational drives. Could this
> be because other devices don't? Maybe the below makes a difference.
>
>
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 6d65ac584eba..60e029911755 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1881,6 +1881,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
>         sdev->request_queue->queuedata = sdev;
>         __scsi_init_queue(sdev->host, sdev->request_queue);
>         blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
> +       blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, sdev->request_queue);
>         return sdev->request_queue;
>  }

This patch eliminates my 5 minute boot-up delay problem.

/Mikael
