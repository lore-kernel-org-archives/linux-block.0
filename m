Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D53D1991DD;
	Mon, 11 Aug 2025 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902519; cv=none; b=qVD/0qt5GzfDNXYNzrGGqVhzgMILpqm4ukda1GwGFFhSSHuCk38miPSca6XgR7FBgNryL7feddOtpGFIXEjZC1dAHJEimLUW8inCruUDBXewJI3HdinUQBkEsoEZqzzz/WPcccSVBCXd/C/GszTxsj431zI59Hc6UISyGBHfT6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902519; c=relaxed/simple;
	bh=9TpHCUtQbpYeE5hC40i0PLb1CG+a9lfcbDOK9kxG3Eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LebBO32JyZLnjafzewpKE4JGSVGlT2KrrBBlGxVV7GZnmtHTtiN31VM3ricXqm/7k+GyfkNvju6b8GgKPPmGcvnDkzS986WEcuxqlTh3cYTORcjNTuR0E0qgrXlpiPXmQ+AsREcFvz+TlCXT4MXl2kktiSiZNojhMvJMFlGJ6B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5392bf8b590so2794503e0c.3;
        Mon, 11 Aug 2025 01:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902517; x=1755507317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CK1AgXEDVnnCjp/WETSt1mjlEj20pRVnTyOEAVLwD9Y=;
        b=XEKu0/YZXvNAG/zbYZ5ROAASftqaJxv61/P/O0G2bcrRy0rSHprq8CriTzGcraV1sw
         UAFGclj5mEXo1el4Xb8CmN8AFPe5sZYTIe8fhPtxOv2kB8mU9Hdye7hU4l7dSMPUOgxZ
         yIZWDGqmBthSU6Gw6cfm3N41TiBPwduwheM2Tse4vtcHDzRpsG3spNlzxfoEA/kAQEmg
         C9FPUX11FwfaGkJFrqqdoL8bsnEzBmO7QSMu0rPNUch3YedNdGUoYbGszY5tcUvDf4IZ
         jobSTfZ0k2AP8u4CQNkyjOz9fWzvd3eHHwm+drPEOEV0RZXMlxeU7ALbea5k5Vmr5XRt
         HKgw==
X-Forwarded-Encrypted: i=1; AJvYcCUS/lFQ5/zJI8QFdNbTMhkAuIoG9t365rO2JVwfwP5XXgUhqGAXFhv8n4MGghR69oJEN0EEzpFT107+qA==@vger.kernel.org, AJvYcCVcdUBJOcog2yqCWOYxa/6rkgUCYYaUehZ9DbWx8ibKZgbtl5AOvO3vOGmX0A12XqVc4o50ww/wXPGLcyVR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bZr4b31veW6kivkP2stjngM0s7kqYwpnVnRHixOA4zmkRDrx
	qU0W4ZbnQNZdsr23EvqoBS9hmoRzycQuFL8+/rcnSOYHa9sQHND/ZtEt0X6uoMHE
X-Gm-Gg: ASbGncu6c+BaFZG9GCyi6TFgRKbFubi1eMWhwFTLiN+TaYdX6mz8Rdb9KE1bbKldkUG
	z7UNR6f5iyFFjktBj/CbCM9w0eJUQSoJKfmtgptbw4pzVYJAQJTOI0MW1ZoF/6oKkT5TE9VVMfv
	M9HKoLB5YuwZPRKaICRJnmrNqylT9rjPPW6kNS/XeupdaGFWT38TLcAxrLmiUI+TokR01DYI+o/
	s39Wc5XUB9K9H9RItLkBP5lB+yb6qS05QArRpnZzCkV/nnqYgzSp2RhqvAh8R1POTR03hBSNtr+
	NgVO0BGixJ8JMudh+L8Avu4jtPKq1J6L3aIMqibnT5lAadO0+munl2zwrUhGewn+ReSZ2VBzHY2
	DHAaMohot6v8kxKGMmkcSW8PRpxI5jbZ6RuoaUf0RJa+0OPYazjNJRPDV25sE
X-Google-Smtp-Source: AGHT+IFs10R8BvcGPhJLYVXhvid+FGzirfrsq34GwGokOIXw6xPwUUE5zSx7EjzSGLaM8v7kzNMHLw==
X-Received: by 2002:a05:6102:512a:b0:4e2:82b9:b377 with SMTP id ada2fe7eead31-5060eed10b5mr4333757137.18.1754902516634;
        Mon, 11 Aug 2025 01:55:16 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-509aee2556asm524809137.22.2025.08.11.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 01:55:16 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-88bc6f023edso2126422241.2;
        Mon, 11 Aug 2025 01:55:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEHr0AkmcwyXmplbJHBqJU+uBW4vsUnYKwKxUVmuiqXmnv2jOi9x5nXTDHtpAketIGZ7YmdgiCNR0X0hG5@vger.kernel.org, AJvYcCXsGXsuNJW/9zGeswTDW6bILlmOSJxD+0BOfy8L7eFwTGrU8TbINhxg4iLpEg+ZVt4sw6+/Q7r2cCTeLQ==@vger.kernel.org
X-Received: by 2002:a05:6102:160a:b0:4fc:1987:fc84 with SMTP id
 ada2fe7eead31-5060f4b66f2mr4026964137.21.1754902515854; Mon, 11 Aug 2025
 01:55:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805073748.606294-2-yukuai1@huaweicloud.com>
 <202508061722.0vTVFHLe-lkp@intel.com> <7d2b0108-4d16-97fb-5de9-7438414d9ca4@huaweicloud.com>
In-Reply-To: <7d2b0108-4d16-97fb-5de9-7438414d9ca4@huaweicloud.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Aug 2025 10:55:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWieP=Tk=Qgii=6mrpZNd5Mp4epSGufs5QD26tLg4joMA@mail.gmail.com>
X-Gm-Features: Ac12FXwhwvPoKhEjbebgA6PlT3FuvJCiQC1n7jaXfuYXxfXS72nh_AEZ8FaZLf0
Message-ID: <CAMuHMdWieP=Tk=Qgii=6mrpZNd5Mp4epSGufs5QD26tLg4joMA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lib/sbitmap: convert shallow_depth from one word
 to the whole sbitmap
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: kernel test robot <lkp@intel.com>, axboe@kernel.dk, akpm@linux-foundation.org, 
	ming.lei@redhat.com, dlemoal@kernel.org, jack@suse.cz, 
	oe-kbuild-all@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	johnny.chenyi@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kuai,

On Thu, 7 Aug 2025 at 23:37, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> =E5=9C=A8 2025/08/06 17:41, kernel test robot =E5=86=99=E9=81=93:
> > All error/warnings (new ones prefixed by >>):
> >
> >     In file included from ./arch/sparc/include/generated/asm/div64.h:1,
> >                      from include/linux/math.h:6,
> >                      from include/linux/kernel.h:27,
> >                      from include/linux/cpumask.h:11,
> >                      from arch/sparc/include/asm/smp_32.h:15,
> >                      from arch/sparc/include/asm/smp.h:7,
> >                      from arch/sparc/include/asm/switch_to_32.h:5,
> >                      from arch/sparc/include/asm/switch_to.h:7,
> >                      from arch/sparc/include/asm/ptrace.h:120,
> >                      from arch/sparc/include/asm/thread_info_32.h:19,
> >                      from arch/sparc/include/asm/thread_info.h:7,
> >                      from include/linux/thread_info.h:60,
> >                      from arch/sparc/include/asm/current.h:15,
> >                      from include/linux/sched.h:12,
> >                      from lib/sbitmap.c:7:
> >     lib/sbitmap.c: In function '__map_depth_with_shallow':
> >     include/asm-generic/div64.h:183:35: warning: comparison of distinct=
 pointer types lacks a cast
> >       183 |         (void)(((typeof((n)) *)0) =3D=3D ((uint64_t *)0)); =
 \
> >           |                                   ^~
> >     lib/sbitmap.c:222:20: note: in expansion of macro 'do_div'
> >       222 |         reminder =3D do_div(shallow_word_depth, sb->depth);
> >           |                    ^~~~~~
>
> /* The unnecessary pointer compare is there
>   * to check for type safety (n must be 64bit)
>   */
> # define do_div(n,base) ({
>
> I didn't notice that under specific arch, do_div() will require the fist
> paramater to be 64bit.

do_div() is strictly meant for a 64-by-32 div/mod operation.

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
