Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F56C433FE
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8D876103D
	for <linux-block@archiver.kernel.org>; Wed, 20 Oct 2021 12:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhJTMcL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJTMcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Oct 2021 08:32:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F42C06161C
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:29:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id u8-20020a05600c440800b0030d90076dabso4892056wmn.1
        for <linux-block@vger.kernel.org>; Wed, 20 Oct 2021 05:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WwuBBStLQugweaehrNZF0FLzNTbyddiMeLAjBxhrgiE=;
        b=cKCcG0jgFs8CIfUXzdMBzoBF2NzuMOMyimgSeQ1za1dBViHiIhZMRLWQuiXANubZUp
         BpOzfK3JvHj/i9C5it573PITTdnwWcqz7c2R4ImFTZbNUG5ACSqDTKN//tx1Knw1Js6/
         Hdg/p/6rxV2pLqsWV4nFZ7v5JctY4fK7/tLlcdzaIjXsZGoZ72jOOlMZHjFFEZ17sCWI
         lW1PQYI3QbBOTEODhBhU4LvyOaPbVDsSAqJRMHzp32Ast/TYA3OGYmJ0KBe4ntv9Dtqr
         +Da7AvBDKMwtdhg1kGkakHrhxzU699gGiMNunDXlcFeSl/EadHEkt0heegUmqmvLzaSB
         UA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WwuBBStLQugweaehrNZF0FLzNTbyddiMeLAjBxhrgiE=;
        b=Mwfppz/HdbimU1pJUP5/rg46Ed75MoseERuD4FlI4SNu6kmkOQ5YVRUYRgrhWBAWQ6
         jtLIfPkffZx1pMrvm0xxjY1vNxdIXpRwgB7twmLik5JBgzesHHIGmaR1jgFKF2JECoP4
         oBjU0LAwO1bj0ToroigFE0d0LPAjCXLCTmws2v5OTV3J5SCr9kvthqA22NuHv07MHN5O
         YcfygAvYuaxg44hiZhyWgGaerqKAcHOndqOrXURX5mLaByWtUCZ24IMe2Que7a9X3mWJ
         Lq6nMPQA6w0ePUxQ1vbMArUXm/+YHTCZfdPgW1ULfYDqplLc9Cr8Xi7COPHrdkKDIvje
         Aplw==
X-Gm-Message-State: AOAM532whfMsGRdTKtB/ljkz8ClJn6jW9duof0+JTiTeTARhr45snflW
        yjJYaAtu5q23cdVtlAwZwck=
X-Google-Smtp-Source: ABdhPJxu6wERo2ahYMS6HECD2rGQ1lFIvUhvE6hWMrEZPo2MKN+G2kWQo6+FZDuC9oxZvoUFfiXvjQ==
X-Received: by 2002:a05:600c:4ece:: with SMTP id g14mr13218882wmq.95.1634732995212;
        Wed, 20 Oct 2021 05:29:55 -0700 (PDT)
Received: from [192.168.43.77] (82-132-229-137.dab.02.net. [82.132.229.137])
        by smtp.gmail.com with ESMTPSA id j11sm1873050wmi.24.2021.10.20.05.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:29:54 -0700 (PDT)
Message-ID: <63ec3431-ac17-be27-d05b-bb519602de81@gmail.com>
Date:   Wed, 20 Oct 2021 13:29:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 11/16] block: add optimised version bio_set_dev()
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <3c908cb74959c631995341111a7ce116487da5c5.1634676157.git.asml.silence@gmail.com>
 <YW+1OxkLRboWQNm4@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YW+1OxkLRboWQNm4@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/20/21 07:20, Christoph Hellwig wrote:
> On Tue, Oct 19, 2021 at 10:24:20PM +0100, Pavel Begunkov wrote:
>> If a bio was just allocated its flags should be zero and there is no
>> need to clear them. Add __bio_set_dev(), which is faster and doesn't
>> care about clering flags.
> 
> This is entirely the wrong way around.  Please add a new bio_reset_dev
> for the no more than about two hand full callers that actually had
> a device set and just optimize bio_set_dev.

makes sense, thanks

-- 
Pavel Begunkov
