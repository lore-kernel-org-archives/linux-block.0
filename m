Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E12309B4
	for <linux-block@vger.kernel.org>; Fri, 22 Nov 2024 05:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732251863; cv=none; b=ckBmDBnj36cS+GHNalLk2XfpOGkevRIKbwmEn1DcKZ0AWSOuLSyCl7BwZzaJALP0+fbD2b6I8RdeXt1tQebfeVQGzPrXufAfxOcRrxe4LvmxPHc3DGgdGbhnZOFIvqCqJYFaKZBuManuBjRMdsdkoi77E6ZsrCirNw69Njvf0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732251863; c=relaxed/simple;
	bh=A/lHaHfafAQy7OfTvmDU5OKRmJrBpX9Zmsb83aoIxoE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qEUR80QLB2gfkVxxDSfjJPWTLTt1uqfDqv2czSbqN/ewM7tfJPHhhP72pbPFcAG53GnijKlGz0QMzjxR7x3D3EjBziuUkkD+eIsTIP7iVv2FBVz97BMHEsVV5j2zKR5HZ/fH1cWYh9rxrjxY/uy3e1fMot4qC4+aWCTcTCRDfrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zFdAxetf; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFdAxetf"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e6010a3bbfso983075b6e.2
        for <linux-block@vger.kernel.org>; Thu, 21 Nov 2024 21:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732251860; x=1732856660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIzDwcozFWCn4iWIZHsgYfF1wjH7Z9fC00bR+vHVLs8=;
        b=zFdAxetfqdy6vjgAlPnY8dcPszsTDct+6mOTzaz8OaYYhujrNWdIyDm6DWDXklwxD9
         htk6uVhmakXRcC2Fjd+gf0VKabBgujYbdZJXpGtUEjMEEtaaIRE7vqvmJ5hR+wAFI5U8
         L5I8GNSP3CIuT9SyFp6pG9PwV5p5HISLTOyaBErkch3CTIh7aqGsWYvgFPU1j1pqziiy
         uKEPXqCROjEj5IyAkIC6yldMzfaMXQ/1Z9Xuj1AZ+dwr52LyscyQch1pg5tlhHkcQpqf
         NnNm4QFDdYbsyt0pDXl38nk7FdXVag61wo0cD2DJ/VZhdCGE8Q2jpBj3wJrxcG0OJ0Lw
         5wMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732251860; x=1732856660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kIzDwcozFWCn4iWIZHsgYfF1wjH7Z9fC00bR+vHVLs8=;
        b=baQjHb44EBX/Su0nZqvqOULikmK2JLOEgDiwxQR5xb0tjL4Ccz7zExWS64WnuAuKAa
         hz9KTzhs0mzHBnWau1I5gBhjb5gyv7AZRyC4jujILwhJ4O/S/mhc8KQPqWQbcSD5rQkD
         3O6cVdkUThbiNf9mfO0WiYO9ZoVCw7GJwozXSvgQtbSjGYugtgszZ2a1HmePfjq+mx7B
         yyNd87XD8c5zq2URNlfi9X8hwP2xdr99i5aEDcKdSaYqoC+16pqenviOg747dg3oaPVT
         8bS/4bp3CUgGjc0cg7tpAXcrKRV/KGYH7g+fhOSqLVeefQejn2txOVEFMg3CSC9X0LTO
         KKsw==
X-Forwarded-Encrypted: i=1; AJvYcCWbTqsDjEj9vYw5gbuOjPuzkBTbZ8um23qe7l1B7Il9ZhcsxbmcY/gUqk1D+1v5XxupwqUu9on92WYmcA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWdHJpsWVc2U09PbfvoE5WrO/lvK3cWzvN1dowIPORHVPoIQx
	HFP9fOH+e8opbP9NwVoSVj1nls/JZ/HTfifbJMXgvL4+HUJ8gmI8OE6KdZNPuJc=
X-Gm-Gg: ASbGncvycIeE52XTs+eQSzwx8F7aC5O++NiKYeh+u9Ta8e17PO2ZgX31AHVPCryutS/
	pIYDja69/AtBnwdpKL+xxxfbwlKG0DFBPqiVySnwLdLvZaYsVPkL09Xf2GNKBWa76JIbxGHuS2/
	Zk0oyGNI1uRn+Fs4Y8GkgGCfrtqreRvidE/Lj4Q0oj8UhZb7sYM6H5WHTCNB9Y8X3GGBDGJ9kQB
	76mnuCh+zFjvTAes+LamX/ekx0/samf2CxSRd/PsJvDHmYe1E/itqY=
X-Google-Smtp-Source: AGHT+IGL6MagCY83L4jKNjJ+b2nvEUCxXAYn80qUw2BRxv2rEU4IPc31obmxQrilm0WF+k6fB1jevg==
X-Received: by 2002:a05:6808:1b0e:b0:3e7:9f14:26cd with SMTP id 5614622812f47-3e9157a3724mr2224346b6e.8.1732251860540;
        Thu, 21 Nov 2024 21:04:20 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71c0383ba69sm280935a34.61.2024.11.21.21.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 21:04:20 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: hch@lst.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] block: remove the ioprio field from struct request
Date: Thu, 21 Nov 2024 23:04:19 -0600
Message-Id: <20241122050419.21973-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241112170050.1612998-3-hch@lst.de>
References: <20241112170050.1612998-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Christoph,

This patch causes a regression on E850-96 board. Specifically, there are
two noticeable time lags when booting Debian rootfs:

  1. When systemd reports this stage:

         "Reached target getty.target - Login Prompts."

     it hangs for 5 seconds or so, before going further.

  2. When I'm logging in, the system hangs for 60 seconds or so before
     the shell prompt appears.

It only seems to reproduce the first time (during the boot). My attempt to
re-start the mentioned systemd target or run "login" command again worked
fine.

Reverting commit 6975c1a486a4 ("block: remove the ioprio field from
struct request") fixes the issue for me. Do you have any ideas by chance
what might be the reason? Or maybe you have any pointers on debugging it?

Thanks!
