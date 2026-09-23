Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C794A40BCC2
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 23:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790206714; cv=none; b=K84KBYk/EmaL5Rv7SflBYAZ7TeGGxrSP+B3p+XhwS5m1Wlm89NwmMZNBB86/ZFORyPMbRLDM5CC/g+GrajJ9dQQa/ksp/fUtT/jL8mxZz43tYdsLEhgwQJNREH/hCtBQm1kjVdTn8vuGTqIBuSoLwDV6zGR5c8BleRB4yRVVyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790206714; c=relaxed/simple;
	bh=uvjliwc5dWvX0yJGmF6xGGfU9SCVJG2FjlApdxVUrvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bJK6tvBvcZzVWF1Ctx120MgSzD/Zljhrgg/RZ4FOPTQwdmX8nSOgWE92BwzORGdldYFYFwytto5DVZNDbTHUKNy20vo2OYTBcdcUyG4PSMcxFZ6DLt/RGQ3WlS0/W7hY9BQD3Ezbfh8rMWoulgvwHQnPLdGl/rU/4BwVmNLeBis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=Me/wKhQl; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=WfXwM2pJ; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="Me/wKhQl";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="WfXwM2pJ"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68NNCUTn2037875
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=Zx+k
	9D7Ap9j3fQM34zf1zNWA4velobJXmZMpA1ZCyc4=; b=Me/wKhQlCxo5Q+vaKK3/
	3U89LdILpHbgrth1EogDPvG9ZC0Si92p6Q08KpCAX3c/+SveEg00n5BOi7wrh2Tt
	EYMpcd1V0gBBpFla3wdTGgbEZfrN2wDK608MJe+4VYoChSwhTBl/Pt/JvjciAtFH
	xe54ZTQprcEAkDR9+L8vPCXdsODKI9F9morl7a+0MRKwy2pRGKJEeEyy7LhttO+o
	7UAZKhKzON8V0GS1TZ8LI36p2XILUyvBPO9RdHHbXbj2ymNJ4A9rvc9/3dTG6LGN
	BvIdwusdP76MosdBu4XIXqblJMhaIk/CQpbdncF3G9AGBe8PprxJgJMeluSqoqXh
	zQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gvh5wcpk1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 19:38:31 -0400 (EDT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1399592a91.2
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2026 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1790206711; x=1790811511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zx+k9D7Ap9j3fQM34zf1zNWA4velobJXmZMpA1ZCyc4=;
        b=WfXwM2pJpxwMBNHjGJAsp59DFhQt1dGXlet3mY61jeUnHXF6h09T4QjZJ9LPqsrKwt
         WjKeSkDt5aLTCjOzCSizZtxkaQG4MRFTTzBxQaruhjhr5Q0X29g9rQGfIHBWQmddmH7N
         jMkOv6FeevxRLFeOIcr1gHg3ASt2UZkAmCHd9efPNTXo4SfJTU8rHAMSdDEEsQfyrHnu
         oXeGsr04LhSwPXlX9WLRSDnuWZ4JfoeDt5TfyxbPh+U/Ch82DhbUTEXSSjC87468YmTN
         MVto9cOXavuUWKWbm188UI3lCyCRYiV79BPJGl7jsOj8i6pAvz4F/TliKF8hgSDcPw8l
         98OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790206711; x=1790811511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zx+k9D7Ap9j3fQM34zf1zNWA4velobJXmZMpA1ZCyc4=;
        b=xowTXjUU6QFh6Z/vq9Sv9wt96t/Ceb+5PAdlTgzvO8pocH1WmEGnQE4VbFjDAlDBfK
         PHOa5unrbhDjKKEZGubg4PvrpBBFGyGlROBGf+6KR5rDeEMfieApVS9Qh/ozJxTrbw92
         B4M40o8wf5AOrS2U9bISOGvN5aEFw5PTwRFcwF+IUwuuSUUPJ/3f7toK6LrsSlWJmpQ/
         wii+jmoXtnvoTGjRLKTzBN0EeK5zzmH+M6FA27CyHujA4HMbN1a07d4ZKT2BxN1qkeG4
         QZSXW2mzyYmdFG58HGF7rb3JN5rYN97KnC+xjaLkMxPVOnhI8ql7lExZumhbsVd1Rz/n
         famQ==
X-Forwarded-Encrypted: i=1; AKwUvBydsCOSBb80U+iH1ZjIuQl2ndE6PRLzJxtS66qE7mO8vajCsXfN5UQX01ZUIR+uEtq2iP+LfwKLj+vhtA==@vger.kernel.org
X-Gm-Message-State: AFuF++kjPYpSn5DPehSbDktTUf6pEgZKBX6YxdS5RllNFhe0Ptj0AFEa
	s6rQms+LhYyv8mC4w7dVhWn3N29mXvY1lCKNgAFDDjcuU0LnZpiFK6CnyvSZsk7ZTiQBxQbQTHD
	MruqA9HATIJBIwMA+StZXguTe+1gOy86sY5otzmo9C7CDGHCZ2p9ALvYPbu9g
X-Gm-Gg: AYBFou0oA06EGyJwMRACRFhwSiIdeiSWfKOvLww+0sBrl6vp47KKuDk+3vyE4eAoG3l
	xbbc6jOeOaPb58OJgQuumetfLBrtZqm3g5CGI7MeU1UlCCmB78W+Eo7QYM6081dNZqW9H8MnheG
	Qq9RBauuiFHUi3KEa+x2go6gJufn3lRtlhTDgGpkNUFteTm6oEvOQTpr924R7Trf33gaed/Gz3b
	nK1Nc4VqGYmjIBAQ635wTYeRLQs9OTyRLe04MJw/hFVSQ1FT0R2YVDBzDEWT+OoU4BXyJz3OIur
	wWNtAcDpq5W3nGAca8LeqlIV0iYqRw5i6XdTq970UVzWsHGrACtMVhfg++JxymbWYx/36nglzYt
	n94u4us7pYpciT7ZOrzwSkbqZ6rbCLpvbuEXWy7OhyaiMVheP0w==
X-Received: by 2002:a17:90b:2f85:b0:39e:6a81:f348 with SMTP id 98e67ed59e1d1-3a098bb785amr470051a91.34.1790206711113;
        Wed, 23 Sep 2026 16:38:31 -0700 (PDT)
X-Received: by 2002:a17:90b:2f85:b0:39e:6a81:f348 with SMTP id 98e67ed59e1d1-3a098bb785amr470036a91.34.1790206710609;
        Wed, 23 Sep 2026 16:38:30 -0700 (PDT)
Received: from [172.16.0.184] (RED-LION-HO.car2.Seattle1.Level3.net. [4.53.155.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm1277439a91.14.2026.09.23.16.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 16:38:30 -0700 (PDT)
Message-ID: <c911d621-2fda-4768-8c90-c46dcaa5dd0d@columbia.edu>
Date: Wed, 23 Sep 2026 16:38:29 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] block: fail a short atomic pin in
 bio_iov_iter_get_pages()
To: John Garry <john.garry@linux.dev>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong"
 <djwong@kernel.org>,
        Keith Busch <kbusch@kernel.org>, "Martin K. Petersen" <mkp@kernel.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260921-blkdev-fixes-v4-0-e2801f71ede9@columbia.edu>
 <20260921-blkdev-fixes-v4-5-e2801f71ede9@columbia.edu>
 <07aced0d-35d4-4c4f-95e4-9d3168e24617@linux.dev>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <07aced0d-35d4-4c4f-95e4-9d3168e24617@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: cq-tLnx85BVTsQdADO--5nSiN6kXcbvI
X-Authority-Analysis: v=2.4 cv=DIEacCNb c=1 sm=1 tr=0 ts=6ab462f7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6aZ3Ysb2zzbY2sELL/OBJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=XJsBi8-B-AtTf0VDNmMA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX0zG/ObackIBK
 xbErFSWtLqyZw8yKwb9u3pFzVU40Y5hfrvks/HNjN9iXPo/viq9f5emd7v9y91egQIbZZ+Godre
 5/KjP3kDiGHbrhKZB3yn60nygQEH+f9bOqllMqoN5oyOe8xADwHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA5NyBTYWx0ZWRfX//4Cagy+68CZ
 EDQ3BI7llkiyM5p3kTntpWnna/6RvfuNdu3F1RQMr9BGttNIgj6A9GGBo2cLNoqjg8LwoudZBap
 Pl5Fq5vTPXuX/3TNp5Vx+eWHus43mvRAJsISnl2u6IH+0gkrGu/F2HIwu4dRu7bo/hRqRW/D8QL
 j9wKsxDNGz85nmLIEnVtCH/D/vfjGhZDhyQXy6pOUdTDwXIV76S6itgBcm4J2OJYKzgtwzwaJqq
 mjqSZNdep3s8K3ptPIp5XFPI6+7Z9FGuXCQ8fAowYbHoIboAaZ0Hu5RxoTCX2u/ifmaAg8P+rt6
 jzjy7vTb4vEVSw8bDu0XXmsj8+LlBtoEt04Q+4X3/HyVl8sxh0JzrfuSVrEIzXcClKbwfELF1uo
 yOKBLfoa36Zj585Vzg9CKnL/6Q0/DH1Zm/SZSoTO60W345rNJ4Kt92QLtxTNTBOQaUGswDWZwbj
 zR0mkNJ5rppc6QgaTDA==
X-Proofpoint-ORIG-GUID: cq-tLnx85BVTsQdADO--5nSiN6kXcbvI
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11914
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=10 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=10 impostorscore=10 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230097

On 9/22/26 6:16 AM, John Garry wrote:
> On 9/22/26 03:54, Tal Zussman wrote:
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
> 
> *
> 
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
> 
> There is some commonality here with iov_iter_extract_bvecs() failing,
> above *. You could add an error out label for both error scenarios.
> 

Will do!

> If that does not work:
> Reviewed-by: John Garry <john.garry@linux.dev>
> 
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

