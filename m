Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007F16DEB0
	for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 20:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766520229; cv=none; b=hoMMMlYgYEJgBL+7I+JO/p1cjnEwrSMnFzwVkPlYOHZcefM6NCus23aUUyYMQ+Na2EmLw9OpKNb3lEQwum8zwtGz+1lyPht2L8WsXY7wQYTkqqd+EUhwfkUELYPEDwe6g6oWwC3OTYN0zAGEIEPX7y4fLh+SlKJBSBqSA45QCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766520229; c=relaxed/simple;
	bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5xWOB1LL715Ys0uFsxgpedErB8rzJOt5mmmUe+4rKbaEc4nlxIfzHpcNLLkJEibcsmgbz8F9ehErw4H2gZ2aJPT6OmM7rVy44Q60TNODkTEMqqtBqEhqW01lXIGBerHYq5oBPWvLWWAI4QSowekgdxCVvMNtnG6+kQGpM8hQLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MLMwxp/o; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MLMwxp/o"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7c32c6eb79dso350209b3a.1
        for <linux-block@vger.kernel.org>; Tue, 23 Dec 2025 12:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766520227; x=1767125027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
        b=MLMwxp/osmLovVn0YNNEHO3LMWMGDo0dtwQr52ZvP3Jp/TwraAtvUVn1+WNm33dwBD
         ypvlTtmVLPck4I7Wsm6dAg1l7AudN1AgODexfoVQhAeG5vVoD74pbuQFt0KQvY95rbwR
         uWIMiCSrBkNJvUXttsnHoYGwzlzCknC462jOTHCCfu7EIYjGeyiOR22Ozs3LDjqfVNeO
         3pnCGHDElWx1OD8N3VkAs0ehWsh77ausLN/+M/bc22evdgqyalgcIhMIBT7OetVecYTx
         QOg8vhMi/S1dSyJxpsxruDgks7oWJa5sY0L1WgYVXOc8i1g19jDActBIUgurTd//ScrZ
         1Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766520227; x=1767125027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EXQmZ+ozp92HfDFtU0evQ90fcQtPfdOWiSV8UAQt5MI=;
        b=LtJrcoYLeO8w1VhGkRhIjc/qsmHb1B6rqX0FGN2lPky06MAmODXcQ3N2SJcmfhuhob
         sdn1USg+jHQde6GpQ8zDRNZ3DQluyg/wxniMjOF6c54JriQ97Xdc23RMs5mkjTPEEpWi
         POD7VZpFbWeAKZ0o/0eia3gbXcSF+uxL9EmiSkQmje2d63SlqBNeY+yfxJiO97Vfp6jZ
         2btJv3B2JWopy8xX6fPfDxZMqs/fH3x8/HmiUuZKQn8DSK161SXLZaDb9QyJS8W3DyWy
         AOHdn40dXNh18sBrJTMK5N62jiSy//L/upDyrocCYh7LDiknAxQGA8vxCMZg4fhbL9/H
         bZOA==
X-Forwarded-Encrypted: i=1; AJvYcCW2aJf4sDRhYi6vBtM8/KRCGC4DKjoh7W/aS3hlTE5b+NYWG2VjXcWvDUo++N0zXi2dFppL90ZC5EQ6JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9ehanV34AkiF89a5/L4N5jIPaMGpiIuVBG55wl40ef/XC4zqP
	QGeSFDHPjyPYcZItB/+qrs1TrrdwTq+n66wSdHWW4rGuTgXPOmQP56Dc1Ui5x8I8hyBhlbJ89xz
	nhQntIVj9dlbqHTcumiAWq20dPMKZXY+kMNYS7rHklw==
X-Gm-Gg: AY/fxX4ieVUENVuqsOno7+ioUEQeB0MB/WM9r9sBnAurcOPmHkskbpBY4RXtZuPxQFF
	HYzmzJonkECpcbIfYO9R64x+JOQA8OfgWfDsU6krhwqBprxGnDAUEGhpXFJdK6dxZ3+geRh+nct
	W6R9z/2n0p9b6qSltmnMR+kVELa7+g1H1HoiXy1MTkr++8BQEOlaiA0+tkc1m9L03xbe4A1rnoV
	ItpHc5vf74bRQn5x/DdRM+2gm45e7EaTbJQTyfdDPEVHJjqkQj5cexz+CprLDGmqXz8K4M=
X-Google-Smtp-Source: AGHT+IGEI2UFmVAB4gllSBCn35IWH7aIKwKwDq37q/Gg/8+joJI9uLy9sV66UHOMqlihr3VacCQHuLlnSQLFMc7ZjsI=
X-Received: by 2002:a05:7022:698a:b0:11e:3e9:3ea4 with SMTP id
 a92af1059eb24-121722ec1bbmr10272339c88.6.1766520226788; Tue, 23 Dec 2025
 12:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220095322.1527664-1-ming.lei@redhat.com> <20251220095322.1527664-2-ming.lei@redhat.com>
 <CADUfDZprek_M_vkru277HK+h7BuNNv1N+2tFX7zqvGj8chN36g@mail.gmail.com> <aUn_PVBQ7dtcV_-l@fedora>
In-Reply-To: <aUn_PVBQ7dtcV_-l@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 23 Dec 2025 15:03:34 -0500
X-Gm-Features: AQt7F2r9LaRDNvbGZXYzIITBheOEsP1_Fp83pg5yHWOiPm7yaPAaLXCI_g3bweo
Message-ID: <CADUfDZogz4ZdVQw5O5stBuheyX-D4CfdZ8XoGqiXBqdp1oQHQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Yoav Cohen <yoav@nvidia.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:32=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Mon, Dec 22, 2025 at 12:11:03PM -0500, Caleb Sander Mateos wrote:
> > On Sat, Dec 20, 2025 at 4:53=E2=80=AFAM Ming Lei <ming.lei@redhat.com> =
wrote:
> > >
> > > Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to sup=
press
> > > automatic partition scanning when starting a ublk device.
> >
> > Is this approach superseded by your patch series "ublk: scan partition
> > in async way", or are you expecting both to coexist?
>
> This one probably is useful too, but it should belong to v6.20 because
> "ublk: scan partition in async way" can fix the issue now, and backport
> to stable isn't needed any more.

Sure, I think it could be useful for other ublk servers too that know
the block devices they expose won't be partitioned or want to more
finely control when/whether the partition scan happens.

Best,
Caleb
