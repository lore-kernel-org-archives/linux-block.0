Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C49C433DB
	for <linux-block@archiver.kernel.org>; Sun,  3 Jan 2021 21:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C22E207FB
	for <linux-block@archiver.kernel.org>; Sun,  3 Jan 2021 21:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhACVzk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 3 Jan 2021 16:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbhACVzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 3 Jan 2021 16:55:39 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D38C061573
        for <linux-block@vger.kernel.org>; Sun,  3 Jan 2021 13:54:59 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so9181464pjl.0
        for <linux-block@vger.kernel.org>; Sun, 03 Jan 2021 13:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q5mLi1qo1IvniJ/lg8x05dulOHxR+g5L4Otl0FpGxeo=;
        b=Zm8cFyx61w8VNooVwux4OSVgWoFC0L/VNSpg6N1plJYyty6xvPZ79xT0Ecv45mJaBy
         +504YGPF72+1F1WVKMEZQVjca2IH1mHBibyF/6StM90cm2JpKWQm4mTWSrft9r3+uErB
         AWEQ3C8+6DHBSCDm8LFwhz/xmnSp1kWqe86pggGssGKTsmjnHMO0260U7Mu1Jk2PQBs7
         5LdpBCT43X5XTCHNL5dHhYiyWawjjEGDiqURwJMIsKMlQcRpa+sEpN+NNs3tCXlYavFI
         Szvw9JlZZLVQZyh6Yi8jhvUlAF+b89Yn8xE0suJaMy8HaMEgS+prj4VtMBKXkjOzTyD7
         tD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q5mLi1qo1IvniJ/lg8x05dulOHxR+g5L4Otl0FpGxeo=;
        b=bTn+opJMIitakc+Y5vlpFrcPFEX25UtIBJzd44Gs4LtLMYAsnpm/HJNjJpPs9C+UZC
         yOt60BfJPZ7WpOdCEQmsnvD8x7hzLuAf4maInm9lb8vKCND0o7MWl51ZNmlj239zY4jm
         tlcf6LjKNtYNkSnJqViM2pzMYGmY2XsqXeMwFF/WtdxEHRlAgkbkTW2bazjYFJ+/gBIO
         JPnj60E6/jS6tsXacfDiCHwKGy8eQSPlyGiky2tNYUFPgMWxvBGsO3uhYPLJyB93Wjrn
         IdcpPdpj2uiE5UEawRUGGy8UKe35lpkvK8Wt0jWIcqKcMTxF1zEhdopQlpSqx+mFEuiN
         cryg==
X-Gm-Message-State: AOAM533aQ/mpMMSoMT25ANBWg9SUf8aNOLsmfgRvHp+mj5iZgLIkbj3v
        iKXa8qAFzM5EXR3uACfJlUpgFhd7TJz/ug==
X-Google-Smtp-Source: ABdhPJyPlNxLHz9ZxDwdqXdCeF/3G7Y3n+hEdqmWtcg/tF1iQwG/dO9760WCBt4a2+gWDHEfnnM+Bg==
X-Received: by 2002:a17:902:c104:b029:da:5206:8b9b with SMTP id 4-20020a170902c104b02900da52068b9bmr69469586pli.46.1609710899060;
        Sun, 03 Jan 2021 13:54:59 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 32sm45045920pgq.80.2021.01.03.13.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jan 2021 13:54:58 -0800 (PST)
Subject: Re: [PATCH] block: rsxx: select CONFIG_CRC32
To:     Arnd Bergmann <arnd@kernel.org>,
        Philip J Kelleher <pjk1939@linux.vnet.ibm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210103214254.1996764-1-arnd@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <27333956-47ad-4f5b-56de-6b2214b75d0b@kernel.dk>
Date:   Sun, 3 Jan 2021 14:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210103214254.1996764-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/3/21 2:42 PM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Without crc32, the driver fails to link:
> 
> arm-linux-gnueabi-ld: drivers/block/rsxx/config.o: in function `rsxx_load_config':
> config.c:(.text+0x124): undefined reference to `crc32_le'

Applied, thanks.

-- 
Jens Axboe

