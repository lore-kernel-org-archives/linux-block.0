Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDED4154C07
	for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732745131; cv=none; b=uuXoI98t7Na0+YODthqGoyFzqxJNFnqicNoUCEtZOpfinArJSNvGvOxCXIQC339d//Jx0eP4n7ywX7UxU2s8qWXH6YsVeUUfaXTZjcfDmWbQCbvbyct0HNn8hjulplq+f45ORFxDo1bsKBnkSM0LdFny7S0ghAFMSxluURKLebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732745131; c=relaxed/simple;
	bh=EJxsfnbE9EPKEjS1IYxhe790wfgTroUR5XpbPnLylrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jQcOROegC2y3aL3pXsLK2UJ/l4B9ic7RxcX7eCDRnWjUzvpqBZ77UzvfenIl1dq6iofcfCri94mvKYbn/EZI6rSaiABcaUAUMvTvb+bLtAAbA/RkqjonMvrZVcj8vlw2pz6Z8dP15KtQxCsGbh5Yhtydu/qu/PbhM0Jos/PV6Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q2LwP0iR; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q2LwP0iR"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2965e10da1bso178849fac.0
        for <linux-block@vger.kernel.org>; Wed, 27 Nov 2024 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1732745129; x=1733349929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEfa3YKLFju9/80RVLy+Veo+Kl0tn6kt9Hl9/TiHPag=;
        b=Q2LwP0iRnL+MNiswgzCsdMmEna93I4HlqxTD1cu6s2WTljJoKb71bunLvgaB4rppYV
         D8nGBe61gJB/2Ktd2dk0tekzrwbPN5nQ0C2CVVCuCdYhm0CtQe04lUVJFMGZHMxyGJX1
         9QlK3iFCWfbRLDe+mhcxUgMK7zSF9E+41bRRSwMoHLLjpIvF5+gNwGysVBnAfi8fBiRN
         ezWOcEK+dxdK0T9UpWQWxsDXb7HENBQ+UbkhyzGOWuc4+GfiMat9fSWgM/wFdJ8hTB+f
         WOkn4lOnrixQkoPVk2f2g542io5x5vbE/BM59QLlGmZdqPLkpOiVWh5MbNzK0Ba8aqx4
         oCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732745129; x=1733349929;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEfa3YKLFju9/80RVLy+Veo+Kl0tn6kt9Hl9/TiHPag=;
        b=Ow59tLxW2KyQeTm/97oQkvHpKoFBBSuSOmFUJT8bvsozC8OWrDVQ3LFmL65XWz6LK2
         Wwh4ezG5dCAxa/n16kuhhVWrCwPkS3fkJwrB6r+2tqPsbVkyGkb1h9N94meaiLQildwj
         54v6CRCvLUa1ERu7L6sN94RSxisdehrqwlkwph9DM/uweWTDTu8L4TtcbPDBRZWQ0TJg
         FZiyXWkVqR/r7qXSe5WVDsRlThiVy9p/R4PvMyL9yt+PX82okdNnWaUm8mOnrmCXJFxV
         LY6hTStBdaCVaDRU27xFer37yB5a2LK3sLIOu1mnRYl6rSi45vme50yYsvKNsEn8pBgv
         iaKA==
X-Gm-Message-State: AOJu0YyxQ1JwTirjSzjh3lpWhFNoqIZTwTBNrbFEgmY+4BZ3J7E5SkiZ
	mkgj+P78yRQvKPgZIfaByIVwIff/g0sHYnLBNpOXXIXshy0tHFQDP8m7cjIfJ7fbXoynor1/9V4
	GZ78=
X-Gm-Gg: ASbGnctCUJ89NHtafFl7jYrMNd7s0AdlZKU3et+anANecFbGvZu/RH5baq7MbuRv7i8
	IwPvAb6AJd6Tas0267Cm4RDPTdpSb/CZ6/mQ/XhH+esBK7GxtEbIvIuIwvzRAutANt7Bvb/gBr0
	mh02imb+0GkVPYmt4un2YXji0sX+5DBw8xicAOaOJXjyaNaT9qBjRoC1459HsRTHMV+p8F0XXmf
	mU+nO95LGJ5bkZztFoStTOV+0kZhCkBmfCMIUms
X-Google-Smtp-Source: AGHT+IE1R39IjlAIR+j32d1e7PLp2vYrx2zuqAjw4hHGajIQVbWJpBlQun5JPpNgXzT11ISb+V5wDg==
X-Received: by 2002:a05:6870:ed99:b0:296:504b:8f2e with SMTP id 586e51a60fabf-29dc3f9ad26mr4709544fac.6.1732745128841;
        Wed, 27 Nov 2024 14:05:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29de92d8246sm49660fac.25.2024.11.27.14.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 14:05:28 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hare@suse.de, hch@lst.de, 
 martin.petersen@oracle.com
In-Reply-To: <20241127092318.632790-1-john.g.garry@oracle.com>
References: <20241127092318.632790-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] block: Don't allow an atomic write be truncated in
 blkdev_write_iter()
Message-Id: <173274512783.579859.15917530879505552793.b4-ty@kernel.dk>
Date: Wed, 27 Nov 2024 15:05:27 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Wed, 27 Nov 2024 09:23:18 +0000, John Garry wrote:
> A write which goes past the end of the bdev in blkdev_write_iter() will
> be truncated. Truncating cannot tolerated for an atomic write, so error
> that condition.
> 
> 

Applied, thanks!

[1/1] block: Don't allow an atomic write be truncated in blkdev_write_iter()
      commit: 2cbd51f1f8739fd2fdf4bae1386bcf75ce0176ba

Best regards,
-- 
Jens Axboe



