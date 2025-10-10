Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A9314F9FB
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064525; cv=none; b=BczUpB6Km3/9lq1kq3nHlA01mzG13cANr+MatsvlW6BjHoMefH0Oe3iRIQrYyDPyVtQy0/RnKnvlhoshVV2+aAbZ5tZwOYo3BKFwwCwvsOutfVuQIWV7zx2m+rouDW5VB1g4ronbPpiAMgVYQA9dsfZyDChwnns/0pLZGywQfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064525; c=relaxed/simple;
	bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uri0p/F5/4I+m6UPaPd7reEs8ZZGp4NfX/uLZnZvIpyjp1Evr4AJBpKuIYJ8/WVZGNCtKp6NgoG6Vzv9npTdy71vLN4YVHp7LyYGyxKwqEMcf3N1gYbRNfk38VGkhjBuzdjbF+RDxMXy3N2XPW2xGO1yvo2NWHWThSQaBa5IDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elQ/QoLE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elQ/QoLE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-71d5fb5e34cso23314997b3.0
        for <linux-block@vger.kernel.org>; Thu, 09 Oct 2025 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760064523; x=1760669323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=elQ/QoLEl07oguGQwVeaLuPvx9pg+ZF3HObzItQAr16R2PwjJJ/BJhHlsBagHWRo1E
         q4f4I5TainPicRHfP4mxi/QA8fweTGrjQlrXERSkdlr6KgU4ZilfiRp9i5MkNzxdmJFE
         GqtJBFbDrYJM4r8+ph0NGbgZ2YQn4dQX2PL+zpJpSkH6dn2eia2X9CYfK8q38r3RGNos
         FYWwKOjsxbNPoX+OU5D0/LZM5lIAyQ56jv8iMtnZPsc8rn7rN4UBS2EkrASRagSQ6iHh
         M0HiA7o+kBUytakpqhUfCayQ9hhTHxglANqJie8IdxhcFjjr6XDM3XOMyO0pRXWHPZL7
         uJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760064523; x=1760669323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=xGyKQXNrWYgV4hn4XKdIU4HZ6hsZ/0rSIGiPNnyPeJ/FrYjeWylMRyos27tp5N8xpl
         UISa6PQCJ0QUFpd/xsc8kvGOQ2g1FLevljnmBVAx8av7vEzn2cR63PSM2k96SBT3WdeW
         2Zya2J3yOEUZR83nVkB45x4+cyMMDTNqXJcNbtJ+ZZi55+dKzqeqYbyAk0vWcZNa1khy
         ZuBdUBazIPnsNj/E3txxKFQBv25Mb8bFyuUMGIAhmhpzrxuxebR71TwQDiZdr4Jq5EVL
         nExlc/JeWMj9xH8dwaLy2NzNYQdmjFVbTFWgAwIURePQJl5FY1m2UP8b8hdWsGcZhyhY
         3Sog==
X-Forwarded-Encrypted: i=1; AJvYcCWqw46l0tnU+vtS/P2qtb760s6T8S94J+m5cHqI0vHnowhASblXy8hWrWwWg1i6qN2CD2Ome11HsDtPzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnND7MiZzhIQmWxLXYf70c1erlB9WtLm3jIdWZ6gQJbKbl7RI
	+MSorSBxRM8Xp2ph2ntKGiqvw/XqKvZ10y+NfKwvCi3jDL9rvaU2jAWCuA+0NtACu8Rt3JKSJz1
	UfgfIz8UbTaI9oyM2BPMCBoMCDpgp7Bk=
X-Gm-Gg: ASbGnctqABrRhpj3cndpRP3iZxMbYjAcfBlGnsSTFWwUWg72DFMmgNUnjosrwvkD3+K
	P8h5zSmoUIqHTmXvdmbbvOWLgsHrlyozo5K82wdv11iXMCxuUwaToFUkUFRXdnyhAYmxzJrEGjs
	AoN/FboKlurQq8DXtCecmG6HhkcKL8MVPcuuRSXHu2HCE7STH42T98knq6g6wUouv1eh0wUxMK8
	NsqmKau8mOUQPjoo8McMg8oF5No1MhW7wxz6sIERQ==
X-Google-Smtp-Source: AGHT+IE/ruZR0Nl+gZjd7KSfaZ+4Yt5azf8Eoz6teA2EZ5XcCIQ6BBXF8AxOCZshaSTrV+l7WDzDAJYCcqNIJ+IMELc=
X-Received: by 2002:a53:cd0e:0:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63ccc4fd4b5mr7697871d50.22.1760064522649; Thu, 09 Oct 2025
 19:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-22-safinaskar@gmail.com>
 <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 05:48:06 +0300
X-Gm-Features: AS18NWC-iakvkxLfUlO1LRxakg0fg4KV7Trw_hsIF2wxGpnmpWZvHTCQ7Z3GaoE
Message-ID: <CAPnZJGDK08eDWaMTmvVQwkAAThUvgB0XgAapqqV4_ZmWeay-iw@mail.gmail.com>
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Please wrap commit message according to Linux coding style / submission
I will do this for v2

> To me your patchset is way too big bomb, too difficult to review. You
v2 will be small.

--
Askar Safin
