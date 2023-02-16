Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003F6C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 14:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBPOtB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 09:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjBPOtB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 09:49:01 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA321C7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 06:48:59 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id h7so355334ila.7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 06:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UqpB3W8m7bzx+nLnNjVHKa816QwWIjPm/lNBINF2UJ0=;
        b=cuPTlZbIMR+OHRIYNCuWRgwIsoY/DzGF4tFhD/+J6EINqfmCgaP8HX6YK0pxrhcSPj
         Fur0md8pPdMHWkaM/hx6+04GDuVxNVtmMOW6POC5aUXe7J5jt2h+YOcxWLVubA3SzP4P
         AjEME1fm9SHs8o9WauSpbQnaqNntSSv6kLMLLEQVtr+jYz8E/jZDBPQNL2bVoDYqyNVa
         Uf1xIW+p2rVax4qssKabJdWDFZTs2mcLr9LLhiIctiJx/y2YJjSO19n0duAM5RmLFFy4
         cQ4Zrm6LUCaaEXt2nHX88QCUWTt2zubttu2yplKx7W0Idphqciqnr6l77WvoVIe/Dcvc
         qWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqpB3W8m7bzx+nLnNjVHKa816QwWIjPm/lNBINF2UJ0=;
        b=IwB6LOYXENAIeOFZWuvOaA5LY7JXwgAs6BxAl6DWs36WfVxSNNzVpDTuczTG2viWTH
         nG2kMRX4gNrPwO+7hKgNZbEk7CtAWcH7TtRyFfRPT4d+pFrQatnDXvGzhFYat0GWNoMg
         WYS3Hv7szJuk+H8+DN2DcnyfPRWvkvpiBJD2Mr4YjTzK5bt9Om2sTMnhhqXydylrodjX
         Ob/2n0i7QBT14wD9lVmMvjEXuoKEwVoUwgFfpUUAu4bxG+VbynN7oAVJKJPaktVssq3T
         BIgVDBg6EXVtdQZiKBmWkQpVi/KdRz1l5L3PNQ8WuVv/e/TOq3eRMt5W9BVlGj3ixRAY
         mOww==
X-Gm-Message-State: AO0yUKU+3FeBFtFQapPaiWuQWz6eTguOPXyfTspRX8PMZMQEfcEqgG45
        A4nXf2bJSHivK//rMqmVJb3+Vx2SSoJErw8Q
X-Google-Smtp-Source: AK7set/JaSBC9THKPhDAFn6P+iwzPpOWypAuBwgGakPa7dFEWCiR4HY32EuH5IT8obxlmiR+7VYAZA==
X-Received: by 2002:a05:6e02:1e05:b0:315:579c:9b77 with SMTP id g5-20020a056e021e0500b00315579c9b77mr5220110ila.1.1676558939096;
        Thu, 16 Feb 2023 06:48:59 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n19-20020a056638121300b003b4a1b58572sm572896jas.152.2023.02.16.06.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 06:48:58 -0800 (PST)
Message-ID: <c2cc7926-05b8-867c-de07-8e7d8b85a240@kernel.dk>
Date:   Thu, 16 Feb 2023 07:48:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] brd: mark as nowait compatible
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <776a5fa2-818c-de42-2ac3-a4588df218ca@kernel.dk>
 <Y+3IUcJLNK8WAkov@infradead.org>
 <9a9adcce-81db-580f-843f-ebff7177464c@kernel.dk>
 <Y+5AVIhMRRD8ks7X@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+5AVIhMRRD8ks7X@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/16/23 7:40 AM, Christoph Hellwig wrote:
> On Thu, Feb 16, 2023 at 06:11:41AM -0700, Jens Axboe wrote:
>> I did consider that, but we do allocations almost everywhere and
> 
> Do we?  All the code I've touched for nowait goes to great length
> to avoid blocking allocations.

It is prudent, I'm not disagreeing. I've got a v2, will send it
out shortly.

-- 
Jens Axboe


