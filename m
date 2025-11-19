Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02986368269
	for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763563093; cv=none; b=jGwU5X68E/S2SZAsGbPFxKPjOWZRqG70hiSHoccU9vf2Po6aD4UM0rzYSZSssdYXGe/sHS2R48I3icoj8WMMeDKef7TrJ9I1GNeaOuwtFv7K4+vGbUOd77L3xNDpXxHFfgSAR5XTCtP53mgEg9fNedW1pzzWe2l1HeDDo8vQsZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763563093; c=relaxed/simple;
	bh=7z78z8erMydQ8BWXrxy8gPAIoPnZKedhbyqD34vp/fk=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sjCEe5gbL2TQXlkUVt9C84n0AbsHPnK784xTm5QXvd6el2esSHkVlY9mkAAmEqrv/ANzYTajqgGQGbU9mP2iqrAA/jW0yfNema68Kyl46hSdYqxN7e9O5Rrd+u7Lh52/nY2a3BQlg3zfxPQt493p9Tp9sIeq+RZBsUpzHpvLNE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DaY+TqEq; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DaY+TqEq"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-9487e2b9622so401799539f.2
        for <linux-block@vger.kernel.org>; Wed, 19 Nov 2025 06:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763563089; x=1764167889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9PkL/ox+fCHAlw1TUgRrHCpKOGScrrUW6UJCpC00f28=;
        b=DaY+TqEqXGoMW/kPBmfaAG0Ykj9vaHkVW6FX6khxLYV8i/kzqb/c0TEcIhq6VtamtC
         hzsYktwpd3o0o2w0cFJqUZcFSEqsKg/bnay90ybCUaaJ3PiWXD+uiX9atmGwkGwJ7u1h
         4ujgSLrXWHCuRq6IGuiLX+c/HXG8DNbRDTktyi3iPDEmxGXRApZFRdPLiM1D2H5zvHJQ
         Mazv7ccIhtK+JmwPXfdZw9o8hMMnCAzyisCQntovJL13qHhx9rdr45rQo5ZrYDizk2aL
         i4Knbt39pz4S+FR5Nz9sgkCAWbp3TF03QqYA0HfNzHTTE4Hv70HLoHUZnmaZHul3dNgX
         uFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763563089; x=1764167889;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9PkL/ox+fCHAlw1TUgRrHCpKOGScrrUW6UJCpC00f28=;
        b=ju4rLn5op69jdlz1O9y8AzKUaRuoG8u6UEXkNu4aa+BKYHyEP9aCFmXtqqrTuvyEVE
         4wpX4CVYfxXwF00kNiUqJl63TdePARXyaQd5JEWHLzIy6wJs9do0GoxkwvE4Z8w9NZYo
         05OQJzvyiIQqcUzOxgAjqZGfoM+XWvjqB6P0bdwVdtiQACH2Ln11dARCPmO6ALLVF4p5
         9+R7YOD3GVMH6YZR4cQ8qbMA8CvI8iWtrn/JoguTPA4ooJxWwBvPg4n9f2U+0QI8ia7V
         NquQL/fbAAc+ZnAYoX5MlCSeOPSyII03K2lV/gLbLkGnM7qmfh12R8r8cOrhXfv/LDnc
         b5mw==
X-Gm-Message-State: AOJu0Yw0f2BWGi2ysf463qfVZLGAgSemsF50nvsd8F1WFtZwmaLCjosW
	q2WhbTAsQUJBzrkVpY47umg554BFprsWCWzsJHEo+0j4dIXN4MO3gm6LcNBJX0JhYBO6/5iueFy
	gnr1G
X-Gm-Gg: ASbGnctYS4r+qd4ejUwZSRgcvTyFActmtLJd1E7Sv4fm1adHt/0ifOLvwRPsgqY4g/E
	pBF3uhfAz4VfhR7YwJEA5/5fMfAOj9NaTPzuo/VADUFNdgomBRX72btW0AyWflaFXFic0E/gd56
	QCzNE981jKH3ex0YZYUcMemaGffbaS+S80Sk/JgmiwMzH0Znk4Aj20QSabPUDBoy8eDtqUs/nzQ
	g7OOI9JKh7yxOP0OA+rVTyPRbTu/o/KVRj2jwiEK6kU5mmAwXM1rR7yQWGzi4PyahnAScpHu/AP
	s+2v9EF35ZK3Lac5orzB28AW3LYSC/6AjL0JSniHx3Ni9K4+r9CgbKAKgJExFShsztunhnyNHPS
	z4HYmDRKCmrD2r1hpvDtnnzLAQKCO6jAUUq0G/9RcFGrfXnR9mMfR5bLr12j4qAsVKK5KdimqMG
	Fpspd0z4gKxLCD
X-Google-Smtp-Source: AGHT+IH7FQ4kfjvp6TlKPUnr2/8EY96Ycpp08O5qy+RhLF2b5h5/lua6vFOUxRs4JDzt3pAf1vWhVw==
X-Received: by 2002:a05:6638:c10c:b0:5ac:8391:5bd0 with SMTP id 8926c6da1cb9f-5b7c9dc37c3mr16014302173.15.1763563089496;
        Wed, 19 Nov 2025 06:38:09 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd24d5e9sm6918897173.3.2025.11.19.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:38:08 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20251119030220.1611413-1-dlemoal@kernel.org>
References: <20251119030220.1611413-1-dlemoal@kernel.org>
Subject: Re: [PATCH 0/2] Update MAINTAINERS file
Message-Id: <176356308869.449499.11726514414939930568.b4-ty@kernel.dk>
Date: Wed, 19 Nov 2025 07:38:08 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 19 Nov 2025 12:02:18 +0900, Damien Le Moal wrote:
> Jens,
> 
> The first patch adds missing DAfile matching entries to the block layer
> MAINTAINERS entry. The second patch adds myslef as the maintainer of
> blk-zoned.c. This is a request from contributors of changes to this file
> so that they get their patches automatically sent to me when using
> scripts/get_maintainer.pl.
> 
> [...]

Applied, thanks!

[1/2] MAINTAINERS: add missing block layer user API header files
      commit: 00ed0350944dc33ac76cca2ddd2966e34f32a80e
[2/2] MAINTAINERS: add a maintainer for zoned block device support
      commit: ebcc028b4a3db7f4a76f97b05d746aa6ff1a56ab

Best regards,
-- 
Jens Axboe



