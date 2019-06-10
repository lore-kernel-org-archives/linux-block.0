Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789E4C4321A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 18:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2B62082E
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 18:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbfFJSa5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:30:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38641 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfFJSa5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 14:30:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so5474285pgl.5
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 11:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CH9MJuRRaSiq33xeCAVYx9BFes61hGUSqIs6DhLhAZM=;
        b=kGJykQAprtx1+FAtTiLDa29chZHbHA2tKXYWblNM6VPH0RYrbNelYBM2csuIbGUGQG
         hTjIsfROcMH8yNIVSZe47/GWgnTmYz5nuilOU8wXbpomdhs/ePiiVcNsEX57SjwoOt1X
         QGk2WfGIPzfLKYLFec2S7wIOacyV3Id44tzpu6qkdHSM5xZWDZxLg0wnRoxAystcqCvJ
         M9IxR9KJAkP5Gz3c4PrMgdna9dp26FDfUkJafyV20c6G3s0K6e7OJ9JS3ksCEVRZpASG
         LNSTGPWMkpP70QhOU26SYUYPRxztsrXmD+J9s3V52AVMSvanNwxXHT186+FfbvPSszcX
         zu/g==
X-Gm-Message-State: APjAAAViuz5wapjyIA9A2aK0V3Fyz9qAntQMqBdlOZ1OdXEMGZ1eByRF
        PBDL8r+J8jz5Qc02n9djU7EYgWb0
X-Google-Smtp-Source: APXvYqz9yFfPD2ZruSXm8W6BUrGLZmIt3V2txkBBL8IVqFmD5hjL62svM6KejCxH2SQdg54AdiWo9A==
X-Received: by 2002:a62:3741:: with SMTP id e62mr76456465pfa.213.1560191456299;
        Mon, 10 Jun 2019 11:30:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id r11sm8699398pgs.39.2019.06.10.11.30.55
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 11:30:55 -0700 (PDT)
Subject: Re: [PATCH 3/6] block: remove the bi_phys_segments field in struct
 bio
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org
References: <20190606102904.4024-1-hch@lst.de>
 <20190606102904.4024-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2e6e99e7-3d17-177c-caf8-394a6f6bbd8f@acm.org>
Date:   Mon, 10 Jun 2019 11:30:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606102904.4024-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/6/19 3:29 AM, Christoph Hellwig wrote:
> We only need the number of segments in the blk-mq submission path.
> Remove the field from struct bio, and return it from a variant of
> blk_queue_split instead of that it can passed as an argument to
> those functions that need the value.
> 
> This also means we stop recounting segments except for cloning
> and partial segments.
> 
> To keep the number of arguments in this how path down remove
                                           ^^^
                                           hot?

I will have a further look at this patch series as soon as I have the time.

Bart.
