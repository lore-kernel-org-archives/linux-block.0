Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9260279;
	Tue, 23 Apr 2024 10:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867120; cv=none; b=Ec3aC8iTV9T1xvObNDeeQ6TeeNOyAr+gbkljkMuvhAk95F3fXlIBkel5PddJoKVTuUug27ATpp+1pSrdLvp1bbZ1v9qOig4m0iXdMFM55kHuIVUfi4Rc0QTyTdpG4wyeSLedHpaj0BHyBr6aktu4PY7YjUF+Ez/8ctbAXXOmvW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867120; c=relaxed/simple;
	bh=gDL7V69ZeRY9y0YFThGTy9iNsHoA/ekO7Qk3cuXFOXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPAhIbUhTtwAv1pEWLp5NSr0PsNd5Gj5io6ijv0vxVNGbldEAkhIYGKsSA61U9tcPLFVNrAhhxJ4dRsCtApdxIRMJqMTfMR+3yUU2YxXLrOz/2D/dHEK3P2UxmD6F7Uh4Hu7pn8RhxJ9gwBW8Xm9sfrNxgfpGsYxSOfn89Yh9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZjrstKTP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZjrstKTP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57215beb016so1216334a12.2;
        Tue, 23 Apr 2024 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713867117; x=1714471917; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gDL7V69ZeRY9y0YFThGTy9iNsHoA/ekO7Qk3cuXFOXk=;
        b=ZjrstKTP7qfqQJuAbfCMqtd54EedOLbfy9/DsBQUKXagd2qkPyXE/zsR3ygY1npRKE
         5XVoKo80qHdg2BsA13aKS0WTzv9bcaBrNMFJv0EMTF3YCL4QQ+9YZ6VEJyLETrWohS/C
         NyTPoxXf6YRfw8cyEULyc/lZSaNILunB6444sd5aleljAyesFMhN67VsUNT9LrzXSAcl
         wbGzUmOnXSt1UgK+SSFz2ugS+DANf56DGO/deZJa9tb8k5+H7hPKVt9eZCJycBMeb8Be
         FYRb+VIPFQv1fB2H++s7qEwCHBzgDxK1kWYpPnYqVuOESKKJsR/QdD+35GQ0/X87dQ1u
         4swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713867117; x=1714471917;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDL7V69ZeRY9y0YFThGTy9iNsHoA/ekO7Qk3cuXFOXk=;
        b=bGGJblx3IjzloIEYHgImM3SrY6bvIiUOsBqQpeD0cwtibOgUb+1IOn0OG9xqqT0Azy
         t5nFAnLwaWdC3opsRYFYLT/SpU8OcPJE7+4xh/IotfJkXGruPwtXx3J2+dTpT+QaFDxI
         rfAzmj86O8BllR1ouNx3NYj2GhhocHDOwZ9UMOY/ryTzVQfewr/tpC/3IDrEb8vaBHl/
         nKmR0QJ3RgM8LGWyYtmZETNAtFGtNwmnV2Bx48cVDnKYN1Xe3lRdPfl7ktg6my1tCcvz
         gk7WHZcVmtP5yFGspk4r3nf5QNJ7A7EEf5eDxn2GTbFRzAtPNyuUIBnfP8ZbWYjIDs3T
         /dtg==
X-Forwarded-Encrypted: i=1; AJvYcCVLJBN5qapbGVyGUmae8Qz1EaSuMQ6ZICEpnN1R7Ayt5FOvOCV/a2FOSwWUWYIu5XZEbM/cozaSvN3mscSPUvtIirFNHQKjXgebkmc=
X-Gm-Message-State: AOJu0YyiA3VMtWDtg+KlKvAjfmR9ri6kUm+BmQA2TQ5RHnNqx5L/8KPJ
	+W76hw2JfzpWNFrQEvkFU6GOcstBPQK6lRFugzUeUsaWbRcHEnoQ0PyIFCDivAdTXBs4LSPFUxZ
	IPflteymylkaMQ7k3I4A02I8s5is=
X-Google-Smtp-Source: AGHT+IGr1hJliux1Bq6a81ZnlVCsosk+UoWybd1/iphLyHSx1HBsmi6LhqV1yI2l+Kfgc66h9l/sgWGQ5I9KJsE4VYI=
X-Received: by 2002:a50:9f6d:0:b0:56d:c5c2:f7f8 with SMTP id
 b100-20020a509f6d000000b0056dc5c2f7f8mr7925369edf.5.1713867116533; Tue, 23
 Apr 2024 03:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422153607.963672-1-saproj@gmail.com> <CACRpkdYoLjXHwN2EKsxZz8FdxNQ8beuqSO6EX9CjZmE0nX3tUw@mail.gmail.com>
In-Reply-To: <CACRpkdYoLjXHwN2EKsxZz8FdxNQ8beuqSO6EX9CjZmE0nX3tUw@mail.gmail.com>
From: Sergei Antonov <saproj@gmail.com>
Date: Tue, 23 Apr 2024 13:11:45 +0300
Message-ID: <CABikg9xAo1Fa1nLE3G=d3t_b6Sr6OvY21WFnk6ew-+UKV1WwOA@mail.gmail.com>
Subject: Re: [PATCH] mmc: moxart: fix handling of sgm->consumed, otherwise
 WARN_ON triggers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Apr 2024 at 20:56, Linus Walleij <linus.walleij@linaro.org> wrote:

> Oh it was that simple.
>
> Thanks for fixing this Sergei!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

To fix this WARN_ON was indeed simple. But the "BUG: scheduling while
atomic" problem I reported in the other thread is a separate problem.
So I'll respond there.
