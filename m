Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD85DC4167B
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:34:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbiK2OeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiK2Od4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:33:56 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B18AE9B
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:33:53 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id q71so13161708pgq.8
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cuxBsu4VDMAPgQORabQ3hLPzi0PvLOfECIVt9tqDIPc=;
        b=5fbQ/o8HN1uU9Il6X/LoLok2YjQCD3iAUzjAwva8u2Bewi7xDO1eAgXOehjqnG89Vj
         Pm4lJytLY4HLzDTxDQ57abFDn0FcRz7AX4j3J/t2xwcY5eehmHpqxvSK8qNSkYM2A1qL
         ZaALy9wnNsf8drMUlQxrEuSZPwM+tpLba4E1LJOjUsxkQJn+d6wlhrHwcE2U4LHYyN5G
         Ya///j9EpjNnfwrpUqqRMVhx7mygFI/2nWAz9f483CvEih2E5bIJLKij11WLssGjYYm3
         76xopDdej5vs9Bvkir9tHFdhagiFnWYdcfTwTy+0UQMEbX7ozDMCRKXhFX+r5emBZADB
         +K/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cuxBsu4VDMAPgQORabQ3hLPzi0PvLOfECIVt9tqDIPc=;
        b=JZNhroHFe/2ByV0tb3F8O5jg707oeXDNjs59I7DZp4SrKZxNBw20SaXeI+0Z2dqe1m
         sOWLl8NHZzp1aWuAzOYEwOezaGT5W9DNQGA0MnEdmOYG/FcA5HEoop3D2rgxjSj4z4qZ
         O97S/i1EGNDp1vHCYzCEHho34Jdwp1uLfy6v2/4ac9B0kT+dsOq0SLS1B4xbwi/Gz1kf
         w/4E27kG62rpH9wZeIIM4Upmce2Dm/NsRSBTcu63JIkwYp9xyab/G1Xj09WYgk9FB5PK
         1ZJ9uRD+zVD3qjL4V8Og33HwnBrkUaPWkBR0OubUWYD24Ip+X3sCs68x2Cbc0kj/4bgo
         IPnw==
X-Gm-Message-State: ANoB5pn2O8JVRilHayRIKWhx+O9ErS01PjHkbbom5vyVK58dlAIaYA5s
        D/04gdFncyg7xJrIwWW8z8TXKA==
X-Google-Smtp-Source: AA0mqf4cAOnifTIeAsmfaAuLmOW0hFwCVqdZbuyJ5wPVOT+Ju8/bLnxagpvq1GBkii7dmlo0kMDu/A==
X-Received: by 2002:a65:5543:0:b0:477:dc7f:bf24 with SMTP id t3-20020a655543000000b00477dc7fbf24mr20910314pgr.555.1669732432842;
        Tue, 29 Nov 2022 06:33:52 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902680b00b001745662d568sm2818626plk.278.2022.11.29.06.33.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:33:52 -0800 (PST)
Message-ID: <9f45de57-353a-08c9-5d7f-57d7acc67b18@kernel.dk>
Date:   Tue, 29 Nov 2022 07:33:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/2] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-3-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221003094344.242593-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/3/22 3:43 AM, Sagi Grimberg wrote:
> Our mpath stack device is just a shim that selects a bottom namespace
> and submits the bio to it without any fancy splitting. This also means
> that we don't clone the bio or have any context to the bio beyond
> submission. However it really sucks that we don't see the mpath device
> io stats.
> 
> Given that the mpath device can't do that without adding some context
> to it, we let the bottom device do it on its behalf (somewhat similar
> to the approach taken in nvme_trace_bio_complete).
> 
> When the IO starts, we account the request for multipath IO stats using
> REQ_NVME_MPATH_IO_STATS nvme_request flag to avoid queue io stats disable
> in the middle of the request.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


