Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E694CC6FD1C
	for <linux-block@archiver.kernel.org>; Wed, 22 Mar 2023 09:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjCVJI6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Mar 2023 05:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjCVJIn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Mar 2023 05:08:43 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19B75BCAF
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 02:08:11 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so5772623wmq.4
        for <linux-block@vger.kernel.org>; Wed, 22 Mar 2023 02:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679476081; x=1682068081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=osSMTiTK5JcTm65ANnclln3syX/u0g8hVX9jxGl8Z0c=;
        b=GuVuJV9fpKYpVpopYDNkU/nl8l0smWLI+JCQymrPzlka1d6LpKpLqBtrLS3k8dn5G2
         0iu0VESZhx9xZoDi+TKRiEyP4MChaZDh60No71r2Mk/U4/yTZHl4Bbqpi7FF3ztkXwc9
         nU5kR8blmwdrE0IbZHiheWMRX+/70XFTILowkm3Gn66wFnnRIeE7KraZKuee2FElMBKL
         tKYXHENknbSeA8ArK/9kQC1x8HO6RfDBhK92dVCVsQ6paIfIfoJLQ4eN9rbMUYSIgmxq
         +YcNnme7v9nZHOcOZe+0DhfBYRjY38MvWmOr+nJnzWTFpZkHBBBOHZBpQ+8Up/lmzL5d
         YvGA==
X-Gm-Message-State: AO0yUKX/tGTsnUzMl+grs1aWBOSQy1msiSHxVuRx5AEbqDFmhMht8wE3
        wdESkL0CKZdrd4ovV9ZIfdU=
X-Google-Smtp-Source: AK7set/BJVHloXDXBwJxgApyyFD5P7GlJKpMHsZY88SrjAM69OAqx1S+blmDjhgCbmK5gFJK8Mv0BA==
X-Received: by 2002:a05:600c:3b90:b0:3ee:52fb:6dd9 with SMTP id n16-20020a05600c3b9000b003ee52fb6dd9mr1993684wms.4.1679476081272;
        Wed, 22 Mar 2023 02:08:01 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a7bc047000000b003ed2276cd0dsm16148879wmc.38.2023.03.22.02.08.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 02:08:01 -0700 (PDT)
Message-ID: <9723a6b3-7673-1f02-938e-12a12e235db1@grimberg.me>
Date:   Wed, 22 Mar 2023 11:07:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] nvme-fabrics: add queue setup helpers
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>
References: <20230322002350.4038048-1-kbusch@meta.com>
 <20230322002350.4038048-2-kbusch@meta.com>
 <ac4ecdd4-104e-0fcf-0ac5-42dde79daf35@grimberg.me>
 <20230322082717.GC22782@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230322082717.GC22782@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>>>    +unsigned int nvme_nr_io_queues(struct nvmf_ctrl_options *opts)
>>> +{
>>> +	unsigned int nr_io_queues;
>>> +
>>> +	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
>>> +	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
>>> +	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
>>> +
>>> +	return nr_io_queues;
>>> +}
>>> +EXPORT_SYMBOL_GPL(nvme_nr_io_queues);
>>
>> Given that it is shared only with tcp/rdma, maybe rename it
>> to nvmf_ip_nr_io_queues.
> 
> Even if the other transports don't use it, nothing is really IP
> specific here, so I don't think that's too useful.  But I'd use
> the nvmf_ prefix like other functions in this file.

OK.

> 
> Just a personal choice, but I'd write this as:
> 
> 	return min(opts->nr_io_queues, num_online_cpus()) +
> 		min(opts->nr_write_queues, num_online_cpus()) +
> 		min(opts->nr_poll_queues, num_online_cpus());
> 
>>> +EXPORT_SYMBOL_GPL(nvme_set_io_queues);
>>
>> nvmf_ip_set_io_queues. Unless you think that this can be shared with
>> pci/fc as well?
> 
> Again I'd drop the _ip as nothing is IP specific.  FC might or might not
> eventually use it, for PCI we don't have the opts structure anyway
> (never mind this sits in fabrics.c).

OK

> 
>>> +void nvme_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
>>> +		     struct ib_device *dev, u32 io_queues[HCTX_MAX_TYPES])
>>
>> Ugh, the ib_device input that may be null is bad...
>> I think that we can kill blk_mq_rdma_map_queues altogether
>> and unify the two.
> 
> Yes, I don't think anything touching an ib_device should be in
> common code.
> 
