Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC6C5479D
	for <linux-block@archiver.kernel.org>; Tue, 10 Jan 2023 01:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjAJBRU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Jan 2023 20:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjAJBRU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Jan 2023 20:17:20 -0500
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F28625D3
        for <linux-block@vger.kernel.org>; Mon,  9 Jan 2023 17:17:19 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 36so7136467pgp.10
        for <linux-block@vger.kernel.org>; Mon, 09 Jan 2023 17:17:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mWoij97YZYZU5Ut7Rt0KH1q/vM62BOVW2vRPTJEw0Y=;
        b=m0R7ywUzlTTjVr7iI0bAulY2NDGsrRMHJbr8p1IGzTM8Q+nx4/SzsddlElVpsDLw2X
         8dh8nxEZqNv4jOTGqcBqSuLr51gd+Q1sJ4dT3h0eEPR9KapOocRpjsf8opDEEQUL7CNg
         3XAQLvFy70Uri37HWmlTY89Dghq9BfJKLSXHMFpyAEPe6UsR5hBf4KqPJLht9EC0tgWf
         +UmH8CpXghX9IKCUSjwpiwBJhnZzcznDSOv+Si95CxZjCwAdsKc8IqFOIOqUMnYGanGL
         ddQ1KvsdfGqoeR5qAoJ3bUIjtHLLdO9AwpWKuS2Rilksle3hVPL0DWxWhwVexvdkVXHb
         ZEDg==
X-Gm-Message-State: AFqh2kqBZ8F5dImCIxaPb4UH+d3RBeAytTDSjRGyQaiHZtRy+dG/RO7d
        3e7XDRuxzwPOJiu8vO1E0uchY5M914Q=
X-Google-Smtp-Source: AMrXdXtGTFNxDQ+1FKuTy3XY9Uj7yFRPlKwzICEJWduvxFSsr+YJggwffScNQt+QmXiUCt1gCgXnHg==
X-Received: by 2002:a62:4dc7:0:b0:586:210b:2b67 with SMTP id a190-20020a624dc7000000b00586210b2b67mr9299985pfb.6.1673313438891;
        Mon, 09 Jan 2023 17:17:18 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:9f06:14dd:484f:e55c? ([2620:15c:211:201:9f06:14dd:484f:e55c])
        by smtp.gmail.com with ESMTPSA id c76-20020a624e4f000000b00589c467ed88sm1446543pfb.69.2023.01.09.17.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 17:17:18 -0800 (PST)
Message-ID: <f47f32d8-92a3-b7d5-a462-d34da9263d34@acm.org>
Date:   Mon, 9 Jan 2023 17:17:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/8] block/mq-deadline: Only use zone locking if necessary
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>
References: <20230109232738.169886-1-bvanassche@acm.org>
 <20230109232738.169886-5-bvanassche@acm.org>
 <92096c6d-fe0a-7b5b-222f-c532286c0c8b@opensource.wdc.com>
 <7bf28b7e-7301-29b5-c610-dff04ad6337f@acm.org>
 <a4f42abc-08dd-9a2e-3e6d-371e3ed695d2@opensource.wdc.com>
 <b72e484c-2985-a755-b0e1-e9ccd93cfc3b@acm.org>
 <681a991f-e09a-eeb6-805a-ee807250c399@opensource.wdc.com>
 <2f0f4f28-4096-ab76-5be3-56c44231fed3@kernel.dk>
 <49a9fd49-c9dd-8e5d-368a-ac182f7165ca@kernel.dk>
 <07084f70-00a7-d142-479c-52c75af28246@acm.org>
 <72092951-3de8-35a3-9e50-74cdcc9ee772@kernel.dk>
 <31d32f69-4c14-c9be-494f-7071112073f9@acm.org>
 <86eef990-0725-9669-6b7e-1fe935a6b648@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <86eef990-0725-9669-6b7e-1fe935a6b648@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/9/23 17:03, Jens Axboe wrote:
> Because I'm really not thrilled to see the addition of various "is this
> device ordered" all over the place, and now we are getting "is this
> device ordered AND pipelined". Do you see what I mean? It's making
> things _worse_, not better, and we really should be making it better
> rather than pile more stuff on top of it.

Hi Jens,

I agree with you that the additional complexity is unfortunate.

For most zoned storage use cases a queue depth above one is not an 
option if the zoned device expects zoned write commands in LBA order. 
ATA controllers do not support preserving the command order. Transports 
like NVMeOF do not support preserving the command order either. UFS is 
an exception. The only use case supported by the UFS specification is a 
1:1 connection between UFS controller and UFS device with a link with a 
low BER between controller and device. UFS controllers must preserve the 
command order per command queue. I think this context is well suited for 
pipelining zoned write commands.

Thanks,

Bart.


