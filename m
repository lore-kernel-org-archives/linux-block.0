Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B063407
	for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708261319; cv=none; b=GOX4TU7zA9lNRbEfgupFnLe4ZwOT3odAYakglknLNDMX7W+wV3nP9ZDdQPUh9BxTh6NNKev4VTuI2jkFM+iEQoJ7LJWb4OeGULG+dhBn37ntthOjkndjcbZHclUbD384hFJtR57ACnFmc2fqUUkakw/P6xtcwkHM8Frj1e4Rx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708261319; c=relaxed/simple;
	bh=CArwFe0qu0rUAkzUEv7P8qSaBIOWCLLpZlpvdXeYt0g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kpgt4itUl8O82QZf2xzMpUiJJcnJwVbb/ohkYM/VrS8MPuW0s5BbNT+VtUoHPcJEvF6jOhWUNUzu3OEB7IkUSmQUVyOUZ3WOWyWBE9jeVBxZ8D2zNcFKyrBKG4caBR7PmXG2vAWUs2b8Cxg7rd4uV6qf+0j/e1mFjFtp2Z4NOxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=JhVbExaK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="JhVbExaK"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29593a27fcaso988295a91.1
        for <linux-block@vger.kernel.org>; Sun, 18 Feb 2024 05:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1708261317; x=1708866117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iIYyy/W1tr/0bAEhThJxXh8k4ZWLMBlLPwt2pJ+jp6Y=;
        b=JhVbExaKZAiiOrbb7iq5oKT+m7TBI48oaaFxNzw5jUtVohmspPtBQEtdabTwMWaWXK
         xxhsWqfEuWeab9foLvASxXZxlnsbOuRePBQVlfRdlJsm07Y8v2mbct2j2O/3YO0+M91W
         fAY8AqC6yjSvJ8rUrkXCMMsWTVHdGE3gUCTMdW4M5MQ1NkSZaRZ3oPnbkRYK1scD5fpk
         jSXDckj0opFoK4QV088xAW2wiLTiTrpNnwIZXoV6o5+HTfHf2W7L7bY1C+Bpj2e4kypA
         syWWSNbMYvyvOMXk7vYO6/fyBJbm4agCqTHbtWiR/YdjXbH3WOwTtgz52yU+WdY8Z5xJ
         uKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708261317; x=1708866117;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iIYyy/W1tr/0bAEhThJxXh8k4ZWLMBlLPwt2pJ+jp6Y=;
        b=LoTUzzM/YIkeZgXn0xA6aSDRGq2h7ig9+etPkItrWHMaalZ6dhpKLL+BGIQkrfSL3L
         DiWSKeOzE0Lj7Pcg1+HQatNJO4GjtHTNaQ6nZ6RlWUivHt0kHz8bWAd2GvkIYKRyfHtC
         hyr2z8SCOU+0UJYLBMM5xgEVYDfjNMWLFcfY65MWxXzSJTh76YWfydrUwFPRqsQAUfxU
         H/9fYcVuWaQT92+tXhZrci+KpUPxjdXh3ZiFkkwePwC6sEKwGBqZyzLmPR/WvSNfOTaB
         GNdJ3aqenvwrG7P1DDgwS52bCJyXV++rI/O2+MbAjBvkMxUqwUpXONc1GKhU8+22DM1K
         njAw==
X-Forwarded-Encrypted: i=1; AJvYcCWow+Dh5rwQL1vUaWOAvBDVtjpnioyGk4Wyn0dWNKOdBAyvyhPaaqG3G2vGc7or9erXzljlEBa8zRxfb5bXc5ykQF7R4ycnp/rCkHo=
X-Gm-Message-State: AOJu0Ywr8OQFaKk+BNmQvduffRqBygddCSPyo3YJ5yt5d2t8Lz+WWlxA
	uyJsvO8KXYHa+F3jl6m/qZMGdk82W3+KBL2dVawKjUurQGdMulEKuX8NXfesSjY=
X-Google-Smtp-Source: AGHT+IFOVa6oJdPekL8bCPtPXjepHYdheq4ZXbm6St90f/I+EkgW0h8RafEA/oyz36xEGT9oV83dCg==
X-Received: by 2002:a17:902:bb81:b0:1d8:ca3a:9d2a with SMTP id m1-20020a170902bb8100b001d8ca3a9d2amr10414358pls.4.1708261317334;
        Sun, 18 Feb 2024 05:01:57 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d9a91af8a4sm2685725plb.28.2024.02.18.05.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 05:01:56 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Kees Cook <keescook@chromium.org>
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>, 
 Michal Kubecek <mkubecek@suse.cz>, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, nbd@other.debian.org, 
 linux-hardening@vger.kernel.org
In-Reply-To: <20240218042534.it.206-kees@kernel.org>
References: <20240218042534.it.206-kees@kernel.org>
Subject: Re: [PATCH v4] nbd: null check for nla_nest_start
Message-Id: <170826131614.3482432.1638173744340292313.b4-ty@kernel.dk>
Date: Sun, 18 Feb 2024 06:01:56 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sat, 17 Feb 2024 20:25:38 -0800, Kees Cook wrote:
> nla_nest_start() may fail and return NULL. Insert a check and set errno
> based on other call sites within the same source code.
> 
> 

Applied, thanks!

[1/1] nbd: null check for nla_nest_start
      commit: 31edf4bbe0ba27fd03ac7d87eb2ee3d2a231af6d

Best regards,
-- 
Jens Axboe



