Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24D6C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C79520865
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zw4Z5X0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C79520865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeK0CXV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 21:23:21 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:44800 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbeK0CXU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 21:23:20 -0500
Received: by mail-io1-f67.google.com with SMTP id r200so14216359iod.11
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 07:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XMQ/5rm2yVCj+1hBUeKk0uc98ecr2zeqqoU2RuldxiI=;
        b=zw4Z5X0dAfC48OUMhHuc5FJPPomI6/K5q7m+Ia34wLlDI5VCidIu0OmOHGwAsV+Y5z
         CbgMxY50LQdEC5DGdAAnSz+zjU3CuZK41tBvYDTZMJQF4t94GnFrAxbOyo+ZsRnM+jse
         BWkYSpex6DV9+sloqpBIHF5I17b7kiteW/V+x80RxXNDmBOvR7+t9+luwb/IP4p0GLNe
         Ty+o8nfg75NWaRZzieDOBd6VExZB49RsFXzkKD37vQLbkn76nIjwWJQbhngIkX5fezmP
         kLBsfRbzRottOLQEeBH8dlP6vRRroEFz+0q+Blz/cH2hQw/L2KSjHtcvJ4TkEBbSIpTB
         EMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XMQ/5rm2yVCj+1hBUeKk0uc98ecr2zeqqoU2RuldxiI=;
        b=MnKBPSZ7JAsgG4Uv769bAzqWSgBRUpHfp7kpk2BKfygdn9IUM6Gs6erZ0yD9GU9H3p
         +1dgQ6p93GAkLrJ5ZJvXNyphwFZqdtwdW4y7xGemzseqBbIKwACB5eGOvNLeWewSnZZX
         A3UL10kjFZvEPFyOdrY744ZtjtS3eSb1N503tTeAsUy/Fk3JNI1UvTqt9AOHfpYkZT1a
         fG6ToxtS3LKQ6I5SZl902+eh8PVYbnr60yTkSnKTis/XWeC1XC3yvPaqiqk0HrShxCfm
         Nlhq3ZXJEO/TzaRO4IYo1Nl7zhW6kABhP7Mv5HDQypg57YYZFKbJ4uClI9IoTIfPYBl/
         wJag==
X-Gm-Message-State: AA+aEWaDgFnmlWXgfg+4NDggjndv+WDTTNevEi2yS2ngY1JAxoekr0F9
        j4uOP8KqxG55EHZFzUQv614HzvA8zYY=
X-Google-Smtp-Source: AFSGD/UXpYj2+TdxXe1q1L5YyI8jJ/LUTSLP45xyOztOViXXVX8AYHGoTMLT7XxS9H9VYYifYPj1Bg==
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr12806370ioa.266.1543246133292;
        Mon, 26 Nov 2018 07:28:53 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 195sm392945itm.2.2018.11.26.07.28.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 07:28:52 -0800 (PST)
Subject: Re: [PATCH 4/6] block: make blk_poll() take a parameter on whether to
 spin or not
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20181123183411.8708-1-axboe@kernel.dk>
 <20181123183411.8708-5-axboe@kernel.dk> <20181126081816.GC362@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d865f5fe-b7ca-4e18-f592-320d0f20e5c7@kernel.dk>
Date:   Mon, 26 Nov 2018 08:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126081816.GC362@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/18 1:18 AM, Christoph Hellwig wrote:
>> -int blk_poll(struct request_queue *q, blk_qc_t cookie)
>> +int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> 
> The parameter will need some documentation.

Done

-- 
Jens Axboe

