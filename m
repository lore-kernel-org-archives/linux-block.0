Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3DD341062
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514544; cv=none; b=UUAqknFsxWelzFGbEZh7btj60xdeU3HVIBJtPeX1IK/TbKdab3HhEEjsvn8eYqi6wczhbp/F5ohiNsO0BBNJaBcqnGEaFN2D+sp/S/zDxq22nTlE1m5vIMVbE6As6U3kAUrfSi4DQslwOsgG8qTGSDRnGfLp7M9OdwVAfP9DbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514544; c=relaxed/simple;
	bh=SrwoEvhK/qDevRWILRDkfcVZX/1zzUR6RAuiJ2wMZ60=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=h7JWvxX65jqMggjZIvnR1ZsdsHyYuaMsULclMOJsl6zoFwmz5okImeBE/Oc62amT9YVxzEdlA9r7oBb6sSgAApxrwuMPVcK4H8ugGjljp7yM+FYT+hTxzMcECgGZV1aaHyeliAaPKuEUQEDsno9fNgxhS1pnMKcKGKYPwuqve2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=T8hlW/4c; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="T8hlW/4c"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-67997ce9e1cso611646eaf.2
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514542; x=1772119342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0a42HPsS2WRNnKKxk79oQNkIqa+mdBipBEupoa2oeM=;
        b=T8hlW/4c72cypm3aFKlpQ7l31th2BCWI1bmze9iBm2PC0oudU9OJLbz3HwStC72twf
         c03rJ9Ym58aI3uNRYDlIEBGvYbqX38TqnlN5+MzkVImUTqpZdh8EwvIIwcFqgs4ih4rg
         vfQ+bd4h+coMvvyDJIMHbsRyBYbGAAvG6c1LdCTLzpo2f0B1jyRP3RIW8HDqnUp/UOE5
         FQGzatS1rf205Ivu5D3yIVCFKfqh1cc++bEZntjrus5ZFkq6THx6mpqGtyRRZPxaFWpf
         uFf3PBJ+8gu0F1HbqGvaJKQZemwJ+cXoH9suLRbXKcKcPWVKU/Xo+JrEe70r83qvR0eX
         7hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514542; x=1772119342;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0a42HPsS2WRNnKKxk79oQNkIqa+mdBipBEupoa2oeM=;
        b=piSXMhumc4lRIWXuA94vHliktpAk7oGub4tZuPpebTlIvu2SvFN2fLF6YDlhyFi9yA
         /F7uur2uMhUCS7vSTH8RiT5dHKFcBJnsXsj1ca6aIlW/HFp0yhz7dj83HcNmFxLNa6aF
         NcksqAgHG/3X/3wgMfwd2RinnLwdvLU5NV+XiMexgk8OrtRKTp81W6pr1N0VM57kwplO
         SDvriz7cV8doA4pYUvsLWpqbx6mfKD2/jDuf69gc5OYVnH5VoyhFr2VB7PUKwd6+8vkX
         ms63hhFThOlTr8aDtgJKTACamhMv2eRArJx+uqPbj4XGH294GiDQ8jJ//hA/nD9J5CTN
         dPRA==
X-Forwarded-Encrypted: i=1; AJvYcCXYSO8rP4yhft4Cm0jOGLjx7wfHPJXCrjoReQatZCRXz5BWLgVeRL9ShC1J5aMa2Xt4w4EB4mYKCOau4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHCILdrqPlhG8+yJZOdokF82A19O0etdf+Qa+DurK5ecQy86e
	Yk1X12vfoxzP6quXcU6wk6ap22794KFRcP86eyz8srf8SGhVtQbyo35CsR6dOfJ04cY=
X-Gm-Gg: AZuq6aIMPS9MEZFxnrh05zvk504VclIm10SkpsLJJt918gZpjn3SVEohNdFLAKFRNCP
	lPBcqfnp6B9ZQ2JXipkJpckYAC/XNXSEpKdts8+vSzEmbPsjKToNz2ahLGQn6s+nGD/MDAo/xlV
	nnS1KQiBi9EKoeQ/nvAbECRxSipLwqtKkw98m+vIqQ/tNyDisc1rExn+6EHfZ+UyWW9S6h3RMSR
	kteC80cU0G+2oqP17rLhCdwcPRnHTwm5YJFUjSTe0ajG6Z5oNAnqvZC8N2JMxjZUjWwqto6DaCZ
	aN/GP2+laxn/8LU6rojIttfqk0nvzqC8a6PdZFhz/TpvexFkom6k8ctal+vajh6RVM6SyKEewpi
	P7qYvNZ+zgrKUGTpgwIzRJeVzXZCBrlmosMYpK7XsA2M9v+t608/N3kknF/sxA+UumDoxsljcwQ
	5qvAkzlXaU53gMiGNpAjiBM5cUISNWt7+Ta3L3TmcivEp0CoicDb4mODhyT4keWjkia9ujIUaWu
	BQ8hA==
X-Received: by 2002:a05:6820:612:b0:677:7c5f:e1c7 with SMTP id 006d021491bc7-67858fea339mr8563625eaf.15.1771514541947;
        Thu, 19 Feb 2026 07:22:21 -0800 (PST)
Received: from [127.0.0.1] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679aebf54f1sm1954014eaf.5.2026.02.19.07.22.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:22:21 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, 
 =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260112170412.741013-2-thorsten.blum@linux.dev>
References: <20260112170412.741013-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] drbd: Replace deprecated strcpy with strscpy
Message-Id: <177151454067.556009.8199495060801939828.b4-ty@kernel.dk>
Date: Thu, 19 Feb 2026 08:22:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Mon, 12 Jan 2026 18:04:12 +0100, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  No functional changes.
> 
> 

Applied, thanks!

[1/1] drbd: Replace deprecated strcpy with strscpy
      commit: 81b1f046ff8a5ad5da2c970cff354b61dfa1d6b1

Best regards,
-- 
Jens Axboe



