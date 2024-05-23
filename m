Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8B9F9D4
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 15:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716478434; cv=none; b=d3ugNWLs5iwylOAWohv79LjzL7dNbiHvD0QDg2W46AG69nWXaIIj0mQ7n65Uf+Gv7KY6f8w0gYJ8xX781EVTe37Rpe2fkqvj+bL+ppLP7/qsO+78UEZu64bzT3uIWwvZTq8V//sYejWJGU/R9XbCGnnjRwJuPo4lowoH/FbEkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716478434; c=relaxed/simple;
	bh=nYU1PIO2SFfLSTahfzTNWZje2OwhniNmOSD/p9qzWE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMdfswTb07zUp4mEKr5MFbBdco5FrlFdyNZWEZ+Zo3QexJwx/3JIojC3xqZNbKdyKCNSQmAX3hDxUEcXXhfkUgfKuOoeLlxJQlFchWWld6jVSWJarbZu5NC7iCagEkVTzFpROYzDZfrMq2I9uh+C6ylEqbbGkjl1lURC2rC1NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H6X+St0I; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H6X+St0I"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7e89ade63cdso208739f.1
        for <linux-block@vger.kernel.org>; Thu, 23 May 2024 08:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1716478430; x=1717083230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvWyFJZNYQN+hDCxIRXzzdxVe6wwtRttv3fHKAE+JmM=;
        b=H6X+St0IDQ65SNn6h/goDEToGx4dB73rQlZ1NX0ze66DBN+o/GHLrguWWmmJod0Xqb
         ISltrC3zCvVF+ED7LBUcxWsED1FDhXMFyn/L3qo+h4yJKWnMTX8tEqdrgKVlDaM3S+Hg
         pv1ByuG0sOuue9ys4XoVfpsaSIhyHucPqf0fz/EW2l2ZI5fwj7aWRkbBR+8Y9/3Q7jol
         CkqDUl2sElnY1ZbjEtymH7WakHj4imX4K9+O6kh9ELwJ5MxA5k3Kvw75dQfH4vx8O6iI
         exiqeawGBKK63vnX+rQVpmeLABgLu5X5iO4qtl69biymNNJ13CXxXAoMn7adhzSeynzq
         0dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716478430; x=1717083230;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SvWyFJZNYQN+hDCxIRXzzdxVe6wwtRttv3fHKAE+JmM=;
        b=YFldrxRD7uJK564zSb62vs+V1RSx2PepRHSIoSJPTVVIa3R7zsO73zDC/8+E/HgT6K
         QAHbLAJSxSojC/ZrJqR8WZNtOHMatSElHfVWEJwKC6z1GcmkHzzSbEfL7PokrMBErAq6
         GwP5T7UrWpEoE8Z0auIS/SvaVJn50oMW1qz7h6L8lgutGjxBRNg3cbXJuPSUwFDV5hHQ
         QHR/R5xorTm1zrxKnlFM/YV4Zyh7qDM5HaMwzuGj26n4PCqoHPKQt276SyRm0IiNItPK
         TLwTL6igbXHG6sM7AfcUy62dHPsxhrgSMMAs+nKxCQyDU+2nwRwL9jA0KWcYl8uGsmbA
         fUsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXucdM+UBtVze4zJ9T/UDiTid//qA5xnpKmz4toyDSmvvtl7ULiGZ8ZxGnyrSm7qOncC0V2cGQQf3q53OTkmf8J5XroygzMsqfJfQ=
X-Gm-Message-State: AOJu0Yy70++KJefdcJjW7jJha03+bNRTYjQ066Lrbb1ehWtza2VnK0o0
	WjF7/K2KolN6vHpwSwGWfyL3AtGFH9gEozblTr4TUvVOGmatl/bF9Ym+AeubPIU=
X-Google-Smtp-Source: AGHT+IF5NcgPaSwej7+H6rkVJpCG1LN6K+ptgamP3mzzVLSM397L3FcGvlEY98JyQtKJbxKK2SxjEw==
X-Received: by 2002:a5d:84ca:0:b0:7de:f48e:36c3 with SMTP id ca18e2360f4ac-7e360c17344mr550273439f.0.1716478428270;
        Thu, 23 May 2024 08:33:48 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-489375c13f9sm7936231173.97.2024.05.23.08.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 08:33:47 -0700 (PDT)
Message-ID: <9ef7cff7-1ef5-4a3f-a2d5-5d7e28bb8a44@kernel.dk>
Date: Thu, 23 May 2024 09:33:46 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the iterator
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>,
 Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com>
 <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com>
 <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk>
 <7060a917-6537-4334-4961-601a182bca54@redhat.com>
 <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
 <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/23/24 9:11 AM, Mikulas Patocka wrote:
>>> @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
>>>  			goto out_free_cmd;
>>>  	}
>>>  
>>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>>>  	if (blk_integrity_rq(req)) {
>>>  		ret = nvme_map_metadata(dev, req, &iod->cmd);
>>>  		if (ret)
>>>  			goto out_unmap_data;
>>>  	}
>>> +#endif
>>
>> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
>>
>> ?
> 
> That wouldn't work, because the calls to rq_integrity_vec need to be 
> eliminated by the preprocessor.

Why not just do this incremental? Cleans up the ifdef mess too, leaving
only the one actually using rq_integrity_vec in place.

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f857cbc95c8..bd56416a7fa8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -821,10 +821,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	return ret;
 }
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 		struct nvme_command *cmnd)
 {
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct bio_vec bv = rq_integrity_vec(req);
 
@@ -832,9 +832,9 @@ static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req,
 	if (dma_mapping_error(dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
 	cmnd->rw.metadata = cpu_to_le64(iod->meta_dma);
+#endif
 	return BLK_STS_OK;
 }
-#endif
 
 static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 {
@@ -855,20 +855,16 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 			goto out_free_cmd;
 	}
 
-#ifdef CONFIG_BLK_DEV_INTEGRITY
-	if (blk_integrity_rq(req)) {
+	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
 		ret = nvme_map_metadata(dev, req, &iod->cmd);
 		if (ret)
 			goto out_unmap_data;
 	}
-#endif
 
 	nvme_start_request(req);
 	return BLK_STS_OK;
-#ifdef CONFIG_BLK_DEV_INTEGRITY
 out_unmap_data:
 	nvme_unmap_data(dev, req);
-#endif
 out_free_cmd:
 	nvme_cleanup_cmd(req);
 	return ret;

> Should I change rq_integrity_vec to this? Then, we could get rid of the 
> ifdefs and let the optimizer remove all calls to rq_integrity_vec.
> static inline struct bio_vec rq_integrity_vec(struct request *rq)
> {
> 	struct bio_vec bv = { };
> 	return bv;
> }

Only if that eliminates runtime checking for !INTEGRITY, which I don't
thin it will.


-- 
Jens Axboe

