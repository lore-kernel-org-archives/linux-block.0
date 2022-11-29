Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA3C4167B
	for <linux-block@archiver.kernel.org>; Tue, 29 Nov 2022 14:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiK2Occ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Nov 2022 09:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235391AbiK2Oca (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Nov 2022 09:32:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603F658BF4
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:32:28 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z17so9057026pff.1
        for <linux-block@vger.kernel.org>; Tue, 29 Nov 2022 06:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=15SxSNHfPSkRdUIJs7jjUNKUA+5AqJcIJ0LWkA4RN+g=;
        b=zI4jM57lq4kblIKU5yxIn9FX6V+mwXkU/iIh8lZgHDF6o2hmGCnyHy3B3R5AW3zo03
         hjQvrFsaRvQtI0g5Labl5sM/kuJCeYftFLaKHZ6I410sDOAUCbpDzcUGQvNq2686lF/J
         Ki6eW4IHGBmRq46BEHvMtEc96woczA3ms6IoZI4gLcDgc8zOWq2tZ2H6Ub8ui80N6Z9U
         HkGB2dX37zZKFsY8kuLyvPFtup1HPZXs5/gaS0SeNMS7Lzs/ueuphSju95F4bqF1kNwh
         H09HRQFrmTKdaKWQtY0kPmMB6iHHdoG9GoMEowOdDBD5uXlEhcY/+qcD4OVPJsV2+7hB
         AD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15SxSNHfPSkRdUIJs7jjUNKUA+5AqJcIJ0LWkA4RN+g=;
        b=mxopMFaOoQd5sJ8qHDXPAbxGqhdzinMqDDF8iZkK/3RFmgJ7PFAF0NDzETPVIj2U2u
         VsCKX3Wy3OJ80Kk28VVBsM2AlBfDy1LEFz6uGGwss3VPTIDwqALhQLn77Qeg1GgsLDcr
         1IcqP1ScolNrmFWStF4MaqT2kJ4vZcNyGNC+YoMCfYDe46NX9TgDCL0+cE1gXwop2hBV
         X7K+b1kRRb0lcQe7cS8BwuxNIkhpzJZF1Rc7FHpm4ORU3MwHXGcfUpy7a02v0zfZ+2gQ
         8ruIQP+8x/bfcpIriG7F5J+cZUfgohpuDzNUSpUuMC/0Ohypg3TEzE/norjmfbajg3yT
         CMpw==
X-Gm-Message-State: ANoB5pkrkWow/rhlXyaSnk+nGmeZVWg4AbyaadbhRQzMuA1T5ypL1npF
        Un0JDfW/bEMkjwyXBXIG9n6N6Q==
X-Google-Smtp-Source: AA0mqf5g6DaXafJJOhWTZSsPpS8P+CKVmgSPtpkqBcyOyey/shhvMPSK01cTYg/DRIth7yaOl0+8XA==
X-Received: by 2002:a62:198d:0:b0:572:5a7f:9f4a with SMTP id 135-20020a62198d000000b005725a7f9f4amr37451404pfz.33.1669732347829;
        Tue, 29 Nov 2022 06:32:27 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090abd0100b0021885b05660sm1447319pjr.24.2022.11.29.06.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:32:27 -0800 (PST)
Message-ID: <d07eee61-eb3f-de75-4cc2-d9c554640a2b@kernel.dk>
Date:   Tue, 29 Nov 2022 07:32:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/2] nvme: introduce nvme_start_request
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org
References: <20221003094344.242593-1-sagi@grimberg.me>
 <20221003094344.242593-2-sagi@grimberg.me>
 <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y4YXDAZDZQbnLIbF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/29/22 7:28 AM, Keith Busch wrote:
> On Mon, Oct 03, 2022 at 12:43:43PM +0300, Sagi Grimberg wrote:
>>  
>> +void nvme_start_request(struct request *rq)
>> +{
>> +	blk_mq_start_request(rq);
>> +}
>> +EXPORT_SYMBOL_GPL(nvme_start_request);
> 
> Looks good, other than I feel this should be a static inline function in
> nvme.h instead.

Hah, mid-air collision. But at least we agree :-)

-- 
Jens Axboe


