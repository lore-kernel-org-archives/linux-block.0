Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2820B21E
	for <linux-block@vger.kernel.org>; Mon, 13 Oct 2025 06:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760335594; cv=none; b=o/HCHuuG3tcTqnPy918RCARUDcWyHImmSuqZjZRy4TeyibHxKcjJNH53dhfYLOHL4sviH7U80bzsKypew4cE/hmpTdp7Aj1p3EsnESQU3uv+2TMmPD9yYXtnfhj4q8fEcFhPm5mkMIo5QWwji2SDQov6NlbqpdD/ECsZVEhrd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760335594; c=relaxed/simple;
	bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsqggHmTG031LQEClx/PvncHkKXmA3Eyan8ODY4QEwVhjJltVAi87Qu7jIW8U1gGL3aNDKxZibnBnl8/oPF2dWfi4Eg8dVo+H/LmhfrNm4NqG7urmiTTO8Nq1icGXuSIJQ5wqwIYbT6UNrXm7Iq/apW61hFzRhI1tGZXg2WA1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E08XGpzm; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E08XGpzm"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-638d01a8719so3927161d50.2
        for <linux-block@vger.kernel.org>; Sun, 12 Oct 2025 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760335592; x=1760940392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=E08XGpzmHVw0+qDzU5sCl5j2nWjFq/4gmZrI+HSMqUtrUQdW75O40jzorsqViIJ5Op
         YueCYgQvB7QPc4pUrMdPo6WnC+J7hR1UlRYyfnedh94HC57pUVWE3OllsoN75neJ05zd
         7IcSugJKTLhjY0wSwmbSfQ1BF+GIHKMdxFsZBTI139vylrWwsfot4THqwBnc5WWO1ADS
         owqxNkoEXxySlcupDmKJPMhXmeet3aWT00Ul8qKcfRlZ1+XFeBRnw6Pd6ASpf6fNaQKa
         kriZgtpxAU1TcDZRtFRbT0eY4rS6fV6XOKhazNP5uPTqs37bNueBArVUKMrsryxA49Ua
         /esQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760335592; x=1760940392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RSL7ODefchx0oaqAeJ6n26+cCreCbBCiVlRzlUCjIjc=;
        b=ZFOVavFzYUbxeeqQX9aXcXjkF/BkX9iVoo+azgLqjMu3/NjgZNYtx94M4oXit44mmM
         PgzrLgK/3tnya69wC1BpbcvtorPLAYvdEhwmg25Y0Yp1Y4df4q4ipRNPkzcpMZ52a/Qv
         aS87GiC0FVPiZ1Nvyh5418ZLKCu0z4C1TuLq0DVfsMqcrogGWxTl6dkPEHT8NWiu2M62
         kECQ6riDLPxfkx6yEzbjtDfunAealDAgXzYVJuoqWxV5IOsigmODwZGxAK63KnklINXn
         /VkyUHj4NsgrjvcnDlQ0jqDgfSTLmiXZux/Pe9/hc19oEr6NoBmw7+xt+7NaC8ihTVS7
         OPRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVolA4KUnyJTemx9KOrzhi+xUMsXmOO2eTJ2pkBg4Rek8nSTdJ5KBNZwXFis7/p5XBqm7RjQ39kCQt0Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/W4exj60Ii0yRrP2p4z4wi2r2SrAF1xfV8u+kprM7exKBc8Op
	uZmKyCGjCKqILSuHATYIdl8lHIQX6+pdCtviduSfCh7rmXBZBz3YWvX4SUN9EWVQWvcSEtzRUqY
	oz/hx9KjQQ+AMTCrV8Vy/068poWTVzh0=
X-Gm-Gg: ASbGncuzBrLSk44cN9kPHwheNOiZEl9L2Kx2VNne4yHOtStEBBoOcDOK7BH1nD6JkT0
	sKtg1rEj6AuIQsvp6S6+qbHsUzeN6pGxKGymZK7RensK4OlS9nuxffEAqzAxewmdmN7gXiRcKP4
	JFL7fz09v34b5JmmcqJ4dyD5+sIjEprRRJUlPZ1nWh5YLKodnL+K252avRWJIcg88ojDa6ZFGgX
	f53nqa+pLp+UB1ovkZleFDLCoIUkaaFT1/a
X-Google-Smtp-Source: AGHT+IGNAOIcFLi0/Sm93Y3jSHSuxr+30gS3y7Fr34MKhVqQQnt1MJ/lLmHR6+qpb+bVmq5VVWr9ycljJFZ2Qxe2L4U=
X-Received: by 2002:a05:690e:4142:b0:63c:f4eb:1b0d with SMTP id
 956f58d0204a3-63cf4eb1b25mr7582533d50.22.1760335592286; Sun, 12 Oct 2025
 23:06:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010094047.3111495-1-safinaskar@gmail.com>
 <20251010094047.3111495-2-safinaskar@gmail.com> <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
In-Reply-To: <CAHp75VeJM_OoCWDX20FhphRi6e7rG9Z4X6zkjx9vFF12n7Ef7A@mail.gmail.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Mon, 13 Oct 2025 09:05:56 +0300
X-Gm-Features: AS18NWAQKixJeSnu1jMDTs2ReasUmQ44oKevMSLcLyEUnjeI8Werl5Jwf9tycOM
Message-ID: <CAPnZJGDvHbDt_JvDNLN+LaU+5yFyB_qkdBtVhSEV60_yktAVzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] init: remove deprecated "load_ramdisk" and
 "prompt_ramdisk" command line parameters
To: Andy Shevchenko <andy.shevchenko@gmail.com>
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

On Fri, Oct 10, 2025 at 6:02=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> 1) often the last period is missing in the commit messages;
I will fix in v3.

> 2) in this change it's unclear for how long (years) the feature was
> deprecated, i.e. the other patch states that 2020 for something else.
> I wonder if this one has the similar order of oldness.

These two commits were done in 2020, too. I will fix in v3.

--
Askar Safin
