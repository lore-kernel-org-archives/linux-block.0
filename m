Return-Path: <SRS0=4/Ig=EO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C24EC388F9
	for <linux-block@archiver.kernel.org>; Sun,  8 Nov 2020 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C13206E3
	for <linux-block@archiver.kernel.org>; Sun,  8 Nov 2020 08:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="W67otHr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgKHIrQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 8 Nov 2020 03:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHIrP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 8 Nov 2020 03:47:15 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A18C0613CF
        for <linux-block@vger.kernel.org>; Sun,  8 Nov 2020 00:47:14 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id w20so1672186pjh.1
        for <linux-block@vger.kernel.org>; Sun, 08 Nov 2020 00:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Nt8PyG6XTzRj0oeg+Tq6GJQjN/jJVl2VwJ8IDyOvio=;
        b=W67otHr1Qgxg4hXBKhc7+ztKmaSqm6uKNZ/+8gtNzSPPsV2yYlFa63NUTqkqxg6WVZ
         97TIxSxjsSKjXhFRWnVfhkaML6ksuUGnLAmomQxRIFraQgWGib/iCuXVCn3PRkcV6p9u
         +AumSbpl26niIs9GGmlLUd4/ZyZcxj+hzoiy5TSxHPj1BrqbayC6IgRHSr5I8H0Qo0+b
         Nzqa1EV/8lm3onHz+JNlejZrsCwncId3H6EMmcxWMQxyxELVK/lENLP7nsvqTdTJziIP
         TQMiDssfdBHBFnNQceZ5zCbSZ8kxoeHED0kyZC4K+XYapRNhMdcq/1wkpSgxlovSEgxa
         Jr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Nt8PyG6XTzRj0oeg+Tq6GJQjN/jJVl2VwJ8IDyOvio=;
        b=VRXlqc4xEhrCvLFMNncfPo49XzdUK/Mg5uKix8JEa5Iw5+ehgIKWnStHfa9MTJF/VE
         dZyoyzQJTStoGqmIUP7COs/vK8m2C22aeTpx1bqfFu3SrKbuOAFIytiZrOaCg9VB6L7i
         8B2fNP4YdEreKdUIg8yA/2HM2sVIPHdLmgAEPJ0szFgABuGntnhtRTaH/2rq2ajUZSW9
         uwzAmkjBBNl4GSfAn2J/gtfDs/gZeKQ0Lad6CtXmoRMpB3qbentPBx92z4nrwtvwTAdU
         WuJHs72ghlgXdNih+ehCxTbk7XLx13rMyqFdRgIZ8xgzLSfw36+Y9x4pRzVMUXO86Adb
         2k4w==
X-Gm-Message-State: AOAM532/dAIkTnQLiRtkPy0yQvZf7WvyQlpc7AJJk2K9YLsdw5qHJRhm
        AnChg0CJG8TzV2qKncNShGn2Md1S545uyYBj
X-Google-Smtp-Source: ABdhPJwbAl3DdZhSyIwBG8RUNdjCerhPVKKKD9oAALXRcKYb7S4HxP6T66Fh9TjKA9uY2or6AUT0Ag==
X-Received: by 2002:a17:902:bd05:b029:d6:f041:f5b with SMTP id p5-20020a170902bd05b02900d6f0410f5bmr8447671pls.9.1604825233633;
        Sun, 08 Nov 2020 00:47:13 -0800 (PST)
Received: from houpudeMacBook-Pro.local ([240e:b1:e401:4::9])
        by smtp.gmail.com with ESMTPSA id x123sm7641844pfb.212.2020.11.08.00.47.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2020 00:47:13 -0800 (PST)
Subject: Re: [PATCH v3 0/2] nbd: improve timeout handling and a fix
To:     axboe@kernel.dk
Cc:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
References: <20200930032350.3936-1-houpu@bytedance.com>
From:   Hou Pu <houpu@bytedance.com>
Message-ID: <e0f31dec-fa4b-11d5-a784-9e661e2c054f@bytedance.com>
Date:   Sun, 8 Nov 2020 16:46:50 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20200930032350.3936-1-houpu@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020/9/30 11:23 AM, Hou Pu wrote:
> Patch #1 is a fix. Patch #2 is trying to improve io timeout
> handling.
> 
> Thanks,
> Hou
> 
> v3 changes:
> * Add 'Reviewed-by: Josef Bacik <josef@toxicpanda.com>' in patch #2.

Hi Jens,
Sorry to bother. Emmm, It would be great to pick up these 2 patches
into the upstream. Could you give a helping hand?

Thanks,
Hou

> 
> v2 changes:
> * Add 'Reviewed-by: Josef Bacik <josef@toxicpanda.com>' in patch #1.
> * Original patch #2 is dropped.
> * Keep the behavior same as before when we don't set a .timeout
> and num_connections > 1.
> * Coding style fixes.
> 
> Hou Pu (2):
>    nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
>    nbd: introduce a client flag to do zero timeout handling
> 
>   drivers/block/nbd.c      | 33 ++++++++++++++++++++++++++++-----
>   include/uapi/linux/nbd.h |  4 ++++
>   2 files changed, 32 insertions(+), 5 deletions(-)
> 
