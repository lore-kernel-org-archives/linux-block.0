Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EAFC43334
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 19:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiFXT6G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiFXT6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 15:58:03 -0400
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C90C6557
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 12:57:59 -0700 (PDT)
Received: by mail-pj1-f43.google.com with SMTP id go6so3780814pjb.0
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 12:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sq8imGlokw1WVvgA2w/ORvoxC3QOJSS9KXFPlkR5s7s=;
        b=kaO6tCwWLeNO7p8PaNtADkAYzlBdiyp2Esz2+3d7E08yA4mE1Njm3iFaxoh2UXuZPS
         GjnVgeHzIJW2bTDCV11xaVQ9qtH6Zk9u/5ZXo+iK9GHtxgscOQXRKHSMQ13ESD/Mb8p8
         i/KBjzSZuEre4AprSm/vhstr3Wk2tl+KiXGlzuHq7sFVbleICTkGRiAubQ7sufjMsDKE
         +/+HdcesSGPqBWG7q+s8DnC+WgnUZjYDDlS5zFWwL0P4ivTndFApZStFgPvjTNqg4aI1
         yYtU0AXWlOkTOWZiTxKwW92yV6dTIIZhHTmViGAMSfI8XJ01e4JK52a+G2/HYnJOpTh8
         s/aw==
X-Gm-Message-State: AJIora9Qx4ofz7JB3yH8Gbx3ocdnEF38iP+NhyGPNBpAzonhM622ul5/
        lWUZBg4NDxdLYI21RdQtWyA=
X-Google-Smtp-Source: AGRyM1vnxNwKqhNcXBqQPVCXXeg24UEaMwgNl/UJlsgzQaZ1oYk9L/B9+yklR3X/TjebFI7vEZ8UqQ==
X-Received: by 2002:a17:90b:4a92:b0:1e8:2c09:d008 with SMTP id lp18-20020a17090b4a9200b001e82c09d008mr591070pjb.169.1656100678958;
        Fri, 24 Jun 2022 12:57:58 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e1:3e2c:e2fe:b5e0? ([2620:15c:211:201:4e1:3e2c:e2fe:b5e0])
        by smtp.gmail.com with ESMTPSA id f1-20020a631001000000b003fe4836abdasm2002322pgl.1.2022.06.24.12.57.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 12:57:58 -0700 (PDT)
Message-ID: <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
Date:   Fri, 24 Jun 2022 12:57:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org> <20220624045613.GA4505@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220624045613.GA4505@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/23/22 21:56, Christoph Hellwig wrote:
> On Thu, Jun 23, 2022 at 11:05:28AM -0700, Bart Van Assche wrote:
>> Since __bitwise types are not supported by the tracing infrastructure, store
>> the operation type as an int in the tracing event.
> 
> Please give the field in the trace even the proper type instead of
> all the crazy casting.

Hi Christoph,

I will do that. BTW, I discovered the code in the tracing infrastructure 
that makes sparse unhappy:

#define is_signed_type(type) (((type)(-1)) < (type)1)

Sparse reports four warnings for that expression if 'type' is a bitwise 
type. Two of these warnings can be suppressed by changing 'type' into 
'__force type'. I have not yet found a way to suppress all the sparse 
warnings triggered by the is_signed_type() macro for bitwise types.

Thanks,

Bart.
