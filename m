Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74F92139A8;
	Fri, 28 Jun 2024 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719571734; cv=none; b=BPtQX0EGi+sk+atKlW7tJo/4QWIzrRannc6KUspjSrjMjwVF8sIIRpoO0o9NimN/rt9TGG/gdx2F/+MO17NUMidT/YAP2HaYBETR7Ndnj54guzWBuXjv22Imc6mtlmAIyWCshrPFKGTTL2lUlp6HU1qESlMt9SJnV8KgfqCac4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719571734; c=relaxed/simple;
	bh=Op2EZDW7bEpEd1g89RuuVLQ70Z2yr1cScl8+vTX5zaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=We+FvKzb1IwKTdSg1erpnup5DI72jGBOuPf5T8+WegY5w0OEUPxu6A8RsNEcO2wDdFYvGKND4oAbzUpN2LrJ5+KXUKFXTkKcrtd1Km5TAJJqpnphX18G6VkO0eRzBgX77ybzQ+5Q36jOpVI+iZO0fUd5b8TPpMb0rJpK0BwXxz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgsZ7Fj9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgsZ7Fj9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2c92d00059eso240200a91.3;
        Fri, 28 Jun 2024 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719571732; x=1720176532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Op2EZDW7bEpEd1g89RuuVLQ70Z2yr1cScl8+vTX5zaA=;
        b=ZgsZ7Fj9gYsfDzwWkJb/SBPKLP+USvaQUx1xqVOBa+OosiQxmBylVn62WfQua761OY
         lwMAixVKCY+h+I3puc8KsAD5/n+VLBBDFWnCd71Ynxl+QV35vw1NS1k1DhDi5pOn+tBk
         3c+lI3pkwBp6QWIzb05Y1zr4nZ3nml4Bs9FjtSqWMOLVeSrrOq6eDh6gk66TmnhMkMIA
         J8rSw9Q5JA6/yBI8QMCm2KJVmkTLP15h88sLVa5u2OW3wkgehUVK5dC63PUxgHMea5DN
         HEOns0LiMt/soFi9Hgrzlz7PwK01xYusbvkHFDpHlzFVFG2A0ds0jyHAnaL+qafWO/38
         haGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719571732; x=1720176532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Op2EZDW7bEpEd1g89RuuVLQ70Z2yr1cScl8+vTX5zaA=;
        b=VYDBhtBQ7w9vf+ytV2nsi9044JvL6HhbnqeAPs9qwQJDEeEIWX7kPhXVLsLjtMsCxu
         Uk8t+FOhFDx1fD9T5ibrbS75ZUO4Jq7+3XFcKs8gyCSNsVUS9zg2bLS+b5sY+mXLQDoH
         aNjBFJGP80CIFx+MOsMHylaMGdLS1J6Wn3YJra7QTEJNfAv9tomXN4PVM9QuY/U/rWyw
         vFa5hfUkDxoxG26AKQoNHVvd9xJO1GwwlOVD9l/Qz+jFryQaEf2xx/SltYCx0rdFHWIU
         dRDJUOiljWUAByCcTELS7TF4rz7Xu5lYC50SX5RgigKM1FNjzPgoXClexDMQvueTWLe7
         bOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXcaDrlE5GWwybdp2igFgGY7VPwHHLScBctFVtzxsdJG31sv5cAOojeyxvLAy3Axs4jOo5oxrzvVQCKA2UYmzTd12HB5GmTAlU6v81efaAQxOPqkm7QNgB9m+eUxAJ5CIDmXTgPNJu8hKgzfQ==
X-Gm-Message-State: AOJu0Yy/JfHWG7x7kbwSv6K83htpbiyjey/38bvgAVmvTD5ElgXZvQhn
	8jj/WWuD1Yu8BlRbUguuQBpzmqL+srPZQTMyLlHZbVmZ896biy2ddRGMu12lVeHlBjyPJ0KyPwT
	akbjC8cgzVz+p2etwKgGqef0scRI=
X-Google-Smtp-Source: AGHT+IEnlPA3unm2hvL+8/Nw2bpDU3oCs8qNUA5UJKm6KDDlJWlJGO0dUH5ShuIfEibra/czyTvMZPQBQryLqwL1c4Y=
X-Received: by 2002:a17:90a:ea95:b0:2c8:fc52:6a11 with SMTP id
 98e67ed59e1d1-2c8fc526c13mr3612337a91.36.1719571731964; Fri, 28 Jun 2024
 03:48:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628091152.2185241-1-nmi@metaspace.dk>
In-Reply-To: <20240628091152.2185241-1-nmi@metaspace.dk>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 28 Jun 2024 12:48:39 +0200
Message-ID: <CANiq72n--xSedbAmZD=LUD1AxM+aUbByVzMgXXgYQnP9JeQFdQ@mail.gmail.com>
Subject: Re: [PATCH] rust: block: fix generated bindings after refactoring of features
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Jens Axboe <axboe@kernel.dk>, 
	"linux-block @ vger . kernel . org" <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 11:12=E2=80=AFAM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> Block device features and flags were refactored from `enum` to `#define`.
> This broke Rust binding generation. This patch fixes the binding
> generation.
>
> Fixes: fcf865e357f8 ("block: convert features and flags to __bitwise type=
s")
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

I saw this failure too in next-20240627, so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel
