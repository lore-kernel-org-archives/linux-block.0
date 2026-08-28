Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F8459AF9
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 14:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787927797; cv=none; b=bm7561IEfsO+4Mta/dOQjJhF4840LgkRagvEQCuVvqQ3oSf3OCg0du82oCqbBdQHqm7GlzHi+cU7kLCkDJORnE+H4+SvKmG15vAYINkGYNbWuJPxOQb0xm9H/BX7L6jUAOfFds7jdEUnP90myZzjBtWenTECh6Ra0VxyLPPAfE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787927797; c=relaxed/simple;
	bh=4JiDX/yubXfTIhjMav9YvfmI0tVcsBWXL9wlEHdvhAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIJPvysBtMRh3cgRQtgQjc/OEHKJ5EWlqhilWaU6hTXXxazZ3Oin1DzNsGLT2x5AOMuhl0iSnHoDB+OP05EzmPSt4v72ILt0E2xPLV3wLdhX2F42YZYXvhw1fDshbQYa95prElTt7IJw9fxUZXocuxwrzSpbXuTKq1IJ0F/5WH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=F12H2c2U; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=p1Tp0I0F; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="F12H2c2U";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="p1Tp0I0F"
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SEYJmN2332340
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 10:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=598u
	fPSbILHNfdSaKUhv0/mnqSbYE6cS+Ejd1n/aDFM=; b=F12H2c2UtXrwM4aiV8RY
	T6eQfL7tPt9zJqQ0qDMpHJTRIQx7uGaXr8PNXlYmtIP4tw1xsinsanB65kvwh6yr
	cJWEGlHk7hbi0+jCkEw+P/O34iplGmfv49C3D1qBwP+Wwyl+lcaVjXbwVYyCayZk
	qyIlyk6Gia5BIiB1ESl6zKVrwigefZhXwWUTyxis/IL0bPrfDUvT9IC9t+p3zqnm
	9dsIKRbVfZ5zPwf//UZ/woAuXC1Z9hwJS8+RkgdjQ5NeqiZH1tvUQUWT8nAWoryf
	aYCSICh+wUlIkDYoWFVtNBPlhDVehUoa1Fy8e76aK0yqkmYKCfhPTrWp60RRKqJZ
	Qw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gbbvgg6bg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 10:36:34 -0400 (EDT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52f9f6b85cbso10697991cf.0
        for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1787927794; x=1788532594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=598ufPSbILHNfdSaKUhv0/mnqSbYE6cS+Ejd1n/aDFM=;
        b=p1Tp0I0Fiuti0m4hHE8wwKweya+3mgI8DhCdWRfwLKLyq/SqLxB9S5IHwWySNFkRf9
         9bkIl1tcT8KkK0sS8JV1FZD5Qt1bFL7EMmxnKDk5T8NYLvqkf9ZD9GOxpGVLvK0618fF
         CgzAzFKe24979y/RomedOoKXqpYmlzj7S148r7p7mlevJ4Ri13p8AyMZnQ3eg93b9WAe
         qHP165Up+VT+gL4BQwBhNq2tpOMjFiJ6sYWZgmG+DduBTZkEVutzL4W1SWlB2qLTUy14
         paM9ARp6la2zLACFb2HKfl+FJmgtm6dctWnZbkgMXU6QnecPxU3/oMcc8E9RIPOzfChS
         +wiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787927794; x=1788532594;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=598ufPSbILHNfdSaKUhv0/mnqSbYE6cS+Ejd1n/aDFM=;
        b=Felt9QpmP/gAYI1aFrXv2KWUZdVgIj0mH8nB/hUGwUtS1kfz0zkFdKNUI9ggciXGUp
         byrIKMN/eMkbBiKAqRocBC+iqF32JcWwsJ4Vd0sF+tWeKANOV0w1hBYEQINk3TlYd3St
         Isv0HcWIXPWb/2Fpa2yrsqu2+YUWlhX+iU8oMFuLx+kcBExcTbXmkNp4mmhTt3lUTdYe
         q0y30VbxsTzzI7O4ZXdtLRX/gi1Q53tTs1e0+TLHPD5bRjbhHNb8QU1HUkMbggiiU8KQ
         VuEde2kVZwGzo9Bj3cpMyD9rUuo+L/EiU24C/Ldz4PzT2nkX5r+yKRprKUgYaxK9s4Nc
         RY1Q==
X-Gm-Message-State: AFuF++nvqGeIXUfxHy0erxhDfQguJgN+N7Vh8eAiueDJbHy/3C6OR/YL
	rA2kQdxLNTF5ixUTHkHPIz/HBT80SkJnuGNY8fGK8ZanBhxgMeKlWpQImHL5Gi4psE+1mUu9pKj
	6KhgY9LkoxYfcPtqsERazSSPSD86w1NReHlhOpJXLZwxtctWCKS6rTIhkS7U/
X-Gm-Gg: AR+sD10cizOTWvbbgSuS/B2ratbjLp3AGTzQiuhAMEuLUQyYzLhjD8PzJIpjnPkyWn4
	LiBaEq75n9lVebjz2uoCFB/ybHz3933vP3qGkhUNBWRUTpJenAzfFknYxFYd+uJjpsf5UkEFtnE
	sgbmHyaJAtM8qy+7a4SnHdtRclnQ2zaOQpcSv9SLNAIoS0+3DnmngZi9bo3wi6C78UzbJLn9xqZ
	Dwu2RTg6nKcf6pu3ZD+W0KZQyF067EZOjdRqwEC8HKTlP4XPGDcsrR8BYFAHDxlEyIn7W5hfHcg
	wZ6S4fi5Zys2C/o7vNcaQgP6snyLkXqVMtpQ0UJsB64/ZSfNnTVaqnvYdtnc3q1++tut9wgo2rK
	enqJwuAAzhjYxNau5a6bYC55t4lB7XWy5eE4OCxnTPgH9K9KY4paI/J/N1k/LydQ=
X-Received: by 2002:ac8:598f:0:b0:51c:805:1be3 with SMTP id d75a77b69052e-52fb96ffa65mr81226361cf.31.1787927788725;
        Fri, 28 Aug 2026 07:36:28 -0700 (PDT)
X-Received: by 2002:ac8:598f:0:b0:51c:805:1be3 with SMTP id d75a77b69052e-52fb96ffa65mr81225571cf.31.1787927788195;
        Fri, 28 Aug 2026 07:36:28 -0700 (PDT)
Received: from ?IPV6:2a00:a040:199:85d9:7dc6:c240:3de1:e554? ([2a00:a040:199:85d9:7dc6:c240:3de1:e554])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20793sm4116286f8f.17.2026.08.28.07.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2026 07:36:27 -0700 (PDT)
Message-ID: <8da4a2dd-a4ef-4a61-888f-60c611d3f911@columbia.edu>
Date: Fri, 28 Aug 2026 17:36:24 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] block: unpin all pages of a bvec in
 bio_iov_iter_align_down()
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Hannes Reinecke <hare@suse.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner
 <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-blkdev-fixes-v2-0-32f3f40cebed@columbia.edu>
 <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <20260828-blkdev-fixes-v2-6-32f3f40cebed@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: oPgxdI-uKvX9pkg7WCcGRFuC9tO0ECyl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyNiBTYWx0ZWRfX2BFtJkKRkofC
 DYKz4IWc68H2AVP0wulyh6mzi1REjfg2I5bCdOaq0tQ3qmjMLtIZPtZ67OC7Gf/Q44+v54i6W+T
 nzQm9IMK5e6Jh7mqeVkZyTCk8e7SNkeKscoIsQg+2823h2KruYOh
X-Authority-Analysis: v=2.4 cv=M8597Sws c=1 sm=1 tr=0 ts=6a919cf2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=8X_uEV4oKehs6EEG2ucA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: oPgxdI-uKvX9pkg7WCcGRFuC9tO0ECyl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyNiBTYWx0ZWRfX3PphMJUGXetp
 yiqhVFez12LR7y7iiWalEz9ddgRP1ydJnmNBqsG1y27pnKmjGER+QXW19N56EK0jD3Aaabg0ozA
 vWgqKQYju72sfjI9+eUVC0IywQ5nwVfAXwha+vZC3CoEtamGKmZDpx/437HyDZ+k7BApkIZSqeP
 NsVPe5mr+HiQFG2HiZRIr0WvzIKcNsiHUpyXiH2C3rpf3QsiPtGhClML/77erBgHt+bmM6FTZ1e
 f48AzsA7Exbof+YyuFGMaD5UVKvDwBKDNFlk4IlXGOH8eEH2Ny42LN0AghVKN2iN/atfxd3smJ8
 /785ccnh3FEala+VHAY2/QR3cHkhF9M0yOTZmr+Bx8lnASVkTCvKgRODpW5y1TFsSVkzBgaHsEd
 Z3w5SCTL6pA4kPPzqfvdHGuEtw5Z/LCOcgVG2T3RnZwtdEMwIvqqZdL5NZthsUsj0HxRwpMQzyV
 nb/PImMimPjqYuimfUg==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11889
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=10 impostorscore=10 phishscore=0
 malwarescore=0 lowpriorityscore=10 adultscore=0 spamscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280126

On 8/28/26 4:49 PM, Tal Zussman wrote:
> bio_iov_iter_align_down() drops trailing bvecs with unpin_user_page(),
> but a bvec built by iov_iter_extract_bvecs() can span several pages of
> one folio, each with its own pin. All but the first pin leak.
> 
> The partially trimmed bvec has the same problem. Shrinking bv_len does
> not release the pins for the pages cut off by the trim, and
> __bio_release_pages() only unpins the pages bv_len still covers at
> completion.
> 
> Both issues occur only with a logical block size above PAGE_SIZE and a
> large folio backing the user buffer. On a device with a 64K logical
> block size, an O_DIRECT pwritev() from a hugetlb mapping that ends 16K
> past a block boundary leaks one huge page per call, whether the
> remainder is its own bvec or the tail of a larger one.
> 
> Unpin all pages of a dropped bvec with unpin_user_folio(), as
> __bio_release_pages() does, and unpin the pages trimmed off the last
> bvec as well.
> 
> Fixes: 20a0e6276edb ("block: align the bio after building it")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>
> ---
>  block/bio.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/block/bio.c b/block/bio.c
> index 898b2f5ef8c8..48fa6b9a6dba 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1196,6 +1196,11 @@ bool bio_iov_iter_set(struct bio *bio, const struct iov_iter *iter)
>  	return true;
>  }
>  
> +static unsigned int bvec_nr_pages(const struct bio_vec *bv)
> +{
> +	return DIV_ROUND_UP(bv->bv_offset + bv->bv_len, PAGE_SIZE);
> +}
> +
>  /*
>   * Aligns the bio size to the len_align_mask, releasing excessive bio vecs that
>   * __bio_iov_iter_get_pages may have inserted, and reverts the trimmed length
> @@ -1205,6 +1210,7 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>  				   struct bio_vec *bv, unsigned len_align_mask)
>  {
>  	size_t nbytes = bio->bi_iter.bi_size & len_align_mask;
> +	unsigned int npages;
>  
>  	if (!nbytes)
>  		return 0;
> @@ -1213,14 +1219,24 @@ static int bio_iov_iter_align_down(struct bio *bio, struct iov_iter *iter,
>  	bio->bi_iter.bi_size -= nbytes;
>  	while (nbytes >= bv->bv_len) {
>  		if (bio_flagged(bio, BIO_PAGE_PINNED))
> -			unpin_user_page(bv->bv_page);
> +			unpin_user_folio(bvec_folio(bv),
> +					 bvec_nr_pages(bv));

And right after sending this, I noticed bvec_unpin()...

I think a cleaner solution is to move bvec_unpin() up, make bvec_nr_pages()
handle bv_offset > PAGE_SIZE, use bvec_nr_pages() in bvec_unpin(), and then
use bvec_unpin() here.

>  		if (!--bio->bi_vcnt)
>  			return -EFAULT;
>  		nbytes -= bv->bv_len;
>  		bv--;
>  	}
> +
> +	/*
> +	 * __bio_release_pages() only unpins the pages still covered by
> +	 * bv_len, so drop the pins for the pages trimmed off here.
> +	 */
> +	npages = bvec_nr_pages(bv);
>  	bv->bv_len -= nbytes;
> +	npages -= bvec_nr_pages(bv);
> +	if (npages && bio_flagged(bio, BIO_PAGE_PINNED))
> +		unpin_user_folio(bvec_folio(bv), npages);
>  	return 0;
>  }
>  
> 

