Return-Path: <SRS0=8u48=QA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240BBC282C3
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D149C218D2
	for <linux-block@archiver.kernel.org>; Thu, 24 Jan 2019 18:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BgngmbiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbfAXSIQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:08:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36499 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbfAXSIP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jan 2019 13:08:15 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so5837345itj.1
        for <linux-block@vger.kernel.org>; Thu, 24 Jan 2019 10:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ennrxO2+TA9zkaPve5mAjE5oq7jQGv//a4Sb+IfsDFc=;
        b=BgngmbiN/4VsdwAnYPRQpIcT8uwPTLPvVjKvVq3uoh8oOOmfKoFcH6Wsxb0lgBCUL4
         OtjtD8Xo6G3CTiWkXXySA7SaNDHmuJnYUrGspv0gH+98ktlBO9pmfOumRE3jmN65nMcZ
         6kg9oS5+csEsYastPC1I+US/h0X5X3qN6Wx1ooJP0xJAX/OLPmf6x+L7CjY5NJBW9UCI
         j7nU0FNy3gFR8Q84VtpU1lFX6ec8AZchlxntIp9rDvhWfKfPgysQneYPpNnCl7/o60jY
         tmYWTPypyiFfMWturP9ciA0lcHfW2/L7WkKXy2pFTYLKexQtwIs9UUTQVl8RSKV95mUp
         nrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ennrxO2+TA9zkaPve5mAjE5oq7jQGv//a4Sb+IfsDFc=;
        b=CZNFW035aJXu1eWbZTdk4dqPM3+d0DOACkvDk6SYunmtneGprM+WsNjm+b3GSbBq+p
         Io9E+gmXU7zafvgL/+Rb2lBRzNx8oocuTsRstVjStT2rM1RsDTK2+K19/8xcaBtIeyFK
         4vB16tyKlsXCfi5pRUxdPnPDlfht6hVCVHi7LZeqTW1KNw5kedl4QjapYwzXF/oYj0vk
         f05H0YwaKV6vRwSFZ5A6lVIA0aiwyvoJJVh6gYcN8H6lJfduZJ7oI0zGf0cnpGoeEDUE
         lEP4xoePzzUIdwb4mqJTPuxoSyCx3+w7ZuKzuQ/orC9JmGNPY5uift49o+no1aaWegek
         hdlg==
X-Gm-Message-State: AJcUukea77wWTlZ/SxoDUFHvl69EYVmEFEecJDF5cOi2q7OBQZ6pzRxF
        MVLu6jVp2MKLO9XrtnMbkmXxiA==
X-Google-Smtp-Source: ALg8bN6jDY5f6E2UkMC1yvmlHrjg/zjfFpxZK8Gv/AkSibyN/L5+tVer+Vr/oDheHaj/WsIhS6HVYg==
X-Received: by 2002:a24:9e87:: with SMTP id p129mr2017686itd.148.1548353294725;
        Thu, 24 Jan 2019 10:08:14 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x99sm11438742ita.23.2019.01.24.10.08.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 10:08:13 -0800 (PST)
Subject: Re: [PATCH 0/2] small optimization for accessing queue map
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <531e1343-a941-0137-e21c-036ca8dfbd5a@kernel.dk>
Date:   Thu, 24 Jan 2019 11:08:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1548325533-1695-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/24/19 3:25 AM, Jianchao Wang wrote:
> Hi Jens
> 
> These two patches are small optimization for accessing the queue mapping
> in hot path. It saves the queue mapping results into blk_mq_ctx directly,
> then we needn't do the complicated bounce on queue_hw_ctx[] map[] and
> mq_map[].

I like this a lot, the current double indirect does suck, and it does show
up in profiles as well. I'll run some testing with this, thanks!

-- 
Jens Axboe

