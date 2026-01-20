Received: from sg-1-14.ptr.blmpb.com (sg-1-14.ptr.blmpb.com [118.26.132.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3F2ECEBB
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 16:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926642; cv=none; b=NKzN7bhszYfI6N1edsZwIEcgJlOZtOcG6gL64Uus5+y2q8jojkjC3nV21f2+vOXugbDp2S/crTCAZ/UEkxVFW+co4K2u5/6jd+V6KVslaR54LW4lcT9yGI5xN8cwRnEmlDWVTFfgoH0EIvlvFGo27fTshNPuXJSASOjIeahONEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926642; c=relaxed/simple;
	bh=PsPDpL9ALlmGzBE5wW4c9qjGMkMCNYYzo3NFJm8GlKs=;
	h=To:From:Date:Mime-Version:References:Subject:In-Reply-To:
	 Content-Type:Cc:Message-Id; b=GoAl0LeaT6Ofl7PLUpxfkWg81odaVgY1C2o/S/t4y+Q9jVStEuh7XZKDbQm6qOAnWWNqXKnJBYcBsHs80O2FBxUh4Up8bDnr8Y8rTaMDcUqDbVGUX3dAZ7zODGla8krpzBfyDX58SafYpP5tngbBXb8FD4dJ9DRcAwbSq8KSOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=yj+kDiph; arc=none smtp.client-ip=118.26.132.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="yj+kDiph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1768926623;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=PsPDpL9ALlmGzBE5wW4c9qjGMkMCNYYzo3NFJm8GlKs=;
 b=yj+kDiphP+X97NfYQIsBedgvoizgt6A4tV/V/wO4Y8qSiVC2syZA4ly3Aj8NUeNAltjX1a
 dxcpUcJkZdCjZspAPYgBme6XXfPGcVAhi0VkJJthBG+XaoSxu6c7tSbGRJZeVEDpFg+Vxr
 pzmFwc11zOm+f7QgoFcai4WuDTVy4iFa/zyWFnN/r36jGw+goikolyxN+XluvVce4Jv+dr
 A6D8MuWDby17gQh2tAxYa5hawGE+2PlnR+iZDs3tr+paAYDaTQOIZfpAjVi0V1yjXuvIvQ
 9uvek789tIv/ihdCEanv2eWrvgf9qLCQQJmXnQyuPgic8+tjDS0+ePpM2PmjLg==
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Reply-To: yukuai@fnnas.com
To: =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Wed, 21 Jan 2026 00:30:19 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+2696fad9d+5b2a37+vger.kernel.org+yukuai@fnnas.com>
Content-Language: en-US
References: <20260115163818.162968-1-yukuai@fnnas.com> <20260115163818.162968-2-yukuai@fnnas.com> <sq7fx334im64pvgiieemit4sb67z4p3ftoc4544rsea2ojy4u4@mtwvaerxqikn>
Subject: Re: [PATCH 1/6] blk-cgroup: protect q->blkg_list iteration in blkg_destroy_all() with blkcg_mutex
In-Reply-To: <sq7fx334im64pvgiieemit4sb67z4p3ftoc4544rsea2ojy4u4@mtwvaerxqikn>
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8
Cc: <axboe@kernel.dk>, <linux-block@vger.kernel.org>, <tj@kernel.org>, 
	<nilay@linux.ibm.com>, <ming.lei@redhat.com>, <zhengqixing@huawei.com>, 
	<hch@infradead.org>, <yukuai@fnnas.com>
Message-Id: <99873017-9a22-44fe-adcc-3c6468cd9696@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.185]) by smtp.feishu.cn with ESMTPS; Wed, 21 Jan 2026 00:30:20 +0800
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2026/1/20 18:27, Michal Koutn=C3=BD =E5=86=99=E9=81=93:
> Hi Kuai.
>
> On Fri, Jan 16, 2026 at 12:38:13AM +0800, Yu Kuai <yukuai@fnnas.com> wrot=
e:
>> blkg_destroy_all() iterates q->blkg_list without holding blkcg_mutex,
>> which can race with blkg_free_workfn() that removes blkgs from the list
>> while holding blkcg_mutex.
>>
>> Add blkcg_mutex protection around the q->blkg_list iteration to prevent
>> potential list corruption or use-after-free issues.
> I'm little bit confused why q->queue_lock is not sufficient for this
> problem. (If pd_free_fn() was moved after list_del_init() in
> blkg_free_workfn().)

Yes, move pd_free_fn() is ok. However, I would like to convert protecting
blkg with the blkcg_mutex, which can cleanup lots of codes in blkcg:

[PATCH v2 00/19] blk-cgroup: convert to use blkcg_mutex for protection -=20
Yu Kuai <https://lore.kernel.org/all/20251010091446.3048529-1-yukuai@kernel=
.org/>

Meanwhile, I'm still tring to fix deadlocks first before rebasing above thr=
ead.

>
> I'd find useful some overview of the involved locks (queue_lock and
> blkcg_mutex) and what data structures are synchronized with each of
> them. It'd help to disambiguat which locks are needed where.

>
> Thanks,
> Michal

--=20
Thansk,
Kuai
