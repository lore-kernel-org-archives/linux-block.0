Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F62F363E
	for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108561; cv=none; b=XVybHFO3lrulr9NxPttYuRtoqEZMj4aDOX0QVsCebezac/XXBeppxMiqWQwMyU25MgidQYVXYLU2En7xUp58LYmRhWiCKl+ey/gJr49EhYTSrk5QC4+7QSIcBoGDbN948VArPYB7NOUzBjqSXlWZHd7PLhWSDB5cmqqByiPPbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108561; c=relaxed/simple;
	bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTeXRCXWQ1HJEVW+Ejq/u48Igoxc6TYCIOtV3pHB3El4NEEUwO8cw1cgQa+sqRLFHiCaFbCwGHxEo9PJujo20veZD8gPLf6u5nNYvfSFGw9Jdl/35N0Lp8JRAtz3I83Hf5b6aekbzRNIZdBWdMRljDWUOLd/SJuC/LqSuo8jbE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aFLDqTBw; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aFLDqTBw"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b4736e043f9so318899766b.0
        for <linux-block@vger.kernel.org>; Fri, 10 Oct 2025 08:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760108558; x=1760713358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=aFLDqTBwDW9/tslHGMMpz/fDXm/8YFeWeEqOIcghoh/WbHIq4K/0SzxFSFr2C8rGcg
         FzfA6mauz29MwswTSj8YO3mq3cxhh5u7GFdf5ExSSfl6BXbILBg23XGuvlNp3mANuW6S
         eel9qNFJhrnpSPxNuvU8zfBQImKbaXpPm7yI2z/z99IQuraI1weEKXaWKAoKN2dn1Fia
         VeA9V8C1Loi2AzEhqtTtkmVxXU3/XSg2XO66Oqk58zTi4gP34AT/wGmHBqeZyuMiW54A
         2nUtDEww8Cwcun3qpGWQvCqHEXtidVmA+q8Oy3lJypcr/DIo7Im2rac59BUjorWx/gNF
         KEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760108558; x=1760713358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lLjhJqbBDQ/a2E91zif4RZ281K6W6HFigWXT0cxbz3M=;
        b=cvcdcjCOBXL9qccAGD14Jsq7CNif+m9yyHLW3ow4t9tQX2+pIEW0gBTnoZJT8BsNwG
         A9iJU6xE5KcIBU2l7ShpVcUUg1UxTVtwS9cdw8m22MTmbKh/hmuZ62U/jj9++nkRrFns
         OGYMOMfBjuauH3hFANFHcKtAyUs9U3XzUsDSwmifSJ5g39NWtjFxZ+1tCpXN84JeL5X/
         XPqfrWgJYIBop1BWYfUwHLxcVrLU1ueBfd63WzOjqq+932AOrK5tCAl1cxrAgNnbssq8
         bpqu7O8aPSK/88OzfXtSFehmUdLSm0kYAitOVt24KPttCbTuT7Hc9I9FLLnmt9f824+J
         SO5w==
X-Forwarded-Encrypted: i=1; AJvYcCXxx6sNNRT4gKXobZY6eaNh/X7iKLp7v/DVcf6zv3ot3RxWlkiXDfbt+nM3k5g3Fr+iYvHUSO5Cd8IGGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPV0pqqs7OrH+DcK/7eFMZqIJr7o42cYbzRT3e9uNoDKz5/8c7
	vZWouCRS04IAxJDYlHcjBT4UtQvzso3YTNG0BeklNfuHnkTzLmL1rWpFjMvoBmIcv78t7Y6k9kM
	295D4kkKA6JCebaErLfZyUmXUTmdFTko=
X-Gm-Gg: ASbGncs+V/qD9t+5CGq/EraFbzhlb7jWmP7XedBthhACmpb9piwHldNlD1hBwk2ng2D
	5F5gj8OAUvO4SXYOBGM480kOQdWpkVY/br6VbdVEKCnepA0X0qw3jVfEZ/ivzyOBIQrb7uohIQB
	YJjWYB7mKrdNIeqh2oAe3O+WNMoWfsfoAa70dt3MmYKo/R54yCBCgArgPzE/OIBzXDbaCH0e3QP
	tb/xCBk7spH7MBGp8JHzb6YXQ==
X-Google-Smtp-Source: AGHT+IGa/polL6/8Ynsft44cUD0O1NPKwafCC8Smc6nmBnm4TDK7NhR64Y4hIQgBMI+z098vLRzD8f+sU8sdugojvoo=
X-Received: by 2002:a17:906:c104:b0:b04:9ad9:5b29 with SMTP id
 a640c23a62f3a-b50ac5d1e3bmr1407180966b.54.1760108556823; Fri, 10 Oct 2025
 08:02:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com> <20251010094047.3111495-2-safinaskar@gmail.com>
In-Reply-To: <20251010094047.3111495-2-safinaskar@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 10 Oct 2025 18:02:00 +0300
X-Gm-Features: AS18NWAoVP5WYC_07QqSXrvsFY0nBG5PiGs9ESaeN2ZfR7dfSMsKUbHhpVYPARc
Message-ID: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
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
> ...which do nothing. They were deprecated (in documentation) in
> 6b99e6e6aa62 ("Documentation/admin-guide: blockdev/ramdisk: remove use of
> "rdev"") and in kernel messages in c8376994c86c ("initrd: remove support
> for multiple floppies")

With all the respect to the work and the series I have noted this:
1) often the last period is missing in the commit messages;
2) in this change it's unclear for how long (years) the feature was
deprecated, i.e. the other patch states that 2020 for something else.
I wonder if this one has the similar order of oldness.

--=20
With Best Regards,
Andy Shevchenko
