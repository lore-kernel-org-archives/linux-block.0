Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1429EF9C0
	for <linux-block@vger.kernel.org>; Sun, 16 Aug 2026 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786838563; cv=none; b=ReUguvACz7W8rVwM1FKn+TfhCun+o22b5SN3GzKxzNnrSvLdrXKwOp7Gx51wJSBQpfHtnqhivSk1VDZpdQS6O7As8Y4toCsohjeHU7zHoYqpMX2u1xwMWAs/rs1BlkySMFwbkv/pyWiF+bS5TSsEFANXnDVk1XafbM4faw7xYgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786838563; c=relaxed/simple;
	bh=3mYRE2QCA2LEhg4YJf7q+WKwRqNcW/Cjfe/0AsYgI54=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QwDM8LaAIdRZrIxuokt4sE4MtoZZXCFoAfQo2iUCUBeTSyMjmQR8JOOvQcXGl8f1g8Af9Kruj0C5sEAPHjEDH2MGLnmbQpbBiWnpJsRBuy/Qz9T/Y+i4gz2a9AoQxSAeo2JWBUDnYYLTcUCwsheLE5VHWStPAOn+5X9RVHQjho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=wJRdWJgX; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="wJRdWJgX"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so1497953b6e.0
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 17:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786838561; x=1787443361; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/qYiWPxcEPcSLoYvYCRcNEvFDddbp3US1rM2m9/kT4=;
        b=wJRdWJgXnTTW7MENHCEDXrX4BSFEHluL9+rm0ggsOlCYe9Oni9/NMvmoqzeoCir4Xw
         /TMSMuP3DKSkhj4zLO0lHS4DBSC9ajRGcW41A0c+teXxfmyZEwsxMCOiJgnwUPsfiOQK
         yc1/OSyz6H23ovKd1XBDneatSLT8mLUeZsZwpR5XTB+uxaWMSpbetQSBVC3aBnRTIG2k
         x1Xgs6Fk+079cOYFJSK/GjTK/5qjK/wpWaFH4fsGjxi4saRLyi5qykEYjgOSahi+YO8I
         Y4zc1R+6wKkyPzVNqBMgADK69wal4PxEZSN7qhzE3DcQ1/M0QkWLIaqUKfXj/SWqSXKC
         2oHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786838561; x=1787443361;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/qYiWPxcEPcSLoYvYCRcNEvFDddbp3US1rM2m9/kT4=;
        b=Hs7GW8RS7zIXeH/U3he7t+P2ReBrYO7MaEti0LHUuWnT2UEbtS6P1rmYKngneuziKU
         Xhwul4ZeQPHjSvDlaVu3TNHwt6lef6G5Hv+/swngjIgwtymovcY5fJABAkUojKkW+KYb
         MDh9+9XKGo9vx8sN3fHaEhPO1QqBQNXwANfof8cSQ8RWUj4dhbVrphYX41joXuV7j22G
         cTgvK2pTqnqWW8QnvoL7hFJYxrYvyceIaDL4Viw/87yM4FzxncWV23hV/rEd6ScSzO1o
         5sDD6jdqotztdnkfPZ6yltEBmp5IykljWtDPy0JrGsM0y+/ND3F83XpkSJcva7xfDPVX
         DZmg==
X-Gm-Message-State: AOJu0Yzh6uJQs3fS4Mh317mivoz6+dS7OvloVAn0pXMINwRPyiAjIhR8
	pqU8ziDLeb6XtsMlEOQtAyRktpkqKk/dph2oyqq6TO4CtP5aDxSNgWJehvvNw6ISxgg0lZ9DXys
	pllWnGB2XKw==
X-Gm-Gg: AR+sD108uZMAaw4R0TT9085uifhdchwC7n6ofV2jvKGsqY21eo8Ep/Bbyu7TWruzb5W
	k+kQRYte23WZaiOlZ7ZAg3ZVpylmmwkgdiElYFe1JSZyOgsMK7r0xw3DyfBdxtff9fTeGmJNmh8
	252anmuZobR3YtxIXuXauS9s6mOpiEmagOd5SP9GwLkdL5eMqANBmJ33hDK6znuFTgPbGWoLI5W
	hGlztJla0mtjPgiLcdlh+5SsPLg0n88/pKRdtCF0pOwXTcw/ZrtN/5ak5i8oEEzJvHeamBRZ70N
	Nx4y9XM+kGL5h8UhN+p7AZCvoj6wHv1p4krziVONQkFrAOnoUjFh7MkPF2184zYi2hXHD06tKBd
	CPlgA7KiS8H0/eHXwTPOC8yqdOVwrm2vi+HCiuhGNzkYQqJNdZIcIJG1NVciiQR1PC0P9VEmdn5
	XQy1e7yZ76IGBmlq5LJ7kgKQBRremvdii2ZyaXBF9QwWkIkfDNeWNVWp2hnUWAM2YuTxk2xOdfB
	hLmP89QKUJjqnT+IfYcaffHUbxE5J9RgznswQBzNaMg38Kvjld9
X-Received: by 2002:a05:6808:1313:b0:4a4:c12:ee68 with SMTP id 5614622812f47-4b241e0c705mr12332553b6e.10.1786838560845;
        Sat, 15 Aug 2026 17:02:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b24d92462dsm4347729b6e.5.2026.08.15.17.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 17:02:39 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: linux-block@vger.kernel.org, jianhao.xu@seu.edu.cn
In-Reply-To: <20260806060441.676-1-getshell@seu.edu.cn>
References: <20260806060441.676-1-getshell@seu.edu.cn>
Subject: Re: [PATCH] block: mtip32xx: synchronize ioctls with device
 removal
Message-Id: <178683855833.1984298.10971341503656309958.b4-ty@b4>
Date: Sat, 15 Aug 2026 18:02:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 06 Aug 2026 14:04:41 +0800, Hongyan Xu wrote:
> The ioctl handlers only test REMOVE_PENDING before entering
> mtip_hw_ioctl(). Removal can set that bit immediately afterwards and free
> dd->port in mtip_hw_exit() while an ioctl still dereferences it. An already
> open block device can reach the handlers while del_gendisk() is in
> progress.
> 
> Serialize both native and compat ioctls with removal. Set REMOVE_PENDING
> before taking the mutex so new callers fail after an in-flight ioctl has
> drained, and hold the mutex until the port has been torn down.
> 
> [...]

Applied, thanks!

[1/1] block: mtip32xx: synchronize ioctls with device removal
      commit: 68940f841d013192086a0f6d7cfbac2cd079e228

Best regards,
-- 
Jens Axboe



