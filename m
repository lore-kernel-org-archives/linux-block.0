Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51C3115AC
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206681; cv=none; b=D9TuToXo5YjEU0ir7xTn+8JzdtlTYeewDlq9iZ7cPD0puw/aeOw2GsBK8YkX9ERtCiabXqZuwk8AGy1ov5FExATOlQBTMlrw2/zuYLlC2iQuUpG23XHuTrccEe12eGlydKwBR9xM1Z4B/hNQoc2MCxZqZyBB5XpEx1j5uBJU3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206681; c=relaxed/simple;
	bh=dcfmSxn+2CV96ThFPMNpllLM7s3GmJ078hKUMBhwuNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OC6mKgpmeyIB+a55pnJU70jU9bjnSpzEMz9PTRuWEXU1fdMS1E6LYj7AUyNbkqkLBVJEbvEbZQ/yY8KUkuZFGuPyKbxWV1jUWxzdoaFROewKWYYccy8D4f58ORSjgIBBWzUVQOmWrEz4B6mgEU76AhYrq/iyqEJKcD9pG0Y75cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Zfpy4QsH; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=lhTemABd; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Zfpy4QsH";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="lhTemABd"
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCQAn2931400
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Fre1
	WHO0lJlp8NzPGt+Dbdc0Mc7dWtqphdMSVSo23R0=; b=Zfpy4QsHvaaLa94MobnT
	kwCXTAddtrnNxbwBhiy+m6KzVoOlqE15kvem3FlO+h0otn4GKNJTj/rQjusGjhYZ
	tj3ALk3Lz1bNp2WbDLrOi1AfZcrgEyzmfKtkc3WSn+f5cW/kRzjwMeHnn//mjwEA
	96XllbxosC+Lb80brveDd5koiLolwKrdEJeMvYg5K3AZetdtFfTdTEnPNsCOQBrr
	WR8inS14amtV0eUyJjsnJw/F7hAjEfrNfVbscvsU//SB+xoXp1XmcdNNq14yvcVt
	EfjHnJmAGR92wYVAy2alWJumy3Q7Nu+gYV1bDhfKBefSvywfpQZgIiuY07HIZbbf
	9A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh6a4ej0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:37:53 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso1962717a91.0
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790206673; x=1790811473; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fre1WHO0lJlp8NzPGt+Dbdc0Mc7dWtqphdMSVSo23R0=;
        b=lhTemABdfRtRoxRRjRSPhjgxXGM6rvSsD9s6SSJSnDf4j6/xXbjFAND979a3Djf8hN
         HyEIGjPD2wkunOM1GxZHbe6F1RguhL0hPT+FFKzHrfm7v1M2TwLxKEnV9G4azeFN2BOc
         tFvtGlaNrnlqYyw+vhdklLgfUEQ92LOzwfHU7BwTo0/GPf5v8aAZE4HdFNE8MUvPngVN
         GcIpVmknFRPtqhVqnrtizRu5Hnr6P4BIAPnQUd708X6BbeK4hNunly3t4zwLQC9gdK6e
         W3sS1tA8P56foR7H/KlaxMYd7QRBNg6I4R3QSs3Fn3FVN3zHxnoAtViryc3HrNRgKOB7
         2f9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790206673; x=1790811473;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fre1WHO0lJlp8NzPGt+Dbdc0Mc7dWtqphdMSVSo23R0=;
        b=XyHFqp0qnWD1ybmcoF6n9OkuB7Edy1lX64n0VBbWcJBghPfw43nNeLa2Bb+rmOIk/G
         3GrFygoDKWeL8Pre8PNMRPBUdILqdOGP55KC6mAJ5TrqMYQv9xHw31x1UkH3XwpkZd4V
         be9OLfHIPYouRGgraKNpuvsWr9VwVzjMFTf4BwGoHqruBwdxC+S4o3VTzCdX6oLkR1oJ
         KqL0vIKV9YNk42513rhoQDDvxgQvbsQgxEGBOkvZIFWJxzuP+tRruCx17lnyd43NqS1n
         PbQyzM1bZZDbGdcSysT8RFbuWa2IJ93bcoAwRxef8Y8pJuTF95ukjwcYPPxt4FzxlswD
         EnBA==
X-Forwarded-Encrypted: i=1; AKwUvBxwuz8JOtlWxVx5BzPyccGSnI0WHPM1O/ANujaXxzmJzpx3DUA1uhEtTFpPJL0WevjutQi08L+WwY0yQQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m7ag21Ecu5UUD/oreGmh3OK9m4VAwbj50+au0IrbziJXPHkIHC
	Fpyi4iJYmRKvCTJMoa9QG7fGnCWtmCOpU9jH2p1y6fq6iFRokBz93+MeJrncf1ednT7JInLPRCk
	klIH6ULuOv+uz4F6tfiARvRNM3WhFTi9Nh5Q8jLHX322WuKiMFs25AJoYL7rYeWDBLlo9
X-Gm-Gg: AYBFou2Z8UHZFvksao1GNeYxfEdKQwqFWR/CcWfQDkRX0syzYzw6InhgqsLzKFrXNsX
	b7u0NGkLhhz30qH67E+jlUGmFxhvMRh/MlTMaMm2oE5ZOOhghjfEDHiS7MCpK2YJZA2QOD19w6y
	yDzyJnFyILD10QpZeFbn2VRAGvy+hq6rJ/lcyIVVK2E23UxmsSRsr3h6xHBWizqp40GwjnqYxZ/
	7BjPsoA6+GvokuVkNtz4j2zmJTVVMsB//fu9N2T3PFHHzUqmWkm0L+Gt1ceA826hxNdBw5eTd2b
	kJEJviJ4n/s/tFRSRGAEyn0spRB0vJssAviy1bIRHdp54GuKe6wbw5sTygT2pvs/cy4zQR9GTRl
	30cHo1bpWZEU7+c1/ShzLQyEj5hD/EDgaxcNQoT1pVGwooRxeNQ==
X-Received: by 2002:a17:90b:4c0a:b0:39e:6a80:b792 with SMTP id 98e67ed59e1d1-3a098728e24mr545497a91.34.1790206672577;
        Wed, 23 Sep 2026 16:37:52 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0a:b0:39e:6a80:b792 with SMTP id 98e67ed59e1d1-3a098728e24mr545473a91.34.1790206672082;
        Wed, 23 Sep 2026 16:37:52 -0700 (PDT)
Received: from [172.16.0.184] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1275340a91.14.2026.09.23.16.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:37:51 -0700 (PDT)
Message-ID: <eaac7a07-db86-41c5-9fdc-0e9ad142c5ec@columbia.edu>
Date: Wed, 23 Sep 2026 16:37:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.garry@linux.dev>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
 <20260921-blkdev-fixes-v4-5-e2801f71ede9@columbia.edu>
 <341ec217-4b3b-49aa-9481-4cf7e8952228@suse.de>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <341ec217-4b3b-49aa-9481-4cf7e8952228@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX6yKevhXnQoxe
 pdtWm+OdQV1m3Az9VOGOpd2C2C2rLgpJULz9NIPaoXePa06Fpgjdc4Xmga8/Oy5uqxIMEARAIwe
 V2/0yMNYydGx5v6O/ThjcCn+RNsYs4r8grsX3UERlUQ5NsXRfKJh
X-Proofpoint-ORIG-GUID: kqyew9HnWV2Vf4z3mA3Nh1nnu4AsNiqe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX/Hh+TTZUt32l
 jqdZ99Y+Cbsbb176IdNk3BIpCpxQOkpDDCqx8APjvfjh2IvSte7IwrMPIegB9Tncd3dbYOTbCfD
 xEh0W/qGcY9D5qq+b8QWI8G+WTP0PmYoV+T1hhAE7aK0eesNztD9JyQNR5KAkp20hvUV8YL32Yl
 37Au1XfDLr3ZKq6Y2kOicLIheq9HLbbus1f70PVt2gNz8igywyPj49w8JJOic3JeMGBcZL0aLME
 xQMBp3rNKhcjoo1SZIVs9jAO3xNkPj0HJ49kAkAej1hfgCUrebUZQz7TaA0AvfHFpSlZp13JdTN
 JcQBigAm0Iz2NwF3f86PIANVuTXnP+AmhvCk7dUaKMMAaWCBs0/fw46HsGyNpB6QbmW1Sg1N57I
 fU4ETovG3tBcG9N9VWWYG6d2oNZ723urI/H2bCFjgYfjRU4Lnfeu/AsW9dzWKK1SM0boQPAxApl
 7x5Or/lYtDimwIf3mgg==
X-Authority-Analysis: v=2.4 cv=D6nSufRj c=1 sm=1 tr=0 ts=6ab462d1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=usPcmh10W0ubT8QP8_c3:22
 a=XJsBi8-B-AtTf0VDNmMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: kqyew9HnWV2Vf4z3mA3Nh1nnu4AsNiqe
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=10 clxscore=1015 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0
 lowpriorityscore=10 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230097

On 9/22/26 1:40 AM, Hannes Reinecke wrote:
>> diff --git a/block/bio.c b/block/bio.c
>> index f95b63c0604a..14429a5d4e68 100644
>> --- a/block/bio.c
>> +++ b/block/bio.c
>> @@ -1285,6 +1285,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>>   			   unsigned mem_align_mask, unsigned len_align_mask)
>>   {
>>   	iov_iter_extraction_t flags = 0;
>> +	int ret;
>>   
>>   	if (WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED)))
>>   		return -EIO;
>> @@ -1304,34 +1305,48 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter,
>>   		flags |= ITER_ALLOW_P2PDMA;
>>   
>>   	do {
>> -		ssize_t ret;
>> +		ssize_t size;
>>   
>> -		ret = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>> +		size = iov_iter_extract_bvecs(iter, bio->bi_io_vec,
>>   				BIO_MAX_SIZE - bio->bi_iter.bi_size,
>>   				&bio->bi_vcnt, bio->bi_max_vecs,
>>   				mem_align_mask, flags);
>> -		if (ret <= 0) {
>> +		if (size <= 0) {
>>   			/*
>>   			 * A misaligned vector fails the whole I/O.  Release any
>>   			 * pages pinned by earlier iterations before returning
>>   			 * since this bio won't be submitted to release them.
>>   			 */
>> -			if (ret == -EINVAL) {
>> +			if (size == -EINVAL) {
>>   				bio_release_pages(bio, false);
>>   				bio_clear_flag(bio, BIO_PAGE_PINNED);
>>   				bio->bi_vcnt = 0;
>>   			}
>>   			if (!bio->bi_vcnt)
>> -				return ret;
>> +				return size;
>>   			break;
>>   		}
>> -		bio->bi_iter.bi_size += ret;
>> +		bio->bi_iter.bi_size += size;
>>   	} while (iov_iter_count(iter) && !bio_full(bio, 0));
>>   
> I would swizzle the use of 'ret' and 'size' here; leaving 'ret'
> untouched and use 'size' as the new variable. That will reduce
> code churn and makes the patch easier to read.
> 

I'm going to leave this as-is per John's previous request.

>>   	if (is_pci_p2pdma_page(bio->bi_io_vec->bv_page))
>>   		bio->bi_opf |= REQ_NOMERGE;
>> -	return bio_iov_iter_align_down(bio, iter,
>> +	ret = bio_iov_iter_align_down(bio, iter,
>>   			&bio->bi_io_vec[bio->bi_vcnt - 1], len_align_mask);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * An atomic write is submitted as a single bio, so it has to cover
>> +	 * the whole iterator or it would be torn.
>> +	 */
>> +	if ((bio->bi_opf & REQ_ATOMIC) && iov_iter_count(iter)) {
>> +		bio_release_pages(bio, false);
>> +		bio_clear_flag(bio, BIO_PAGE_PINNED);
>> +		bio->bi_vcnt = 0;
>> +		return -EINVAL;
>> +	}
>> +	return 0;
>>   }
>>   
>>   static struct folio *folio_alloc_greedy(gfp_t gfp, size_t *size,
>> diff --git a/block/fops.c b/block/fops.c
>> index a3a709697b40..90777e8a9a6c 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -342,6 +342,12 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>>   	bio->bi_end_io = blkdev_bio_end_io_async;
>>   	bio->bi_ioprio = iocb->ki_ioprio;
>>   
>> +	if (iocb->ki_flags & IOCB_ATOMIC)
>> +		bio->bi_opf |= REQ_ATOMIC;
>> +
>> +	if (iocb->ki_flags & IOCB_NOWAIT)
>> +		bio->bi_opf |= REQ_NOWAIT;
>> +
>>   	/*
>>   	 * Users don't rely on the iterator being in any particular
>>   	 * state for async I/O returning -EIOCBQUEUED, hence we can
>> @@ -371,12 +377,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>>   			goto out_bio_put;
>>   	}
>>   
>> -	if (iocb->ki_flags & IOCB_ATOMIC)
>> -		bio->bi_opf |= REQ_ATOMIC;
>> -
>> -	if (iocb->ki_flags & IOCB_NOWAIT)
>> -		bio->bi_opf |= REQ_NOWAIT;
>> -
>>   	if (iocb->ki_flags & IOCB_HIPRI) {
>>   		bio->bi_opf |= REQ_POLLED;
>>   		submit_bio(bio);
>> 
> 
> Otherwise looks good.
> 

Thanks!

> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

