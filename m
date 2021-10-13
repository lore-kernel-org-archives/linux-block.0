Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F89C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361976101D
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhJMPJK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbhJMPJK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:09:10 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A39C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:07:06 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id i189so69746ioa.1
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=efQpxf5RQvXsc+7UIRu2Dcazc5/9rxWh9/muFVLW0tY=;
        b=KqVuh0dB+Keze+2KbTGRVRQCDzehy5OIWDyHk8RPXW5HZjDgpNZ/8dtlSVQYvhHuLc
         MTFlKTRVGsWzm0rEzMsDmlTnygkZp/62brE33a1fPY+pmLKnIQ5Z3MHIEaPfsk9SbwXn
         MrbmfrA7CyxZVUTdfvH5AXGCA9ThBJQo1U6aeKVI4lvkLwNmCtLQiCLUTLNTD00LWaNJ
         VjuNoznFtYmbin9fd+ZM0wEIYZfNRPqqGLqtWXEji8ZMm6t3lu714XbaPbhCWItEfvCt
         F8RYihfgFaU5rfXvtpyApUrIVuBJVbK38EnibZM4W0eS288anCW9kUEOWCWLK+5MFLlf
         Gnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efQpxf5RQvXsc+7UIRu2Dcazc5/9rxWh9/muFVLW0tY=;
        b=ikrT00QbvzcpAmy2wJx5L+qz/iLyOboF9hqYiCPCTAlFlGdlh0VG1v18lmszbmLp5+
         GZ3FHLvG1R/Lwa9dIn90wwFkH4GleYCAe/xvO2xCy9NaZS6Wi1BafawESVRUTF+wKkLL
         e1fw/XcMpdr1JL3D0r+Dw4QODZX88ewKcWRXS7Cb+XyU/9yQFRzoS3yJTzoZUaNDMCtm
         FH4Z+j6Z6F5GtvAyMZK5DIfiNineHhKCgb5itWfMbca3+406DVjBkcYxRDi6JeWT+Akp
         fUgA8qUTQOVzPKBkhLeMIaM/BbfOuAZGJTs6CZ4x/Q2HhBEgnNxxOiA/BH4Z32wqnZIO
         c/nA==
X-Gm-Message-State: AOAM5307ckqTZdiT0mMY36isPKuNG1Gujv9Tac7p2Po88bDtXvgBmXD7
        V9e3FBiFxVFTgK6EStLKmhyy4WMNep62BA==
X-Google-Smtp-Source: ABdhPJw8ATUvf0k7jWoP6sLtDCX1tTIUM6E5cPYOI4dl30rAE0UcabpvcRR6jEHNBHbF4xL1QjxfKA==
X-Received: by 2002:a05:6638:40a1:: with SMTP id m33mr28632423jam.33.1634137625933;
        Wed, 13 Oct 2021 08:07:05 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r11sm3559437ilt.83.2021.10.13.08.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:07:05 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     John Garry <john.garry@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk>
 <659e549a-db56-ecae-35a3-2f6203dc3a28@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <228a30bd-c931-d7c3-52dc-5ef4e98de2f4@kernel.dk>
Date:   Wed, 13 Oct 2021 09:07:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <659e549a-db56-ecae-35a3-2f6203dc3a28@huawei.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 3:09 AM, John Garry wrote:
> On 12/10/2021 19:17, Jens Axboe wrote:
>> Signed-off-by: Jens Axboe<axboe@kernel.dk>
>> ---
>>   drivers/nvme/host/pci.c | 69 +++++++++++++++++++++++++++++++++++++----
>>   1 file changed, 63 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 4ad63bb9f415..4713da708cd4 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>   	return ret;
>>   }
>>   
>> -static void nvme_pci_complete_rq(struct request *req)
>> +static void nvme_pci_unmap_rq(struct request *req)
>>   {
>>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>   	struct nvme_dev *dev = iod->nvmeq->dev;
>> @@ -969,9 +969,34 @@ static void nvme_pci_complete_rq(struct request *req)
>>   			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>>   	if (blk_rq_nr_phys_segments(req))
>>   		nvme_unmap_data(dev, req);
>> +}
>> +
>> +static void nvme_pci_complete_rq(struct request *req)
>> +{
>> +	nvme_pci_unmap_rq(req);
>>   	nvme_complete_rq(req);
>>   }
>>   
>> +static void nvme_pci_complete_batch(struct io_batch *ib)
>> +{
>> +	struct request *req;
>> +
>> +	req = ib->req_list;
>> +	while (req) {
>> +		nvme_pci_unmap_rq(req);
> 
> This will do the DMA SG unmap per request. Often this is a performance 
> bottle neck when we have an IOMMU enabled in strict mode. So since we 
> complete in batches, could we combine all the SGs in the batch to do one 
> big DMA unmap SG, and not one-by-one?

It is indeed, I actually have a patch for persistent maps as well. But even
without that, it would make sense to handle these unmaps a bit smarter. That
requires some iommu work though which I'm not that interested in right now,
could be done on top of this one for someone motivated enough.

-- 
Jens Axboe

