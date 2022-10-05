Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EDDC433F5
	for <linux-block@archiver.kernel.org>; Wed,  5 Oct 2022 18:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbiJESXq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Oct 2022 14:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJESXg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Oct 2022 14:23:36 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3E1D0DB
        for <linux-block@vger.kernel.org>; Wed,  5 Oct 2022 11:23:34 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id x32-20020a17090a38a300b00209dced49cfso2572869pjb.0
        for <linux-block@vger.kernel.org>; Wed, 05 Oct 2022 11:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1p6tr4lITENvaMZNWc0f9dLt7HGUG84C5h28sFeBA/o=;
        b=WzxyW7QQ3eWmRHQje6jU5h69M2f+xuRzIY7N/x+3OvTDpDMkBqh0fDH0oofG1kWjzQ
         PBGnk6uXMV1c32xzG+a+DlfYwl5XFSTtAFRX9IRWOd/9bDaEWWD8oJd3Ws77BEJLgqz8
         obzVN13WHsN26c4su6OKVxY4NuFYavDzbuuFUEg4htzV9jEhEcW/uChT5CFOtBMs05H1
         3AjSy+X1VmrTvarRYZH65f86LdkMbAs5INaGGIvaUfEEPIC6mcAI+sFf2GN5dmxMiWIv
         kuFQ/zogvRCwL2tM6ILMGhYtPqbPtwnsWq5MrvNiRt9NAu0LEDG0ogmcX7aCqZXEbXmI
         XdvA==
X-Gm-Message-State: ACrzQf1rhyCVm8Ec9Mo7e1QXK5bRN8s++kpdTPzWzoBp/Wg+ck51BL3j
        BbrJOYrRfmI4q/bnOTE3WbU=
X-Google-Smtp-Source: AMsMyM7evQsddfKt+F+sQOA713OamrdnvgpH5cwQJfLnFMHZlPuGJZYcgrKOs3a31ddgqQgSe+MM4Q==
X-Received: by 2002:a17:90b:4f8d:b0:202:dd39:c03a with SMTP id qe13-20020a17090b4f8d00b00202dd39c03amr6524137pjb.71.1664994214144;
        Wed, 05 Oct 2022 11:23:34 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b00172951ddb12sm10759402plr.42.2022.10.05.11.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:23:33 -0700 (PDT)
Message-ID: <6fd41ef7-a281-cf1b-1f1c-987679abfb24@acm.org>
Date:   Wed, 5 Oct 2022 11:23:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: Supporting segment sizes smaller than the page size
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <3a32f6fd-af4a-3a81-67ad-7dc542bb6a3c@acm.org>
 <Yz24Ghonv2xmplz/@kbusch-mbp.dhcp.thefacebook.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yz24Ghonv2xmplz/@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/5/22 10:00, Keith Busch wrote:
> If the hardware's DMA segment is smaller than a page, why doesn't the driver
> just split a kernel's larger segment into whatever representation the hardware
> wants? We do that in nvme, at least.

Hi Keith,

That's an interesting question. Your question made me realize that the 
bio_map_kern() changes I proposed can be dropped if the code for 
counting the number of segments is modified to support small segments.

My answer to your question is twofold:
* Splitting segments in a driver is easy to do if that doesn't cause the 
number of segments limit to be exceeded (queue_limits.max_segments). It 
is the responsibility of the block layer to split bios that exceed the 
maximum number of segments into multiple bios - this is something that 
cannot be done in a block driver. This is why I think that a (small 
number of) block layer changes are needed.
* The blk_rq_map_sg() function really needs to be modified to support 
segments smaller than the page size.

Thanks,

Bart.
