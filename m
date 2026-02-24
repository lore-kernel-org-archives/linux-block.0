Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D8139B4AF
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943352; cv=none; b=kWtjHPC1G8dvV8CxI7nSdLFf48/RJsAHjD40k5aSnmf4psrtAeNRlhPvHtyF/WGxr/e+jbpSjCo3Wb7B1Xck5oo9oMlHVTFKH09Sv8RUU1r0ST3rkRmr1VdTDQ1zaSH0e4blKpiN/E00P6fi7vOxT6CLM9X6A0ibHHV81ueINdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943352; c=relaxed/simple;
	bh=r2xK9ymerIfBib/fwRAh6IfFO7DwgaTRkn5wo2POBHQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mFaqYXWXanqr7cwMskHwU+mnC1oV5Uq46d4/MKGw5wko/k1Zlrn+jaw/g2v2AX0UnSjI7CK2CCXGcHI3MXgxqJksQb+N0jNVZ9XGvfBDY1U9elsa66zBNASSmlmosdB2aKIvqn5Z+a1w3AYqYF9gfQya7acHB+sLQ023ovM52Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mi4wyyu2; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mi4wyyu2"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7d1959ba05cso2645352a34.2
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 06:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771943349; x=1772548149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+h4cUB5z3gwLli6Uxnqc/gAlaab/h3hRG/G3BGWGVEQ=;
        b=mi4wyyu2MQSSvp4eqmx6MHmTV5bkhYy8AdqnhvDuQn66VfbNKayY7HWsdSml9Dr7Bx
         McVNCKV5Luupisfyo50c/DRKLu47IU9MO7yvciayJvqw39nB9oFcbLLA5kkYOmV9R5BI
         mbE7mBhlFI+uWJ28ujl1fDoKFnGH6NEzoc8/XRCNoa3f5QzYXNS7GrTU8Xwz1pDZIq9V
         ca7H0a2r4IA8DMRU9vkn4CUx9QPshQLBECksNa+B55eAYi3ZM1O9WawVqN0gBMkpFb8a
         sFsmu5e+auFc1WNxu2+JFAhYPJl4ordUCxjiStQK8vyYg79pzyTGaijw48qROCsVcU2V
         Tk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943349; x=1772548149;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+h4cUB5z3gwLli6Uxnqc/gAlaab/h3hRG/G3BGWGVEQ=;
        b=KyEdxhSLTNsRQDdVFQv4eZAHLL/oZn3om/7+B2x1lZ5D48TYJOQw3xwHIqZU//dGDK
         OsX4p2Yq3Fdvs+EbwKh1sMZnmeEp+Bw9bY5Hj5RLTu+FLtZeQRZtSmIO+fDcZSjtyWqS
         gQHARLs4KKVpjxLCbIwD87QiPKHVTavBnVtb+zhHzb+9HuXqv7n5WM44XHQqCfY712Xj
         Nrv+VSLk9Q4k+Ug7u6vvVFK5MCCUC5lY4GOGW4iJ4per6/mJgSHKG1xM8FQsM7Z6aqj+
         CqNGs94fXrjZEaOqehCTeViSQkKdfyA7QM9LNh2woeJzpsnEbp+H1uc7Fc2PSkuOt4Y3
         A0HA==
X-Gm-Message-State: AOJu0YxJwGEHMGFOCH1xt9nTS0a9A/Fa3yQXkbEz38GodxSbxpaWwiTm
	dps2FPZCm8sS/ZTTYfUK5fptATGfOlyUggTgix8DJM5QTUau0IzaWEJtzYijd55ZCKPd4iDTxEH
	SUxvEgTM=
X-Gm-Gg: AZuq6aIVEEeRBlGShEuFKcFWiJsE7U2lzP9eNmPuJ57ov0FGdkklLG/ZUqD0CYAi8uN
	bJXcx1oXbIteiFwdAWYxZHdfdTIdeioysg+0zuN1XQxprWIyf2TVc4ceq2Z+vV1wI72fdeKkMeT
	ODsb+o19lHcqx+/BViYyPYO4iFy6nQ7sg6ppNAlUBdcz8L1EvEJ1McGHpF0k2oEbk8eoTGOneaU
	7xr0I9J2vKCaPjofTMVLwcFgPX+fbpeB0aN76OLoPSnnIhkEEUN70V1QL4nJSGLnxl92awvgSeD
	q5D01KrE7tFD874mWK3jPtby0aCdR/sdurixkcGjDvZd5x9HqOPVQQROzlgs/btY/EpIKj4csTz
	ohG+NsheT05Hejh3YTW76kMPeb6aozdEyGbvhU/Jeg3Zb4+rAqvKIs/8UYtXLhvx/76vFON/AOa
	K7RmBJdpMcsSqXI/JLlsiXoBIdj+iuSjzvr5Mvd3qgogdVJPzkMCMSbKPUynDzhqVQutbmwDd9n
	6mu
X-Received: by 2002:a05:6830:2a92:b0:7cf:dc2d:8508 with SMTP id 46e09a7af769-7d52c1d65d1mr6777350a34.1.1771943349263;
        Tue, 24 Feb 2026 06:29:09 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d52cf78e52sm10058593a34.2.2026.02.24.06.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:29:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: csander@purestorage.com, Keith Busch <kbusch@kernel.org>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Christoph Hellwig <hch@lst.de>
In-Reply-To: <20260223162939.523508-1-kbusch@meta.com>
References: <20260223162939.523508-1-kbusch@meta.com>
Subject: Re: [RESEND PATCHv7] blk-integrity: support arbitrary buffer
 alignment
Message-Id: <177194334824.714329.13631824511589600708.b4-ty@kernel.dk>
Date: Tue, 24 Feb 2026 07:29:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 23 Feb 2026 08:29:39 -0800, Keith Busch wrote:
> A bio segment may have partial interval block data with the rest
> continuing into the next segments because direct-io data payloads only
> need to align in memory to the device's DMA limits.
> 
> At the same time, the protection information may also be split in
> multiple segments. The most likely way that may happen is if two
> requests merge, or if we're directly using the io_uring user metadata.
> The generate/verify, however, only ever accessed the first bip_vec.
> 
> [...]

Applied, thanks!

[1/1] blk-integrity: support arbitrary buffer alignment
      commit: 1fa00430269e08636c14b52919a63d0b5cb77eed

Best regards,
-- 
Jens Axboe



