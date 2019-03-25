Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A17C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C64D20872
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 10:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xZUkVpHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbfCYKyx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:54:53 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40155 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbfCYKyx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 06:54:53 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so7078550edw.7
        for <linux-block@vger.kernel.org>; Mon, 25 Mar 2019 03:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cp8u0+5UjbHelumJDk/PQOXlCH0r005U28GDH7bkstY=;
        b=xZUkVpHpyYdZ43sZGFdMtaBr4YazIJUC6xwIeWDpxET2pMT0WVeMkCYYMBSJhfAIzM
         NWksdvpWtoC1O4hTYaHhC2ZPrjYVgTtByJ0qc5qfferToTbCV665Z+p+vQPQtDFGX+eL
         UEv8LpBtL/KVwcCYqn/rbr4dz4KnxTee5JKezdEVkAysf+b325MwohFTjZHLWR7Se83a
         qrqjVLIxqkS/zagrpL+iwUUYlpDWmxqZTvJ6zOVdFYVJTGTE7gZhzgaLT+JZlA8WmkJa
         GA91uAA4XP2cBtDRwow5kWHSS+vKCoZ1wPB6q+oDg1J8CrWzDgiv/Nd5Ed+QCWUkjLLI
         /adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cp8u0+5UjbHelumJDk/PQOXlCH0r005U28GDH7bkstY=;
        b=EIcQh/W8gEBQBAmTB5HAD0oobF6UWmRg+YBj4heeeNhYcJiZ4gN7qU0bAcsC1C5/j3
         vwdhYG6d0peg6Egpxtj5gvBcYvzpctR931/Ay8suedY8LVrBjV2VCZR7Zgrln3aaE+Ne
         EqNCu15wyYO89v44yxG45wAFN9aaKC8kVWrL4m1x14RVldPgRZD6fHeGKVsZMoCm0Up4
         4+6FAFbxrRc2OR/pXl8kOSu2X6OdBxIt76maHNC4r57fVyj7w5bVJKh4nvm66vWhlIty
         eJVNyUEZR3fF3XJjtbYrDXFJiGxylmFCN7U7HiwajCaVbm3RGdgOIRykqkpl7snqqqkr
         eopQ==
X-Gm-Message-State: APjAAAUMa9fs9JJlwBSh9zGox94wslJrWVyeYsCunAo+kmP2FFqsp8bR
        hbx4YdkTb8WONBKq0m/1Jc2Opg==
X-Google-Smtp-Source: APXvYqx+rIN8kaDRlE7uNSrtvCsjkQtRFGuzq1fErlhioLhpttnlIwPRvfyodOyQQZkNDwDPYTBMDQ==
X-Received: by 2002:a17:906:251b:: with SMTP id i27mr13912368ejb.146.1553511291724;
        Mon, 25 Mar 2019 03:54:51 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id e2sm3405675ejc.53.2019.03.25.03.54.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 03:54:51 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: pblk: set propper line as data_line after gc
To:     Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        javier@javigon.com, hans.holmberg@cnexlabs.com
Cc:     linux-block@vger.kernel.org, igor.j.konopko@intel.com
References: <1552922879-14075-1-git-send-email-marcin.dziegielewski@intel.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <b1b8bd50-a894-292b-19c1-e7a2bd0b4d36@lightnvm.io>
Date:   Mon, 25 Mar 2019 11:54:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1552922879-14075-1-git-send-email-marcin.dziegielewski@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/18/19 4:27 PM, Marcin Dziegielewski wrote:
> In current implementation of l2p recovery, when we are after
> gc and we have open line, we are not setting current data line
> properly (we set last line from the device instead of last line
> ordered by seq_nr) and in consequence, kernel panic and
> data corruption. This patch fixes that issue.
> 
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> ---
>   drivers/lightnvm/pblk-recovery.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
> index 83b467b..017874e 100644
> --- a/drivers/lightnvm/pblk-recovery.c
> +++ b/drivers/lightnvm/pblk-recovery.c
> @@ -844,6 +844,7 @@ struct pblk_line *pblk_recov_l2p(struct pblk *pblk)
>   		spin_unlock(&l_mg->free_lock);
>   	} else {
>   		spin_lock(&l_mg->free_lock);
> +		l_mg->data_line = data_line;
>   		/* Allocate next line for preparation */
>   		l_mg->data_next = pblk_line_get(pblk);
>   		if (l_mg->data_next) {
> 

Thanks Marcin.
