Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD1A2641D3
	for <linux-block@vger.kernel.org>; Wed,  9 Apr 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206308; cv=none; b=pPurf/dAaQfD4aAgHTzsG1+P3uSexIfL9ILItjFaVvaeGQ0TKAkE04HRPkSjRRhQWjYar5D5H86vBzxxCHwGAxZQbRHt0mpZZr86Hv1W+vnzX7FyPEEVgZ+2EQdWEKFJmarAhm7BLBJR/+yly33MFkOk8Y/0xw2QUsYr2Atuj/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206308; c=relaxed/simple;
	bh=N6wcPMUvh/0+BCr/uygdnupqu+ftVjbtZbuAWSWYlIQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fk9LkpIkunZdf/9NW6zuMD3Vg1aj6xVg+YCSUev0kq6DZkmnH41/F0Uyo4nCOhfAFh/NshGlYkJ68srub9ysKeR+egd7+L/v9V5kjXhREG2SFr4HCrrsSQcslXoTnYMiQXuQxxuKi1Ii1+qPS51BvGjPAJqRFV1D0ej92aq40W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GvYgJFqx; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GvYgJFqx"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-85b3f92c8dfso222427539f.2
        for <linux-block@vger.kernel.org>; Wed, 09 Apr 2025 06:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744206306; x=1744811106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2n3IdMUkHossZhEf/i//EkX+jKlNoH2+k6k5Y9546g=;
        b=GvYgJFqx13AfXjYZVvcQ5yFtZV74Pw6kJ/LNUn8LyEl/QlilBOEr3iZdd7iYRf8yQI
         A+6A+6tW3hmOGzWWmKHjcFkBHIdiY2FW5FqHJLaE2uLMHzl7msU2hkOkEVvthuTPPUhp
         VgWQC/xhDDCCvBm5viBwRnCWFG33/ElVGkDdFS1OAr91Poyft0BTJrHd8RmIW9y8Rt42
         x+hGMtuWrukNx7fS1Z0lENh+zSPYg5ZKOEXdh2P3SB3W7zEwREoHS4wwl9Xrv0UOk1aq
         fA3zv2g1CQiFx3wACiebVv+tfTMVlOpC01mSLgyBG/6pj/rqKON72F/FXNqlkwQ1luvc
         yg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744206306; x=1744811106;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b2n3IdMUkHossZhEf/i//EkX+jKlNoH2+k6k5Y9546g=;
        b=vpYfqXyacCg4LiNgY34MztVnR0EoxmvB6U+VOLjfu0A9gfxSUwCYbh+2yBaCXjcuas
         5vZBn4TWmSn6VZtx44M5otnCixyH6Odxw1Ck5kM2XYo/rKssyyyoCOo+56AbCeph/XnZ
         siDcnjXXPLxovToZjIN5I05HprPP0tvAsXiWXfPribpgMMnS+nrd667TvmDjpj4id5Ez
         G0m+XP0YzV+Kk8yhEAHRDwOakiyBsFIoOHYI9oWoq5vpTyVWhChoJ2R5dq8GQEIG1dRF
         Nuzh/aO5W11sx0blYzo1W8SgKE1UAFe8NcM3FcKrIlMtRUb9m1XsL4Iy0ycVxXbq2zwE
         /iGw==
X-Gm-Message-State: AOJu0YykLrlsXq9aC3KZLmqphI5tsOZWQXJGDlZBU+dVd2i5Nn+NomN6
	wglFnwKmUvXFRHCJgMv56dbM91CKUhanB35B+8Xv6HSzDDAa5MyBf5xXluRAR5Ol8clHNw21hsK
	x
X-Gm-Gg: ASbGncvj2ht3Y8b8duczv6zQmd8pAyxshGnLnSbOcmaBp4jhPzprQKrLqDNm+eISN2s
	/TtM4huqi5ojBQ4v9u0Axk7G0m2tQDlVFk6Wgnct2mjAZtzdbQjaXouNGXKkgsNCa+T7hw23oyn
	cN8tm3ARDfkEZOcuIoaklPZQaAuEFK0hMPY3AcNxlrAMR0zrgJ7IjLav26fAQrPInmWEITmnPWD
	aUE/SCdjTOjapCPNjWr9SPORsM71AKjhNuCzRDbKmfMsx6XzOL5I3bnM9A5WxvClP06UZKZb27y
	hoWJoTvcYnfktFwEJYVJHMCcFtmjzG0=
X-Google-Smtp-Source: AGHT+IFioQPajn1X/B1bL++WNFFBfHffOKSyT9NVCBTe6b+vt/tSXgZ1uZrVMVqdKBwAubtTT7hRZQ==
X-Received: by 2002:a05:6602:274b:b0:861:1cd4:1fef with SMTP id ca18e2360f4ac-86160f60d6bmr354276539f.0.1744206305776;
        Wed, 09 Apr 2025 06:45:05 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505e2cbfesm240104173.105.2025.04.09.06.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:45:04 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20250409011444.2142010-1-ming.lei@redhat.com>
References: <20250409011444.2142010-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2 0/2] ublk: two fixes
Message-Id: <174420630427.200173.5693990872245207194.b4-ty@kernel.dk>
Date: Wed, 09 Apr 2025 07:45:04 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 09 Apr 2025 09:14:40 +0800, Ming Lei wrote:
> The 1st patch fixes one kernel panic issue when running IO vs. remove
> devices on ublk zc.
> 
> The 2nd one fixes one regression introduced in this cycle.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/2] ublk: fix handling recovery & reissue in ublk_abort_queue()
      commit: 6ee6bd5d4fce502a5b5a2ea805e9ff16e6aa890f
[2/2] ublk: don't fail request for recovery & reissue in case of ubq->canceling
      commit: 18461f2a02be04f8bbbe3b37fecfc702e3fa5bc2

Best regards,
-- 
Jens Axboe



