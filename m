Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89079324B34
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 07:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764920787; cv=none; b=gpr5Or79t5b1MMcQEftEvyCbuDFsoEWoctFJhovIgl+LKznyhqmlS+saCg/HFI9UGFpwpaymip689BtbRMA6VgeUB4mqBoow0sba9Trg1f2IVGA4MSv+42OR0GRJ4Phvrr03hykBxAmqjfG/4NkJIlB1wCkXCXshdpagDFdXWOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764920787; c=relaxed/simple;
	bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzIXxJtAGr7T8EXTRn4oe8gMj9HdIPSMZ1LF33T0BTGUkbfYPjaNf+37EJW+ceyz4D2FAH5ptvmQyPfTiGelwfXRtDR/69JXTM9fWCnOXGLNgfqj+HUuFkwQGcj0oWl22EZQxTcbpow2oOVXUlzNj7W569CpvE3sqCmg8KhX9ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIUg0V2J; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIUg0V2J"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ee1879e6d9so21076201cf.1
        for <linux-block@vger.kernel.org>; Thu, 04 Dec 2025 23:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764920762; x=1765525562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=CIUg0V2JCjbHzU6ZgNrXL+2mqVIMDpb1IdmtbxtfnZytV22IH7UwGHwoviMMW/F+5F
         mvWYMXJ8iYXTuTkp17az4Tbr3aOdT/tAm0wBsJ71KFdrlf3H6u8UdDzGENzaEIT2J4jQ
         cZvELfdybc8PUSZO+i4HqoEJ/VeNRIRAPdjuizdDzp3BNuvnw0Zv0S/lFHCIywOWnpUu
         uSraOQuqQvStJBboIXJeewQR0mPOs1mkVlXAu+QvtbgfVY2QYsD1xkg+cqvdTc1ZEp9Q
         w2HaXk9ADarjsh1zIszaafX9d35TLjLSbsw3ynNDNJHN9Ej8SU1pn95ZpfPt1mv/XW1m
         3+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764920762; x=1765525562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HXtSwPAI2lC/ImQNYqZw2xOGmU6O3GtB13oXE7vjpQ4=;
        b=Zh4urdyIwIr0RifIe0ne2SlAPPjX2jAlprPWvwdnmGokKG2YLlyjgcwqyZ8jMUr+ga
         7UwXyJZsglhruKAnmCYKWgmJ9eysolM1xeIl17ZyTSKPndLJyDgK4axYl1xaeF1JKECE
         Yja3nFhSt+2mJ0qCyS3hUZ536JWTOX9K4swpTnTz5rF0BlPeoGOGB+45jXCoA/HL52k8
         fJYdOR0st9jEOR+MDvVnBX1r7F2ohBzhlSYkAjeZTn5hjbWl8W+OEqae9cg6S+67y7L5
         xdGAt3fccCxzw9hBWbhSnIKa4KozjycH/v6ZvJssITmLYvfxKZykPszyrLSFlBgMzhyE
         GenQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf7EohGEBcHJBCK81AZoBfHuexh16dN/+VuwodK2eUpiBwobjkCjCAr+mZqZLTYrjSwUjjETffRiSZRA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhoqU4r7h+VzOVXSSibFE7/xZ+OqpqKO8e/I+ihcx1M5W6xuJ2
	9c4OayOTW3jyqUtzpDoJ58SxZz0ta5fxfEqABnVeAHWp/RLXF5x/w6KpUoQruwEQcmDgkVsrEnq
	mky/X83NheuEyQDo5TAxQXbcs/l/OsltPId3D
X-Gm-Gg: ASbGncvC8w35nI8Z627KQ2M72TBkHy/ZW33RluBnz5JqdZZWahKdO+Zro7LasnB1eP3
	4Sw3tUg4eCg81ix9NPZEL75MolYRiQpjPSt7b28LZ0ePGCQJCRO2cHvUkHBfDEzbwhUAOaJeH7F
	Z90KOURxfgn+0dkS3PjHy1iYzcDhYdsMMyjBKNIhXuLttgfwgjkumYzKTtULCxFrDcZuyRJ8xvB
	3k0MFxYMRpqmiK5TsuU+YdXmNwoL8RjHHVF4mST7IHkYvM+utg8zf+xBVS1dDuuzOkTANZA0tkd
	D4w1/g==
X-Google-Smtp-Source: AGHT+IGno4YCEk34HtoQAUN6GrFl01k867Kp7tydcNcb8xmuE9aFUTESOSk0G3T3M/y8W6zfCnRmuyMISYmpdGJqEvo=
X-Received: by 2002:a05:622a:5c6:b0:4ed:2164:5018 with SMTP id
 d75a77b69052e-4f01770bf40mr116570781cf.80.1764920762038; Thu, 04 Dec 2025
 23:46:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-7-zhangshida@kylinos.cn> <CANubcdUtncH7OxYg0+4ax0v9OmbuV337AM5DQHOpsBVa-A1cbA@mail.gmail.com>
 <CAHc6FU5DAhrRKyYjuZ+qF84rCsUDiPo3iPoZ67NvN-pbunJH4A@mail.gmail.com> <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
In-Reply-To: <CAHc6FU57xqs1CTSOd-oho_m52aCTorRVJQKKyVAGJ=rbfh5VxQ@mail.gmail.com>
From: Stephen Zhang <starzhangzsd@gmail.com>
Date: Fri, 5 Dec 2025 15:45:25 +0800
X-Gm-Features: AWmQ_bnqjBxuauDVJJL96EAzZiNCKi7bmfbcq5aA841m6f5U8UUuamAPefRv5L8
Message-ID: <CANubcdVuRNfygyGwnXQpsb2GsHy4=yrzcLC06paUbAMS60+qyA@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] gfs2: Replace the repetitive bio chaining code patterns
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Johannes.Thumshirn@wdc.com, hch@infradead.org, ming.lei@redhat.com, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, linux-block@vger.kernel.org, 
	linux-bcache@vger.kernel.org, nvdimm@lists.linux.dev, 
	virtualization@lists.linux.dev, linux-nvme@lists.infradead.org, 
	gfs2@lists.linux.dev, ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhangshida@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andreas Gruenbacher <agruenba@redhat.com> =E4=BA=8E2025=E5=B9=B412=E6=9C=88=
4=E6=97=A5=E5=91=A8=E5=9B=9B 17:37=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Dec 1, 2025 at 11:31=E2=80=AFAM Andreas Gruenbacher <agruenba@red=
hat.com> wrote:
> > On Sat, Nov 29, 2025 at 3:48=E2=80=AFAM Stephen Zhang <starzhangzsd@gma=
il.com> wrote:
> > > This one should also be dropped because the 'prev' and 'new' are in
> > > the wrong order.
> >
> > Ouch. Thanks for pointing this out.
>
> Linus has merged the fix for this bug now, so this patch can be
> updated / re-added.
>

Thank you for the update. I'm not clear on what specifically has been
merged or how to verify it.
Could you please clarify which fix was merged, and if I should now
resubmit the cleanup patches?

Thanks,
Shida

> Thanks,
> Andreas
>
