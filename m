Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA541B359
	for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 22:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772231220; cv=pass; b=ITJ7mwC82eBfm5dwvI8ufm68iwYu0dytepnnY25SkY0aYpM/gh2TYRmyerDv8VrL2F7p3+/cxiUZ2UmnWotCUBfMZxJ0hgCgwkE+jfI9h6/Mv7HodSa3viMSnYMJiIThQ5O8FQy027u0OnAK2QB37L+mqDTMV+3Bf7S1lOc3H3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772231220; c=relaxed/simple;
	bh=HEc6W3B3KyQ3qcm07Kteieoys840RWPWeAPSz2C3iaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLdejs//Gwkui5624dx94BY5xlzzu0U8tb00FlZugd3ueW5/oDNqZi9CyHEa/kdtU9zUZqhoxPXArlduhdyHPWQvwAPSWnMFOmAbng36Q/TUH1D+e7LBizjhdG9ujAJJTj6ZAV9sJ24iwHCmvuVXqEiZNyKQN0kpnCvxDNGFqrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMaNTNyq; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMaNTNyq"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4be94eeacso2255634a34.2
        for <linux-block@vger.kernel.org>; Fri, 27 Feb 2026 14:26:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772231218; cv=none;
        d=google.com; s=arc-20240605;
        b=gO8B9xap6ZyMLHFMG9UXlMJczxnATvh9YajdjvQe0m2A4VlsUSevu70FVqDuNppnZ9
         utJ8rrZOX2ffF1j1Ezw6j1wUqibuyzA31a7VU0weqEL7oZZphFoDoiBF7Pfm7vVURvqU
         euhioIUz/CI6ZAnwKWh/Ym/vGObwgVpBqejs4HaatYcLEWnmbjLiPVslkjaZzQxeHGw/
         Y8yC6n+tNpcheizPl4EeQG9bzQ2peOAF2umuKAlubUXVM+Zxg5MklprpG5jjQ6eeeavX
         GCaijx/LSBXFBictOMZ1yYshM6Ppigb9fqMUbtTLIDwNBqvcWzwQxcZ53tTmMWuia1zE
         BOmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        fh=uieuZ7y5zUOVU3ZpvMxNFniiLCh1/9BEvBUizoIdVFg=;
        b=CEPKMjULg8g3stGKfUXZDNC4nzh67kuuTYhtgmlIcy262fRALrAMKeph7Swl6HXzaI
         7S9gaOLR9GW2pBnRQs9I/co9TYIdlUFlB2ZXZvzmXxWBD+40WQRVlvAzoWyJpg50Rx9b
         rERTFXse9h+4EumDTp39rjz30CgzfswKmygwaxsHUgBG2T4saY1DN+oZGa2+UpLwBBtL
         tBz4bSi9UoLkr/b+2uZqDq3N0Dy7H7zUS9xvdkcWO0D73WuJ3AgXC2YFpdUJdzRAKvET
         P0IYhTrvhcVNe0A+LpYZO5HTOe4LCZo10fhyYKoBN2tyr8XOe2qZjHHUPJVnJmJZ9rUC
         4gOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772231218; x=1772836018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        b=FMaNTNyq5P2L2ZOkCx08XVH31ftCQCl//RJJ8Z5O7k1OA/ou0pGQpNJbIqWkpnZ8Oe
         vZVoskqyK4ickPDXrLzAxRqbxkgeJodI/gOFvmb0EH3Xf9lFTn9sVoJdZ5hpNa4QPRry
         tszjE4/VFQAYW8cT4I5YY3V/FhBFENjQ+jeccGBEkGPapY1EeL/6wTeK3KpszC7oMm4y
         la8vrr3WZrTNxBasHGYx16i7IK4UiUYtlHC70kghTEkn/fCeFOF7Gn9y6NRfIVDrhgtS
         1MRgAkx/zyHpkOlBbc3mW2GdNF1OQdLV8wWsCE2YkVWxuX5W1mfITHB99EDZZrN2imdk
         CZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772231218; x=1772836018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8eMIGQgXwUC3hnpuRTbobexlYQNAdEuk/XQ06Fgu5Gg=;
        b=UEJq4/aPp155fUrZicCdrEcr1uleZshgYsfZFd39no+3dYriQMDpGAq/yY1ZExdD8u
         olMfq1msWY7Y2Yc089Ul/L1HZHzs/nYdzHc991ZnpdlDbylFr07RKs+bky51zKVA7eiR
         /K33Wm7uS5NzIwDHdQqUCX/ghx1cnbqgR0kcIXyV+r6iiuVA3bGxLDsXWI2xak6jXuI9
         GWmNyJRFb97kl61ow+8c/m/2qFJflsGRtnD2qYK6bYiHnETN6cv2LakMPJBbHIDr07p9
         7boAAq5AVAQGEW4Ym6r//Lj7KmjsWvM0GD3mqVHvo8qDJmA1/Xu9u7TD/jGYEZZgR05b
         +C5A==
X-Forwarded-Encrypted: i=1; AJvYcCW88P56qz+HNUvSIdgo4fC3NfOkzEylua43y49mv7/dC3OwIN2EABnxg2Il15ArlIbXlIeAdnTk7oyOfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQnqSF7x/BWy/KxXUPpr2kQ4S4rqaeYAcvLqMq1P5juYQwct/
	wsgBHkF9sEjbLjrGBJOzPMBHFmR3YA+xyIPTk3w6z0BO0sqjDVnKVtId3Fv61pQFD7uxWY8bRFf
	a5bGVv8l2XtnsdNYDjBv4P80tQxbu3p8=
X-Gm-Gg: ATEYQzwTizQgVfH0bey8JKQFsMzGq2pmpJSWQFhii3HbVgHTKrswM3O47si4AeJpv3B
	AMY4+SlMI0LujEm8RL42floIKa0GilPGIbcpbXQWjN2/1PXcyYMst93F0vZPOVxyTxDvjWZJNjV
	HnuPr7bZ2DtHMrshxaLev/Ej6cYvL0eygRDaNok36LejMZkttnxckx52Z8KGJAI/5HPKMIKUkvJ
	kZy2Fklp2m0gY8Q1IZgj+VhNoKqnv3JVBPbP1LUAX29lMvaP9jr8bVfWVAfVH6fYcRuLjLdg8Q9
	jeyiS9YS3rYn4F/3FxVZiJCmt1WTXaKeYilEzBmM2msqgenmwyz3bh7y0/HEaRk/9JrFPp39vVb
	xGc6FkbxHpYnKxL6rhZ+/IMlcSEIvr3z6r1Z2rg==
X-Received: by 2002:a05:6830:200b:b0:7d5:96a9:388b with SMTP id
 46e09a7af769-7d596a93bc7mr1340172a34.17.1772231218567; Fri, 27 Feb 2026
 14:26:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206182336.1397715-1-neelx@suse.com> <20260221205606.GA23260@quark>
 <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
In-Reply-To: <CAPjX3Fet5M2C=1TDNRhrqmanvJ2=aFdtQXfXK7MuxiOkz2rNUw@mail.gmail.com>
From: Neal Gompa <ngompa13@gmail.com>
Date: Fri, 27 Feb 2026 17:26:22 -0500
X-Gm-Features: AaiRm52Usi2aZHq1dkEfq0px3QfzRlx9VQVNLzVN9g7lM_OjE4pL_WS1HE1bAk8
Message-ID: <CAEg-Je80=M9nS=Dmj3FiGfXTEP_fDYytAv0ouN_iu+GzRrHp+A@mail.gmail.com>
Subject: Re: [PATCH v6 00/43] btrfs: add fscrypt support
To: Daniel Vacek <neelx@suse.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	David Sterba <dsterba@suse.com>, linux-block@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2026 at 10:55=E2=80=AFAM Daniel Vacek <neelx@suse.com> wrot=
e:
>
> On Sat, 21 Feb 2026 at 21:56, Eric Biggers <ebiggers@kernel.org> wrote:
> > On Fri, Feb 06, 2026 at 07:22:32PM +0100, Daniel Vacek wrote:
> > > Hello,
> > >
> > > These are the remaining parts from former series [1] from Omar, Sweet=
 Tea
> > > and Josef.  Some bits of it were split into the separate set [2] befo=
re.
> > >
> > > Notably, at this stage encryption is not supported with RAID5/6 setup
> > > and send is also isabled for now.
> >
> > Where does this series apply to?  There's no base-commit or git tree,
> > and it doesn't apply to mainline or btrfs/for-next.
>
> Hi Eric,
>
> My apologies, I did not explicitly mention the base. I'll do it next time=
.
> This was based on for-next @20260127 (commit 80dbfe6512d9c).
> Since then, some changes occurred that will require additional
> touches. No wonder it does not apply anymore.
>

When you make your next revision, can you also provide a tag or branch
that I can use to grab the patches for testing? It would be easier for
me than trying to yoink them down from the emails with how many of
them there are...


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
