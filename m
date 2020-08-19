Return-Path: <SRS0=HYnl=B5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81239C433DF
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 12:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51ABF20FC3
	for <linux-block@archiver.kernel.org>; Wed, 19 Aug 2020 12:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NyjiFBib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHSMzu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Aug 2020 08:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbgHSMzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Aug 2020 08:55:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC6C061757
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 05:55:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f5so10769184plr.9
        for <linux-block@vger.kernel.org>; Wed, 19 Aug 2020 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rrbpQDX15p//tPT7UvuN4uevRSDzI+hoTHUn4a3y+a0=;
        b=NyjiFBib4jG9+dEWoEnnDri1nWuFNmYsX63rP2x/bSpFDl3/E6+Fsey3gIejp1KEl/
         Zt6SapvAvbK+PGznoa9rvJsaQyrV7llkBKEAbb7QOVpy11/haGw0E1rjga4lLhOK0T3B
         n1yVM6QnrxYRbd0N+Jt6pZLHvycn/ysJVrHlVIhFSTUQqZQWGogi3CuaV/C7tao2jHcV
         ZG1V3RDNOQT2b/4Q2xqki4U7M2HHirSA5SONgufGeBgmeI+AAPNi4CjVp1a4T0bn7EHe
         8iEeDt/VxVc3GT62278Iw8Dr8R69qJZplrKNnbrbs1wqzr/zDu3RcURLPkusNnYLrbQE
         7qYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rrbpQDX15p//tPT7UvuN4uevRSDzI+hoTHUn4a3y+a0=;
        b=i/SSrHAqVql3empPNMNCA/NuyvJFCrbw3jL6E13dnBukWakDgu027po2XuXOfciNoD
         +0LXKYi7eI+9K0M4ju1rYcL6VsWfllTy5dcgHcGD6xn8Dd6qBIPMOKYtnJZ1lFX/pmYs
         dVufZ0Yuk3wWfigdfZ3qOt8Ttds4wk3Gn0Mxo+h+TA5ythQLf90x0+kdTN665ehuBNLM
         z/s2t6zBd5dRIwUrUyz9StVLBc83NMnL5NssydLkusvNyRT0+Z8+L0v5E8jUSW4K9xSq
         LlGwCAtmn2CLhdUCvrrORVR9ZxvvCuUlRyOKtwDFgnJULdolA785U4bcoeFwXcqY4wBV
         WcHw==
X-Gm-Message-State: AOAM530WJkwmLRQfJoHUG+GzjAsbJUUgstzZtQzZUw6QJSlh5kx/35yg
        1ONIEnFIm8XAK/9BrHzcgOXg+dnpAFvJXTCY
X-Google-Smtp-Source: ABdhPJwt+h/eu259u72qGri6DEmcqEOTbSywiag9NYdAcHMjkxwqLjx5ajBORusqvqeZVyqqzP290Q==
X-Received: by 2002:a17:90b:4a4e:: with SMTP id lb14mr4061190pjb.228.1597841722879;
        Wed, 19 Aug 2020 05:55:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w3sm28975674pff.56.2020.08.19.05.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 05:55:22 -0700 (PDT)
Subject: Re: [PATCH v3] block: Make request_queue.rpm_status an enum
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200819123403.19136-1-geert+renesas@glider.be>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <54e9ec37-00f1-b3a9-ab80-f4be77382aae@kernel.dk>
Date:   Wed, 19 Aug 2020 06:55:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819123403.19136-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/19/20 5:34 AM, Geert Uytterhoeven wrote:
> request_queue.rpm_status is assigned values of the rpm_status enum only,
> so reflect that in its type.
> 
> Note that including <linux/pm.h> is (currently) a no-op, as it is
> already included through <linux/genhd.h> and <linux/device.h>, but it is
> better to play it safe.

Applied, thanks.

-- 
Jens Axboe

