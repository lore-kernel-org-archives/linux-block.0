Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB9152162
	for <linux-block@vger.kernel.org>; Tue,  7 May 2024 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715080793; cv=none; b=oyI0HKK5rYOkLxRCMBafLsnP3M9U3myEmddsSPHtG2MlObQuAKQ3u6v1SkqVW3gK/CSkTG9zPXmFFAyRVZBNI3in8symR2WHHETZh1C7/F8yrYAMLCJfI50fCy9ztdIIi4/pdHbZIMGGfzQ5Gaq7kfUINMTBgVksxXpumn6/v4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715080793; c=relaxed/simple;
	bh=2+7q0tHts3vAYwWoCF59QNV7DoQpUg/EBwTmN6XRyrI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kGBnDHnTsgwWoaqn/8PUUm6AqI3zaVGA5gMrz6n6G4Pgyk9f8eu5QSPkzrRLrG0lYp2W0oRXxUEF0eEbavdKkcREwX4fbX0agSj/54Vv7aDL2q72aGw5qnTOgHv31LPgLYv1cLn0LvlLqD2uETZO80wAm8wD32xh1kOzJaY39h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NAzJp925; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NAzJp925"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2df9af57b5eso40296291fa.2
        for <linux-block@vger.kernel.org>; Tue, 07 May 2024 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715080790; x=1715685590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHs/u1KySRDd2T81+b99K4HJ95jGnznmh3akOmpBG9Y=;
        b=NAzJp925939SGxJR2UDZbt0HW+0F7IGTVxOdRWLid6klsYHRQ8wVS8UiznnplvqY3j
         D2UP97TJYqanz9bgdezGlhaDnLLnLluvD2Ut5A6r4hPe1Zm17kGWFmV/sk47W0mpqnJ/
         aqEv9SEw2zIjjKUByLIgCfVkfsoqCuEsKRA29M82rwaKvNyjZAAaHjoCE5hmp0ZnLp8C
         eNniDN3K9AuZaRPvQGZfLFUQRxxdvLSX7iozpAto4IF84Or//+l2uVEBQGY63Wv9Y2z8
         d88WHSJEknhInpEvPmzCwYyZyknYAqtVCePbN1KVKsecLvRUSV/at1Nrz9+UEJJcAV+P
         3r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715080790; x=1715685590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHs/u1KySRDd2T81+b99K4HJ95jGnznmh3akOmpBG9Y=;
        b=odue/mYobmeGWx4dVdsQOQUWe66kzga4aqjYenQ8j3POi7YLBKgZHFQ5pBEqrbTjuw
         6tfxbxlQZfld0/2HKudNww3pigkV1zBp1UyoVeLzP1cL1N83mtaN4gdfhmbxWs79swaJ
         Pr5PQ/U2rdMiTvGif92EacgL7g/bU2lOnACj2yq2bRuvyuEPHfV8R6gU0GAwjKLu7KvW
         rki85kUNp3+6sX9xb59xzFZgbJCUG2XKTGvpI0xerxL+t8t9wbsRnpgYu2H99NRuWqaq
         IjhLpEZKvGhd7cfkzBh/EwjhWSbOyVOnqm1IcvNmGTO8s2n/SoB0GgXDexnCBAqIzgwf
         rIQw==
X-Forwarded-Encrypted: i=1; AJvYcCUDjl1n4aifSUz1N9XCxozJFsQ8hpCtW46wE4qy09eRdSwEI1Qq713yo9Xeoe1vkghOLMTACaJ85P0d2Sluz3UvPvySQPEIto/YxRw=
X-Gm-Message-State: AOJu0YxdAIei5lH0IZR5eF7R/xDEshm0qvHgETOm5LDky7BFD+einQuO
	5lWGkChst+/zqZM05PsHj/i9iUL6dtJUqj9pEM3oh5UGyqOdMtdnbfiyJEmvEUwPV9JADx9jXfi
	cLO5Uu8Qc8jus94nnW4jhGkNQN4M=
X-Google-Smtp-Source: AGHT+IElBffJEeOauLX4UXPPLN2Jx0F+ZGsbZfiLRxsx8jMNo4SC68v9Cg8kVWKyoHFlsZq7V3LBJE/ZnTRjHKLfWsM=
X-Received: by 2002:a2e:a488:0:b0:2e0:4216:6fa8 with SMTP id
 h8-20020a2ea488000000b002e042166fa8mr11312003lji.39.1715080789310; Tue, 07
 May 2024 04:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240430175735epcas5p103ac74e1482eda3e393c0034cea8e9ff@epcas5p1.samsung.com>
 <20240430175014.8276-1-kundan.kumar@samsung.com> <20240502053553.GA27922@lst.de>
In-Reply-To: <20240502053553.GA27922@lst.de>
From: Kundan Kumar <kundanthebest@gmail.com>
Date: Tue, 7 May 2024 16:49:36 +0530
Message-ID: <CALYkqXpAj21_Cwc0_AddMp2ah2W+pWvcYPk=8_tn9Ke+Dz8RvA@mail.gmail.com>
Subject: Re: [PATCH v2] block : add larger order folio size instead of pages
To: Christoph Hellwig <hch@lst.de>
Cc: Kundan Kumar <kundan.kumar@samsung.com>, axboe@kernel.dk, willy@infradead.org, 
	linux-block@vger.kernel.org, joshi.k@samsung.com, mcgrof@kernel.org, 
	anuj20.g@samsung.com, nj.shetty@samsung.com, c.gameti@samsung.com, 
	gost.dev@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 11:06=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> > - Changed functions bio_iov_add_page() and bio_iov_add_zone_append_page=
() to
> >   accept a folio
>
> Those should be separate prep patches.
>
I tried to split this patch into prep patches for these two functions.
The main patch logic (folio, folio_offset, length, skip) gets split
into prep patches, which looks less neater than doing it in a single
patch.
