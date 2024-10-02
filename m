Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993A1CFEDA
	for <linux-block@vger.kernel.org>; Wed,  2 Oct 2024 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875052; cv=none; b=Kb7UQRMruxG9ucD0ZhM+4qj+h6IskyBI2EeWYIT6E4SucoedoMk2MffPZ0FkTgI/GzV5vz0hk1OI1yVSWbSaJVb2dYd8+tQoPSRJ8ilyRfBWqlR+mzpDrFkUpPU7eVMCOKLlJR/FPPGBe7TbWJ75YGs3mFwkZ/0UsLUwOcrm6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875052; c=relaxed/simple;
	bh=2A+8b1pr0Z3hF2MWtBAakd+me1LkLLnlQ/jk00xjDvc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N2Bg0K++Z2guy0D5nSR+k/SD1xp+BG0piyXfmdlPMeq3skMOfJFVrnGNDHfsx57WHfe6fijTjP3Qtg/8lnCkx0+vcRQB1HWbyMw2plD6Ksq9xazT3WBEq06XHVi6r5bcneDJOFX1oNUpLat9gfNvnKHpYKNiULMc7Usr4JElWPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QXSMoyuY; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QXSMoyuY"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a34ccc6a9aso14682535ab.1
        for <linux-block@vger.kernel.org>; Wed, 02 Oct 2024 06:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727875050; x=1728479850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLHqmD5F960+PFVlj2adteaxIzC89WdoauZaGlnWSKU=;
        b=QXSMoyuYwAeuYYZBA9EBmq71R4S+zZDF7iYYcMv5Fq2CQymDbMsHvqmX+4bSPqFdeP
         hmwLUrJXDs2laxClA6lJ++TEmKITEXYAF3T5F7DvsYO2nz+YK63fN+fL6wsjhgLRYnDp
         RzZT3Ch/IjxEzPoz0BmTcOsaMOk2AWVrsqhS6Fv7jUNKHn8f9/S/if2QOUZpOzaH+qQW
         QZPzj6aw7RbNUJ/WkKVX008yVx0Yjmh9Z+RAhYWaJoA/9BsCoW8nCZ5Cg+gue2iMZjjj
         JbUy5uAuZw6uddAiVcY+Xc8jVlNbjiTunTONzh6UxdD2s8MxWI8Nwh2l6tD6GvOetF0S
         EBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875050; x=1728479850;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLHqmD5F960+PFVlj2adteaxIzC89WdoauZaGlnWSKU=;
        b=HJRC8JwCltzqeDETz8G/dSHCSgoTuj2yVtQXhfBRvgPU9FFCsqMq/v6aJbJWxk/hN5
         CmVKZwvQWCaZUxDYrDu1D2c/RVfGF1eGcSMA3XX46KgMO7acqzx55nLjMt8BChs7ZeVc
         4qru+zw0MtDQVMuaHiqnuMyUpbLJhYYjO0HHXVpHv3gKcucPayu6kdrqQ3hsdjAIS8ou
         4dYvA7lkaSrgNl4Frs1cVjUwllTNTNOE3rDj9Qxxe5oYtd7yPblyx+/sNzoxMUoUWMmG
         KjlLRPJbBxQk9drkD5Bl27gEHGxCT1e3k9d/V0urM8cznLlSOe5bmG4WToYgj8HsdhJC
         DUxw==
X-Forwarded-Encrypted: i=1; AJvYcCWTXRPWHU2SolVLLh6ABTd13rz25qcVQwwtBp3eb6jOnB02IADxv02SwoMPThh3f/n0JNj/J2ks0AS83A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4Hw7R65Xaw8SGqxdn+/42+7k3lxoWoMO89yKVLxGMU+sC4vN9
	3wgE2yEcL2NP6/kwORTsyGp35O7WyUDd9NF9WITlV/cT300DLW9JWyPDecsrSI/V6cCRU4ufpZW
	goAg=
X-Google-Smtp-Source: AGHT+IHIht0I/8GJalCXOyPKOfttdnOyJtYt5xKO9zFwIYtuSDHUVoTtPl7Mvzx/BNOqNOKHveJAuw==
X-Received: by 2002:a05:6e02:1a89:b0:3a0:4c4e:2e53 with SMTP id e9e14a558f8ab-3a365915437mr25754565ab.5.1727875050072;
        Wed, 02 Oct 2024 06:17:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a3678e3ea3sm3490625ab.87.2024.10.02.06.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:17:28 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Justin Sanders <justin@coraid.com>, 
 Chun-Yi Lee <joeyli.kernel@gmail.com>
Cc: Pavel Emelianov <xemul@openvz.org>, Kirill Korotaev <dev@openvz.org>, 
 "David S . Miller" <davem@davemloft.net>, Nicolai Stange <nstange@suse.com>, 
 Greg KH <gregkh@linuxfoundation.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>
In-Reply-To: <20241002035458.24401-1-jlee@suse.com>
References: <20241002035458.24401-1-jlee@suse.com>
Subject: Re: [PATCH v3] aoe: fix the potential use-after-free problem in
 more places
Message-Id: <172787504822.64996.12000204584360248821.b4-ty@kernel.dk>
Date: Wed, 02 Oct 2024 07:17:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Wed, 02 Oct 2024 11:54:58 +0800, Chun-Yi Lee wrote:
> For fixing CVE-2023-6270, f98364e92662 ("aoe: fix the potential
> use-after-free problem in aoecmd_cfg_pkts") makes tx() calling dev_put()
> instead of doing in aoecmd_cfg_pkts(). It avoids that the tx() runs
> into use-after-free.
> 
> Then Nicolai Stange found more places in aoe have potential use-after-free
> problem with tx(). e.g. revalidate(), aoecmd_ata_rw(), resend(), probe()
> and aoecmd_cfg_rsp(). Those functions also use aoenet_xmit() to push
> packet to tx queue. So they should also use dev_hold() to increase the
> refcnt of skb->dev.
> 
> [...]

Applied, thanks!

[1/1] aoe: fix the potential use-after-free problem in more places
      commit: 6d6e54fc71ad1ab0a87047fd9c211e75d86084a3

Best regards,
-- 
Jens Axboe



