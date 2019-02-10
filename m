Return-Path: <SRS0=XSHr=QR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F13C282C2
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E3512176F
	for <linux-block@archiver.kernel.org>; Sun, 10 Feb 2019 16:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="t3mvq4rl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfBJQFi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 10 Feb 2019 11:05:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39450 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBJQFi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 10 Feb 2019 11:05:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id f132so4052152pfa.6
        for <linux-block@vger.kernel.org>; Sun, 10 Feb 2019 08:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZECTETr+0oYMyy5ey4rWXjgads+kVgi2qo5hy8wL3QI=;
        b=t3mvq4rl6j4xYG/9Q5itnW6D66F6G1GBMYlGFggfHDKC6YVY0biGssfxElOi6sq3xt
         ulkopKCiK4NRu9JAHuU+DcKDxoF8Q8835FRPw9G09B8glL97ZEkkoTMeZBlK+uIV0gqf
         +s1Mux8BulfW0qFVK+lHWEr/fYq7n+RicPk5Rlgv/9J/NdRH18S/lyN+UAFG0FiCpdM4
         FskAbbsMhpRmNX/jLer3qKIxEYiVZjHCLM2+5qLsqmja8inKqE0nY4c/czKjwRTwXmHz
         9PepSmWVwfGl6ZzoeVNpCU65naH5ttQ8FXLxv9x8zMckJb7ZcPZVY0nCRdMUxFCk0/ea
         fPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZECTETr+0oYMyy5ey4rWXjgads+kVgi2qo5hy8wL3QI=;
        b=I8cQlE4o6xTQroKWslZi/I6i1IuYmbe/CzSQBdsj+5JWaMZrOp6lXKkhM8Qbo2sh5R
         ZrUDo0M9GEnjtD1NBbseu+N895q/7xPTItXw+CpY81r7vyu31DSNHW4Rx36x8epT5tgR
         8Qre8rI627U9G8OPlCFDTfDLNe1UmuL79FjDEDvcZue8/DHrn+PwLs3VS2YJ2mhul91X
         9cDxBBkhKMGjvIibij79CJR05BizXAo1hrBkj4yK3LqnsA4RJ9Fa/26Pux6LCWuzB4hA
         i9zXqy5Hqa073xgOzis1i7ivJmL2Pzc2ueP2agIBBJNdS871y1g6ldtuku1yUECksq5J
         vnWw==
X-Gm-Message-State: AHQUAuYO4fVKr7hcACCUm8oZn8jUgvLgtMhlb7GxqXyT1Royg39XqHVi
        fhlJxC+2u0CelBVheaQxUzQ8HA==
X-Google-Smtp-Source: AHgI3IYIi9DI7D7+SITg+MDWtOJDrglXBmwoxfYojS0BRUTmzZNTsmuDrvcq7uHZqFFEVXZoXr8jfA==
X-Received: by 2002:a62:6ec8:: with SMTP id j191mr32641753pfc.198.1549814737430;
        Sun, 10 Feb 2019 08:05:37 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f2sm6404041pgp.32.2019.02.10.08.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Feb 2019 08:05:36 -0800 (PST)
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5
 minute delay during boot on Sun Blade 2500
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
Date:   Sun, 10 Feb 2019 09:05:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549813472.4142.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/10/19 8:44 AM, James Bottomley wrote:
> On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
>> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
> [...]
>>> I think the reason for this is that the block mq path doesn't feed
>>> the kernel entropy pool correctly, hence the need to install an
>>> entropy gatherer for systems that don't have other good random
>>> number sources.
>>
>> That does sound plausible, I admit I didn't even consider the
>> possibility that the old block I/O path also was an entropy source.
> 
> In theory, the new one should be as well since the rotational entropy
> collector is on the SCSI completion path.   I'd seen the same problem
> but had assumed it was something someone had done to our internal
> entropy pool and thus hadn't bisected it.

The difference is that the old stack included ADD_RANDOM by default,
so this check:

	if (blk_queue_add_random(q))
		add_disk_randomness(req->rq_disk);

in scsi_end_request() would be true, and we'd add the randomness. For
sd, it seems to set it just fine for non-rotational drives. Could this
be because other devices don't? Maybe the below makes a difference.


diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6d65ac584eba..60e029911755 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1881,6 +1881,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 	sdev->request_queue->queuedata = sdev;
 	__scsi_init_queue(sdev->host, sdev->request_queue);
 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
+	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, sdev->request_queue);
 	return sdev->request_queue;
 }
 

-- 
Jens Axboe

