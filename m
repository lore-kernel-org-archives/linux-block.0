Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2409C433E9
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 02:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EC9D64DDB
	for <linux-block@archiver.kernel.org>; Thu, 28 Jan 2021 02:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbhA1CpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jan 2021 21:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbhA1CpU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jan 2021 21:45:20 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6BC061573
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 18:44:40 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id s15so2498495plr.9
        for <linux-block@vger.kernel.org>; Wed, 27 Jan 2021 18:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lmvDCXclOa6IE+XJkq72UxfMlP+2yPszQwAo2L8ANJg=;
        b=HCw0W+KHoz6gTeokd2bGZ+b51Unlk2RRYMWEYv6fZ0jUiPlS5/E0eT1bqBdIyhEa3i
         BrVb/FOGRR4ucK6BZ7FfdWt5KbnEjKtXOgaPjDzkbP8HDxcWsmQ5Xkq2sXbgMbSpThy2
         PmB9g39XuNHPCbO0qJPbUZEXLrD1ROeUwzF89eV/s/ptYhPdnD8kUvp9xfwPBO4Rf0es
         aqWb8Km/6IA6maeoulka8V6RUjz5cvDXgBZeTswAKBabqTmk6Ie58P+QbBsxPZKVz30X
         tTeT5JOM/TDqBWi5QsNEpmmQ/Fsm3ZbSrKzaDbzvtciR7Pn7O5Rl09T+J+A3n8VqYxXf
         jopw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lmvDCXclOa6IE+XJkq72UxfMlP+2yPszQwAo2L8ANJg=;
        b=cuoUx0X1z5PkjQHZm6fsT6Cx7MPX6u9cb1uauxCntHpycc4/AmznZHbr3wh4oW+356
         QNUEV/mQwkMARfHvT5WEJWECUUokwpCAzzdrxFZww3VolsW5HY9/gUUlunJS/kQYIUnC
         oN/imHv2dIppHcfoz+wzDRqUTITrJ/Li7uoZvmulxi8jrtyn0pNAauPURWv5vjoc9nnR
         41gE2nHwwpxOlvJRN1V68pMq3pL1WEN7n/W2gAGKupNPfzqjZCIQs2SgdIJfRRTYqTtv
         2S0ACbChH1Cg835bZ+8LhwU+XOcLUJgwPQ5ycEdYzhvBl38/KIqj8okpI6XFUSCREyp6
         Puqg==
X-Gm-Message-State: AOAM530Cw7YqfnA420TjMNoC3Qrl63X2wmMwNyKshocVjMGy6OLH1OqJ
        V5QWxJe7E6q77in8PMWVbDbI3A==
X-Google-Smtp-Source: ABdhPJyUoYLr2Kox/cS11rFj4e957MI7du6RRijTvNazvJrUOAJL5XHyhvIOYeVsRyk6PWDDoaMbtg==
X-Received: by 2002:a17:902:e887:b029:de:7863:19b0 with SMTP id w7-20020a170902e887b02900de786319b0mr14366222plg.42.1611801878203;
        Wed, 27 Jan 2021 18:44:38 -0800 (PST)
Received: from [10.8.1.98] ([89.187.162.118])
        by smtp.gmail.com with ESMTPSA id 21sm3505940pfh.56.2021.01.27.18.44.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jan 2021 18:44:37 -0800 (PST)
Subject: Re: [PATCH 1/4] block: add a statistic table for io latency
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com
References: <20210127145930.8826-1-guoqing.jiang@cloud.ionos.com>
 <20210127145930.8826-2-guoqing.jiang@cloud.ionos.com>
 <20210127171050.GA1732656@infradead.org>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <9c2c4681-41cf-94d1-12fa-3fe09bec987c@cloud.ionos.com>
Date:   Thu, 28 Jan 2021 03:44:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210127171050.GA1732656@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 1/27/21 18:10, Christoph Hellwig wrote:
> On Wed, Jan 27, 2021 at 03:59:27PM +0100, Guoqing Jiang wrote:
>> +config BLK_ADDITIONAL_DISKSTAT
>> +	bool "Block layer additional diskstat"
>> +	default n
> 
> n is the default default.  But more importantly I don't think having
> this as a compile time option makes much sense sense.  No one is going
> to recompile their kernel to get a few stats or to avoid the overhead
> of these stats.
> 

Ok, I will just use io_extra_stats node to dynamically control the 
stats, please let me know your thought about it.

Thanks,
Guoqin
