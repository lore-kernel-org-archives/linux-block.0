Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9007C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43F5611C9
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 19:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhE0TCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 15:02:32 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:40485 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbhE0TCb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 15:02:31 -0400
Received: by mail-pg1-f170.google.com with SMTP id j12so634323pgh.7
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 12:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AzApNRys76JJam02Z9HGuQTO4qj+zBNtuyYfxeaJY0=;
        b=l1O4OK6t0mdqurkEzZc+p1S3uxJtaKlC9N91b7S8X7l3DV88SUf5t69B1ZGSN/V5DT
         pXv2a/QrPNFALTI4VfVXugzM2Cg/lvQFRw1bzk7QRS835Op9hr7uGpjCSxJ5MifWj9W9
         Z4gDUagt2X/jxVQ1TyvHGF+fh9GeFAJDotJFhxluHkuMQAkdMlqD6tu8vNxoCGXiX5sj
         NuzkMkmgJRWYCjHBSiHCkGZ0RVKoahVkXeh+EgkzM/1+PAt8ytwbX2pJGugRYtiVyKEA
         aAwGuqhjDHniVSBsz+fun2iiisVkk4hVo/C0kYlPKVjhrfKnrUeb939OgT28HShr2Eq1
         F28A==
X-Gm-Message-State: AOAM530ryBYcpEkBOFhFoGpZ0j7fuQWxjp6VsaudkPINVaYxg62AmUnf
        7S53Xe3pd7BN09MUukhussjpZkMS5ic=
X-Google-Smtp-Source: ABdhPJxrYoSTdCPs1jacQ5jwQsJsdp4iV4/+z+m7HJ81xESJIQKnMmrWQZhCbrM2lc8G0HkONfldtw==
X-Received: by 2002:a63:4f47:: with SMTP id p7mr5138204pgl.52.1622142057736;
        Thu, 27 May 2021 12:00:57 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id w123sm2443941pfb.109.2021.05.27.12.00.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 May 2021 12:00:56 -0700 (PDT)
Subject: Re: [PATCH 0/9] Improve I/O priority support
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <PH0PR04MB7416F36FCACCE792DCC5AC1D9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
 <BYAPR04MB49655AE60D23813CCB22CF4A86239@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e6b6caf2-5978-b638-93de-b5b77a1b0817@acm.org>
Date:   Thu, 27 May 2021 12:00:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49655AE60D23813CCB22CF4A86239@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 10:23 AM, Chaitanya Kulkarni wrote:
> On 5/27/21 01:56, Johannes Thumshirn wrote:
>> On 27/05/2021 03:01, Bart Van Assche wrote:
>>> Bart Van Assche (9):
>>>   block/mq-deadline: Add several comments
>>>   block/mq-deadline: Add two lockdep_assert_held() statements
>>>   block/mq-deadline: Remove two local variables
>>>   block/mq-deadline: Rename dd_init_queue() and dd_exit_queue()
>>>   block/mq-deadline: Improve compile-time argument checking
>>>
>> I think the above 5 patches can go in independently as cleanups.
> 
> Yes they seems purely cleanup from review point of view.

That's right. This patch series has been organized such that the cleanup
patches occur first.

I have posted all 9 patches as a series to make it easier to review and
apply all these patches.

Thanks,

Bart.

