Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D76BC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5561A207E8
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Fso+DmLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgGBEWL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGBEWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:22:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C357C08C5C1
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 21:22:11 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id l6so8780202pjq.1
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 21:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FehuGENcvzp/EQJtVZQ8Al7xnlsXY1VdqZs5dIsreWA=;
        b=Fso+DmLBlu4N3T8KBLvjZdo9R+VHR8JYNcd5e4spBbJGp5Xzbqx2bTXEymZja7g5hm
         VSUDx8Xhu8CeMNoeUEHV30m+29gDaln6LfE8WkB3A28bJkFFTT3azEryvdjiGlMWth5/
         Cn0bnW+QeSX/iGsEAn/UlM/j126DE5kg0udzBtT+5H+MOctBzegnuaYbDCyrcnetOy5O
         Y8T5BxnvcZElG8bJPLXHtuTABWU+zIh885qFuxyrRccBIuFiv222hE7n9SHw1m/5XirZ
         izGdDNSRGA0F94IkI5csJeRXn5UVmpAns5xzFclGmreLlQ4LbnFRBVDFfWYxku49rErK
         A8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FehuGENcvzp/EQJtVZQ8Al7xnlsXY1VdqZs5dIsreWA=;
        b=oK30Evu1gIDa2mQ/zgovaFauOqeyHjy12Gjb2c4USxfyK2LzlBSl6Ij6TrtOhtknZg
         XOU28wF4bhURy5bI4Bn1G80gFbnftcLlFzlBS9qnCu/AeYXKj5a7KNUXLOzhzFSsOWMR
         I5Pxrrv+ekCjR8swZvB6XKnWK0WrT48GqHOMjEtKXB4P1aWBO3Y3h7eump8LnY6MvlnU
         VWT0b0scoC1eT58zFH6bvSxd8vNN1MmuSieiyayUbwVIeoLGyY3Q2nMlqEADOAxNOTIM
         52N+yBicpq1FLxSb6ldq955soblo4aLkXCcX0fIbvmskqQzzFT3a88NvWfAIra1DwlIa
         9LVg==
X-Gm-Message-State: AOAM53335SoGfxb8+KA0xBi7XTBNH8kIkib5fD61hkE+ehBP6D9JUdZp
        ooNjUhQLHRjrv5OSoHvB7xN0vQ==
X-Google-Smtp-Source: ABdhPJwL57A9VA2G1ljqXFzXNc9GSBzuYCq1qL+oM3CboFV1Ao939cK5iBtV+BwSl6wxh6rEXoRGbw==
X-Received: by 2002:a17:90b:1b4e:: with SMTP id nv14mr204519pjb.30.1593663730842;
        Wed, 01 Jul 2020 21:22:10 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:b0a2:2229:1cbe:53d2? ([2605:e000:100e:8c61:b0a2:2229:1cbe:53d2])
        by smtp.gmail.com with ESMTPSA id z8sm7591256pgz.7.2020.07.01.21.22.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2020 21:22:10 -0700 (PDT)
Subject: Re: [PATCH V2] null_blk: add helper for deleting the nullb_list
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20200702004914.9017-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <34fa2184-3642-f341-4e8b-8df66cbe7f54@kernel.dk>
Date:   Wed, 1 Jul 2020 22:22:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702004914.9017-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 6:49 PM, Chaitanya Kulkarni wrote:
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 907c6858aec0..3f5ff75fcb3d 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -1868,11 +1868,23 @@ static int null_add_dev(struct nullb_device *dev)
>  	return rv;
>  }
>  
> +static void null_delete_nullb_list(void)
> +{
> +	struct nullb_device *dev;
> +	struct nullb *nullb;
> +
> +	while (!list_empty(&nullb_list)) {
> +		nullb = list_entry(nullb_list.next, struct nullb, list);
> +		dev = nullb->dev;
> +		null_del_dev(nullb);
> +		null_free_dev(dev);
> +	}
> +}

Since we're making the cleanup anyway, this should use list_first_entry()

-- 
Jens Axboe

