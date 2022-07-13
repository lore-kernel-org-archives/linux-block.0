Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15001C43334
	for <linux-block@archiver.kernel.org>; Wed, 13 Jul 2022 21:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiGMVsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jul 2022 17:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiGMVsw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jul 2022 17:48:52 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB86B1FD
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 14:48:50 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id v7so197042pfb.0
        for <linux-block@vger.kernel.org>; Wed, 13 Jul 2022 14:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A9oxaXXRhuwiZDMw/1aWzbkzQARqKL2elZmHBEaGEPs=;
        b=z/2nppF+e8L/fTPwecKHx7cOnrsDtjpnIEHZCZZmZsklzyqayMpOH1m2PDClYHBHPV
         I97ND437OvkpxB/BBrJGQ0j8LtV7r3+Odu8RjbJMRX0EmP0RXvMSETL6Zb8beFlwtdbU
         5oB0/hLYdx5iFEAthkUTbYDBhi4QwoEPXCo+pEoctqmZaP51wMAWtO3D60QL3RTl+kMi
         7WKpxpvX6F7mVpZOj3zOmZdCSc1BOjFod5ph+VjJGBb9o8kwyRyCA0X9mBDLIopc/fm7
         Zq3mfXXGAO1lOBCGDi53FKvmyv3ncU9yyEo4N13kYcmCujeJF66cbUhViAe6Z/I7Fkm/
         3jjg==
X-Gm-Message-State: AJIora8iFque7zA13Hb2L2SRmRxuSXmaU815oNEfeDuSXre3DQhFRjxL
        kVw0vm4uiBv0fOWY/xiDH0XoPyjTVo4=
X-Google-Smtp-Source: AGRyM1vZRGNtaOtHxshswkOGS6KPvfCXlXgvc/mtIZlyaP8/cs21pkDgCChj1JjLTZfe0F6xtQbl4w==
X-Received: by 2002:a63:149:0:b0:40c:f753:2fb0 with SMTP id 70-20020a630149000000b0040cf7532fb0mr4557155pgb.172.1657748929673;
        Wed, 13 Jul 2022 14:48:49 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:cf8d:5409:1ca6:f804? ([2620:15c:211:201:cf8d:5409:1ca6:f804])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d2d100b0016c23c2c98dsm9428648plc.246.2022.07.13.14.48.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 14:48:48 -0700 (PDT)
Message-ID: <d1a88d4f-9f03-a1d6-cf4a-fcdb8070399c@acm.org>
Date:   Wed, 13 Jul 2022 14:48:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 00/63] Improve static type checking for request flags
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <20220629233145.2779494-1-bvanassche@acm.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/22 16:30, Bart Van Assche wrote:
> A source of confusion in the block layer is that can be nontrivial to determine
> which type of flags a u32 function argument accepts. This patch series clears
> up that confusion for request flags by introducing a new __bitwise type, namely
> blk_opf_t. Additionally, the type 'int' is change into 'enum req_op' where used
> to hold a request operation.
> 
> Analysis of the sparse warnings introduced by this conversion resulted in one
> bug fix ("blktrace: Trace remap operations correctly").
> 
> Although the number of patches in this series is significant, the risk of this
> patch series is low since most patches involve changing one integer type (int
> or u32) into another integer type of the same size (enum req_op or blk_opf_t).
> 
> Please consider this patch series for kernel v5.20.

(replying to my own email)

Hi Jens,

I think that everyone who is interested in reviewing this patch series 
has had sufficient time to review the patches in this patch series. Do 
you prefer to queue this patch series for kernel v5.20 or kernel v5.21?

Thanks,

Bart.
