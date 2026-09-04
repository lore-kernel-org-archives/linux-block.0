Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FC24FC8D2
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788561315; cv=none; b=uLLbHxwjhbQvkmqH36zI3iUmazlMK929/UfdYNp8q88iiPapCriwa7h71e17Qj+5Gfn2m1GvGPoCFLIL0Lq62suI6qzVWUVq2cFhNiG8nOjy5d9fZOcvYSm48dJxVbXwzbPGiVCk686rImoa3DwvyUfArpiKsiuKzn7rr+S6/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788561315; c=relaxed/simple;
	bh=DA84oxU3rQPrvSsuP6rsi2zMphGkpHQDobH17fbWDNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMxPaiPfb50SlIDCikAAaJyjoLiNY2SUuSUQnRFuvKs8RxGOLWBq0cmUW+zGkIkYrvxdi51qvWwgN9PkSJrElM6lKl1Q/9ccENBWJvoYENhcgQqOH7krjH1a1A6LzUaLScQg3QUuTt2CZ+5Tx28mX3vNEo0btHxF/GtsgAYvd54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=OM83EIbe; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=p4AhNWtA; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="OM83EIbe";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="p4AhNWtA"
Received: from pps.filterd (m0167070.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684MWkrZ2906573
	for <linux-block@vger.kernel.org>; Fri, 4 Sep 2026 18:35:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=NS3I
	WLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=; b=OM83EIbeyrJBmKFxiBn7
	95BjxB368qVNGNObkjZ85O1d248QOiUYlzhhJJep+Gt6Hi2B8Fzo7oVG64eJc/tj
	zbc2s9qp5g61Kxn9jIQmS3ffGdAlGQCLFIZHun44tpLrXKQNNfvb8FNBH5XRYio2
	Z0cVo9Dhz5NYwVILy/CkqWJ4AHXPq0IB3wvtxsLVRMEl30S7UHiN5mLrnAZYCkPg
	El3m/66187L/MxMuSPzMn+/WT6GRdkqqrMx3xhVwRJ1iy26arqEVzNfdiHL4NoDp
	xnLYfSKwSetCrD1jSwhPGIAgpUmWjZfBSh9+fhBno0Kz/ApUcGuNj1MCJ7bpAC3u
	VQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4gg4b613vs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 18:35:11 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93909014c85so254053285a.0
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788561311; x=1789166111; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
        b=p4AhNWtAX8wTG5vcPeNMdAcvakpQAgw5k6QYrC1/brPsb0ngW6tTBFeahesat9odxP
         3/CeRuSUVwltWS+YmhVbW32ySRK+wgeoOP1mAg5qJNFADd22/RTTdMNo4WY+nsgFcy3r
         tIM/Lc66jspSRsVFs4xxPN+Iyz68ZXTVepvBh/ovG2zevFudQ6nymIw3vOLr+xw+dd+A
         EMIVdCQHwdZQI0YqVYI0xQPp60no3jNtSJVJQMeZMMAwOv+upZeY/nwE2mtrIFqpUx++
         99tApD++TY7WQocdN+Vb/ljMdRb2f+sL2dbkP2mxUEqvWoG27jkwA13Ty0hfNuxG3/9t
         MyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788561311; x=1789166111;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NS3IWLMNep/DrvoibIPUp7dIa6zL29X7BYhj1p+bdp0=;
        b=hW/uUxM2ZcvdnoTpF0M47aYuHbD1UVN9XVtj1iNxuPFadhj6U6CeeNvLn6lRuI68CP
         JZQWKba1FHzn3TsGBTtPIgic7xYtxPzdV49Mp+VSlCvwmY0H20aDrgaWIsE6a/y07GJ6
         DI/L5wimGDXPqN7ZSc9I3vxwIuXfrMfSgidQac+eDSavxAL0aN/2MzgV6ks3VkPLCx6a
         lm+PbnnLBPhrD93svIMvNzLAGLJUKy6+a+U3/Nfg4fOzlpNJyaH4be9fj4SjdCqXlokI
         k4VlRnG2F0WRHboy9PFGDE0ooVxsanE1Shqu4vAwj5Iw3K0KtuLBRHVRtWHOM5gNFsHm
         6n2w==
X-Forwarded-Encrypted: i=1; AKwUvBwpL93yngZe97twuOgXMuCyarvSyEzzLBNvCuGaUnLFxiiiqBFSPp88zqitUXyaYStDZJbX/AS8m9r0AQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m8E30kRVT86pYqK7f2pgACZFmh90eS/1NDMUaeXte7muk+SEM9
	UvA1n1zLH6FmL47aoN06mABykC2vIXnmQA6lrgSIxMPTvYmw0dA0Wn3cMZSpIhm3XTVCkpSjrVw
	1BnPnMrIkAvVzdKuK8BFpvvtet2poEbnua4VzfmNakRRa+6f3rjZwKIx/U2qX
X-Gm-Gg: AYBFou20fnV0ZtJauJQ5QxXvq5fTug012kMN/Ytlj8OQzOJY5edq9sPigA6oMv5sHSu
	PR5iZfO/c5aiRovDgvUbpexagETDs1ajD7LYJJiE0VfRYMizVx/Cj7DVGWLELXZg37cCCBxusfA
	QBG4wVwvQV0WbZ89s6v3JhPjuydyC2R5nlub0nYcGQ1WEb8Er1jJobox3Nmp7ncYVl+YQbCgD9G
	cfa4EhWphWNi6sFFd7z2qpcJUdwtutFne/f8v2tR1DBjn2O8Wv61rIQaFtSE3kbS8gMVoLjhMiq
	FfZNn6DDRoHFxiY5/H2of5dSROKwHXaHH2BlusdmoJRnNYDJAE6MedrfocpLKO9bca/7GgNh+oc
	KcIJ+BiFQkrNToG1bDhwupds4Uvs6COm6vMJLNh5tgNNuifslfSNO
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id af79cd13be357-9398905d927mr531683585a.17.1788561310774;
        Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
X-Received: by 2002:a05:620a:44c3:b0:939:8905:ce9b with SMTP id af79cd13be357-9398905d927mr531679985a.17.1788561310278;
        Fri, 04 Sep 2026 15:35:10 -0700 (PDT)
Received: from [10.207.49.22] (nat-128-59-177-158.net.columbia.edu. [128.59.177.158])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040664be1sm31193686d6.18.2026.09.04.15.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 15:35:09 -0700 (PDT)
Message-ID: <789e5449-fc8b-4ef4-9571-26abd514681b@columbia.edu>
Date: Fri, 4 Sep 2026 18:35:09 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] f2fs: complete dropbehind write bios in task
 context
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org, chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        hch@lst.de, jack@suse.cz, axboe@kernel.dk, baohua@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, qiwenjie@xiaomi.com
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
Content-Language: en-US
From: Tal Zussman <tz2294@columbia.edu>
In-Reply-To: <c4e69fb1ffd6c6fd968683c690ba29f2b98c9fa8.1788438786.git.qiwenjie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4Z6tL9B1Z1BUmOlY58ZVNNxTrw9-9A-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfX/I+WEBI7Iad4
 5iMcTnQYnyOIldx4wgqC2wf47wfSdx9bCYe8X7B6VMxjEl6Ma1/+lrKd8cVTbKml+7N91NGlXNW
 ShH1UbS4iCvQJvixfMOZR6U/ZU/L+Ktt0yOiD0j7Anc+xGi7FaOtb/+ndO6TCYNyraIvUw4kKD5
 vCZNejNRYaX9WPLx0NOQR5n+6+pbX6NU/yi6V8EOjcCyEpp3x8IMsGhF69W+HcExXtv1tziyY6x
 5iIbvslc3tfRodSboI+LKWLwMItXI4NF8P56/DlLRo0BH/qAGSgZJkwsh98X3PTcBxVilIFNBrS
 /AnS4PB93ERSl7uj6APTfazWKHeUCSJ+fk97b3NBnDeBV8BqxuaBffkPoN4oGmzcXMJVAhoMm+i
 jFYlTW50KwTD4fPo7ZKRUZuXeEsYOJZGkXEgXAtxKSx/RVUKdhwBTkLajHJK3dncnsJIQktnL01
 VKPDs5l5fs6VouAkX5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwOSBTYWx0ZWRfXx1gNF3zdHAlj
 +gogRei/FhDplCb2OuTO9tsXbmRszT6m8gj6B9gFPqafPf5WLzRtZm5xwoSfLGe1O4YsZC5v0ZR
 OLNRuxbl6Y7s/McyPFoe5pMWEFb2+Cm9QvnKZX1QrWsTYiHiNuCD
X-Authority-Analysis: v=2.4 cv=WfI8rUhX c=1 sm=1 tr=0 ts=6a9b479f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=tLges04aSNaZGVAfhBIy2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=svvvyxlR1OQQkelhaPoB:22
 a=IeNN-m2dAAAA:8 a=r4jUT_wghbJ-rGNBW1sA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 4Z6tL9B1Z1BUmOlY58ZVNNxTrw9-9A-k
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11896
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 clxscore=1015 phishscore=0 lowpriorityscore=10
 priorityscore=1501 suspectscore=0 malwarescore=0 bulkscore=10 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040209

On 9/3/26 3:59 PM, Wenjie Qi wrote:
> Buffered RWF_DONTCACHE writes invalidate dropbehind folios at writeback
> completion. Mark these bios BIO_COMPLETE_IN_TASK so the block layer runs
> F2FS completion in task context when needed.
> 
> Use the same flag to keep normal and dropbehind folios from merging in the
> IPU and OPU paths. Classify the original page-cache folio rather than an
> encrypted or compressed replacement folio.
> 
> Keep the existing large-ATC completion path unchanged.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 21f396ebe22..b0fedacfd12 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
>   	bio = bio_alloc_bioset(bdev, npages,
>   				fio->op | fio->op_flags | f2fs_io_flags(fio),
>   				GFP_NOIO, &f2fs_bioset);
> +	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
> +		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
>   	bio->bi_iter.bi_sector = sector;
>   	if (is_read_io(fio->op)) {
>   		bio->bi_end_io = f2fs_read_end_io;
> @@ -793,6 +795,13 @@ static bool page_is_mergeable(struct f2fs_sb_info *sbi, struct bio *bio,
>   	return bio->bi_bdev == f2fs_target_device(sbi, cur_blkaddr, NULL);
>   }
>   
> +static bool f2fs_bio_dropbehind_mergeable(struct bio *bio,
> +					  struct f2fs_io_info *fio)
> +{
> +	return bio_flagged(bio, BIO_COMPLETE_IN_TASK) ==
> +		folio_test_dropbehind(fio->folio);
> +}
> +

So I'm admittedly not very familiar with f2fs, but why is it necessary
to prevent merging here? For iomap, we concluded that merging was fine,
as it just results in some extra folios getting resolved in task context
(see commit efbde6f9f449 ("iomap: use BIO_COMPLETE_IN_TASK for dropbehind
writeback")).

>   static bool io_type_is_mergeable(struct f2fs_bio_info *io,
>   						struct f2fs_io_info *fio)
>   {
> @@ -985,8 +994,10 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
>   
>   	trace_f2fs_submit_folio_bio(data_folio, fio);
>   
> -	if (bio && !page_is_mergeable(fio->sbi, bio, *fio->last_block,
> -						fio->new_blkaddr))
> +	if (bio &&
> +	    (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
> +				fio->new_blkaddr) ||
> +	     !f2fs_bio_dropbehind_mergeable(bio, fio)))
>   		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
>   alloc_new:
>   	if (!bio) {
> @@ -1086,7 +1097,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
>   	    (!io_is_mergeable(sbi, io->bio, io, fio, io->last_block_in_bio,
>   			      fio->new_blkaddr) ||
>   	     !f2fs_crypt_mergeable_bio(io->bio, fio_inode(fio),
> -				bio_folio->index, fio)))
> +				bio_folio->index, fio) ||
> +	     !f2fs_bio_dropbehind_mergeable(io->bio, fio)))
>   		__submit_merged_bio(io);
>   alloc_new:
>   	if (io->bio == NULL) {
> -- 
> 2.43.0
> 

