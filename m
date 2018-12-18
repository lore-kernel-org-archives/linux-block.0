Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB33C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3E21872
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 13:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D809f/mf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbeLRN1R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:27:17 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37297 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbeLRN1Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 08:27:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so8147821pfb.4
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 05:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UkzfeD1d0reD5ZnsjdtFKPK2A3BQmiHIrSYOmtoKwH4=;
        b=D809f/mfV921ZNLnauMjyqb1At25Dhq3p/d6rJX3r0yDmuHLj2aWzQ2ACT0DOqrf72
         Yc9hk69D7swVsLNv3EyZdVk/QHsH6D/+V7f9tb6bA+hyvY1BQRunHsWH1+TgdYWiekZ6
         PkQ8DsyhdP7cfwNJsrweX5RUgnHAZII8QU/mnbVhSCgMtyjcjK1omqhP2D0qP5UCqZNb
         aULTZ1uzYJjNdfqIRcGX1DvAHa1EEXGCAaWV0nFDHE6KFYEUsoik4bLFaJ/+fDr01O3b
         SMTIRXSwF6FFUIguoVTIi6eGrq2WPWFu25KwyQOQNcIx37jWCtOs5WJSb9mJj5CauOsH
         dsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UkzfeD1d0reD5ZnsjdtFKPK2A3BQmiHIrSYOmtoKwH4=;
        b=Ri0qmazAA9Z3bF2lleMPREIS2ZaOGeYDv5TiAVCQoO2Lm4eq45qca9mHsFq/Ce2tZ1
         k78focs8QEFiKAX/5ZF7VazC3bxDAJc+L8RUVbT30bq2cIpOI7wmxd+A9tk/cJrs3fyQ
         lzK21Ug0WAOVhXblb/J4ZLDMFAJ6pTr4lN9aABeAYtovq9dx6MTvYAavcXIUTfmr5fmx
         QjQhupm6vBxH08xTv39P9XQhme5Bfyc8AdMWLBXrz9Hc1u5+MgOkEWR4O4NgWFg5ZBzy
         Q7M1nriNR+/En6qpdmIiVKddcHSFcC7JfYFOlcNPkBxEOTammDyMyLhdEGVcA6J6Sr4H
         fjIA==
X-Gm-Message-State: AA+aEWbAi4fhb6Okz2uuqGmss4reUkejAGY5UpXOKJ4zK1wpZsCKFxRP
        MritXesravhXciYyWSqAbB6tZQ==
X-Google-Smtp-Source: AFSGD/UR3FrmtSaXoEDcl7HYkl6zS3KR1IioT1JDbSbrNRKz98vwhjBsE8qaz9WhqGoTxMMLQhgl0g==
X-Received: by 2002:a62:9913:: with SMTP id d19mr16650040pfe.107.1545139635728;
        Tue, 18 Dec 2018 05:27:15 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g11sm20757586pfo.139.2018.12.18.05.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 05:27:14 -0800 (PST)
Subject: Re: [PATCH] blk-mq: enable IO poll if .nr_queues of type poll > 0
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>
References: <20181218041529.27787-1-ming.lei@redhat.com>
 <95d4e41f-24a7-bdb5-e014-994e021f901a@kernel.dk>
 <20181218064739.GA1219@lst.de> <20181218080918.GA28587@ming.t460p>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <acf138ad-6c4f-e9fa-6ac8-72e065432fc6@kernel.dk>
Date:   Tue, 18 Dec 2018 06:27:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218080918.GA28587@ming.t460p>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 1:09 AM, Ming Lei wrote:
> On Tue, Dec 18, 2018 at 07:47:39AM +0100, Christoph Hellwig wrote:
>> On Mon, Dec 17, 2018 at 09:34:55PM -0700, Jens Axboe wrote:
>>> On 12/17/18 9:15 PM, Ming Lei wrote:
>>>> The queue mapping of type poll only exists when set->map[HCTX_TYPE_POLL].nr_queues
>>>> is bigger than zero, so enhance the constraint by checking .nr_queues of type poll
>>>> before enabling IO poll.
>>>>
>>>> Otherwise IO race & timeout can be observed when running block/007.
>>>
>>> Looks good to me, but we might consider having a helper for this, since
>>> we have this check in 3 places now. But for now this is good, thanks
>>> Ming.
>>
>> Jens, if you want this I can drop the nvme patch to set nr_maps to 2
>> as it wouldn't be needed.  Not sure which one is more elegant, but
>> I guess Mings version is a little more fool proof.
> 
> For READ queue type, its .nr_maps can be 3 and .nr_queues is zero, so
> if check on the two queue type is kept as consistent, we may get good
> code readability, IMO.
> 
> As Jens mentioned, we may introduce blk_mq_queue_type_supported() helper
> to cover both.

I think that would be preferable.

-- 
Jens Axboe

