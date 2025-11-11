Received: from sg-1-11.ptr.blmpb.com (sg-1-11.ptr.blmpb.com [118.26.132.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2A3AA195
	for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869830; cv=none; b=FDQv6XF/gmaoNSXjnATs15/wxmYL8PlIFQKfaqLb+Jvqe3u3dR95z0ALaj7umPt7mX41Eg3ybLNFLtEzzrt7Q6AeZ3ggrGJf5D2I5yP6AF56qbtCHxAeVLCUurXynhm621SO1fO95G+QYNexYkQsH/BC+LEpJ9H6EhTEqur/+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869830; c=relaxed/simple;
	bh=/5kmZWPLrOXlUSVGBi3iNjaRUd4UXNYQkUNK5+RlXsA=;
	h=Mime-Version:From:Subject:Message-Id:Cc:Date:To:Content-Type:
	 In-Reply-To:References; b=U7+DEr0IWVHlZV1tmeSR7/eA3X9Z46HdH+c/4eNwZbRpL0AtUeCvvjwJiuj03mtsydZvSfMD4N/7rZC73LwyFNFvgRY3vAm4tpftBJGK548OauiuoYFBg7B2sZOWdQjzGck+sxpnMJiU2S8io5J64yn3Dxw1i56a2aiwDT51hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=vaeq8iZq; arc=none smtp.client-ip=118.26.132.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="vaeq8iZq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1762869818;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Ae4EIh4ONcbs6jvdEyBqGmmn/47kQ5NZ9WtLM72vbj8=;
 b=vaeq8iZqHTd7SDI8+3xNWw+UJ/e7nqiRyP94OXffRhAEzYdLV2ty6WLjtmPqFi2IfXCgk5
 KuOiSE/6pVTOyYBh67OQkITIT5taAmhf99i+eFvCltREX1Npf9tsH5sIs0bwb+1s2RpQXG
 fYxfJlAVfGzBpdnD+vycR/tmcuQX2kruGGaI26Xgc97PrAFiU5DL9nHCaEOiHs+5FUftaa
 pknXa2nvvbd3nWCqrwBCl0nyBtEKT4Br7COQ0JaQjyEl8XV3blTk+yOOmg3dRpob3WB9mU
 VifyUnNpGlYspa/zzvh0K5PdDr5F2xmg6rghZzE5cW2RHVarT4nLB4zzo0b6tQ==
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: "Yu Kuai" <yukuai@fnnas.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-Id: <ab181a42-ffe6-4d12-8b8d-7aca1069c59e@fnnas.com>
User-Agent: Mozilla Thunderbird
Cc: "Matthew Wilcox" <willy@infradead.org>, "Keith Busch" <kbusch@meta.com>, 
	<linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>, 
	<axboe@kernel.dk>, <yukuai@fnnas.com>
Date: Tue, 11 Nov 2025 22:03:33 +0800
Content-Transfer-Encoding: quoted-printable
X-Original-From: Yu Kuai <yukuai@fnnas.com>
To: "Keith Busch" <kbusch@kernel.org>, "Christoph Hellwig" <hch@lst.de>
Received: from [192.168.1.104] ([39.182.0.168]) by smtp.feishu.cn with ESMTPS; Tue, 11 Nov 2025 22:03:35 +0800
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <aRNALUnnxzIuyHng@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com> <20251014150456.2219261-2-kbusch@meta.com> <aRK67ahJn15u5OGC@casper.infradead.org> <aRLAqyRBY6k4pT2M@kbusch-mbp> <20251111071439.GA4240@lst.de> <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com> <20251111093903.GB14438@lst.de> <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com> <aRM5UoApKZ9_V7PV@kbusch-mbp> <20251111134001.GA708@lst.de> <aRNALUnnxzIuyHng@kbusch-mbp>
Reply-To: yukuai@fnnas.com
X-Lms-Return-Path: <lba+269134238+c30958+vger.kernel.org+yukuai@fnnas.com>

Hi,

=E5=9C=A8 2025/11/11 21:54, Keith Busch =E5=86=99=E9=81=93:
> On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
>> On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
>>> Ah, so we're merging a discard for a device that doesn't support
>>> vectored discard. I think we still want to be able to front/back merge
>>> such requests, though.
>> Yes, but purely based on bi_sector/bi_size, not based on the payload.
> This should do it:
>
> ---
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 3ca6fbf8b7870..d3115d7469df0 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *p=
rev, struct bio *next,
>   {
>   	struct bio_vec pb, nb;
>  =20
> +	if (!bio_has_data(prev))
> +		return 0;
> +
>   	gaps_bit =3D min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
>   	gaps_bit =3D min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
>  =20
> --

This looks good.

Thanks,
Kuai
