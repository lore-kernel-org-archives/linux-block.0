Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820F3C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 22:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378881AbiFPW7f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 18:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379286AbiFPW7e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 18:59:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA162A23
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 15:59:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id f8so2414877plo.9
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O9V3/AlYpAsbFFaSq3hdxAF1Vu95mFr7ygq63wLb9LY=;
        b=p+NVcFD7msBrG7dcd73zCP7q7/2HKf1/iwm9AHY8Z1lQTvqNQEPZsLN5n2BJQ14Brk
         e/K9Uhacm9MlIhhEpmbjv8xsACMbTb2WAM1PFPWVrCE3qYWpGPlQ8qAOixtqFfsfeH8E
         UNKmsU4MdQC0B/czxhhZwQ2Ph0/SE10mvD7XwbFxA5zjcigdKHEmHg7HvTssRJiCbuMn
         zrozYGSgEDj3CEeQyzBoP8ob1j5ga7y7aHhbXyDrkZdCkZz+LHAp/dCI6/RcUpgIEkTK
         0klZ6kRc9N/CqZUZ7HwpTgHeZO9ZSCNzV1Sec0E6cM2AOkAFp+Ar8YdXJKmXbVZ3NU+T
         sgMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O9V3/AlYpAsbFFaSq3hdxAF1Vu95mFr7ygq63wLb9LY=;
        b=NMRpHMBNjY3KVP5RgaKvFQb8d8ZmxqVRXBGNbrHICIcppXoPkn4zH+ZacnKP2RXr4j
         1VTcw/wzMWyITwp1hQBrGf7WStTDUT2N5VtExEx9MzrnMxYDNvpBYsamMJrwh+OSyady
         JqcSKsIuyQsUckZ6mC8Zv6rAQffSNPFno/85KYAVt7aobJjENvEycPsMW/sTIgnbA3YC
         FFcs6SMiQIV/qadslTC/CmqEOmP3Jr8SLK0y87hc/w8E7eLeMUNWMvkaniK1jA+jXyPc
         ur6HyRqA/K//TJoUb/n0uSOlLMOVq4xHfg5dsxBtn7VIHHv8by1RaJdbEPri4ScDMlM5
         dTyg==
X-Gm-Message-State: AJIora+MRketzqyyfbNYBwBEy58J0J9GkhcPIj5juGtsyeR6PQzGfxQw
        Czi0oyEF/2H8ZCIp3BETBuI/KZQ5up32xw==
X-Google-Smtp-Source: AGRyM1s0GtK2vcaRIySXnTwpQkmSS6u+lmLYHJdFKinYm39BOLzaAG8Mb7q6htEmuuGD5CwbFB0SiA==
X-Received: by 2002:a17:902:f687:b0:167:58bb:c43f with SMTP id l7-20020a170902f68700b0016758bbc43fmr6574299plg.136.1655420371086;
        Thu, 16 Jun 2022 15:59:31 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z3-20020a63b043000000b00405306de2c2sm2319411pgo.65.2022.06.16.15.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 15:59:30 -0700 (PDT)
Message-ID: <2c8256cc-38d5-11aa-6332-903447aa764e@kernel.dk>
Date:   Thu, 16 Jun 2022 16:59:24 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] block/bfq: Enable I/O statistics
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Cixi Geng <cixi.geng1@unisoc.com>, Jan Kara <jack@suse.cz>,
        Yu Kuai <yukuai3@huawei.com>,
        Paolo Valente <paolo.valente@unimore.it>
References: <20220613163234.3593026-1-bvanassche@acm.org>
 <6704edef-8c60-9fb8-ea45-1a350fdd9bf6@kernel.dk>
 <6efac11f-bb1d-7458-cb6d-bcd6e99e439f@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <6efac11f-bb1d-7458-cb6d-bcd6e99e439f@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 3:14 PM, Bart Van Assche wrote:
> On 6/16/22 13:50, Jens Axboe wrote:
>> On 6/13/22 10:32 AM, Bart Van Assche wrote:
>>> BFQ uses io_start_time_ns. That member variable is only set if I/O
>>> statistics are enabled. Hence this patch that enables I/O statistics
>>> at the time BFQ is associated with a request queue.
>>>
>>> Compile-tested only.
>>
>> Have you runtime tested it now?
> 
> This patch has been tested lightly: I ran blktests in a VM against a
> kernel that includes this patch. I'm not a BFQ expert so I was hoping
> for feedback from Paolo.

Sounds good - and Jan reviewed it, and I consider him the defactor BFQ
maintainer anyway these days :-)

-- 
Jens Axboe

