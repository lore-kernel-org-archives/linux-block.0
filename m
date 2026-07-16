Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226041DECC
	for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 12:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203937; cv=none; b=XUo1KD4g/Yc/gmXkb6agP/ky6sPHI+QRcdt7hDdOJXKmio3wqbd9Z9fSBfyRhcsYSbTzmTpsvt4CUqvGLRivy3VDGf2lOkhXilpqoiMMKuKizWkXRuFOAkUuZPJj1Cgtek5MTjQaCDPIYx1bfUcgB3WKV/LulgvCeQSS2CnxG40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203937; c=relaxed/simple;
	bh=Rf7nLlBY0UGt8AcQzy+GhrMarTGAgb8COzbu4/v4tCM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=caMGCazEhiwDbpY8HDKzfTd+itRfzg/aeIMYV/7/j/gXVXp/eSlw3uE5YwuzBJreLm/wuoXyO4o7DByzru/o1dFAnDzZtuQ0r0OdhnPntHP7RUxLbfOeQ+eX7PzxRa96fT1b3W/QMM1swehGxwW+BazxskvzcPtNhCDRbb7AM4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=F71N0zQ8; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="F71N0zQ8"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6a3ea601aa1so393166eaf.0
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2026 05:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1784203935; x=1784808735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kHPEbfAJmbrxwq5A+lYHjFPEkNV8xEpzSlBXgFk/5ys=;
        b=F71N0zQ8Oof26G+hwT36d0MFF7PBlA23y9Bs2fNOdHSV6aF/JIfTPMOccOZwF27oee
         IM7d7qttkyilCFFRHry3UPUrG/zY79M2mC6FqIu4/HjRrYlCkzzHS+ED6CY/aVemXfkB
         wgvMM67Zk2JVNm3xqNT87MtC86Apn1yL46FvUHa04+wdH2bosx7y0aZ7Kcf7ZYyu4nS7
         9XFBMCGbH4Sw4P4ae1G/V1bvRhjhmFyxXRQevZCp/b0Y+7zT/fpGwKT9P7H9xNaToIbH
         CZ4oQMW4r2AyVvt/eW44PFUPPOJvvyYu6G7HH/XHeOCCMi2lrBUhHf4NYMFAeCePkbDB
         4m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203935; x=1784808735;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kHPEbfAJmbrxwq5A+lYHjFPEkNV8xEpzSlBXgFk/5ys=;
        b=GcWoB5DpekE791/5ndREABaevCvmCE6itnswwGWd+SBnq321n8hyRLpupk9kw06KXl
         ZUnPjixCg/I7Dri3KTMfbv1T/qgDzlzd3NTIwqDbZymgUglrBhrg0vAqNDRyZA5SVpvv
         ZOiLcBk77iHoF+dZ+KESeU3/R5ULmNIGf5fGI62Snl4SsCPl49TFmEzpO4r1lxSdyPSf
         PjTceAxKei4oElTh3HZozKvLcOUHoKd3XJWVMGlCzXpQkKUBh1LdDA13G32VgBV/BlfQ
         Qp/IYMLmQlz26f2Su2huWsgSaE47rvS5gRlzwRUmplICHxi5p2TMKl+LozNxeJudy8Td
         dgbA==
X-Forwarded-Encrypted: i=1; AHgh+RrPRF+R4wA57Aq7dB+pNYH1wTQQaDDl6AN5rQM7ikmNLZA0vx/E8rLvM/s86Ob2fQF712Jxg2q0u3hZ1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCwiGTjwugwvsSTDdQnNklLsLnPju7cUIt0d4WcLMuRNFxbwgn
	d6AMhgs7duLnNnykOix0vXZfoT54V8zOf0/1khuzw48AYUoWkZnsBNxaZ9eX5ZDPdX9YDG6Ah5Y
	gqdJxduA=
X-Gm-Gg: AfdE7ckxM19etPvDf6F/jgKIAvLq4ZoOhoU2FfcMdN7sCT3MPa23hEqSkKBxEwqfCrp
	/GOIhsr06nR2FHTTPGVEOqWIIDOZXCnq19cAWM9phIrmnYIB2eFSUu6cVaz5uCYtvrZ9JGjQJkt
	c+wP9VNyu+8ZV42rshWtNB52HOz1qdeslaMYOufJbcADLiCfNbpfppmfL5DtKLZl1znt6ma6c/+
	LF0Z1k/PkwkwMAODUMJlyWGYPT+emFqAQvK8dcksA8PPT0b0uxZhwbRDkmdH6UjHT5p5bASthBR
	UdMR+b+nbR9QVfVlw9Sx1ZmulfRCxOY7wPhN59ag64cKbf967UvJ/6rSQrWfbm3tla6loKxqywG
	q52kEZ5OZjehQFReWFiTVps/yp2jr9ah0lI9yWIRnKrmSgidNLptmMHHTQwwasAf9xQydv3SY11
	HSSKhbGb4E1h13a2whGmkPegqUWRpuKXwiNTl/1njkcM1Rb16Wl0Ejf7c=
X-Received: by 2002:a05:6820:1f05:b0:6a1:5756:10cf with SMTP id 006d021491bc7-6a3ecd74ef7mr1296165eaf.20.1784203935057;
        Thu, 16 Jul 2026 05:12:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a38a4bd734sm11627050eaf.4.2026.07.16.05.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:12:13 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Neptune <z1281552865@gmail.com>, 
 0wnerD1ed <l7z@0b1t.tech>, linux-block@vger.kernel.org
In-Reply-To: <20260716091306.316625-1-hch@lst.de>
References: <20260716091306.316625-1-hch@lst.de>
Subject: Re: bio bounce buffering fixes v3
Message-Id: <178420393277.282740.16973850634777356489.b4-ty@b4>
Date: Thu, 16 Jul 2026 06:12:12 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 16 Jul 2026 11:12:44 +0200, Christoph Hellwig wrote:
> this series fixes a few issues with the bio bounce buffering code.
> 
> Changes since v2:
>  - fix another issue found by the original reproducer
> 
> Changes since v1:
>  - go back to the previously tested approach without iov_iter.c
>    changes that break small vectors
> 
> [...]

Applied, thanks!

[1/2] block: handle huge zero folios in bio_free_folios
      commit: 4f221efff9b32fb4206f8db240a2b35a7d27696d
[2/2] block: fix aligning of bounced dio read bios
      commit: df308a14585649f7683a560f5c94978ab4f8224d

Best regards,
-- 
Jens Axboe



