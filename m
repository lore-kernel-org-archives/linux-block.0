Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739DE2C08CC
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 19:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098408; cv=none; b=F256pLZZON9voy/zfwDhYnHYb3JB2h2mKJaRNElLPW0nUYyFmiBNJ50CF9f+MdqaIoj3qO4HgpGu0APt/UpAtjdaZjqer/jga+z4TTcjCkql+d8fUKmwy/ZQSIHS38c2DGLcaNSFR3t7U8xIBERacxZyCFHmNYdvtA/eO1pjMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098408; c=relaxed/simple;
	bh=weoF253YS0RDYDNFjzSDJ5tIChF4WqxAAq+yZqEKh9c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NgbHXjNe9TyZ4py5p912wCYrrjAtPmt2+IGbPVK53l9GsK2fhMFoMpfj8ZLlNUJpci5/JbBoCgXSp0W4FAGz868hr1G+DU7dI0pXsx8CQXNwawyDc3z+242GEdg8r3OWMhWja21suofEcpY1quOewT/TIcK2+A2Uaw2FJL4VhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ou4yP+cP; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ou4yP+cP"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-948f8fa9451so172128039f.3
        for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 11:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1764098406; x=1764703206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=Ou4yP+cPskomYMeVdRXei3aGe4CA8qWru7OsQP6BwdThf2GaArI8DOmVuUTM/9jgv8
         7yfb3c/0JmSqRsVHmB9X6Phme2s4crzBqQXAGysf6khbNn9GegUtUQKxVlcAy26vQYp6
         kl4sPUIwsjVQr7ahV4j/Ysgjpa1LobItHW3YSAHaxTCkylGkOFUf13dApdSBcuce3quJ
         ddfICYEQhhFNAtAxjqjafE/HQviesUSIZ0VFAkfuiWwoW2sMZmGf6ATN89T2oU4YONDk
         y6k1rY57h3ydl5s0+qPDswY0JwxaJs8RBzn4/NiEMU3SkXxLKVYxTQp/dmil0NkNCP06
         IxPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764098406; x=1764703206;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wynpj+E5fG2Oh1abG+WZEscR5HBvHm5298AKLCuUClg=;
        b=u3Aq5SQeoub/4FFNf8x5iAflw/DYM5DpAghWhAZ9F0Ht3+AVYJatJigOszRrQbtykM
         9XNmyMPThK5IzNu45uHeZoqk+dhOYDFKMC+zCQwUkYT7RG3HdfmksB65ToaR7BcQme1Q
         BcrY+gPteI8+c2doQw7ipZiMJmFjcyKwVzyZnyr/i3gmtLXR/wqRUPbwYrR7WsIDMbsb
         wHl4Va0HtYme0Ep9vNrOgxBAvuvbPkTsy/q2atu1Nt5IxZW7WsUA0b90/UdfRUY5MlKD
         AfF5N9XtmwCzmL9NziEghxmFwk/lPwo6w62n+U4f6+5fhbmYu8J2Ip+zzBZqUONrmxim
         TLzw==
X-Gm-Message-State: AOJu0YxilBsv7W5pdTJhUBJbsuqiqx1y7B6Us8jrRV5kTnGoqujxduwt
	qSeFjVSylLAAHW5ngPf41zBB4M728eSIj4U3S0m3uZX9Fo7+x5OzU0c5ax2EfQbVU88=
X-Gm-Gg: ASbGnctyxhBFaHE764BP+8nsrsfuq5m0ySEzfehCRxdUX5f6K0+yzX+bUV5K5Q0siqf
	NiAtXG4RPX95xYQjeH3txybTlAlHbNpS4PPDZ0xJdObIdlv13U78QfAv0Y7XfAEjNOetivNRaIQ
	qFR+wykvmzm0Jx8GsB6UL78nX2e5fqRqczQyl0bnigPQsKdXn/2cocQMlVemb2KJkzZx5c1xC68
	Z04dyNrtBFuxl+BOT6eCU0GExR+HbfeL2/wKMBg0U379ifpQO8qGJ3GjyImVpJ748KRghCTCFgq
	mG8tc8AB5VXzFrxNSearonZGQr/p0NeQEvCmadeYum+l1Yb7hZs/kRxaiLmDnuBxvQeL576nOPV
	/EwX2Gg9FskeOSZuCH8/CKrdFtEa16c2wROyZO09Z9pfcJIIXcAp5RlgKS9a2/a5KEXOLlpns3s
	5WlA==
X-Google-Smtp-Source: AGHT+IEoSNUPWsr6TkiMj1VyTgtSM+H2mYKN8PQqct0sy21hTM0OQb7u5ZARk6n0QLi/CE7kBBB/xg==
X-Received: by 2002:a05:6602:690d:b0:948:a32b:b6c4 with SMTP id ca18e2360f4ac-949473eb047mr1023076839f.3.1764098406436;
        Tue, 25 Nov 2025 11:20:06 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-949385c2405sm668551239f.6.2025.11.25.11.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 11:20:05 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, 
 song@kernel.org, yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, 
 kch@nvidia.com, jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org, 
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, 
 linux-nvme@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-xfs@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
Subject: Re: (subset) [PATCH V3 0/6] block: ignore __blkdev_issue_discard()
 ret value
Message-Id: <176409840493.40095.8097031483064544929.b4-ty@kernel.dk>
Date: Tue, 25 Nov 2025 12:20:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 24 Nov 2025 15:48:00 -0800, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() only returns value 0, that makes post call
> error checking code dead. This patch series revmoes this dead code at
> all the call sites and adjust the callers.
> 
> Please note that it doesn't change the return type of the function from
> int to void in this series, it will be done once this series gets merged
> smoothly.
> 
> [...]

Applied, thanks!

[1/6] block: ignore discard return value
      (no commit info)

Best regards,
-- 
Jens Axboe



