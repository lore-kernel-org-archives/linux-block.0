Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567C2376E0
	for <linux-block@vger.kernel.org>; Wed,  7 Jan 2026 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751852; cv=none; b=ED/sflwzHBnczCuOsmzXFYonVgaE4V2LjZbK+u2Hk5HcfDYLvCkZ/1EN5/cn9D/AylGOf/SGJVfQevkcrIiTewZ2E1wRCIideO3+baZi9YaVyyfxi/bbPCSaf87+tQkIpg2BXNDlo2QEAvYiVFi3ARrfBF4rtuTh4VIVnWeW/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751852; c=relaxed/simple;
	bh=CaibCJhvL55waHquyt1b0Ro+XASHw/tKbBumUPMIUkY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Tn/RYCCM+pRSrZr3Pa1j4lFmEfJ7R1o6j7Zjek0DJ/gTKoS67yYHit7IIao/SSGa9Eg8PreuBxCthdPP2YT2B1C8kiNYRAouHhtBRbkOcO7HTFia/Ojur8K0+c2B8l4MpXyznLDHGPigeEe6HxTqX/iclSIEB2TXXeEI1msvFEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rMw5Unk2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rMw5Unk2"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7cae2330765so200803a34.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 18:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767751850; x=1768356650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGO9V6t38pWhRcUjuKcEmhXixM/ugRlM9F+VeEvQ1Sk=;
        b=rMw5Unk2NgEm31ZQKzkk3tj08RNE5jiLP9tkejreXq5KjLbri2Krbqp7knmt+FZzDx
         T+wesA9628SmVLzV7b/qqXT1kJunSWyV4Rq5eC8dBd74SSl5kBASAdlSP8/JOFG46YDp
         Qse/yVf0vUJVWwve2rXheUV8Heu1iLZF1ZLCRmka7Q1nSmR7kQxZ2uU2Yk+A4yfBRjBf
         V4KSdikeLEnceI97Suiwpy4UsQgd6I9Chk7+JQFKdvPgbr0nbhuyFNO+B2YKrY9vh6D9
         rWjcp4IpOdquSQ86/WwWQYdiqNKUkWGPuN303azy17IdAJhuvZqk+I2pXWpQbzhLT1Z/
         Er9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751850; x=1768356650;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hGO9V6t38pWhRcUjuKcEmhXixM/ugRlM9F+VeEvQ1Sk=;
        b=sK1QpGZ2KFN0SqyQ5Ku4VBffNhKDxv8/JfqMfJ5NdHC7bXT0AmbutAsRWRJPdDGiqn
         tyewVnjhkb0iuq2VKgruRXbgBThATfa+liPYazSYefzJd8Q05dOHVujnH/ZpY9IvDtmb
         0BCjerAq2S0zLZ9uqQHb9mqCad8aQq0Q1aWGP9uTfE9vCsNISkwxhj/+R9z19aUe7rN9
         s6K7/DEFXbSa1gb1pCGO8wDFopx9EZM+4D8E10nWNhojw4ow8h+4S7upEHXndqmyxONI
         3v/zGi75DXXv1Z170BBnfO5ochsQQYOPgeluUToHP09Zj83TKBPqFHbZ1GhGEpz6E6TB
         O/oA==
X-Forwarded-Encrypted: i=1; AJvYcCXTk3kccdRf2CbS/epRBazmNhcp1lh6khNWmth3ByY1YTAQdRvUSfa3RDHtEulcRaEZBVcp8OlX8R9lGg==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd6adNpC+i/WQ6/T3DnSg1hMG7Pna0JvsZsWROKjPExujNVmMV
	49XMKQTTatxmpJyRu3IERRS6jV+WodwA7qfYkQsZebVrAJnT71I3isPelPlLPWJEDL8=
X-Gm-Gg: AY/fxX6DVeJaaC+Ot/vX3nvv0bsrOqMNUlQxuldTwJ42fzXtUNFiM+o8N2J27s+qRdN
	7a+MoA8GMv3TEQoIZSpWNZVHw67wYPdKokJNwPgS9mmFtXzXKsBbvGzRa5Jta1W05BEznbEHVZC
	Qa9oaaKZib+GGVBoPR5gXwPrFX0H9kXQU1L9UnB3/WmOwj1Sy65qB4NA8YIrvuO+yp/lxzv6GSN
	Huiuw0iR7zqOTMC8OdGtnjYwy2INVJYFBRe7mj3ZowsYDJ7Nl1+X+0MtizE4knrjSEYPNcp1bxB
	13X/Dmkvj8JD1HaiQAi9SwJ2WfTuK80Iahvx43UKCAZPv7DpwFN3mjw323+gyksQqq2F+AYdkg8
	IxflRK4PefBse4XsIbZuQm+9JAGBYoEGR/3Zc49l+FaG7rTZ0PdeuBc32hMR1UH3KZ+1E+TGI9T
	xeKpU=
X-Google-Smtp-Source: AGHT+IF1niecuKpR9e1VzWHOa/0aIml7CsgcQQ4j4j1BLPt+s7mJSiluFktoFQ0BrivFQkdNzmZpDw==
X-Received: by 2002:a05:6830:1bed:b0:7ca:f4cd:db57 with SMTP id 46e09a7af769-7ce46d10370mr1904762a34.17.1767751850040;
        Tue, 06 Jan 2026 18:10:50 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm2460657a34.14.2026.01.06.18.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 18:10:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Ming Lei <ming.lei@redhat.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106200838.152055-1-csander@purestorage.com>
References: <20260106200838.152055-1-csander@purestorage.com>
Subject: Re: [PATCH] block: don't merge bios with different app_tags
Message-Id: <176775184888.14145.7372547504260204885.b4-ty@kernel.dk>
Date: Tue, 06 Jan 2026 19:10:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Jan 2026 13:08:37 -0700, Caleb Sander Mateos wrote:
> nvme_set_app_tag() uses the app_tag value from the bio_integrity_payload
> of the struct request's first bio. This assumes all the request's bios
> have the same app_tag. However, it is possible for bios with different
> app_tag values to be merged into a single request.
> Add a check in blk_integrity_merge_{bio,rq}() to prevent the merging of
> bios/requests with different app_tag values if BIP_CHECK_APPTAG is set.
> 
> [...]

Applied, thanks!

[1/1] block: don't merge bios with different app_tags
      commit: 6acd4ac5f8f0ec9b946875553e52907700bcfc77

Best regards,
-- 
Jens Axboe



