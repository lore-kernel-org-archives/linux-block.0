Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EE298990
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 15:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747927406; cv=none; b=Kj7aRrHcz/pU+ylzEfZArHid7qvT2Fs1+8Ae9C/+T45dcUbKVgQNoE6Zxu79asLAqpoXmdYdUpKPMY7tZjU9z5mcC0kfZT17/5Cl0FA+20RHH4yKSEyfOjtSf4vyrZNUySbPT93dyeaAa/stsJCKY/GCTLicF4Tcm1PuK3gKOQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747927406; c=relaxed/simple;
	bh=pooPKGmFgT32vstUAPeBuZumUMpHcBloRuJ9TM6Yvio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s0EYIH+JV3IEskA4ctiRec2bCGtVoOy+Oly8GeQgEpiK/K5PITHUzl6hD3qkuB48mQp0s1lEBqibMUlqyog571bhXRvOANh47+5rShY5sC8ul0j5yvYTYPJROLS2JvH/4SrXo6JfF3z3FOM8cDbX1yH/quoGHfkA8M5FoCZLPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DGEidXuC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DGEidXuC"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-af907e48e00so698071a12.1
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 08:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1747927404; x=1748532204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pooPKGmFgT32vstUAPeBuZumUMpHcBloRuJ9TM6Yvio=;
        b=DGEidXuC1n7Ax8zm7raLQeBN7z+eOet4q4zy2H5v82vDlJY0KFTc8P/UpuFpmbUy6k
         pqz348HbpW7Ff2eb889lJg3H76hPAaIpknHHf+xT0h1guHHSCMnbMFJA/RRpFzM/V6dK
         /9eWbYjSslaAmL06RZ9Kq4sITM0nL84fhjPZ/u+iD2W4SvNYWWpXUrMUA+NFjh+/A6vc
         VwpRQu1PoPjYQEMXKwJi1xTtOb+k3YudKURNSQtHdLwdP7uQr/oZMU9fQHzF+cEIB0Et
         CWTsrQG0AJrJReblelakJkTbYyOzTN4It4xJbf/qS7V2469OMj4Qm/PGFkU6ls/AF+oF
         Bdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747927404; x=1748532204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pooPKGmFgT32vstUAPeBuZumUMpHcBloRuJ9TM6Yvio=;
        b=ZUqPFQhJWumwQzK5XwePu4pAAhsp7nsWpyQOI3e2psfsaATPk7ZgOP0HyD9v0weuog
         BiJycanmB/majHPl9jRy4q3ZFiBUczYgbKDGUAN8PvGa5hNRuLLdNVrrFo/fb57Obi86
         GWkC8uxcFO0GvIoYZ3tRpRZcjdRmPr4ZFR8Anxag3wCSdHNLIK/0F1gc5EqnjNTa3I9I
         8MrWheTGeMwrDOb0db4lv8HUMWGDgEFKG21mMyo25UMzkYNPHgnGf7Psb1l6XiBuYx/u
         nlBYn2k0xaOmnA+DWaM1mY5AhX+XXGeWAjxQjCaCEVHNdDFYtG+Ma8JSk27BdZWi35aW
         Bd1w==
X-Forwarded-Encrypted: i=1; AJvYcCUdRtr/Vke1Ai/5i1j3+G9zj6Vqa0XU8v6VP+Tz/us7lElANgsAtApPK5HUz+5wSueMs4Yy2Ghp8lHmQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNPMAY0Y5rsTxwedtvDkG/Kz6TbD6o4+a13evyQnSdIo1OxIW0
	PCdP5oX0Bfq53d/o21QgXNf+3juRTBLcPC2CgLTFCEU9M1zZG4CFkWjlD5GwDhs5oGjdo2LHljM
	A7jjtgtXHEU2UFhYrYobBtQ/sxbpBTS3kyu+wMgzW9w==
X-Gm-Gg: ASbGncuSo2MaPZtrKnW60fUJ5oLGFA6dKtgnEttua1E5zUdZHgXovsCrprLQrLZCmld
	C/WB69QMoxVe//w9EzShSYEmumzCxqV4Pd5B2MB6VeVr7Iau7dBDT3B7ZPyaXV/uR0JpYKAb5MO
	0ZU1rm3UQK4oWF9Pb+NQJl3Scfe/cXZoo=
X-Google-Smtp-Source: AGHT+IFyJDkLhc3vcy/BkkkKyj7LUOHhUvPrXG04fQZCkfixg46SzBPmIn4NlKtgD3+PCK3EqhEl42Pkl86ab43KLZM=
X-Received: by 2002:a17:902:ce01:b0:215:b75f:a1d8 with SMTP id
 d9443c01a7336-231d43881e2mr141147795ad.2.1747927403816; Thu, 22 May 2025
 08:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522152043.399824-1-ming.lei@redhat.com> <20250522152043.399824-2-ming.lei@redhat.com>
In-Reply-To: <20250522152043.399824-2-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Thu, 22 May 2025 08:23:11 -0700
X-Gm-Features: AX0GCFuTunneohC4OzPu3tT8GL3OuC9BtrUxGwfw2AHvQyRpNkqkF3TPhlR9PS8
Message-ID: <CADUfDZof9s1sOJjNRvaAi4xJaq0LNui0NST526+XQV6pcvz9uA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] io_uring: add helper io_uring_cmd_ctx_handle()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, io-uring@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 8:20=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> Add helper io_uring_cmd_ctx_handle() for driver to track per-context
> resource, such as registered kernel io buffer.
>
> Suggested-by: Caleb Sander Mateos <csander@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
