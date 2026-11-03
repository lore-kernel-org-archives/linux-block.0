Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793716273;
	b=XYQ8DJFDljtuNw0LaJ6KKGB11CSliK8L6/R7FKSUZ3tb5kP9RrZtkm96qf+/KbEEbIQ6
	 fWACsUcSYjrZHHlwwZnARoI4PNXrFACJ2rvoo8317dpm3Q/SPDIPUAogu/9FAZe/EO9Gz
	 6esiKuVODzDqv/tjVV3w2L5759KVuQUEVRefs7IN2aNjkeqOUYf25HZTtXxoumOA8dJen
	 zqTDFo5uCyZJkITxjF/NmQuM4lEgcgdZra5c3CstjbT0nXpFoRq4PNnvqS4F8fRmHbXL3
	 AzhKLYu1j8lNTD/iVFj0c8IH7fOP7ZKheAd7dH6b6LhIsPpcr1c21qh8k+O0tkgjMHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716273;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=DDx8Ehj1ckHKpx5GFjUEQj8Z/cmjaQtpmHixmoQXBEg=;
	b=W/v3dMGUcwkn5G4blnagqrogZBfAgjAL5yVmbEM24lpo6Q7doIol61sO28kyc5al1GpR
	 jXDDzRmQmnuGL7lERVrTTSvVZmtiXbeIdjR/j3lsCHlDv8KU/gyiMRt2l9IVb7AFyAsI2
	 m7UGNLrzIj5k6+E2DyDHIkrfNVgxBOnEb6JA1atk7DsC1GjgE07wIVPl2F3pVPO17bnCe
	 dAS0UGyyasg4EIcOQoIamnzq3LvwuK/7DvXW1UZj9pykCVjRX02PEtSWxdnbRaY5Bz4Pp
	 ss0Zau+TtcfMN6OQms7E/lBJF//edahgyAmDx6P1cYXFpMZ8VnfuynBZn/tyKtqnGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O2ZZYQ7g;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E070606EE8F
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E070606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=O2ZZYQ7g
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-170135e43c7so2531005c88.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793716272; x=1794321072; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DDx8Ehj1ckHKpx5GFjUEQj8Z/cmjaQtpmHixmoQXBEg=;
        b=O2ZZYQ7g5x9WzmRrWKlJBZKCGUL4m3NcbK1BgXeH6hQ4g034AAF+ozXP6Vq7VFQCpo
         rD7zK58l+OmrJQdSBlzoJVtmIx37T/qwy/d8zjA5GH5Cyi3e3QZ0KCLEu//X934ut2d0
         fkGf9eQ6F8h23rwbn/xAsrrmJlYiKkw++1TKJUTEjO87ZQitjK3soLmrsyriCgiFohdm
         ZcmolbGECjOU8pIXL4qGQGUX3Yno5zuW0caZHCKFBuS85zIB7/T9KxMrVg9xg3MMc7Fk
         HYZuU9/1TVwZ6LF6H2iExDrrbn7HXug/oKjVtS7EMNTguAiBueMNaEcrIP85LkGpeiu9
         1FhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793716272; x=1794321072;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DDx8Ehj1ckHKpx5GFjUEQj8Z/cmjaQtpmHixmoQXBEg=;
        b=X3YnN9lC3KH4NWc04FevgvqCJubqBnn4Hys8yIcQSG4MNDqB6hvJKS/UO0dl39n7qc
         rC2rUPikSd6F6bLa6g53EymOioGOTTYkWpphi/qyGqZg1fWDQkzg4mbp7CAYI2aoVBJH
         Vz0mSAnpS02BnoxniVCYMkWTTy7eMFhjeJJweJ130wN0UsTqjtZ8D/OOi/acY2rELO5q
         P5xY8o4++KaQEXvOMEq1C3F+E4lORU6ZwZSBoUONoVx4BDtys+HBJCOLQMan3izZm0nf
         JLOWDsdUmczEUHB8tyIVnuhMU5Y8ctdwCvLMpoxacsNcCB1LSlJN5K09RQjPIO37pzBf
         f2Ig==
X-Forwarded-Encrypted: i=1; AKwUvByazOBiIq0vwBni3TAjueqWX5A62Pm6tzafNgiEXxBDTYQ70/0shQwjAa+ZNIrjiAttA1LM+nJXJCVnsQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8VU79cXAFn7AzfuV1z4MDm7DYRDvTTn5XM7x+Xt+iCyg8MZ35l
	yeMeO5nRg4dt8FbVUPHeSSG6TMlgb5S2ZIC3hwAhdNDWxw8SYRnjAjDQyxv0oHhy6PU=
X-Gm-Gg: AYBFou0lwdljF2PEF12nNgUNNw/9c10jbF4nySnUc6adzQG6v3r9BGfTclHfuVBJuew
	eM59dlei3J9lDlhWeA2myFt5HXlJ1sQuaG2ja59DDjpZickYVR2qsjysb0MYGPT+EzxAY7wLFDz
	dYhixOr2L+hwcngO+iuThCb68Sy9ig10XYk155F3qJ1FyHu6W2jwE2t+wQzxpcYaiuep8RpVjDk
	OQXZwBoYexEhs22wksnYikQSyC39OyoR5bxXFkx/w3gsJ0qxfsYfHd1bdx0xMVzEeZdrrUwgSij
	fMvIYSug0dpGOQPiFZHItHcSjbBLp0y2QsRxXW9J3b24EoniQmQsZLfoNjZ7XdT7siJWYlLCTpv
	bNVT1sksTBPXLuBPN3zUQc+PQrvPMkqO1Q/zdLaV/08FWnx73HRzLq969YhVYi3L9OF9AvUc4qi
	uTTxccM96L5mwbw+msl1kyYez4lX9dS9YrlK+ZsZmnuJFgRoBVPQxSUBoiMxD3ksVg1yugg0scI
	WsbF5htLoTt7MikVSnKBwvMgxoy7+t8BqaIEs+Ttrbka1zsT5wBEdkBgGDIpVRsxmFWUc2AlDBR
	xzGB5OLndLpFIkWm4qK81td+hVEq3BJXbNZ1AURb4atoSZknZ39KFOIJxsMFfAyWpNZDM911YMT
	7TQt+FcVKNqc6
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id a92af1059eb24-1ac5e8e1e4bmr27128472c88.41.1793716272247;
        Tue, 03 Nov 2026 06:31:12 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b23b847348sm9534779c88.4.2026.11.03.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:31:11 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: bvanassche@acm.org, hch@lst.de, yukuai@fygo.io, 
 linux-block@vger.kernel.org, Zizhi Wo <wozizhi@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com, 
 chengzhihao1@huawei.com, wozizhi@huawei.com
In-Reply-To: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
References: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
Subject: Re: [PATCH] block: partitions: reject GPT entries with
 starting_lba > ending_lba
Message-Id: <179371627073.3691261.1371314560299241508.b4-ty@b4>
Date: Tue, 03 Nov 2026 07:31:10 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 02 Nov 2026 16:04:42 +0800, Zizhi Wo wrote:
> A GPT entry whose starting_lba is greater than its ending_lba is accepted,
> and the kernel creates a partition with a bogus size. The bogus sector
> count defeats the end-of-device check, so I/O through that partition is not
> confined to it and can access sectors outside the partition on the same
> disk.
> 
> is_pte_valid() only rejects an entry when its type is NULL or when
> starting_lba or ending_lba is greater than lastlba; it never checks that
> starting_lba <= ending_lba. For a reversed entry both field checks still
> pass, but efi_partition() computes size = ending_lba - starting_lba + 1 in
> u64, which underflows to a huge value. That value also wraps in the
> end-of-device check in blk_add_partition() (from + size) and does not fit
> the signed i_size, which turns negative.
> 
> [...]

Applied, thanks!

[1/1] block: partitions: reject GPT entries with starting_lba > ending_lba
      commit: 7e3801d12ebabaa3db6e2685ccc80b6e6f6d1ff7

Best regards,
-- 
Jens Axboe



