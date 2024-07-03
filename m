Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDEE183089
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 16:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720023707; cv=none; b=i6qxmq8QSOHc1Gwrb9dKZ6xccrGItzj7+fwa+a0nJNEIXVqaLucKzJuSVnNoYWTOFRiHukhpI8i0zpQhpw7B2yj7SJyyRiBz/mdTDYfqqLnjaf0V3K8QYNgBHnPcnsKLI0JluWe1B7BN5Udno0PI/wikf3Bd+cBogzrhZL6Z5fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720023707; c=relaxed/simple;
	bh=RuoXGPTQsWDis3UNVcMSmfIW6SFCzHH7MMeCKQXPviE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y29WJcaqDTvqd9TL4/WA0u2ZUNstOmCQy1fDxivFd7Wimazv6dtCKsH3Wfj91wklIWiUEUcws8Ls9kCST2LeDbRRBr2erJuzzcgqZDG5MQjk1ux30lBT2xJUlRpRsL6Gfkmgza79ZY24qMzfwVlkMBOB0K3ZmrFlSESB4+meuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fPQ7Uc1b; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fPQ7Uc1b"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1fb1c68c6a0so280395ad.3
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2024 09:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720023704; x=1720628504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O6UladwbpAykQENDXwpkzxUUhr6MHbfUBMXCwHOX8w=;
        b=fPQ7Uc1bqEBA9BGqRLaC5OMTz0y19PvppQlCrZeVmpyykdtSW5FpkQdPKcDUVZELar
         Y062MTtpDpS69KWQwshjjqIw/UJymH5u99j+p+Kjs79Yk6uSpSbFz9N8BRTQHAihfk/p
         nV7+aos2wMUNoE2akCkjxrp/YMjatKaAjDsbpkSWuf4XquM/YZ6JS1gd/FcUq9K11a9Y
         A4RjEFBF5fuZqqzFz4iIC/WpdvgpThOsf9oAnCO0QX2NKhvWBvEPQv2rVf8T8Es1g3ur
         l+eLx8kPuoOFBzuhwLzZpsueoj/ZVFsh0/lx10nwCjxAY8dHf1CHI2QCMq9Wu/m0+WUl
         pAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720023704; x=1720628504;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3O6UladwbpAykQENDXwpkzxUUhr6MHbfUBMXCwHOX8w=;
        b=uIYY3wyfqO/KaOrQzK11ewnJDpaZY4HBXOJ2BlednRLyqvWz8Eft7IpPmmXRGaxqFM
         o6DqLKPwxthsMt5DIoCKFPYqYTavxAWhB1ZiIMkPUxQHYiTGm5hGNxB1JNllD1uISrbp
         f9Q2Re9pvCRfQ0adxQFYcaIk5l7/9W/9a4o1exiiRbm7Mze5Aj4G9yGDgoUg4O9Kla7j
         DpvVyRGlO31xJlAKTDw4wX/QUeihFzCC2WS9Vz1gL9l1+td5TnFETbtjgn37qVtyTCoR
         mqHjN96UdAYY/cCJgS0nH2Rs02xkvOWI4AETf+Uo7QMfPgZScXb5jykLLzhEM04CBsHb
         Kdpw==
X-Forwarded-Encrypted: i=1; AJvYcCW9AC1ndQNVHFPYYbTzVo5VcbnB2n2KmIZb8FaP7CshDaZSR25lHtl3D/WEJOznDd3GLy7CWfk+1OvFWESrPTfM26oXaEt1JNM+obA=
X-Gm-Message-State: AOJu0YyWjBZGNj+CvnpbqWCfQvjUSecDaltQXafWuolJmkPhuET624ey
	ge40jTwv5EqHbSKNo4kOsEioOXj9c/qjSLinPhljFAkerm7bKDIC7i1SZ5OKbc4yzfJYrD1p8Jp
	aL5c=
X-Google-Smtp-Source: AGHT+IEtxs/rfT93NYR/UNx906zv9E8gRwFTta3mOblIGHKLvUX+hwkMcIcf0vQ9hsX44gpi8s2LRg==
X-Received: by 2002:a17:903:41d0:b0:1fb:1cc3:647b with SMTP id d9443c01a7336-1fb1cc366d5mr16463525ad.5.1720023703682;
        Wed, 03 Jul 2024 09:21:43 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb0c2e10dasm24093815ad.223.2024.07.03.09.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 09:21:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
 Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
 linux-block@vger.kernel.org
In-Reply-To: <20240702151047.1746127-1-hch@lst.de>
References: <20240702151047.1746127-1-hch@lst.de>
Subject: Re: more integrity cleanups v3
Message-Id: <172002370225.229966.7737192611340706754.b4-ty@kernel.dk>
Date: Wed, 03 Jul 2024 10:21:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0


On Tue, 02 Jul 2024 17:10:18 +0200, Christoph Hellwig wrote:
> this series has more cleanups to the block layer integrity code.
> It splits the bio integrity APIs into their own header as they are
> only used by very few source files, cleans up their stubs a little
> bit, and then in the last patch change when the bio_integrity_payload
> is freed when it is not owned by the block layer.  This avoids having
> to know the submitter in the core code and will simplify adding other
> consuer of the API like file systems or the io_uring non-passthrough
> PI support.
> 
> [...]

Applied, thanks!

[1/6] block: split integrity support out of bio.h
      commit: da042a3655151157c06e71a583e883ab2d86d1ff
[2/6] block: also return bio_integrity_payload * from stubs
      commit: 21671a1ed1ff22e158ebe9d619943f926f03f5cd
[3/6] block: don't call bio_uninit from bio_endio
      commit: bf4c89fc8797f5c0964a0c3d561fbe7e8483b62f
[4/6] block: call bio_integrity_unmap_free_user from blk_rq_unmap_user
      commit: f8924374fd37a8b41d554acd8b7407af7d354c0d
[5/6] block: don't free submitter owned integrity payload on I/O completion
      commit: 85253bac4d02b1f95d6109c221aeccd7a262ec4d
[6/6] block: don't free the integrity payload in bio_integrity_unmap_free_user
      commit: 74cc150282e41c6c0704cd305c9a4392dc64ef4d

Best regards,
-- 
Jens Axboe



