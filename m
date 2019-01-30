Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0711EC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C877B21473
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 15:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AR8w8ERQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbfA3Pxg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 10:53:36 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:50519 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbfA3Pxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 10:53:36 -0500
Received: by mail-it1-f182.google.com with SMTP id z7so43111iti.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 07:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=M3TRdOIcRo3NPQiI/hms/4tEaaQgW3pPAxv7ZL5hIkI=;
        b=AR8w8ERQrjHLNYl9lhBF1ltQn0U0XmYfzVna+k3tSPo9ybnasZZDinf5bqvqLoxfr1
         YmRnsHd8GsepTNA/u4egGdECayP1q++YKV2D69QG1MgocCX/zQiOV+Xlpw4CSOapgZ9t
         nyViDb5kfcXG+mX2db1qhKCUOTon5TmEy8XGBGXl0fe280r1SUwilIbZdbkOIGvKEhw0
         QVBvV4ZHPkmixDW45hXorWNMIACv5TKWsay9XrUD3bNy44mmSn0JxxTkJS2tj4BA47mT
         t4pSDpEWY1jJqAxQUu1xGKDyjxWDmFmsmn1wIpAM4EG9uBJdlQOr+P4kNFxLKYJD/QEZ
         rKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M3TRdOIcRo3NPQiI/hms/4tEaaQgW3pPAxv7ZL5hIkI=;
        b=i/ZZUvrCbnTzTgyHW0o2AjE5obf+0HlRWiZi6NFbBMq6uZs1l7WOVfSKeEuMmSGM5Z
         xwDco6CF72AfwI88c3Gr88ucqfS1bI6N0iaB50cexr5mHsSjSoDb7XktCRoFDR6oouHR
         bDI8tIWENrtGX0MLhdcW5OBsUSpu2qJNgBfLkpvqdTG79gdOHEvFpYEeYmvzWl+HyVtk
         deMS8IZCs3cg96accGr2c1klIv2udEm80hZDfUEf6SyDyi0eXa7kjXuRlv1y8065Iqpz
         wmc6opWrZtSkfLXAlvS0VkDINO4y/oLdIrIQoHNR7eDI8b4018lrV8UCd7PQtzW/drd8
         8NoA==
X-Gm-Message-State: AJcUukd9tjdRrcuVH18ZcuZUbeY3gFNj0NEsHR8jxduKuwlHxDiSOeyz
        La5Kp9fakt493qEk59BHKBnKvXWq/w8=
X-Google-Smtp-Source: ALg8bN4BQHgp9UyZCBSCpY7draI/B2xWkX34gDAAlGPVzJNKHG9Bg0TEN5gTsErLly8JJ39JtaUVrA==
X-Received: by 2002:a24:c2c1:: with SMTP id i184mr15835728itg.117.1548863615218;
        Wed, 30 Jan 2019 07:53:35 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id o63sm1367554ita.8.2019.01.30.07.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 07:53:34 -0800 (PST)
Subject: Re: WARNING in __flush_work
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <000000000000c1ac2805809b7cf6@google.com>
 <4d633ac8-2340-8759-f2a6-a147dafe3339@I-love.SAKURA.ne.jp>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6a87f3b6-3a5e-cf96-69f4-0172a89c8897@kernel.dk>
Date:   Wed, 30 Jan 2019 08:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <4d633ac8-2340-8759-f2a6-a147dafe3339@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/30/19 6:56 AM, Tetsuo Handa wrote:
> From fd653e8dd0d5368cd0cd9ccd89cf3001e4584f8a Mon Sep 17 00:00:00 2001
> From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Date: Wed, 30 Jan 2019 22:21:45 +0900
> Subject: [PATCH] block: pass no-op callback to INIT_WORK().
> 
> syzbot is hitting flush_work() warning caused by commit 4d43d395fed12463
> ("workqueue: Try to catch flush_work() without INIT_WORK().") [1].
> Although that commit did not expect INIT_WORK(NULL) case, calling
> flush_work() without setting a valid callback should be avoided anyway.
> Fix this problem by setting a no-op callback instead of NULL.
> 
> [1] https://syzkaller.appspot.com/bug?id=e390366bc48bc82a7c668326e0663be3b91cbd29

Applied, thanks.

-- 
Jens Axboe

