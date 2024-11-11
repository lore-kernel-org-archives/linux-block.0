Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C74D1BC58
	for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338229; cv=none; b=dUsyuZjMncDOpMaD6PSDYkmWV3/PDqemdewwDN2BC7rFds0XUDxGVM4GgX7lnurlKonYbspz7qxrVNL+Qi5wSMOxfdDNr0g7tbUNy6+tCy2V1W1t/yEFq8TR8HBwmr9W0XImhndbEGoeqK4d7eDNHyBQgOF4PVrViClyQlS0k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338229; c=relaxed/simple;
	bh=5mglLWlQDVCW9S1DxcB2RlxHNcZg1Dez/gGInZMM1Vw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=srEfvYsgH5Uh6Zeyc/Wh+nxo26xhgyJ9PqwhSKiuc6SwqOMgks4qNvylEFoS0xGqzduo4UAlmtyo3WcJUPBpBkCxlsePm+3yq2eAIEjrIPpkJmFjhXNRl4C3nJQsjPy4IJvAvXb/G/FALJITibfqUjEsIZqZZ/j9qVs31BxjUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=jCh/8bOE; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="jCh/8bOE"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2884e7fadb8so2353104fac.2
        for <linux-block@vger.kernel.org>; Mon, 11 Nov 2024 07:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731338227; x=1731943027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qTNqZekwtHw/I6Wjflq64VtIvDI6PYfVEIhwmbtaRWQ=;
        b=jCh/8bOEDmXOJT4jYtT78OtCokQ3xZr+KrTGGjVQxePRgoe1Vu5HamXnX4hGOnJYjT
         NenMrx+tvuXzxsxsWNqvxHdftBuELYVFXEQWEXRikxu4Ub2rwcSKwB0Qzn9umPiHjw6x
         IC1Ww/luWym5dvExYWEIKeU3M24hrBlGhJIIdj07CXppW0Nl/Biv2y6pV8uanKZ+lkE7
         CNr4erKWI/XyNhjXXDa/b852cuoinnmkh1L2plkKdtuQvIyVWNWxfn6FlAPQBHYNajWj
         R1oOgDrHiN7T7buOoCENa/fC6hV7X4m9BDj+5cYPq2xC2XS5Qo1/k5CKDPi8FhIugngE
         A32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731338227; x=1731943027;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTNqZekwtHw/I6Wjflq64VtIvDI6PYfVEIhwmbtaRWQ=;
        b=AhC4PS5Qn3Umd5ZuIwtRDfEH82DcLlb+M5RS9+1sg/ZX+TlPv5nJJVmGKi9NdoEgwW
         pg5Lhvz34Gj0NcKAazd07VkmEi5qom/ztFYZC7L0kAxegLMi8wU3waFF15SAE77ttKQ1
         Y6ZOFzAlPf6aXNfvfe9Hkn8CNK2lbSgrh/0+OeGal6EZBqP/8jiDERceWgoVqm+sneqA
         4smXJ65sAUZvVDx+idYume8LRmZ9qBMJrXPq7cs1Cm2GZ62M0rDPEeAkpuBiIVPaEhBq
         lU+Tvc4M6NvKSWGYk3lZ3QHFZKX3KUSvupP9oFBz5GI4YRk58L5QNGkvuj74waLizTg5
         QtSw==
X-Gm-Message-State: AOJu0Yz3w4km93YB+UAmd8Zv6Vocw8hZqcmQUV2MFswTMDya1Hg4teQp
	Y2X8+n8bKrxIn8r/xVS+ImJqQk6i8hHjDU1hgQQB6+CEYN/AAF+xomNe2bCWiwweY103SL9QSY/
	fhcY=
X-Google-Smtp-Source: AGHT+IG7hV1F4r6SeSGVFChlgt8eEYSnrJeZ3KMhN6TIaupsFh2GLBzRcDjqlBtDr4SMVDpP3aZ3dg==
X-Received: by 2002:a05:6871:5e03:b0:286:f9c3:ed78 with SMTP id 586e51a60fabf-2956030ecc1mr8473584fac.36.1731338226803;
        Mon, 11 Nov 2024 07:17:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29546f3f2f7sm2861968fac.46.2024.11.11.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 07:17:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20241111110718.1394001-1-ming.lei@redhat.com>
References: <20241111110718.1394001-1-ming.lei@redhat.com>
Subject: Re: [PATCH] ublk: fix ublk_ch_mmap() for 64K page size
Message-Id: <173133822582.1860965.10816573961090273161.b4-ty@kernel.dk>
Date: Mon, 11 Nov 2024 08:17:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 11 Nov 2024 19:07:18 +0800, Ming Lei wrote:
> In ublk_ch_mmap(), queue id is calculated in the following way:
> 
> 	(vma->vm_pgoff << PAGE_SHIFT) / `max_cmd_buf_size`
> 
> 'max_cmd_buf_size' is equal to
> 
> 	`UBLK_MAX_QUEUE_DEPTH * sizeof(struct ublksrv_io_desc)`
> 
> [...]

Applied, thanks!

[1/1] ublk: fix ublk_ch_mmap() for 64K page size
      commit: d369735e02ef122d19d4c3d093028da0eb400636

Best regards,
-- 
Jens Axboe



