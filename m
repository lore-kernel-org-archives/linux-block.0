Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AA6C433FE
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 15:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbiI2PHj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 11:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbiI2PHi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 11:07:38 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D6E11E0DC
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:07:37 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id r8-20020a17090a560800b00205eaaba073so1597583pjf.1
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=36OTTwRy+5c5M7fe2EXmhqbct4GRhvZJ9FMcrAFKht0=;
        b=SNoe1BDPa3AgjVgbKlJugpoKUqqiu+dfjZfcp2/52Nhd/QSECre+9KJQjNO3a+TCEm
         PtuIoIG+9DRAv7E6dW9scD+uJMQyErVAXdxPSSXAhbdqZ/PPrh3ncSHSlpUpWxdJdY59
         hhwqj+vfDZnhefJmbNAFrc8G4AXNyJcNnWlvK5bdQFhiWcMaO5Ss0O2OF/fRrNuthYE0
         Qk6DTWQLcDrDoVhZLXn/HEdTfsYbUD+TPH3XsVu4/TmrOe7mGT8uFozka0wGasyi/7rT
         hlzIo+XofpEipzrY9bvCg6SoP6bXNR/S4AqXZbUuPNimauUCkBHw3mWZNuHFteflqIyw
         koZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=36OTTwRy+5c5M7fe2EXmhqbct4GRhvZJ9FMcrAFKht0=;
        b=qxySDZWn7ysRwcbs6480eX4ry922Rk90MXcpDwjzvZoFSqCZswz0JTj86DZRNbLUb3
         P9Nan89dcUknEjlLctMKZIFCldfrKO6VQOXh/uxx6ZRUJfIp8l1aWRv73C8u1vd1P7tl
         V8HwwG+n4pB6CCmGLaWTkbvE0wjV9EIs+LlIQm7opbyTKGAxFVWNimOlpxxnFxomRjf8
         CLiXDl8/U56OIMxancSIz/HK0BWY7q+uAhDN0mOw+2MBGdv1OnxKpSoQHv2cKIgaKqBs
         3nLCSiA/DWHat1V6U4ph4CT0W45Ol1ztypmh83mL44YAT6DWLetMmrTfMHjebn+VsE56
         4LZw==
X-Gm-Message-State: ACrzQf3OxYgW5ZNe+bPlhh/OkTAzMXGOpuU4XZ2CrPM0sC/S1Kpdm75/
        BEPbIyHvsnmZ+ZH4CWSINWfnBw==
X-Google-Smtp-Source: AMsMyM5x+qK0MT841AFb/0462HlriETBk438rHme2KGFcNnIBwf6hCVBnBgtLQeLsm+vStdYi/DAiw==
X-Received: by 2002:a17:902:a50d:b0:178:9701:c02c with SMTP id s13-20020a170902a50d00b001789701c02cmr3848250plq.145.1664464057409;
        Thu, 29 Sep 2022 08:07:37 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016d5b7fb02esm3315601plk.60.2022.09.29.08.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 08:07:36 -0700 (PDT)
Message-ID: <cfdf4e12-a855-49c1-2c65-7e49c24cd2c1@kernel.dk>
Date:   Thu, 29 Sep 2022 09:07:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4588d1b8-c2e1-bebd-3aaf-29f94cff6adf@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/29/22 4:04 AM, Sagi Grimberg wrote:
> index 9bacfd014e3d..f42e6e40d84b 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -385,6 +385,8 @@ static inline void nvme_end_req(struct request *req)
>> ????? nvme_end_req_zoned(req);
>> ????? nvme_trace_bio_complete(req);
>> ????? blk_mq_end_request(req, status);
>> +??? if (req->cmd_flags & REQ_NVME_MPATH)
>> +??????? nvme_mpath_end_request(req);
> 
> I guess the order should probably be reversed, because after
> blk_mq_end_request req may become invalid and create UAF?

Yes - blk_mq_end_request() will put the tag, it could be reused by the
time you call nvme_mpath_end_request(). It won't be a UAF as the
requests are allocated upfront and never freed, but the state will be
uncertain at that point.

-- 
Jens Axboe
