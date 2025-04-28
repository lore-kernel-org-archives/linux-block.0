Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD8F18DB0A
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745862372; cv=none; b=aHyDN6bI1Y14ZnzpAhQZYnu5NJA80mJJaXyTE94SCYsu15KcV0yhPAeYxDrC+xG1AlnI1CYLdsSkAm2MjMnhGx8n1qEGjYjXdPLL8lChpdX+G7wbXPMIiNp+mEghDo2QLpQA3Sqi3NymFIcmPEj+RM54xeWssRYMx4eINuTCfEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745862372; c=relaxed/simple;
	bh=+pA/bsVQYfd8F4vf3qxb79sjzTXnaUGuMu8FEgLyJZM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NuomgzOzQoNPgaEA753EYzNGsoyprKiut0/Y8L8JUn6Lxo+4duikKA1i4yfQQMET1wtByutrQRAh0t0lBcDqWCqUGZvlg+kZioQrimrhL2CRQU77MX5GjKb/DaX/T7QmOX/FengshQVIpMz14xZ69O9Y1Pgr/wQK7r5H9gBVB6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fmQLvjqX; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fmQLvjqX"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-85d9a87660fso494553439f.1
        for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745862367; x=1746467167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puc5HN0yRTqK72IwWtHK5+PoK9XuiD9s8i1FJNDSDrA=;
        b=fmQLvjqX2rxZyGnADKVJtfXw26uvl4duNAOw+Jn6+hFKInIeEvdKrVTA1ZEAEnhESW
         CoUuN2yab5Z8nLZGWAAsIp4jU0ZUrNmuQ8ob62X6873m8nsP1qtCafwdn+fjYJvqQRKA
         1vFY0yg99wt0D6ExC2DemuPgbSgUvHQC8RzezUXczYwe7hEADPd6uzMcXGvPeuUiiiJl
         HxF6NaRMW1pkWb82uyA1ZCZQG12pwOWQhx6Md692/YK5UUDf6ZJnKz4jOGrxPXi8YMDa
         p7FjUeFGN90uYRkaODovEqXysPrcr9Txqu2PrWgktKTKUqBAFzRv1lueprtw/GoPct0B
         meaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745862367; x=1746467167;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puc5HN0yRTqK72IwWtHK5+PoK9XuiD9s8i1FJNDSDrA=;
        b=TfluWCFNSS4RCth3yidOEwHHUGbSWR0HP44hV3Uyx/s82ifCrYAY6ZPaeiFjK9EYam
         6jIeCNkCIBR/q0b2wCeXx/mngtbdilJxgyzsEZJNu2JlDlkDI236UsK2+L6+AEPEnHCT
         +gDpzKArTPN2j8WdHpO46IwdIHv8BBmQ19Zbl59Sn6ZmNSnavTbaF69W1Rwk9z0PtHBm
         Bnnk8ruAMLm6yFvgm1tKGPpC8uVnCitRD7qkC+KjwClyx0gG3kJromdvRgUo1BQt+H6m
         TFsIQ/iQZvUvVPIJC3S2p59OIYa28LYFUEBlPbFlmwsrQXjMmjxu0hW518nAf0m+LXAl
         r80A==
X-Gm-Message-State: AOJu0YxndN/PZ6OJ8JB7OwMBf8ip0kDzn72qAxuHDi/9eKf768F5BO0b
	BI8nC8Yk5AxHX5PQAA8MK5krkoBvVQybdpqQ3ojweSTyjUftiA+2iQMk9VO4HSs+0piDVnVu6Au
	I
X-Gm-Gg: ASbGncsP0duKztFcDl2vVp20LMmklVbEyv4g0pN0bjzMNCbeBDgXNf1HN3hQ5gsz5pk
	FZlZz0XPITY/mG1u3CONdumwR0/Kd8SnCHHJxpDCpyWEVdVx0u28Fo6NfMCQoHdCIFYWwquAe3o
	5UbutCUWd53yKjiYhTM/dgL6Zrg3fFXuqi70TZdwSf+/4lGIISNhOKzv0SxRpeF8Dek8E9toXcL
	bnEyvNod6DF8VIaGK35HvHi4MukHNj1L/R/G8xnYBVoiIxhe25EoIB7xE6YpLgoVfghjzGlNXpW
	Wx6RE7RlGzZh34JKjzd13/YyXA9USQU=
X-Google-Smtp-Source: AGHT+IGvrfQEuJWtPAVbyMggXJAttbqoLgusWRT+yphHCUhS2wvZKkrcABBy/rO+mSzgx2sshesnJg==
X-Received: by 2002:a05:6e02:12c3:b0:3d4:2409:ce6 with SMTP id e9e14a558f8ab-3d942d1dd78mr102653585ab.5.1745862366721;
        Mon, 28 Apr 2025 10:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f824a38488sm2359217173.31.2025.04.28.10.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 10:46:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai1@huaweicloud.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250428141014.2360063-1-hch@lst.de>
References: <20250428141014.2360063-1-hch@lst.de>
Subject: Re: brd cleanups v2
Message-Id: <174586236594.1436445.8417246444528945370.b4-ty@kernel.dk>
Date: Mon, 28 Apr 2025 11:46:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 28 Apr 2025 07:09:46 -0700, Christoph Hellwig wrote:
> this series has various brd cleanups mostly to get rid kmap_atomic and
> poking into the bvec fields.  It is used as the baseline for the discard
> fixes from Yu Kuai.
> 
> Changes since v1:
>  - fix a subject
>  - minor tweaks to formating in brd_rw_bvec
> 
> [...]

Applied, thanks!

[1/5] brd: pass a bvec pointer to brd_do_bvec
      commit: 75d99aa279561fc6d91afec8bdd1b56548f860a2
[2/5] brd: remove the sector variable in brd_submit_bio
      commit: 857aba38b56a0d8fa868706c57053dcd4282e436
[3/5] brd: use bvec_kmap_local in brd_do_bvec
      commit: 95a375a3bed3b8734059351ba046a6fabdbde485
[4/5] brd: split I/O at page boundaries
      commit: 3185444f0504ca8ff54e2a7275f1ff60a6a6cf0c
[5/5] _page in brd_rw_bvec
      commit: 53ec1abce79c986dc59e59d0c60d00088bcdf32a

Best regards,
-- 
Jens Axboe



