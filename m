Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF8D3C433F5
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9604A61139
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 15:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhJMPMH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbhJMPMG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 11:12:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CA0C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:10:03 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r134so22642iod.11
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 08:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9VWuVHtNBFOtV/cu3reVt1FourTtJbPPeMN7AULlydc=;
        b=P/afyN9Eue7Qlwq7g3/Nz6jjDNXqMv3k8vFlkUwl3QYMvdS/7DhRaHW6MnUluWkmva
         LPS7TuSboQq+pYEtYoKwUEfp6++ZeibXsSYq+X7+/Z0dRFQwjbvByp7GfiUzwE2M1NrD
         f28+k7O8QruIcbe6zSbe4wG7hqABT/2PE7fwSqt3S5KdSOu46Lyxr+MifovNXob3Lmbi
         Eh3T+MRdBRmpGmFg6uqb0UyLFrz0JGMwP1deaM8VnRasuzVxrwutzy+8dbAGMn+cQL8f
         bRyr9+6DMLwXuQK9I+be71fhYPxzQZjwed4SE/jnsJnApOW0zRHU1SDGJ6g6qHPA69xT
         Q7FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9VWuVHtNBFOtV/cu3reVt1FourTtJbPPeMN7AULlydc=;
        b=4RCf9RygQANTchX+Yh14ZjRX8FEwm6J0fFyjw6inRjLo4n1A+JJZMy4pFP4aa+BQCd
         zFsRJ4I8RymawDuC6qUUL6wBnwFmRqMMvPKLP3Wi6TaihPFda5kbPjFYrI3UD5Sm07KD
         5Ck8d9+veNwtv8iizsD5Zh6hsZaGETBkxIVOdvKrdvY11adIECvCzo+ivGRJZ4mhG6wd
         WmsiTwyWHwaWcmhjnN2h5pG5RJTUaoYXtxEhNc3BJAv+nf3efKKA5O/qbeZNfVftqgEW
         KJHc01pfiY3q2GFFgpUICR1eN+4uAuM8rRWnKsIsLjL6KdhhBhfA1GxEqh9WKwx0WNkB
         nDvg==
X-Gm-Message-State: AOAM530H1grDll2U5a5fWDAR3vAC9h8ADUQMWsB7B3pChD11fVooH+s9
        ECSRtNyqq1CqKBIkG9Q/3Rxk6Gy+ZE42rA==
X-Google-Smtp-Source: ABdhPJxcTHdkO6GVKZ1wL0e8PGh7BXzvu/COw1+w3gKM16HDGLKHlfwPpyCvXHmtXBXLVEvxI8QmhA==
X-Received: by 2002:a05:6602:1513:: with SMTP id g19mr86572iow.30.1634137802655;
        Wed, 13 Oct 2021 08:10:02 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r24sm4246816ioa.5.2021.10.13.08.10.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 08:10:02 -0700 (PDT)
Subject: Re: [PATCH 6/9] nvme: add support for batched completion of polled IO
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org
References: <20211012181742.672391-1-axboe@kernel.dk>
 <20211012181742.672391-7-axboe@kernel.dk> <YWaGB/798mw3kt9O@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <03bccee7-de50-0118-994d-4c1a23ce384a@kernel.dk>
Date:   Wed, 13 Oct 2021 09:10:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWaGB/798mw3kt9O@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/13/21 1:08 AM, Christoph Hellwig wrote:
> On Tue, Oct 12, 2021 at 12:17:39PM -0600, Jens Axboe wrote:
>> Take advantage of struct io_batch, if passed in to the nvme poll handler.
>> If it's set, rather than complete each request individually inline, store
>> them in the io_batch list. We only do so for requests that will complete
>> successfully, anything else will be completed inline as before.
>>
>> Add an mq_ops->complete_batch() handler to do the post-processing of
>> the io_batch list once polling is complete.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  drivers/nvme/host/pci.c | 69 +++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 63 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 4ad63bb9f415..4713da708cd4 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -959,7 +959,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	return ret;
>>  }
>>  
>> -static void nvme_pci_complete_rq(struct request *req)
>> +static void nvme_pci_unmap_rq(struct request *req)
>>  {
>>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>>  	struct nvme_dev *dev = iod->nvmeq->dev;
>> @@ -969,9 +969,34 @@ static void nvme_pci_complete_rq(struct request *req)
>>  			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
>>  	if (blk_rq_nr_phys_segments(req))
>>  		nvme_unmap_data(dev, req);
>> +}
>> +
>> +static void nvme_pci_complete_rq(struct request *req)
>> +{
>> +	nvme_pci_unmap_rq(req);
>>  	nvme_complete_rq(req);
>>  }
>>  
>> +static void nvme_pci_complete_batch(struct io_batch *ib)
>> +{
>> +	struct request *req;
>> +
>> +	req = ib->req_list;
>> +	while (req) {
>> +		nvme_pci_unmap_rq(req);
>> +		if (req->rq_flags & RQF_SPECIAL_PAYLOAD)
>> +			nvme_cleanup_cmd(req);
>> +		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>> +				req_op(req) == REQ_OP_ZONE_APPEND)
>> +			req->__sector = nvme_lba_to_sect(req->q->queuedata,
>> +					le64_to_cpu(nvme_req(req)->result.u64));
>> +		req->status = nvme_error_status(nvme_req(req)->status);
>> +		req = req->rq_next;
>> +	}
>> +
>> +	blk_mq_end_request_batch(ib);
> 
> I hate all this open coding.  All the common logic needs to be in a
> common helper.

I'll see if I can unify this a bit.

> Also please add a for_each macro for the request list
> iteration.  I already thought about that for the batch allocation in
> for-next, but with ever more callers this becomes essential.

Added a prep patch with list helpers, current version is using those
now.

>> +	if (!nvme_try_complete_req(req, cqe->status, cqe->result)) {
>> +		enum nvme_disposition ret;
>> +
>> +		ret = nvme_decide_disposition(req);
>> +		if (unlikely(!ib || req->end_io || ret != COMPLETE)) {
>> +			nvme_pci_complete_rq(req);
> 
> This actually is the likely case as only polling ever does the batch
> completion.  In doubt I'd prefer if we can avoid these likely/unlikely
> annotations as much as possible.

If you look at the end of the series, IRQ is wired up for it too. But I
do agree with the unlikely, I generally dislike them too. I'll just kill
this one.

>> +		} else {
>> +			req->rq_next = ib->req_list;
>> +			ib->req_list = req;
>> +		}
> 
> And all this list manipulation should use proper helper.

Done

>> +	}
> 
> Also - can you look into turning this logic into an inline function with
> a callback for the driver?  I think in general gcc will avoid the
> indirect call for function pointers passed directly.  That way we can
> keep a nice code structure but also avoid the indirections.
> 
> Same for nvme_pci_complete_batch.

Not sure I follow. It's hard to do a generic callback for this, as the
batch can live outside the block layer through the plug. That's why
it's passed the way it is in terms of completion hooks.

-- 
Jens Axboe

