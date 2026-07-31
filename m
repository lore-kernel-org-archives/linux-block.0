Received: from mail-oa2-f1.google.com (mail-oa2-f1.google.com [74.125.231.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2BE35CB81
	for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 14:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507090; cv=none; b=orJvXlkA/7opkmBZe3SrhZ4MOwIrJsrGxDbhHLgW4GrPJg9Cmi1cbTBqgNWYbHEmePIVgtY3LXkvKSFbfsflxTaaSPU9/2ucyyh/p/sSRN1mBF1dIq57Hxx8OZzrjjdwb1EZkiIXFpPDINONDXPyMgM4+7fXUnVjE6Lw1JPbOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507090; c=relaxed/simple;
	bh=4ZdjWakCq/Aqizx6AFYC1adkwgp2P7rM4QX9GlA4i94=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ICyUmnhvxnXK1lyUGJjYEr54+/viC10TIdxyLE9oB5A0J+VkVn11RmmY1seZn/PDV1tY2RYRmUHQOROOPIyIeHD9Ab48IVJInyf8f0uXjXLDjz4bmexyJfytGnJupS9NIWc93yl63wliocX7J+/2pqI0ZOnFoASVjqU7kU8OTMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=OASmQ7sW; arc=none smtp.client-ip=74.125.231.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="OASmQ7sW"
Received: by mail-oa2-f1.google.com with SMTP id 586e51a60fabf-451e22b4773so82947fac.0
        for <linux-block@vger.kernel.org>; Fri, 31 Jul 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785507087; x=1786111887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SUpW3doNTk9ZVDYiQz02iPdiZ/HzJ9pbPw8kgbFuw4Y=;
        b=OASmQ7sWtme8vdy9ZeOxOfqadf1ySSahE6U18q4xv78UPiX10WES9aUK/APpGVTZnt
         bVWB66lfMxa9GVrHuaCauvFh3hroZB7UXNJQABlZWxQIl+WDEOkfg6+jtVnvp6jkFrvw
         /2zQH5igkODASSoiCdZaFF1OBTd6pmmyPPuvttpkIPf9nRS0HuZpRis4pKehTdAdYxbo
         OU2bJOcPNm2KUwT7718uOV/9Dr5T2CbO2pgtny29hNvi9FAS2BLVKvQNcSqZQxeo7hDi
         7xHqdXgphMdwR5IAVgqiyA80gowYPlOeVg/XikUWYFk1OBxXXpaCa21cRWVTRh7MiTOf
         IiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507087; x=1786111887;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUpW3doNTk9ZVDYiQz02iPdiZ/HzJ9pbPw8kgbFuw4Y=;
        b=VqBgrU8mD+fPVVgbLlrg+/AwvuBXV2afcrlhx93Z5nFIZRElIFdRndaAWNrma6R9wg
         NztH77cfdWnyyvaewgMzl8fb+NW4kw+vtLj5w2FSbO7n5wE4ecYDHdvT1UY+K0/1W9jY
         pSEub3anBdx3XSXYf8GiifoSSLz2JjpSsXdF4nMXDA0an7G3L6NPt9FVXViLqG9dno6r
         HAtyazcmh1ObIt+O0DKkMaJ8545YUUKT/9oes/l8V9W9+KRDvIx8sNn45NgiRzIk3IAE
         vyo6emxtPK0UI7DI3ePnKihsaBpYLvG+ngDFr0SfPV4N0FUPpI6XjjiFNtkrnqpnEdPY
         WpLw==
X-Gm-Message-State: AOJu0YwXkKUMiOzEFz2vKT0M1FHBBZlFW7Mv7LWtFhS2H3vCVA/cxE6/
	Ho4xScNu9pfSJS0F5XDRDnUEDkvAoe3sP0y50B0PVraTHIq6JxrfdPki4GbjfVL4hLs=
X-Gm-Gg: AR+sD12G0YFuaj+19hAX5XFpHP9t5vSgajWJ04EqYVTUY9Sp9i654Fb3RecJN1JblQK
	1Dv9N9dyzuYJ7IT4SbMxjcDdua50wbYK71vS7JE7zeyaVODsP9e2BzfjVBSZmvNbhTxf58X7S8u
	rT6VqKitzispR+xi5DeOc3uVcaRxmcFG7nkLqf029TcZNYGUHpjgXTscBR9ywEzRjBaF3q1MZwW
	nbHbq/zmE55pPs744EqjGb+LoFpt7WltQHBtwc7zYwr3j35mrsSRParnGCaW3Pkv+m/KhL2fzkL
	GV/wuWQGvuMVj6YvHpb3WiLx/eMsol8zkBMLAxGaHk795UgBzx/udDn11RKMC5wUsHKKC11WoVy
	/QRDQTv6e5xEUv/QZj5i7Z+IbT+EVM08lhfjNJbjsJh7BgRi7ADu/bL8WqM7apclKBdG7BHE7tY
	cl1GQfYfEIIMXpYDA3JOBllF3ERulvJQFzwKnG2mBup6BU3tjuQ9VWDqf+3hkIbyHHY47XJD7YE
	leaXs81p10ymty5sYktmUVMJJW9ebWWsEcVL4Yboyo=
X-Received: by 2002:a05:6870:d40d:b0:448:a0cf:5afd with SMTP id 586e51a60fabf-4590572cc6cmr526052fac.4.1785507087079;
        Fri, 31 Jul 2026 07:11:27 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f66c1fe3sm1162982fac.14.2026.07.31.07.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:11:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Keith Busch <kbusch@meta.com>
Cc: dm-devel@lists.linux.dev, hch@lst.de, brauner@kernel.org, 
 djwong@kernel.org, viro@zeniv.linux.org.uk, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20260720201057.1862857-1-kbusch@meta.com>
References: <20260720201057.1862857-1-kbusch@meta.com>
Subject: Re: [PATCH RESEND 0/5] block: validate direct I/O memory alignment
Message-Id: <178550708596.3329022.10599196691426679849.b4-ty@b4>
Date: Fri, 31 Jul 2026 08:11:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Mon, 20 Jul 2026 13:10:52 -0700, Keith Busch wrote:
> Resending in case this got lost.
> 
> This addresses the misaligned direct-io problem behind various threads:
> 
>  https://lore.kernel.org/linux-xfs/20260610145218.141369-1-cem@kernel.org/
>  https://lore.kernel.org/all/CAC_j7i1R7oy+nRhxEjCTba=DUgn02w9X+p94DCu0aHv5+5tKnQ@mail.gmail.com/
>  https://lore.kernel.org/linux-block/ai7rnH20IYeSmY8s@gallifrey/
>  https://lore.kernel.org/linux-block/20260616154009.2123183-1-kbusch@meta.com/
> 
> [...]

Applied, thanks!

[1/5] block: use blkdev_iov_iter_get_pages status for errors
      commit: 75ae18ca942674f9d5b55d7e8a2975485125f715
[2/5] block: fix dio leak on metadata mapping error
      commit: 702a2a9f3dfe066a7481698c858371112f3cb697
[3/5] loop: set dma_alignment from the backing file for direct I/O
      commit: 6c8dec275ccc35e8f86cb9287283d31c5d8e9ab7
[4/5] zloop: set dma_alignment from the backing files for direct I/O
      commit: c5059c1af2bd22bc1435b99d27d800164162cb72
[5/5] block: validate user space vectors during extraction
      commit: 14b007e178811db72fbb1ebb3535160db6ec1e6a

Best regards,
-- 
Jens Axboe



