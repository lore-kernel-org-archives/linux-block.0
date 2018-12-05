Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485C6C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1102B2084C
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 17:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="YyWsT9e4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1102B2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeLERkq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:40:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38683 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeLERkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 12:40:46 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so17371429ioj.5
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 09:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bFKJJR414hUU6R6EM9SGv8dNwUdn/V+gZ7351wE6npw=;
        b=YyWsT9e48xRmmSXYxM8YEiQXHXfm4mVlwlsoB5+O1sGDFgeBdNdU1BCSTGiXDh13ah
         FpxgMZJ9JNH5CTEeKaUOj2v+kLFndPsYlJpTBFbt0K8CtAeGa1/QJg1iWOwW28fXXExT
         3LyjN8dRYcmlaZE+G0ayACg42lU0UTXtsSwQPpx4JYI/btoWqCh1Wyr/AyFdWBKNbgOo
         uutapyDf1Df4Y1Tbvn2DWk09ENy+SZDmBo6M0hQKfRfus0FsgaOE238oHivh+vGraH+V
         pVl9Z8qUXjwGo0PrcCAyX9sVbcl8UXHC6jqWOF9eDZ1EjEiS1efZIXyOb9MiCYCeMTZ0
         FTJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bFKJJR414hUU6R6EM9SGv8dNwUdn/V+gZ7351wE6npw=;
        b=U1f8dKfMAtzJ1FWMo3IgzMJ310KaLL/4YgxSDbbJ4ex9H9ZZ5F1I5pQIdasZsvpLG6
         lxRbSTWq8KTXQzJADho1p6fnEumt77qkUFBKZ3Addb1Y5xwOj67mr49/KDHQF1c5Vtvu
         pym+tych5xnlCu0fwz/GOzB7a3gPZytroswstTMIGO4KftJ9zElp/ditVGrBjW/UAGXG
         jIFebO/p10go3FojUHSjmHll+8BNPr3QOcvphlc9w05ShO78+JkKPCRQD6OmhDo24Zzx
         s0lIqIs9NlTK0EXWHAUQVospA0ZaFaPIx8h8yVfyc3fCxHUPopptxdD5lQH7SK9Gq3uN
         MzpQ==
X-Gm-Message-State: AA+aEWajXRnSUkG6DlCw6HRWqcMHD0Yi7jIdeZtg3Q5K7hXFdIrEgX2r
        SsZE6kftKt/AtEYLj/iyuCzQYiAh3EE=
X-Google-Smtp-Source: AFSGD/XzYir6CtVOXDLWqHyO4BrrlOdXcvLPGXCKhhQVH7AzUDBvZb6FufAEDZDhwbBK/U0aI7yy8Q==
X-Received: by 2002:a5e:a619:: with SMTP id q25mr22218360ioi.82.1544031644677;
        Wed, 05 Dec 2018 09:40:44 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c3sm8452854ioi.2.2018.12.05.09.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:40:43 -0800 (PST)
Subject: Re: [PATCH 0/3] Unify the throttling code for wbt and io-latency
To:     Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org
References: <20181204175904.8486-1-josef@toxicpanda.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <74f1432c-8100-26b6-84d2-f33f4b2a793b@kernel.dk>
Date:   Wed, 5 Dec 2018 10:40:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181204175904.8486-1-josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/4/18 10:59 AM, Josef Bacik wrote:
> Originally when I wrote io-latency and the rq_qos code to provide a common base
> between wbt and io-latency I left out the throttling part.  These were basically
> the same, but slightly different in both cases.  The difference was enough and
> the code wasn't too complicated that I just copied it into io-latency and
> modified it for what I needed and carried on.
> 
> Since then Jens has fixed a few issues with wakeups with the niave approach.
> Before you could easily cycle waiters back to the end of the line if they were
> woken up without the ability to actually do their IO yet.  But because this was
> only in wbt we didn't get it in io-latency.
> 
> Resolve this by creating a unified interface for doing the throttling, and then
> just handle the differences between the two users with user specific callbacks.
> This allows us to have one place where we have to mess with wakeups, and gives
> each user the ability to be their own special snowflake.
> 
> Jens, I based this on for-next from 12/03, let me know if you want a different
> base.  I tested this with my blktests test.  Thanks,

Applies fine to for-4.21/block, which is what I care about. Looks good to me,
applied, thanks.

-- 
Jens Axboe

