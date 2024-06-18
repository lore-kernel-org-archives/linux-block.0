Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102A13AD06;
	Tue, 18 Jun 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696469; cv=none; b=u62b24S/6sV8/Iy77qpgwV6wKo9lAj9/3fPkKItksgzqw3WcG2223tWQx54lQo+NalzV4FJR1EGtYo/bUo4XshPaAMxpCfiyFndv9ObuQTUaVfpnNsZkj1mP9jdOMHrUnlXQWnzn8PYUmCFoBdUoft3G8Kcz1Yv2zomZxaqGUkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696469; c=relaxed/simple;
	bh=OCSlR/hykcXlUKjuNJYIPJIeyL0Bsq4BQyFHe86L/ow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiWYD0g9PAUGWWN7EYHQI5X09QU0zVHu1+oyIomRp9DqxFUmo9ZFMfLwZePmA9TBLRl5uF24QSa1NOi3wciX7aipPxAu/ttGAfc6UY6ikcFcmRk4BE0xaQyDKk/eDL84hGYPhfQsF7Kw5cHsyt6rE+GFOUvh+MFpmr8QwdFdM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-632597a42b5so37321397b3.3;
        Tue, 18 Jun 2024 00:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696466; x=1719301266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16cLoECCQqMHG0+pPhZp0c/TkjoD0Q89/c6KNA0JOkI=;
        b=lvQ1NR+Zlir4c9zRq4NdR6GZtzmyOvBZBOl6V8Zl3XN1221QNosHIdtJQjsY4lpGv0
         aT/lFbQbms8gYCiO+bII5b0snHTMHogrPWBKzcnl9KRWcgbEGaO/vQ4G4TxnV1nEDjX8
         H0icDfaHpa4zIi8Gn8PvBDWYqEILkta6o5+H9pognzLow4esmskYVkKiHpmEdKm8qGhu
         T4oQCa8WMYgkwtbs/k49Awx/c9fFBG49qRlpOpzKUCXSkKOR+tW4Bc70PCuXXhAJkhl/
         gy7M79EUauB6Gg/FgVJ/QPjkqE6oWc54xk72BgMZEp/VKAglILoAuMSWl+54eOqYJYZU
         zoFw==
X-Forwarded-Encrypted: i=1; AJvYcCW3yFiScYe44hNiVSrUCELSV3jxvJILtX+Cw3avJ1PyAp7BVleEEujSXyJ7aN1pTA/5sdsBCNH0VO3igH/fzfm8mnUlA6KRG2x4MsFM0cZtBA9tFpXYoZphAjgowc9CqTX3FnTjeabd1HPExz8PjQ0O3vV1o4UtoVGvpeVHED1uSTEy5gAEePLaXL4=
X-Gm-Message-State: AOJu0Yytd6eF51u+YjxbAUfeJjv9/vHuRvrhuBvH/gFSd2nySHOSlOgE
	nYUKRs717jDo8VC2QE3Fcpz4LDlH/gdRKq1JJWw9+rhDHKx3KTltiCdSC0Fo
X-Google-Smtp-Source: AGHT+IFOUK6nW6W6yCWUZ5ZwuP1WUBHoacUI8zSype4GniGjuKeQmogFAhD++i+4SQLwjYq9tuGrDA==
X-Received: by 2002:a0d:e882:0:b0:632:c797:c7a3 with SMTP id 00721157ae682-632c797c8admr103471977b3.17.1718696466265;
        Tue, 18 Jun 2024 00:41:06 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63118e9d2e1sm17237137b3.71.2024.06.18.00.41.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:41:06 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-63186c222eeso47142267b3.2;
        Tue, 18 Jun 2024 00:41:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjtUGd/Oi5f0RHplx8D+9DiQsunAiugsp+nVLOov4xy6fQL39Bjcbj77OyaDY5oQdun/mGTBZHl62WApAAs3B/6S65OdWH/9xTZCzBvjyRt08SI+nlU7nzWrlGKzFunxwF4WewNuT0Zlw5FI5f/L2opu7gJdk3X+87xMr9JexKdf0rf9ZVLoydHew=
X-Received: by 2002:a81:89c2:0:b0:62a:259f:74d1 with SMTP id
 00721157ae682-634ce7a21ebmr49442277b3.5.1718696465525; Tue, 18 Jun 2024
 00:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-drivers-block-v1-0-b200599a315e@quicinc.com> <20240617-md-m68k-drivers-block-v1-2-b200599a315e@quicinc.com>
In-Reply-To: <20240617-md-m68k-drivers-block-v1-2-b200599a315e@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:40:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUrbM2nCJ7+hm8stsSBhRLMszyNKsiv1h2Z2CRJtzhcMg@mail.gmail.com>
Message-ID: <CAMuHMdUrbM2nCJ7+hm8stsSBhRLMszyNKsiv1h2Z2CRJtzhcMg@mail.gmail.com>
Subject: Re: [PATCH 2/3] ataflop: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:14=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/block/ataflop.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
