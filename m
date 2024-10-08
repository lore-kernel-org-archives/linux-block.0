Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A31E0497
	for <linux-block@vger.kernel.org>; Tue,  8 Oct 2024 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394125; cv=none; b=eRa8Ffi/DsR3vBW6v4bLRyZ0rRS1yc/xMRSFbt4g9XNfo4WV5/u0QZAdHYuhWJ0mt0CJCiF3ICWJ1Kb6uQIoH0/JhebijiPhlZrDaomTproW770xHdVTeczw8hAo93C7SxRkpRZHhu2Pn7De3PMsBGM+Q6TiBqZQMzbzeVszmEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394125; c=relaxed/simple;
	bh=Fk2xWdQ7oFJIptimzfQx4nG9gJAcjP31UB3hTYdUsPI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pFvT17LBR/E3oEGg09z3f8eGD9rLAxNjJzgHol050VGyiTEn4J/9X7VvJwkVT8Dy+XBAPOmJ7v9ZVD6TbHB0LpS3I1YRz3CdgSqfhW1xBowDGLmkJIKFE0zt0TurUxpjSNndWTUmu1tOdcoM+2dOodzzVCn76xrVAYFJ7K5k4so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YbVZgUwt; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YbVZgUwt"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a3636ddad6so19833255ab.2
        for <linux-block@vger.kernel.org>; Tue, 08 Oct 2024 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728394123; x=1728998923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gtLinp5gQmHZWPk0gJtgI6MvF+HIdy6GkOJ1R/ji5U=;
        b=YbVZgUwthV8LN1FjKh+SyKhDx+Tb8yV3mXFyhwQMKeoot6bGfPTq/SQkl7/6k+ZIaP
         QthMetKVA0ESEOKRjIbYV585jooB4+049R5bRHenQCide5yTivk33pN5MTLwW2SpulSi
         D/sGkKJQw5I9CvKdzyA44l22Rp02vYc38wssqDxDbqif3IDDRE3msSLRXmcftosljn9n
         3K0ogruTtE8nDSXRyuwQsRK6MxJahM1zw6yhX4hV5goWfsza8bmnlqCllHdzm76LwoFH
         ryECmLeeuEfEkfvEOlRyn6+hQTGYIN5qpO0LsfOwP+9rDuot62pYDyhtQHeHMdg5tp5l
         zKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394123; x=1728998923;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gtLinp5gQmHZWPk0gJtgI6MvF+HIdy6GkOJ1R/ji5U=;
        b=wluooBqPKBFbK/gTqAJ8kzYVy3KNoUkNAYRczt5wPV22abQq0WbUysEvpShkbPp8t3
         uR70gi935NMj28W+L3SkgIx1HXku7/J5ucXtM4hA2IRj7/69Nh9x7ol8mlVka2eH8z0E
         GhkODLEE9/jgjeuRS8oPq18KE57vNGOnf94qWCZXUTKyYBXIGI/rtcBvB4HdVMjyjD7P
         AT+0hQIb6DeuStPhXTu+e0/Wb4/I9Qwv/YVBy58Hb3yeFDCWfaf9JS1/niuHbwPwcs7c
         LWaYi98dHXEfK5SFZLU/sbtH6LGhP/DnctysWncNbrY8et4vOPp5h8HmVLRNdJLcALiA
         Y3KA==
X-Gm-Message-State: AOJu0YwMxdg59op7MrPaCpKRg4UG8BWBqji30ZAQh+x4Au5T9O+Cun3S
	zflwtRjy8j18Jumy3kyqhD7WZsSw2oSRBbBtt05k7o9kWK2LH/9kmomzqwlodNAWMzozAYFgylC
	lAK0=
X-Google-Smtp-Source: AGHT+IFLuYWnVkBg6vVNiVVRkSBT/9RVastxB3Uz4/Mjy2kpIrp4snraADHXveLniIEybfFGJMYl6w==
X-Received: by 2002:a92:b752:0:b0:3a3:778e:45cd with SMTP id e9e14a558f8ab-3a3778e472bmr103519665ab.21.1728394123317;
        Tue, 08 Oct 2024 06:28:43 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7e7cb2sm18287785ab.6.2024.10.08.06.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 06:28:42 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20241007153236.2818562-1-kbusch@meta.com>
References: <20241007153236.2818562-1-kbusch@meta.com>
Subject: Re: [PATCHv3] block: enable passthrough command statistics
Message-Id: <172839412207.7534.15256939193261032051.b4-ty@kernel.dk>
Date: Tue, 08 Oct 2024 07:28:42 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 07 Oct 2024 08:32:35 -0700, Keith Busch wrote:
> Applications using the passthrough interfaces for IO want to continue
> seeing the disk stats. These requests had been fenced off from this
> block layer feature. While the block layer doesn't necessarily know what
> a passthrough command does, we do know the data size and direction,
> which is enough to account for the command's stats.
> 
> Since tracking these has the potential to produce unexpected results,
> the passthrough stats are locked behind a new queue flag that needs to
> be enabled with the /sys/block/<dev>/queue/iostats_passthrough
> attribute.
> 
> [...]

Applied, thanks!

[1/1] block: enable passthrough command statistics
      commit: 5dfb485db7d998b3eeb16bb95188c1e56195e047

Best regards,
-- 
Jens Axboe



