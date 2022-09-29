Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB3AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiI2PGG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbiI2PFy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:05:54 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13927A761
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g130so1110040pfb.8
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jgnDNASof/g3kUSSX5icXdxlDgaWwUplvsCMn1pF5vM=;
        b=JKBVyObYGRAOO4ywPCjymTsySSakqkGw4waL9JKUdqf0SMohmGWuMTTBmLcYp3jchM
         qVf6VGEwYD1B2crtpCBsCnbsJhVyMY1DFCc2n+BNyBIJg6inrzcPouCwkV3waR5XR0W/
         rT3lA0gxdMhZKER49g29N1jEskq9SblBQTksO0Zb5ya6eQMq2L3nQGU+1a5Rg1aatI5A
         tYOpHtQ27ddm2/f0HOOUjWaG8K7ZYD4N8K00QzrXPLlpY5Id3khDKqI7MeHXCJStonUq
         Odsj0OmORM8Q3Q02Z2IaYLusLR7UNv0cuOHNFHgKT4VMfFuz/vcN4JN+1sNO1OReNkav
         tivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jgnDNASof/g3kUSSX5icXdxlDgaWwUplvsCMn1pF5vM=;
        b=a5HFK19RD/uE725Qqv9K+N/JoQvoa9oQosX/YNgSZRCMSnBTZZf0dI2Gh+8TFwQAcY
         SzO/5YhcVKhyJZ6IECCK+yCt+zQvklUnsfre8JWVDkgmlME9wUSBsbddi8K4zZhrv34b
         E4wK04snXJDBo4eL9DG6BLGjMdePwVc6ZLUdQMfmfZtErOpB+TfPJPe+pyhWzanLP4ld
         Q5dSs9c+0qPIxIAQnUXiGNOrH3qUg2OCXw6sllw99ZVDIKXTv/mvUmGSF7lZSLsrLYvI
         5ZXbX0mRAJfnB5T1dJRlRPcAqF9Uwe/z4w0vSvf3TmWIU5a54Dr4+L1YVmsnfv/rxTG+
         misQ==
X-Gm-Message-State: ACrzQf1eDLZdqq6Qg1vnvY6LkBn6RZNDQrHpmY6ZRcym9ARBnT4cnFzK
        hWGFHSmwXl81n099JmepLTOwVw==
X-Google-Smtp-Source: AMsMyM41XNEMrU48oiar1bH4MmONyZw4Yx23PNT3LPamAbK93khCZlOEW5+ehLdXeXaxwJbhGqnvYA==
X-Received: by 2002:a63:590a:0:b0:439:6e0c:6381 with SMTP id n10-20020a63590a000000b004396e0c6381mr3317699pgb.141.1664463953462;
        Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902bf4200b00178b6ccc8a0sm6027002pls.51.2022.09.29.08.05.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:05:53 -0700 (PDT)
Message-ID: <04b39974-6b55-7aca-70de-4a567f2eac8f@kernel.dk>
Date:   Thu, 29 Sep 2022 09:05:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 3:59 AM, Sagi Grimberg wrote:
>> 3. Do you have some performance numbers (we're touching the fast path here) ?
> 
> This is pretty light-weight, accounting is per-cpu and only wrapped by
> preemption disable. This is a very small price to pay for what we gain.

Is it? Enabling IO stats for normal devices has a very noticeable impact
on performance at the higher end of the scale. So much so that I've
contemplated how we can make this less expensive than it currently is.

-- 
Jens Axboe
