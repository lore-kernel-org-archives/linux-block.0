Return-Path: <SRS0=alrN=OK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955C8C04EB9
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F1D2081C
	for <linux-block@archiver.kernel.org>; Sat,  1 Dec 2018 18:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NBeNnV0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F1D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725731AbeLBFYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Dec 2018 00:24:06 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44401 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725728AbeLBFYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Dec 2018 00:24:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id t13so3884247pgr.11
        for <linux-block@vger.kernel.org>; Sat, 01 Dec 2018 10:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+Ifd+XoQKIPHhZlrY1G+LmEKHkl+36ZwviBPuVF9PZo=;
        b=NBeNnV0fLPx7uJWPA+77Gz5ev3JR+YsQtCl6+j9+12TDhrfDKltFDzex+VkW+rnYbL
         +B1n/fYxreRPbiiFBy3X0hsG65EfMC96H8YksitjCq71xWpBI2/Ztaunj+nSEAVVVnqm
         8mpoBJwYq9XRfOqLpKvM16fTDxwB1I5J8YtDRPmNzl2dHeTrJLQuAWMeBaRpifW5bbBs
         9/UGu6x1xmtnrIemS3ECOZRoVF7iK/q8x/O0h3qTv2plnFwiAlGyu29O/k4UsAtbBCRe
         rwW9r1a2P90+pcBEoQ7Ru6IPsDM0CiMmAgrp92YKMpNJaG+YdcWN/FMcKsvin8IMoOnZ
         KXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+Ifd+XoQKIPHhZlrY1G+LmEKHkl+36ZwviBPuVF9PZo=;
        b=hZv8v6DDawhQW8Sl6EsIii7W+QNIKJ4KBBOPkMcSr0tJkqt/WRLQ2sjXGqKBTlK+p+
         2qq69BZdTzAH7mON7vl68iDdGhUkfLgmfIoO8VUHGAamjCKJO6OkLFGiZWVmyVoR8WPY
         6XjzGpcSpO0F3v77lcTfvtLIc9HmHZmznuMUKRZ9QOg6lT1McR9ig994TKqY9rsU5H4a
         kxXe1D9QCmusG3A0RfjBIFAgi4WiOWRnIGH4OEh1Je7PmmtZSNLVaDTOsJDD6lwUZMzp
         P8A/OuJfTZF+wIQjOGb7SqmrOGH4JW57/WcEI0a4Y2VhZ8KyH333WQqswT4XNb7SKWH8
         3E8A==
X-Gm-Message-State: AA+aEWaT9SQ8WchoL/yGkzinUhFKI6z5nSAw54U5Nii1o0sT/wBUFbaw
        1vpQvAduPwhCs4Hh4jXuRVZD0g==
X-Google-Smtp-Source: AFSGD/Wb59HPYuhnvhMsoDlh7oOU5EAYd2zFg6K/q65JgEMs9nlCGEzwOZSUtuJmJX2yiV42ua92bA==
X-Received: by 2002:a63:1d1d:: with SMTP id d29mr8566951pgd.49.1543687861687;
        Sat, 01 Dec 2018 10:11:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id r83sm16991417pfc.115.2018.12.01.10.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Dec 2018 10:11:00 -0800 (PST)
Subject: Re: [PATCH v2] block: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Yangtao Li <tiny.windzz@gmail.com>, ed.cashin@acm.org,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        josef@toxicpanda.com, linux-block@vger.kernel.org,
        josh.h.morris@us.ibm.com, pjk1939@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
        nbd@other.debian.org
References: <20181201142414.7766-1-tiny.windzz@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5682c419-9e44-10ed-6a2e-286e6f5c5def@kernel.dk>
Date:   Sat, 1 Dec 2018 11:10:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181201142414.7766-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/1/18 7:24 AM, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> changes in v2:
> -Modify some function names to avoid compilation errors

The fact that your previous patch didn't even compile doesn't fill me
with a lot of confidence in the amount of diligence and testing
you apply to your patches.

Why would you send something out that you didn't even compile?

-- 
Jens Axboe

