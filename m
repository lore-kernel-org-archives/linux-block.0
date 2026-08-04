Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052CE43B3D6
	for <linux-block@vger.kernel.org>; Tue,  4 Aug 2026 13:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785848442; cv=none; b=VIMOzfncb9eTTMjmv54FtUn0CH0HG0mNcwVpqo/pSE2tVp/30B8Cg9P0laxCFZq0SIHQ5XunAQjqrLGFOI37BCk2PX+PS2QQ9ZB9vlGlt3+ZrYDnfipAE4SjMuYymwvQq1PwD9ZMq7AljKT8WecsSP1/MWtrfr6ASNWCXHipCwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785848442; c=relaxed/simple;
	bh=Jf/ulHB64njn4WmjKBUzNqvAIC1wFOlc2MREPr/01m8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Q1j+Mf0NuWB4dUn3erNqSSQT7Z2pQwWHVd7kl9bWumtmycvKlsPxA73n+eOBnStdqOClr5/Gc2xwD4FO5QLzA5p5skLnKDpQPTI7gt3IEBTEcof27uCMS77WFL0eVTb6u06bUVVDp36BbuFG0UhdQb9Lw4/0wMuNpbBH+AqeZ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=mnlu+R31; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="mnlu+R31"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6ae50ba83efso474388eaf.0
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2026 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785848440; x=1786453240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CD2iqK/EPaClCBXLVXSOQDWirgcUGjlrzZ6ba7dIsAs=;
        b=mnlu+R31J6ogLzyJU9L/xFL15Xzm7aCfoKV7X/e568sX+3uyYWN+HCjxMTRdRfHEZO
         FYCiKTaN2Z5VcTOn8XU0tOAuX0NZj9c0oDGvOMEMxadmpXLIDjls2cTLKSAV6btVcAld
         8gXIlAbcesIlLVIDCjgc4+KxCsjBhwn7caSrGk+Szj+CEGfTN8hkE+isGTATG1uF78K5
         ODyUNJuDCoZLw6ky3CCpYbWE12/vDgoCfFSDMfZ8esYHqSj6+V0EQTOFVPKqZk5z7We2
         psNb99Gtj4gDwddphD6zV1ppAVxxE2Ocu2VynBjMZcqQmi/gWxvWoLceU1HXmbljNDrc
         DHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785848440; x=1786453240;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CD2iqK/EPaClCBXLVXSOQDWirgcUGjlrzZ6ba7dIsAs=;
        b=myiZ/UzTfcl3aQL9nZ40XkWHAA0kd+9/tzGBa+zbIFUCcXAX8nT+8xJwcrX51eNVpn
         G97iUqPCWREwxIjUQBbUIXBUncS1fkyO+O0fngK1voRFcymceisdOTT0wIo2xtJKE6fL
         zpUx/qE308GGSTKUBAtS3Y9LxZY53WUzezkN5xC/CRxzuxP6/3r7451gKsA+LF0v7KVq
         0kSXf+1AVhzxdB0i4WDzSp5GI5YU+ZtAMK2Up+NZIHx2/Ckp0X9Rzb7bG89pxJ6GKrlX
         Eu+xrif60szh4zJ5RISlWllbtGn//Jrqa96a3hxnhmH+O3GO0rUwXcUSir1K5Ewvg1f/
         MfGQ==
X-Gm-Message-State: AOJu0YyBR9T2hidUio7bIkXwHwMPSP7f0n/s8qKnvkXUQ96Hd8qye+Yb
	53lMZN2tkckz3ELwVCGctLhzlyWAdOFGO+AtUV4318bHvfBbxAGyQiDy6c8JXjNi4iXKf1WJOfy
	hrUI/MFGwsw==
X-Gm-Gg: AR+sD11JyHlgllGU6/03WwgW4mU3oa9927GeHokfAmBU/OjloxthiKS5VuOVsQYGeRu
	OPxqKYUBpbI+WCMJltcZZMFA3KQCUC/kCeCm9NUBm6LRxwTz08dT5PbaoOhBJ6pUn3PUbDK6Lxk
	rmuiwUOFj9/SrS7f/jW80awO36xL4L0BZlxkjh9f/PKY0GdWzKU4gnf9fUQTUJ2lRGv0fk2cCDO
	yqr4M3WDSeyQr3nPhIy6xWfTLyqkv5nUsjTIikj3/+BfsBIPOYhCvTAcImT2X8/cJMR4pnomB/V
	a5o43T26nxg1B5/uQx7c6H3HHkJG8G4ZYvIErUvK4N1x6F+sqCp/PhS04XQlCOzOZDLCs2MeyUT
	QP7RZONVD3VUENI744r+/QYE02s2feDtKtmMwmjMsaBr3Rm8RjK7hrB6TdDAmLyOzqgvhWBnPGg
	TkNb+F+6BuRaFmp/Ab/A5CksMDCJqEtGgjqtLRvjwh8azn+4fPN8oMscOIeEUCczAAlvnR16suE
	TPDGWBxpx0gsSk/zp1Q7+27VyfzzxGYTBoGSyyPpm0zxOz2naAg
X-Received: by 2002:a05:6820:4de4:b0:6aa:e7f9:fa68 with SMTP id 006d021491bc7-6ae828b8bfdmr4365672eaf.11.1785848439805;
        Tue, 04 Aug 2026 06:00:39 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae93d61482sm61530eaf.7.2026.08.04.06.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 06:00:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-aio@kvack.org, linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260804125524.740996-1-hch@lst.de>
References: <20260804125524.740996-1-hch@lst.de>
Subject: Re: [PATCH v2] block: split out a new blk_plug.h header
Message-Id: <178584843869.926496.8137441533296046276.b4-ty@b4>
Date: Tue, 04 Aug 2026 07:00:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 04 Aug 2026 05:55:10 -0700, Christoph Hellwig wrote:
> blkdev.h gets included in various places outside the block layer just
> for struct blk_plug and related plugging functions.
> 
> Split blk_plug into a separate helper to reduce the amount of code
> that needs to get rebuilt when blkdev.h changes and to slightly
> reduce compile times.
> 
> [...]

Applied, thanks!

[1/1] block: split out a new blk_plug.h header
      commit: 758b86f7bc8a2582d0783f3535854ea05d3ff97d

Best regards,
-- 
Jens Axboe



