Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6B522E;
	Wed, 10 Jul 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720595312; cv=none; b=NsUBgEai9WvWqdW+s2RcWPKy/MjtHFpCCKWmb4Vzv+JjHMnfcTaKkcAa+L5Wt0QvU86wdUbu6dINHNAcyCvBBF35BidAwDlkjPo3NsNhJtUl2cMhYUjPmdwBHCeQZiEOZvdK9678jWRPBMp76vtBMroWKFj8TBWlJdIPTdiPQmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720595312; c=relaxed/simple;
	bh=7fvadA7RITC+QOAAEDu3n12JpxuRRxQSkjN/yN3J26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sx2bregU8m6xST36tPizJJkIV7SlJgai1l0xF4HSvUgiGWZFPPJY2DTyZu9Vtogym0udlIZ0jdKTc1ueBiHu1jGnIC4HmvoO5poHxS3MMv0JIOACRtGn0G4MruOIT7coRQjWzib4nmP3Uz3h7Y5kzlOOFndT33RwvDm+f2yx2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dfab4779d95so6223545276.0;
        Wed, 10 Jul 2024 00:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720595309; x=1721200109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3qNitUXgc1yU9l8j8hg9vBWdghaTni/Euzxu3xsiqKs=;
        b=n9VqxuqXebKxeH6B5ON9mLNrhAx7kau165fTVFkYdTuyvWgfqIgDInqvVoIVMo9oDW
         LipDZ17LUa2DgnTODGYBg+rXmzE1888xJXmA0Tb017mKwCpthwtqxEem0j01QfMt4kQz
         sykPUds+uqRUB8hnh5/WY7sZbTsGKnQr6vLIiOMoNnQE8fSqwuJL24SSj21W5quNyBmQ
         0HaliAFKdmFVuED4s3M70fpmu4s8j9l1p7iUxR85BlAdhh2RJvZWzr0dzNCuDbD8U1jY
         4JpYlGgLgvF/eab3Tuvo+Ms5QsfyuaJduTvRmupCnl1WWBghs6hcKTpYcaUWBmD/lEup
         03ZA==
X-Forwarded-Encrypted: i=1; AJvYcCUV25VwZB1qm2C94VTo4BbJFLXE6CfZHLvl5fSPbUDoodIDecccI0jDPriCLikQ10FQwrKeD4wVJ2xQmbSfRLSyjPZeARWBBktPMKIq+1k/9fzSj1jObQxR+aKRtSEybJ+eoOG2Ythl45I=
X-Gm-Message-State: AOJu0Yw79+vZPr3GktPB/ERDz7Mb8C/kTlGd3BTpUowP+GXwTumoeZD6
	2RbQDV8jvOPgvEJt4G9fyxuKCct5WLY4nfJOrcL1mVD1UNRCEHzpRmQEM0ps
X-Google-Smtp-Source: AGHT+IGQfRRzrdNu1XbfjLkuQmjgFO/FvRNIV1E4Bo4R9xXBLO4HpZeRIw6+Q47+AVhzTQn7ysYX0A==
X-Received: by 2002:a05:6902:20d:b0:e03:4ead:a32c with SMTP id 3f1490d57ef6-e041b074603mr5481029276.30.1720595309104;
        Wed, 10 Jul 2024 00:08:29 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e041a8d8009sm570841276.17.2024.07.10.00.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 00:08:28 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dfab4779d95so6223531276.0;
        Wed, 10 Jul 2024 00:08:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFQmthwavDCsaN/tNcXAv/miRbWkmjNEWhiUSt+FFP7LqqjksTFKNXlPg/IVLhs/UzRB3OpdHJ+0p/1Pc20k5/K0tukh7xDkcRFWMW0seMFsq2CwUbx45sTVzaYK2auNGd/Rzjuh84lHE=
X-Received: by 2002:a25:ac94:0:b0:e03:a70d:c12e with SMTP id
 3f1490d57ef6-e041b058688mr6130050276.15.1720595308046; Wed, 10 Jul 2024
 00:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706075228.2350978-1-hch@lst.de> <20240706075228.2350978-3-hch@lst.de>
 <CAMuHMdV95g78=2GmLP95Kn3_0DL5zVuv2KCDYVsk8D2gNnu7SQ@mail.gmail.com> <20240710055203.GA25248@lst.de>
In-Reply-To: <20240710055203.GA25248@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 10 Jul 2024 09:08:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU3oSOLTth-UGjLi3SttqPf-6rG9DvUTLay=hVSySB3rA@mail.gmail.com>
Message-ID: <CAMuHMdU3oSOLTth-UGjLi3SttqPf-6rG9DvUTLay=hVSySB3rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: pass a phys_addr_t to get_max_segment_size
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-m68k@lists.linux-m68k.org, 
	linux-block@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, Jul 10, 2024 at 7:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> the fix is queued up here:
>
> https://git.kernel.dk/cgit/linux-block/commit/?h=3Dfor-6.11/block&id=3D61=
353a63a22890f2c642232ae1ab4a2e02e6a27c

Thanks, that fixed the issue!

> and should be in linux-next.  And next time I need to do a full
> retest after doing your suggested patch order change :)

Always run git diff and git range-diff against the original after a rebase =
;-)

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
