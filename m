Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC112DECA3
	for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763397755; cv=none; b=SAVY1ueUiUXNqhMZy6yUrK31uX/2zxCv0XgouC4x5HwQviGPtEc6v6m94U2kOGxbVhU/CB39zYLxHgbKVmGKUeDsW1KXcnA9zMLWx8ul/3L84s5nIkFC2RElvqXtcj1dq47Lu6SOIKyCKe3MJVlOeZJVRoj1YGTO1uxRkNncmBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763397755; c=relaxed/simple;
	bh=TrKHhvKCndiDokU7KnIxjqT4cgeQQ8O0J1xpQzFB7GI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JLcC6/HuJDIH//9QjqpQeMC/W2cg5FT7IpIoT7s47t08oTecVJlzuStPerMjAaTXpBBsYUAEpPwYY1LjP7Lpv/s6ymQvXoOA3EdIptRdk6UulYW0a1MXlE8L288pR40eJUvl890cYQJuEXvEZGEiaFHBApH8kSyTq8sGkkCJT7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FkD5w+Sb; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FkD5w+Sb"
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-948fbdbc79fso42012239f.0
        for <linux-block@vger.kernel.org>; Mon, 17 Nov 2025 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763397752; x=1764002552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuImeIz9Uk0zduA55mA0vmvXz50gokEHjEh3uh49klM=;
        b=FkD5w+Sb/JZJEovU8PjiVPCSmOq4hTFHNIwR1usq+TUPOezaXVaOOP5RKTcLw8Zyfb
         P9/wTv2nkOw4eT3EyYZTKVdMQUnIXNrgDA/eZWeU1/Df509aCqAv7+w+KtPwiQZSCFdo
         qD+MCW3UKa+rk6hetlmwt9siiNhH1mcDey1RM3FsOGQVq+4zOAkSp/6akeDcJSn7R3lz
         ykaPDAVBO595LtoG0cfRD1oZiJlYBAvWcn8ijJz1a7XYZj1Q7gLcAHoGumVrOAFfSZHc
         W8i9WNglG9t0U0P3qxrk1Lwrd/uRhdjsYShNxmbHov0pRwmYWGvIAC2wdL4DGgDMWGhC
         SehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763397752; x=1764002552;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kuImeIz9Uk0zduA55mA0vmvXz50gokEHjEh3uh49klM=;
        b=FQvpM0rvZZo5IxIYuaiazsWMvEgMe+r3CCwjRawz5fdA49Al8Mct9gn1MhZBwOEup5
         HMyfGqAfVvydh+sQe2YAiKdvAvE+R88EBjW6ydkC9Y7Wm1YXGfbHMTw6YG11/DQfRf+p
         zITOTC6xeEM++AhbyRis6CVCN/nzP60nwraXjuExd+uv+W0iBSVc3DkmL2w9xE1ak2SA
         BlSGhxWJqFJvAQoROISXD2lRE3yqwxXUrR4euJtnn+Z2SSPaH92Sf5rp+SR3sQ42ZtkN
         ejcSrPPtCLjnpKUPSBXA2MOxUyRx/7slOaBeSTZYNF+aRkUjwkV3S/Im5JkUaJ0EdZH4
         BWdQ==
X-Gm-Message-State: AOJu0YwQ6cZB1IEWLWxlKtz8BT+F0bUpP+Ua3py+8NS80b/HOxDSDTU3
	gD7u5vVjw08mdgjU6/Mkj5WsjbBewXoDfO7wa9rNKMjxgc6FtAxpyHS9iJE5QbULgDI=
X-Gm-Gg: ASbGnctkRZoiKdMc5EG3Ypu5xVqk3V18ZssCBBBO8d+/XPX8qHaAvMV1lt+cLMtt1i3
	xj5odiqDMZBVW/7UxJikyE2Ghr3BvfKf1T6oWPGHRhYuHKT6pOLdZmmxKrjE7U7hWc077iouF6h
	QaueoPto3xk+NjpnewnVcHRapDWqI1AZ7UX9dMgXiCHmyCXDliIGdeW0e61dG7SsL4tl0o9Yzus
	oW8ZLnWpoXbgroqy2ACeiJ+MPvDd3yG2Ii5dKVIK5n7Yzc0J97hwoSgGWuS34dtP1LGv6e0qufj
	qUS1y90UzPZtih+GUZe9XIO04j6cOvLZDtr5cWpMBC7JYeyRhVpC6KETAL3lFL5Tb274cJ4dWqi
	rUenOcXiLAinIKfydXlsEX27vUb+qSyc9Fu+l1OSEcKuxNw784e+4VuH/GewVUDia0O4=
X-Google-Smtp-Source: AGHT+IF0NC2rUAQ8RUaBRLLoy5CBGLOEHL7xo2Iw8ViwDQfhl9xSvG5v0ESiY6HQ2ZddNMBn6OUqmw==
X-Received: by 2002:a05:6638:aacb:20b0:5b7:c2fe:3d87 with SMTP id 8926c6da1cb9f-5b7c9ecc915mr7134414173.18.1763397752075;
        Mon, 17 Nov 2025 08:42:32 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5b7bd26e131sm4924100173.20.2025.11.17.08.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 08:42:31 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: Keith Busch <kbusch@kernel.org>
In-Reply-To: <20251114183145.519913-1-kbusch@meta.com>
References: <20251114183145.519913-1-kbusch@meta.com>
Subject: Re: [PATCH] block: consider discard merge last
Message-Id: <176339775137.116629.6992941342138596254.b4-ty@kernel.dk>
Date: Mon, 17 Nov 2025 09:42:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 14 Nov 2025 10:31:45 -0800, Keith Busch wrote:
> If the next discard range is contiguous with the current range being
> considered, it's cheaper to expand the current range than to append an
> additional bio.
> 
> 

Applied, thanks!

[1/1] block: consider discard merge last
      commit: 2516c246d01c23a5f5310e9ac78d9f8aad9b1d0e

Best regards,
-- 
Jens Axboe



