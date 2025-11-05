Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646FA263F2D
	for <linux-block@vger.kernel.org>; Wed,  5 Nov 2025 15:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762355204; cv=none; b=sZm+2ioQzvaTFljf7RzC1LPHgf95uCmO4WBdeXZ8oMGrxLt5lIJZ4+6JZ5QJ1rQ+pFLzDCKq9v7T4Slccwornau7hosdUveRAf9z2b53H4b15U6Ygwb20UBtIc3vOP+Y9rNk6RmJ4g8OMVF5uw5hlqmjY0iZtFlEoSpDEm7E4h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762355204; c=relaxed/simple;
	bh=b92Vh6T3zqhhZPnOj2hQMaUsPPDge5lC2z+p0IURe7U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nN88Uo9YTkj1zrpHZmsR9psDvftoXgSmGoTPmP/pKhn3IhxddcvrbZwC1IuHHmkxA5fOMDG7LaYIDT4Dk02mTi9lF+TEGV8wk07PvKpEUg06X/6VkEDxkmGML1tikoLOVN5xWslytC7uMcfz0pQiWxZK3smhXt3L71Y3rSYJVJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8ZHgEru; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8ZHgEru"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-43326c74911so18085875ab.2
        for <linux-block@vger.kernel.org>; Wed, 05 Nov 2025 07:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762355199; x=1762959999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzckCF5aEzJUzXLjGMZ1qOjL6LbguzARHPu5XY2G2HE=;
        b=m8ZHgEru4vXYVsEcE9VNOdDWroKiMvgGe4fuyROi4VytiZnJlDSqGMTAQY6ESnJo2O
         l4mwYF6K7TPNhQ0hdyOJ9/LPt/a2Siazt4hD3R7ZSY9Sce2ofibcqiLaQTxvul4z7L3B
         KGhOpc1JIx/HKaA7o6RaFUAsJueLlWrQzXa1gUdUmzParYELB34fhxJc13stIZ2NIQnV
         IYnj5V064qX3qzrGw+4rBIOA0UfdCkyn/V1n2MBXwAXf5Sp8YmLySL2V8wVNje9EwkfN
         xm9v0Zb46L4q7Z3IDcQfDJWTa+sMxP3aowOAJP5KM1rLaAHw8YqN21tPRBvI+jP+REd3
         cPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762355199; x=1762959999;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzckCF5aEzJUzXLjGMZ1qOjL6LbguzARHPu5XY2G2HE=;
        b=BuMjsLBACB5tlPUq2y7CXlM5hLW9G1ASLr1tQ19XpU3SqY18SS2bWfq/I+5KzzbpxD
         v2z/SHqdhpNC7g0DqU9UlcxoQWrYqGbx5tbDKchpJqG4SP6aNziaPHSFJLNvmVBpBfTJ
         QkAGa/JK1JgSIL7lM1NKwjGRWhEgRWyoDc6dn8x0Inlxbt6UTI7IjteebJSl9y41dSAu
         Kd61EhSy+6ukS0IrEylcG9QorI6zeZt4Nwv1YKVQDhG1gqSkj9m/oQS1ObhRKNI0PebD
         YJ8eEYuzDorzRF+HvwqGOwwYl9oVGagmSABxBKFkGeVw71eFCVaP3cWWoKlinpoVeXOC
         1sSg==
X-Forwarded-Encrypted: i=1; AJvYcCWkJAhOk8/7tDaWXN7niwTn4+I+K79ccb7OFD9UAF9x/cIg2pUnBFbNOeWld36vrdjSjeZyMpfiJKQYug==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoLPzgII7Ztzq1sHVuUjstpZTFjeWC6ocHefopg5Ma3rYZDIY6
	+cTjvLRaBdGXf3awwJDnokZBAAKjrgg3wynEKdg21ymCgOOXViHUesMY/coZV6O/OnB1VTdnwRM
	P9N7f
X-Gm-Gg: ASbGncsoUJslbsW3ISt9UHkZumT/2S/421wblzdpDelggzca+aRr6khoOaD/2q+6GdF
	iQEnyQ1+PhrjbM7CgzjqEMuPb5XOjLiESVOrYnjvJUhUWrNNX2+ahHpZVAF4A5DHWRYHzvG9c04
	Hsl63WNkm01e8bVOb7Aso7+ASMwq0/ncMTCKNjw+gs5V0j69JL6Gco9TzitVESwh28aZcqc10iq
	JnY+/Q+klhXF4w2xku7OB3yoQ7jWYW3CeX+5cFioF0UgnyTwxj7Jah72nmxljQk9U7hXLZDlnYg
	gc7GhqceCU9sUSYqxgCmEwpkEOc/vd0n2vMSrsqE/k+LRKmN0C1mTiV365/V7eHjuP0u9rltCFe
	Kl/VIoC88N9VDLX3168h0AFH1GN5NcXrkmKQujUvmxWSQCwaLIJT8ER10rmzQ9ARxXm4=
X-Google-Smtp-Source: AGHT+IEogCqFBcZn7URbAM7VPSsD3I3r8r0gBIdYnDtATiv5aq7X+Ru9ktVW0rTvWySK1OsTu+jAlw==
X-Received: by 2002:a05:6e02:3303:b0:433:3498:6906 with SMTP id e9e14a558f8ab-433407d51b1mr49391585ab.32.1762355198840;
        Wed, 05 Nov 2025 07:06:38 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-43335b5ef98sm27180425ab.32.2025.11.05.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:06:37 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>, 
 linux-block@vger.kernel.org
In-Reply-To: <20251103101653.2083310-1-hch@lst.de>
References: <20251103101653.2083310-1-hch@lst.de>
Subject: Re: make block layer auto-PI deadlock safe v3
Message-Id: <176235519749.183649.11826263704720817502.b4-ty@kernel.dk>
Date: Wed, 05 Nov 2025 08:06:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 03 Nov 2025 05:16:43 -0500, Christoph Hellwig wrote:
> currently the automatic block layer PI generation allocates the integrity
> buffer using kmalloc, and thus could deadlock, or fail I/O request due
> to memory pressure.
> 
> Fix this by adding a mempool, and capping the maximum I/O size on PI
> capable devices to not exceed the allocation size of the mempool.
> 
> [...]

Applied, thanks!

[1/2] block: blocking mempool_alloc doesn't fail
      commit: eef09f742be2a89126742f9f6f6a0d5d7c83cba8
[2/2] block: make bio auto-integrity deadlock safe
      commit: ec7f31b2a2d3bf6b9e4d4b8cd156587f1d0607d5

Best regards,
-- 
Jens Axboe



