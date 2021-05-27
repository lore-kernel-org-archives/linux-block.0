Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64120C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367686124C
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhE0Tjq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:39:46 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34325 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234187AbhE0Tjq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:39:46 -0400
Received: by mail-pg1-f180.google.com with SMTP id l70so739376pga.1
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=31+QgvW4mk9wnHhRKlmKQ8JBnFBr6tg/3EzhHs1bq1M=;
        b=Z0cCIC8lnfTFj5glTIpp5hBKelJ5LSwzx0XAlh/e5TACMf/XT0uK8eMIrRllcpIiKX
         lUL9qYWLPo7HlNgCqE3iE8lH83uQuBHYU6BmPV3tOuErhbmI96u7IMBX2GrsQGqEr70q
         AWQp8zvcc6nwMruhg3pX6EjD6129SLrhNC5DdZmSIOp32UtDNQf+yRKg05FZMs/pLnP+
         +LbITd3WCjqyyF3ZlKxXtHfDJ/8+QXxU+h/MRKeoIOKzNBwjSw0CXp+xQiGYMAEpd9Ng
         sJThZ2AKFivxSMr6YMB9beE46R5X05J/ZP7fQ75UKjl+Pdewpo0iM120Mo7jxyeXieBl
         EM0A==
X-Gm-Message-State: AOAM532wtyFeDMYXOXQjPeVneqHU5JNbQWlGye52tcc19rvuQ3CBUeOo
        yezzgtBnFA9l5NhGrpFhWsc=
X-Google-Smtp-Source: ABdhPJx38g6mPn9m1KGXh2ApJ3ti2HtSzCrvLBh0+Z4JpHPyVyEISHO7zGTNeIo9SzazhTTjyuXvbA==
X-Received: by 2002:a62:7b07:0:b029:2e3:b540:707f with SMTP id w7-20020a627b070000b02902e3b540707fmr17750pfc.59.1622144292761;
        Thu, 27 May 2021 12:38:12 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id d22sm2536199pgb.15.2021.05.27.12.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:38:12 -0700 (PDT)
Subject: Re: [PATCH 5/9] block/mq-deadline: Improve compile-time argument
 checking
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-6-bvanassche@acm.org>
 <DM6PR04MB70810C07E70C25EF512B4A45E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <c7f41b26-997b-45a1-55fe-629f9613b12b@acm.org>
Date:   Thu, 27 May 2021 12:38:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB70810C07E70C25EF512B4A45E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 8:24 PM, Damien Le Moal wrote:
> On 2021/05/27 10:02, Bart Van Assche wrote:
>> +enum dd_data_dir {
>> +	DD_READ		= READ,
>> +	DD_WRITE	= WRITE,
>> +} __packed;
> 
> Why the "__packed" here ?

I agree that using __packed here does not have any advantage. I will
leave it out.

>> +
>> +enum { DD_DIR_COUNT = 2 };
> 
> Why not a simple #define for this one ?

I only use the C preprocessor if there is no other solution. As far as I
know there are no rules in the kernel coding style guidelines with
regard whether to use a #define or an enum to define a constant?

Thanks,

Bart.
