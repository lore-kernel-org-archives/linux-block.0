Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014EB2F8BD1
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108713; cv=none; b=FCNbeqTfL9R361ZYe+BqcbXMYiGXMPsvVXzH7sr8V/FKR9ZAHNoHIFilI1TAL1GqTAP9F16ZhX7y8W0DDJrx1hA5ZvVLqRwE9hrcbBkEg5/+YvISafiw37EJTXGTkzEtuc2Pe/tDDZX2xcQyS4vP3Ry0V1hJ+y3TFHGFWPmI/eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108713; c=relaxed/simple;
	bh=auvR4vzTTatOuCuru52VOtm4KI7SmeTOVUgJyw2/46g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6oNf6pmHUY/TjfnF340aA/pHjylEfgnc3IBpeVZeoBEnLqEC2oD/amNOMdf3jALKAPlq6b8YhlbC6PNer1w27va+gk/TPCTzB4AtT41Bz5o4IOD8WTh+9ztNEgC/yRfGMPxlMO0UhzvZFWBf3rBbUzOD+K2Y/d+UHZRKigEij4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cukOrGdK; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cukOrGdK"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4539dddd99so446141566b.1
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108709; x=1760713509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NIWxPopIPg40sXCXJnzxg4lhVvntApAACn3HESqIPcY=;
        b=cukOrGdK67ALc138mnVZJfA3nAbcSaf9ydeV1KhpWWi4VAc2Reodc632tdlco8WCam
         6lmTryDBz8Pwky0HIhVJGEdxdSIf+t7NjJZt66/OCUU01cmxp+7b2d9nrdbpTot4q3Xw
         PG8OPQYolf/jm7ASPNQQLQxnQpjWMLLE8DE0H7sAy535HzhvOfIi9iDMTUNjgURkfN38
         sPcLH8bje6HSkKtd2nm1jf0miU3Fm3O8g947/Ybrc/iWH3QK6BG/H1hhM4S750ZmcsYw
         dK2uOqJRJTQHyoL56Sg0wLuhcKFqk5jTN+4Tgym4kGXc1tRa0WHfSarSptSXNVsGG1tq
         IDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108709; x=1760713509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NIWxPopIPg40sXCXJnzxg4lhVvntApAACn3HESqIPcY=;
        b=aDlU4qTSCj5BckrbN5ItaLV0xLRvho4pOkUyVtCJthjpmXJfW3QSH4erqlARPqOvOf
         Y9Xmk6v7LcFG1T5m7Xk2XxsFDIzcwK4Fw9yuawsTJe/tzHEwFiG83beYJMZFbzCBHfU9
         JsAUCD6COJe1yBI1Rgw6GicCc6kaAscQLfjffCJOQ0QhAr6uHYOhbGV6ntb1h+o8frMS
         9/U2obKv9uDSilSC/VoZy1TjAhShsND1LXUEx4JDU0MEkZDVr2Y3TGA7sh2pZYy475wP
         KkxdxEZRFfgG0j/NLl3apgLumpF4A/pYjvwtoplWXj38XgMZlz3Gj5yKGqtVP3LlwksB
         mCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1cilCUd5WTkNQgzBd6uSU8Tk+jyLOh+yPm5iIQ3yp6n+yepfFKbMXBQfOD165Gsqrp77FWYfu4ZosYQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3z+wDTwwtKptAjWrh5DKG8VVX39g7aoKh0dfaLJLRAvgAfUVa
	JSi09+rczupMRr5AetpyUlgBEhQTSyWRjzzM5g1KeZvVagavHgLjiLA1Jea/cZ3FRj9jyLNIvGG
	NM0utiWnSjTrC4NHPZEy8ipQBPXjYmic=
X-Gm-Gg: ASbGnctmxkAQKbrwk1eh0WO/6VqYNe+k8nh5w9PI78SaMJRl3+sFi8immJSVSPOsEw5
	lcuOfY5DO8HoJJyAYmQI7bXG5YpqtMrfjwKcwsc49JiP0C8ppalCs1HXXAnlJoDmbohpakkWVUv
	IP1zOaKmrlmTKpkVhuXrdlYSkEtRp6JB6NOCb62WsYVmus6ZKtU95fVh6L+21yb0tXJWRiW71Rg
	na5X1DrBGkPSbWpi9bHaC9z8bMsCiPY+0hf8C+rEM02/TE=
X-Google-Smtp-Source: AGHT+IF09dfhTcQpiRWLSf2A1k/s4FQSc760VKHf84ZQbfzXVjJJrp2yCq5wGIDsYhhFT8HuSa1w5HwjyUCOwQmF8So=
X-Received: by 2002:a17:907:2da3:b0:b3e:e244:1d8 with SMTP id
 a640c23a62f3a-b50abaa44c8mr1245748966b.34.1760108709145; Fri, 10 Oct 2025
 08:05:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-3-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-3-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:04:33 +0300
X-Gm-Features: AS18NWCvLx5PLZaUkorsbem-B-yR3hlKjw6yF-hbdTFMFmR4Zuzb6EIcT1htWkA
Message-ID: <CAHp75VezkZ7A1VOP8cBH8h0DKVumP66jjUbepMCP87wGOrh+MQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] initrd: remove deprecated code path (linuxrc)
To: Askar Safin <safinaskar@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Aleksa Sarai <cyphar@cyphar.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexander Graf <graf@amazon.com>, 
	Rob Landley <rob@landley.net>, Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dave Young <dyoung@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Jessica Clarke <jrtc27@jrtc27.com>, 
	Nicolas Schichan <nschichan@freebox.fr>, David Disseldorp <ddiss@suse.de>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 12:42=E2=80=AFPM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Remove linuxrc initrd code path, which was deprecated in 2020.
>
> Initramfs and (non-initial) RAM disks (i. e. brd) still work.
>
> Both built-in and bootloader-supplied initramfs still work.
>
> Non-linuxrc initrd code path (i. e. using /dev/ram as final root
> filesystem) still works, but I put deprecation message into it

...

> -       noinitrd        [RAM] Tells the kernel not to load any configured
> +       noinitrd        [Deprecated,RAM] Tells the kernel not to load any=
 configured
>                         initial RAM disk.

How one is supposed to run this when just having a kernel is enough?
At least (ex)colleague of mine was a heavy user of this option for
testing kernel builds on the real HW.

--=20
With Best Regards,
Andy Shevchenko
