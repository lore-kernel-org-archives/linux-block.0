Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAB4130E2C
	for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711556959; cv=none; b=ZVVsbpit2iDXeNFDnjuhg/QxhmMaqW9n5l5wZI0/icq4UTPHag2P/cH38b/Ip2IV8WEIEJUKDL/OZd873mb0rRYdCRwEXy6PDMm0yr0aUMpZjiEzF17fIxquqg3efgDFqamj6NzFfZNBIaNFjGw/l587DxfsDqnX49g9VpX45wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711556959; c=relaxed/simple;
	bh=mII8AsdGfE3GWsjGzSAaPSlthCFXTu6oTlUS3OqE7E4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RonLmRFiutcnEAu3N3yAFipDgk1Pc3Z4GDA6cXqwawM/ctBb4r0T84U89uxaFzEAhfdQ7iNX0U+ke9ikE73Y6/qEd3BTZfBqJF0oAD7ehiLQc7N7EgHkyfvXnG/at23pDozrJ1SaxqYMta0Xh+YuAxlZ0IpahhusALdQgLL+jh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1ttpBI+7; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1ttpBI+7"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6e696233f44so13771b3a.0
        for <linux-block@vger.kernel.org>; Wed, 27 Mar 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711556957; x=1712161757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBy++hZ/Vyd+a0hUTwNOGiU/nVRI0XUoA6D6aRpBZ4Q=;
        b=1ttpBI+7rVIS5tmL5/7bjPoQQpQYyZ8d/L4WtNCvpbMl4+emJpi8Z+x9IZSXkRm+Hk
         Jrm/RaIJWYIe+oA2V5MWo0vR4uATYN6uQisCJFozym1tt6et7yhtNsMsnuKQjCKkbIU0
         kTW6MNCfPHzgLLW5i3ZnXCv6ob3wryuGqbJiXV7aAWBMj29Kx29RP1R9dr2e24XDCGxR
         k/ns/a/5/t0zhCc6dmRPeFfbCvIiyVLLPYo8PJBi2sQxn6YkJeCc8sWPIEmHADvQfHoh
         2a3XOjjnCVPdVT8CWbhNkUOU9tarNTddGNmh7sN7VU8f2NmaxjCqrgBOeheLYE3ixmd/
         fNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711556957; x=1712161757;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBy++hZ/Vyd+a0hUTwNOGiU/nVRI0XUoA6D6aRpBZ4Q=;
        b=vN0z0lGFK3zR5CETrFGCF1awIWFKPBVrz9ubDWoTm2fWS/vHza6xETKCETicIxPnBm
         Puvuo3FnVoQhW1jErQsXlwfCnP+d/8hfJIAGsn5zTrfUaV+Y6tcjLhIwSG/1FoWp1bDc
         VOMCQObi3VMYLyKl6kaii/r2RvWNnAw+4CWj7S04ScLAeFgA67KZIRAdd5dipyyRIxTq
         MDNUK0spZ6xh94Mh1+XUwrtwG1a6p6akSURG3WU2r/fL4DK8Bk7lYwMEYPnWBSKzdWay
         9BgrOTBVGH+ZYSGWaey233FwxZ2xYRWMMM/qhIM5t2qUDmIEROFUJJIik4IeWL0baTiZ
         FM0A==
X-Gm-Message-State: AOJu0YxM2sKSpqVZhJe3vpIbHWCx1Q5HlVSFyWRfLSWRhRuiqCnv47rF
	A8vEmaWcGrjy0r71Y4tFniUONKjgRGrxT0BLmgLFns2wEK4RTZQCk3rFnjtqOns=
X-Google-Smtp-Source: AGHT+IE+wXfhdDTkk/+vUItbUPXH0iivy7FtbqgNS8SoDMVkJFdAWKbiI/nTGqqNROD7CdJcTeqZpg==
X-Received: by 2002:a05:6a20:3ca1:b0:1a3:b0a8:fbe9 with SMTP id b33-20020a056a203ca100b001a3b0a8fbe9mr565562pzj.1.1711556957159;
        Wed, 27 Mar 2024 09:29:17 -0700 (PDT)
Received: from [127.0.0.1] ([2620:10d:c090:600::1:5ff4])
        by smtp.gmail.com with ESMTPSA id q9-20020aa79829000000b006ea75a0e223sm7998068pfl.110.2024.03.27.09.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 09:29:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, shli@fb.com, hch@lst.de, 
 John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20240327094020.3505514-1-john.g.garry@oracle.com>
References: <20240327094020.3505514-1-john.g.garry@oracle.com>
Subject: Re: [PATCH] blk-throttle: Only use seq_printf() in
 tg_prfill_limit()
Message-Id: <171155695535.507853.13796923043030036347.b4-ty@kernel.dk>
Date: Wed, 27 Mar 2024 10:29:15 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Wed, 27 Mar 2024 09:40:20 +0000, John Garry wrote:
> Currently tg_prfill_limit() uses a combination of snprintf() and strcpy()
> to generate the values parts of the limits string, before passing them as
> arguments to seq_printf().
> 
> Convert to use only a sequence of seq_printf() calls per argument, which is
> simpler.
> 
> [...]

Applied, thanks!

[1/1] blk-throttle: Only use seq_printf() in tg_prfill_limit()
      commit: 8ab13608cdad15fba1a5f43b8ef7d535e2faa7f7

Best regards,
-- 
Jens Axboe



