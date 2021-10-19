Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE1BC43219
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E1C6128B
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 18:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhJSSuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhJSSuu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 14:50:50 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8299DC06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 11:48:37 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y67so21511377iof.10
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JABbiNToQZ5a+bjEWUK0pbrE/4uEB2au01u3vMiwyUA=;
        b=F1EbynelcR+2laudFSps7IFEM6WK8Ta1FjarR4t4NNvDQq+KjTppatJ36x5UM0FTH3
         /ixhcgsKTamyLS23Xs7bQYlKOv1yPsC2gsaFbOfvmBpNwe4UgEcX5/cFX76MDJrCPVwW
         ZEig6UdP/zw6TteWYouAQQDS9EoIYOlngLVwyFhFzDN5VMkj4YaivzP5jLubeG33uHPi
         aE8359KBqrTpp7au+Yu1ZDwDqcFgWjuNW9G1xkA573aWOZKcxZ8vk0NgZq4q1bblEdWD
         x+9uU3JVVs46ubQ66mx5v9hJ/P50N3HJ6uLZ8QpSwJqUs6AL+HisJ8jIlPTWdcOLGzbz
         7c8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JABbiNToQZ5a+bjEWUK0pbrE/4uEB2au01u3vMiwyUA=;
        b=OIKXRZFXGS5Xvmc292+SRrs9rJcIkDWa2nctEM8eSaYvkhUHRN2LAADz8g+DMfiiNn
         iCZv4A4SGsOHTbXMGQejB1imyo4qBEOODExYdRNabQACmrTLU9ZeWuEPwsd/5SxRSgA7
         G7DipG5sm1tSxhSoS06WNGfYOUZ30N/sjVwXbF1PxEOZBF0g735aAnN/XO3lO6xefFgi
         N7Oci1eTcU8nlWYhdM7Fa1wBG4z312swnUwZOOq1B+bCe4IjfuTuU0OAXFLFJqpWCe0Z
         72Dt+ey0NkEhTp4bykakzJe9abABj/LcmNaME26P71EBSVPM0R7c/ZLx63qt2unWntAV
         SI4A==
X-Gm-Message-State: AOAM53383a2mrzvrxNuXs9f3UCfnJEyCpA851i3TGHSeyKqNQ/HpZgZn
        cpl+PNDUAOi5wf7WEsAIb0c3Waj/ADUpsw==
X-Google-Smtp-Source: ABdhPJwfB7dTAbi7tFlYF1+lw16fVlVzuvKIRjmrCUJznOC9J3z4Rv9n2ouOPb0iDPaDq0YYMSK8Xg==
X-Received: by 2002:a02:620b:: with SMTP id d11mr5413748jac.69.1634669316689;
        Tue, 19 Oct 2021 11:48:36 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n17sm9043749ile.76.2021.10.19.11.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 11:48:36 -0700 (PDT)
Subject: Re: [PATCH 1/4] block: add rq_flags to struct blk_mq_alloc_data
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-block@vger.kernel.org
References: <20211019153300.623322-1-axboe@kernel.dk>
 <20211019153300.623322-2-axboe@kernel.dk>
 <20211019184259.GD2083665@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2635920a-2976-5ffa-6090-15d73968c0c8@kernel.dk>
Date:   Tue, 19 Oct 2021 12:48:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019184259.GD2083665@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/19/21 12:42 PM, Keith Busch wrote:
> On Tue, Oct 19, 2021 at 09:32:57AM -0600, Jens Axboe wrote:
>> There's a hole here we can use, and it's faster to set this earlier
> 
> <snip>
> 
>> @@ -148,6 +148,7 @@ struct blk_mq_alloc_data {
>>  	blk_mq_req_flags_t flags;
>>  	unsigned int shallow_depth;
>>  	unsigned int cmd_flags;
>> +	unsigned int rq_flags;
>>  
>>  	/* allocate multiple requests/tags in one go */
>>  	unsigned int nr_tags;
> 
> The patch looks good, but the new field doesn't appear to occupy a hole.

Yes, not sure how I missed the first flags. I'll cut that from the commit
message.

-- 
Jens Axboe

