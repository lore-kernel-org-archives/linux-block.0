Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B62318595F
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725458514; cv=none; b=qe4gy+rszoa57tK1UB4GiCgiGElEzH8UOdb4YVCklxZ9b23bq/fC/44uJP4M46s3K15CLDvAP2n9n0louJ889mx+p22KX6CpiqBvnbPMQFbEXkzY3PKrRxNNQrGk915XYiQ4zpkWjepo/nw0x16BsFqLIoXDpovpeuXw6yNbAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725458514; c=relaxed/simple;
	bh=oZUHzFllFNZRZ0ymAqZRn3/ETzjE2DJdUU18PlSGOU0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jbLSpgBhDQNngNDjjDFD+Qp12JFMdGi78WI1GvBR0lpINGyIEKEwn8+/k2gAKXSrpIVyJO/GOV609xxzLM8UBYV9iJGfFgkS8RkdojR7vh4qxHGi+sjhxefkQXRvGWeNj4JyabsTwP19fhcBcl848Rt0hv6pub6kS2/BQ0OKlJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XKyMCGTL; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XKyMCGTL"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-82a316f8ae1so197048239f.1
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 07:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725458511; x=1726063311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et7S0xr5vIQz6R8rPfAnH3OjUESYp8shHXxKDyRmzp0=;
        b=XKyMCGTLN2rcDU7C9KUdt/CIAOPBoJWuZQM4xGnkdNvjVhxj2JnrMuB3MqFaYfErv3
         wmzywVeRkZj9YM5Pb5WMNTy/tjzCoMiMX+aJ1lk9/gZKLp3KbUMMhMUcJtCUYUV37FoQ
         gbj1UXhq3l64uz+MkLTRJDwUQgqvRFfgwjq5CiGRMmUaXJ39eLwbDWfofl3DNdg5g/li
         DLssHT95iAU5DP59flxvWsD1Y9qt3b/stEX6uDCiWjkBdepkGrYS3gGONHpXpIyb98qa
         R20dLJiI8Yl0bmWzAAyGJiszSeE0maPlkb3mX8YjAKpaMAtO1x/GMAG9Y1pMupO1pJvC
         Lj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725458511; x=1726063311;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et7S0xr5vIQz6R8rPfAnH3OjUESYp8shHXxKDyRmzp0=;
        b=ZTcfO9UToIV2ulVKncYwS55Eb1u9CpXb75ukLFDhoksMHrkrecLF1yuas61O2BxChr
         JehmGOeCJoHCgIi4x9YQTg3ecxg0AeE+YQ447T+orfLozTWkS51kpBXfe3UMJxzZw64H
         97gokVcdGBM09yfilrEy+NNTJ+fO6mfQ/6jl7UZhG59/1GADQewYUopfN+0KaCKkou0w
         Tne/BxdWXNimANm+RDxWM0RsoCUjBvhZu9Sym2v/AjNIdcBVTrK/KA8dWDYDDhGIeE5P
         8NxFsm7ot7D2oWR0iioMQiNjIBMRRdIrqePsyuhD7XyLF1QiHicin4ZOZK2+DPThKYfm
         3J5w==
X-Gm-Message-State: AOJu0YwgGszWVn1fd8wyFbuxK710pvDXFE8dhH/9Qksvq8oNRuDxixDA
	izIBxUIYFEEX4Vj9y0S6imkBc+bwZs24z3zQCl1FX57zwGR+223SqwfeJHTo3OTh6uIUjR/z6fW
	N
X-Google-Smtp-Source: AGHT+IExVe/1i3BinVlz5iF1HTdoRCPaF5zpz/PCxwsTW/F2+6aYIAavQs+iKstRFXqHpfY/Ei63DQ==
X-Received: by 2002:a05:6602:2ccc:b0:829:e6c5:cb0b with SMTP id ca18e2360f4ac-82a5ed0d2ffmr827296539f.13.1725458511141;
        Wed, 04 Sep 2024 07:01:51 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82a1a429a77sm365306339f.20.2024.09.04.07.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 07:01:50 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: linux-block@vger.kernel.org
In-Reply-To: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
References: <9e64057f-650a-46d1-b9f7-34af391536ef@p183>
Subject: Re: [PATCH] block: fix integer overflow in BLKSECDISCARD
Message-Id: <172545851040.63811.11093055717026197348.b4-ty@kernel.dk>
Date: Wed, 04 Sep 2024 08:01:50 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Tue, 03 Sep 2024 22:48:19 +0300, Alexey Dobriyan wrote:
> I independently rediscovered
> 
> 	commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155
> 	block: fix overflow in blk_ioctl_discard()
> 
> but for secure erase.
> 
> [...]

Applied, thanks!

[1/1] block: fix integer overflow in BLKSECDISCARD
      commit: 697ba0b6ec4ae04afb67d3911799b5e2043b4455

Best regards,
-- 
Jens Axboe



