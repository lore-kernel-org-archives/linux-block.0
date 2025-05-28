Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3A28EA4A
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748456746; cv=none; b=uxBfFEzdOppHAAr74aUlmogv/8pn78jxcz7Zp0bVu60q67MuBkqO4wzViArYDV1ZDAE1ENpi9Uu9XD/7NdKWLRftzIpLIryNiy1WWu+tmxou3mKConmg7xxTefrMJAGDU3ud7TKDlquSlPHqQXtclyNK/2a2U+KT/toNLXrvQDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748456746; c=relaxed/simple;
	bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7TAzuNMU6hWbL9yW2WDhAwgHeCWPbKWgW/q3rs0v5mcoMITJMok7DIs8IYpmHwZdy57Sar+rArfQyORGVMqLA0zQv4qPIOslU5cBYAwH+rtiVm4hCgcZxl5fbcmrU+cY6joxWK7/lyokEgB/R0Yq8nz6afT29pzRtQg65SCEjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=bcdf9GzU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="bcdf9GzU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234949fd425so242845ad.2
        for <linux-block@vger.kernel.org>; Wed, 28 May 2025 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1748456743; x=1749061543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
        b=bcdf9GzUH/qkvrQSKiVwX3UGs1vEkrTQECdy0fa2oyHOgsyjRl9EharQdf1hrOxT5S
         aOgqVAhiFy38epz8gLWuFNKnZVI87uDMvm2Czhz4ACUQFWufFrAm7cNj4iMzmIstrJdR
         6SPaI1NtnmZ5amQbOuuBLlGr90UEvwq/Ox33pfIIwfce/Fa/0xkO7KIziJEhtVGxloz8
         sZDwmrFOgsPCuqm2GwgExxbVBxsf/lhbSYNJXoaAdlIhhETa4mvvzVv2CZCp95SE3KoU
         JrNM1aTQQpngAB/1d1KJdpyUyAeq7PyX/U8XqoPUhJwHvShnK5vz4AEn0LIcbBA8gBB2
         +9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748456743; x=1749061543;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcwcyGpDrfErPsyWm8xAfFlcYZSyGNfZutLD4QklKxk=;
        b=dSHaOTAXcdUOZRS7ak/DnF6n+51TIXq6evLg47EbgV10i0zovjGPossAcOvwCaeilU
         /vgH/bB0E2Rcl1yb7e314Bx8YVLESyThAHB/xcTQF04aXonYQs+uALiMRAw6B3Zagjzx
         n8WACJHlVC+TIT0jdxKbmCDga+XhegH43XylRMlG9C5j+tunBkwvX7TWy5JJgAXna76t
         c+bHxF5CLm4cxuPff8TW9l8mnnUZw8ExuOn4FblSfheGKqz9ZARnSQ8TNnqkVbnoz/PY
         +7++4o/uZARcXbiLaRGqlk94cJI4JzmWt1ElvbhvGgjJa/zjoGx0236a+uPLxHMFtRTm
         uE8w==
X-Forwarded-Encrypted: i=1; AJvYcCUI6eOw8rUebkeqKIab2xLOpFbpxcot1mc2P/sA4Bv6vSQfka+JOvavUF+CdidZ/at6hhi5B5aE+hI6jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAStRFzFwmNWxcJLrs7FNaH+GBHiHmZHSaJE0LLbZmDtGkRUNJ
	U7xeHHjog7Nbz1rk6doUMlXpZoJcfN3FJ7+WXQvz7bHoIfNYsxbJz3rg8fcBmMpK1Rsy+dqLWxU
	vApixrJtDyPzldnzFukwamvAMk24FPTOF0jaZXNAIIg==
X-Gm-Gg: ASbGncsFq6RSMJXJYJwmtXc5ps6vVWQlsNSG1IYSDugF5Pv9wCJaDyVBHu3/+4PNi8w
	1zdMZKMI+GsPjJsTdLWjzMHc3A3X5WXJ3Ul3n3e77KE+uJRuOwRv1Y8XCleHoZXmkhzcitm+HfP
	ZErVG7oO5ow8gizmjZs9cbgPRxjy6Q+rnK
X-Google-Smtp-Source: AGHT+IEqPgJEvwuKzLiSxyyIQ81so3lXBN15LCeb6qSM07Ix99PnGXOOlMeJsGGG1A/YckjG2+wZSDm+qfUtj+1ifm4=
X-Received: by 2002:a17:903:1b6d:b0:21b:b115:1dd9 with SMTP id
 d9443c01a7336-23414f53285mr102307925ad.5.1748456742958; Wed, 28 May 2025
 11:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250527-ublk_task_per_io-v7-0-cbdbaf283baa@purestorage.com> <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
In-Reply-To: <20250527-ublk_task_per_io-v7-8-cbdbaf283baa@purestorage.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 28 May 2025 11:25:31 -0700
X-Gm-Features: AX0GCFtwLbawvnl7mK2nPLXhDZ3ch13VYeZVtizo1aZXU9QSxG4dusWwjli_jhE
Message-ID: <CADUfDZpjFv9Vo1H2rzeCyYo2nsnP_k1prkTCQqTtpk1YjL==zg@mail.gmail.com>
Subject: Re: [PATCH v7 8/8] Documentation: ublk: document UBLK_F_PER_IO_DAEMON
To: Uday Shankar <ushankar@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 4:01=E2=80=AFPM Uday Shankar <ushankar@purestorage.=
com> wrote:
>
> Explain the restrictions imposed on ublk servers in two cases:
> 1. When UBLK_F_PER_IO_DAEMON is set (current ublk_drv)
> 2. When UBLK_F_PER_IO_DAEMON is not set (legacy)
>
> Remove most references to per-queue daemons, as the new
> UBLK_F_PER_IO_DAEMON feature renders that concept obsolete.
>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
