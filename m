Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B75C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8D16124B
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhE0TfP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:35:15 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:39646 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhE0TfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:35:15 -0400
Received: by mail-pl1-f171.google.com with SMTP id q16so468704pls.6
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=beK4XAlCHvV7T4PhdhtJSE/Y42SUh5bMKXp2v/MXZpA=;
        b=stOGIAQYnOaIzzZNBVeg/RttUqjjaWivwn79DejD7TE1uFFGsHPar1WBsTORvWXvCw
         2UmAg4wgIKTFguHda94waQyjRP+XXC8WlnX1JL61fVZG5w4SCgmpDYQzpMKS8bjwRsYv
         1Pj15ixXjQItpXn11tFILSQ1GVPpFPIqg44BmDBeilxMto0JQ3uBg2P0lBUDSzBzmUZ7
         vzIta4TmZpg7XTeCyw1P8ZGBd4C4iGqka5NZEftl2ovy+OLzEyCL0RTGQ05IE46V8p3Q
         lFm8G53i+tRX6MhTy0hKVqw0snJ2ouOGG8g9t4oQKHWnYYbEeM8e+Mt3lwhC7UMHl0cB
         6yZw==
X-Gm-Message-State: AOAM532Oqoy5X41HtKy+LmkWMNqzTSklqPIV8xkWhDUhNYlZ1PS2ZwXr
        T3AzqhXGC0aOZLxycmIA6CQ=
X-Google-Smtp-Source: ABdhPJw33U+y3NidNBby2c09kV8gzSq77mBvQ3/iHsIUq6opri0evsgNiSqnOF/pfAFXgSlaFrhn1g==
X-Received: by 2002:a17:903:1d0:b029:fd:b754:5b8d with SMTP id e16-20020a17090301d0b02900fdb7545b8dmr4696292plh.76.1622144020466;
        Thu, 27 May 2021 12:33:40 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id g19sm2308695pfj.138.2021.05.27.12.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:33:39 -0700 (PDT)
Subject: Re: [PATCH 4/9] block/mq-deadline: Rename dd_init_queue() and
 dd_exit_queue()
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-5-bvanassche@acm.org>
 <DM6PR04MB7081E7FC163109B4082627DEE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <21fe53e9-5b22-4e6a-e7ad-8fc4f369dfb1@acm.org>
Date:   Thu, 27 May 2021 12:33:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB7081E7FC163109B4082627DEE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/26/21 8:13 PM, Damien Le Moal wrote:
> On 2021/05/27 10:01, Bart Van Assche wrote:
>> Change "queue" into "sched" to make the function names reflect better the
>> purpose of these functions.
> 
> Nit: may be change this to:
> 
> Change "queue" into "sched" to make the function names match the elevator type
> operation names.

Hi Damien,

The functions dd_init_sched() and dd_exit_sched() initialize a scheduler
data structure. To me the names dd_init_queue() / dd_exit_queue()
suggest that something in the request queue is initialized which is not
the case. Is sufficient as clarification or do you still want me to
change the patch description?

Thanks,

Bart.
