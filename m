Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82036C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57B3A207D3
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 15:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CahS7+Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404399AbgE1Pgc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 11:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404463AbgE1Pg2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 11:36:28 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083C9C08C5C6
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 08:36:27 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y18so13675004pfl.9
        for <linux-block@vger.kernel.org>; Thu, 28 May 2020 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=j2E+QWCN99GkL+jUWwqOa5WumEbu9hymujfpSZH48JM=;
        b=CahS7+Oqf9MMiC+5XoJAyIlCTgM/47HU083Pw5nxpdLBudce0LynUHMZq4q44nzko6
         mb7paavfK+jutO373Ba82gtkCxmfPS9fJasvKEnJvIL2FZ/LD9OE9a3HX00xyAJ4J0b5
         QjvovIyrYvCRWiR2/a1WUDwzm3gayuv5F6NmAMUTtzYTX48IH4gSMxgWyVIRpT5Ij8p0
         4EW/r7lcsSAjYJEI5fDfgDVA1clwXzuBBQRPzQpu2OTaZSC7pUJgyCpHYHBPcV6Xw2sA
         Jdh1rDfyZLiorpssBXKx7PgNXtnhO+S9BYegImv2msGTvJDy7k3rY4Dr/gJYCeS2Fd92
         DsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j2E+QWCN99GkL+jUWwqOa5WumEbu9hymujfpSZH48JM=;
        b=o76AP90KwIAscwX624/gNsq2qg7dkz+W1sO/XvKgnfiY7aVMcv1kZz/hnj6rOaGC7r
         gg0o+IB/+3r+9jJ5Ow2E6PhOmRoUJQHEJ9ebeHD0Kymvfpnmd1w5/hsOm0E83Yz30qI5
         ilnyh6Ge+PNY4Hf2jX+5l+QO5sDt8GQR0PI4/RmxrbCAtpu9X0935/hZPUqCNtd/mRY0
         gLyVFC8NIKg533AsQIk/XqCUaskgOsSw78Mi2aQjiLvfExnQay9ZWxb41IhWWydwlwm2
         0Omvwo23hEIJYnuNWHec6Vn3tR4c4Pd+IrViIStzi7nhk5UmGU11Zpq8/XHkVnLLnZnl
         OU2w==
X-Gm-Message-State: AOAM530vhGCVaHkFJp/XroCY77bRIiXoY3rwHwVun+gL3qiGVteFCmcj
        WbzxRMlarFopmW/RHcrwOLRToptsJsUOPg==
X-Google-Smtp-Source: ABdhPJzTMGWXsJcMQNUvqT+/Wgk98+2+yEQ0N9aF/rgpbgwENcF0LDXkmiClZdcsegasGJHD5S9Sxw==
X-Received: by 2002:a63:b606:: with SMTP id j6mr3585474pgf.334.1590680186112;
        Thu, 28 May 2020 08:36:26 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm6227351pjg.51.2020.05.28.08.36.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:36:25 -0700 (PDT)
Subject: Re: [PATCHv3 1/2] blk-mq: export __blk_mq_complete_request
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org
References: <20200528153441.3501777-1-kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d9376cc4-16a2-2458-7010-d18b780c7069@kernel.dk>
Date:   Thu, 28 May 2020 09:36:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528153441.3501777-1-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/28/20 9:34 AM, Keith Busch wrote:
> For when drivers have a need to bypass error injection.

Acked-by: Jens Axboe <axboe@kernel.dk

Assuming this goes in through the NVMe tree.

-- 
Jens Axboe

