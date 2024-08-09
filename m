Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058D62F37
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209389; cv=none; b=UBAHE1SMo3LcmfWpAj/95u34rewZYuJjXwBdQoFo2KrNLFX5TSxA4BKqHj9Irv6dSIGreeblRsng5F6fHlB6Fyx5y6GJcfCTOdkWyIsW1p3pP5P0CKFeNyvN731apRx8rktlOZtHzVSe5UfQinAt3NnmvuFPKrmS36K6ctrpGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209389; c=relaxed/simple;
	bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Knzw3isNKkdeYSzCsWVkRCVglMvYIZqQQPtsp0XND/dYV8yQkGFfASTwdn+FHq9PRCrhY4Fm0/AOsfSxdD7W8Ac/m2OSodIlRwfqtG9pt5JoIm/uvABG3aJuro++sOUHEabBhQnsihwbNikoZxeFgooBUtMzcce6jWkR2xvKrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij8QSxps; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij8QSxps"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso14845205e9.1
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723209386; x=1723814186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
        b=ij8QSxpsg2UMcdzOEQX4CYZL1OeZI4vWBGBX5QHtR3glQk7bQDkbcfZhjuXimJCudH
         HS5Qro1ADMVr/yIVw9KUDRSoYTGNYoBN/PN8EGYzuOGYGcBWeAJxMKCrbw2g7Ol6YTXy
         ZrckBN1y/ao7E8gjfUxDlFipKqZBIM1IEoxzy/a2Zrp/wgmYa8fjd0Y1oMml3OXg77OM
         5GlzIJ/Gh4dAwfe5hrPUNoMgeCzDM63gLQ5D+qwvtPS3WksSw643bob6/XSPO7QC07GH
         J2CgivjRtgZslYmjhwokSkBfNPFGpotCtDXHVk2g7PVASHrSVPCFVjuyuL9eREjEPrQO
         5Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209386; x=1723814186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
        b=eN7gCMJX8eALHObU3RH8jrJKEuqIrrbp8bz0Iac+GNMs385a5yJdFpnPluI+d+2QDS
         +wuztN3SKx7LbCLnxptQxV7NdBlzhkqogPp6Dxfhibz9GcIAPJmZFJAmJUQ/+VoUrBMu
         +3e0hlTl2iM5q9W42pQSSYyZsDqkUZvDKI3PAybmh1QxKi/ubOu3gNpyXWcry2yVUwEU
         KJk7oeSnyrLuQLwiRw+AFHmjK4RlaU951Cc0MoycIXppjN/Qh+qckun1TJP5HeJ6qO4D
         laY9qJhA+b3RdPNYcwpTKrk+sw9bjPmPKv7xNnTOgnWZPfWyu/Aj4ojW1Cw/mVHcq8iS
         6Saw==
X-Forwarded-Encrypted: i=1; AJvYcCXfOavakVjcQm8zOt96bfb6ecJgsrgQ0ZgcT5rNh+uliw7p5JVBAwLAuXxhKy1TVFqctSZtKxYWYhaVbg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4e6aS4wuCokmo9drnnoR80mth0JYqxPG2Bcor22Uwen0XzsAm
	YU4DASNwsbhG987zw1h/WsKMlibeBVGi8FAvJOKFYKCOZu+HrfBMJbbEHG2Lx2yBSlsjvhX/Sk3
	G944CemTElSU0iZkeTUVOsxAGpkBTBDszXRIF
X-Google-Smtp-Source: AGHT+IEencuwb5ZiZqBxrl2yiXarWFIGCnvBaoEIUj3k90VcnrheSq2WUA4koqg2hebfaLRX95IYrP+jEef8wEWRJhg=
X-Received: by 2002:adf:f545:0:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-36d5ea00d30mr1177252f8f.28.1723209386152; Fri, 09 Aug 2024
 06:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
In-Reply-To: <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:16:13 +0200
Message-ID: <CAH5fLgiqQ6GxPk4-JCdRnKmi9ECgzVj+MkoUnZLYtUp8-yCebQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Jens Axboe <axboe@kernel.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:07=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/9/24 12:42 AM, Alice Ryhl wrote:
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
>
> This commit message lacks an explanation for why the change is
> being done. Yes it states that it brings the headers in ascii
> sort order, but WHY?

I can add the following to the commit message:

The headers in this file are sorted alphabetically, which makes it
easy to quickly resolve conflicts by selecting all of the headers and
invoking :'<,'>sort to sort them. To keep this technique to resolve
conflicts working, also apply sorting to symbols that are not letters.

Alice
