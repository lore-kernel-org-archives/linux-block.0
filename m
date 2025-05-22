Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31812638BA
	for <linux-block@vger.kernel.org>; Thu, 22 May 2025 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747902027; cv=none; b=HQg9qq3g42psvS2cztXD6dSD3zWRnM815E9Le+zYCZfvnR0qTZd79UtWtgNRCuOk53Y23FvUC0BIRVvS6IUXAZZH6VLgLo5qDlspIYN1jvU/imz+pAeyDQXfupZRZ24dN8l8jn83nytbHVo+iT/KJE/3IlEzWFVbb3SdLWd7Oz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747902027; c=relaxed/simple;
	bh=xjzrahvBpcKxk7wXYhglfUlsunK5xKhmahzvGBnygz0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tp5Me2FY+bHsSVREBMdL5OzjK0pVW+YZoXfbLfFy8WjAFk7CvUeow7MaXyJucdOERBiKMsLy29nk3WwD1XvK8yKkcbnAN+WTCiRKSYZvh1K/bj0JamokJXdjS8Ucm91+SYU/dRbEyRn/ozco8QvshdzfucN9FjciLc0g74YgvpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=UahKmO22; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="UahKmO22"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad52d9be53cso950478366b.2
        for <linux-block@vger.kernel.org>; Thu, 22 May 2025 01:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1747902023; x=1748506823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=I43E9Used7ZzOVDhq/ufhep8eOi1ZE1QL/P9g55nGak=;
        b=UahKmO22fIkO51UyyFN4jUtjGuxLUeEidDkJD9VWqKHoPjwO7Q+/UhpZT8UzTU14We
         xbX8doSz2GP1AcMtgfa9kTT/34OpMv+owKUjvY3YnPvRUS2Wybn12XjC0VArJCbpKPQT
         9Co/zXLZAmbC9nV1xYVsaPRKl6upUlw3SP4ck50p4bEbQ3svchivVFi7XPwnRtwwH0nt
         le98YAfBd54zh4PnMNUyDJryt+uQeQbiac095VjFzpZUQKYWzqIUqUWPeHOl1Lp2PS9O
         qK5ZxIanMAcT3nTWsfbH9xbfQ+4WX6tfAga82FIXSct67rBdgLhozdlRtBUQ5+29EsTd
         5kCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747902023; x=1748506823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I43E9Used7ZzOVDhq/ufhep8eOi1ZE1QL/P9g55nGak=;
        b=OPOM8OxDOqknkfycvWtYvtVTjJzw1RteELJARIT8meyneRBHWBYrkxX5TKJeuRhXiI
         MvnLaeuBQIWZtAovp7OqI3jqkSXpjfAB9Lak3BsH/6kiK6qkLzfHF5NxgLIVutUAqhej
         3xth3YFCAb4p8Psnkglo181aszh0TcGJfVZQzzJpOQqKR4w2+JM5+qATetsRWGUXsxzR
         KhW/aVoC8GQHPM7GCTZDIYbDjXmPJ9D28Cn+iTuDnb+gZArY9zcLH02o53A12/09z9La
         hrDgki8Dab7tEXbmd7bCgyab2ymKTs41Is4bfKwGap46XJ8RTbzKeAQ03ao1hBSaZ/Ei
         Acrw==
X-Gm-Message-State: AOJu0YwdiiOZeDUSMPjaaBkZg5qOijKM3E1UQDSqWu80P9fWnT3ZaXwe
	pJfaBNZm3bxA33cI0gnm0X+FBnXqc3paOqLIFEd2m4+5I2OeFQHVFs5YAnuUPx5OUC09OANV1ew
	UtPbbckDo2w==
X-Gm-Gg: ASbGncsBsQievB64Kh383DGhbGItA0/GNYowU+JlBqVFEa51SFLmDJYGfkuLbXPjH2K
	78C+2DYm2KUuzMqPfscHxJIhX+7RhjYC/6mPc94VXq5em4Hk3tiUSk0VT5GuXPsQOPAJe8Iz6Hh
	WMdSSgZGqzQVDKe4HV4yJ4bTMhJSQhG9yAXgpyxQu/4INSMD1AEbAD+MXLgsHGU8QKcl6GbQ6Zh
	H0GtgP8pvJZ3LawNTRrp1qx7PiLjsYKqejPLboiHeucWTLKbMy104hkdxSSJ35SJ/Y4O3JKMPOS
	/TcGcZonQ/BLyXPvYf9L+bLy8aD+mlduMDqrRPEaIeOZpeRCb2mga+rvbYz8EI51LzOU9iDoWMq
	6+xigOv3kQaSTWZsDoN3cSpc8
X-Google-Smtp-Source: AGHT+IHd/c+RlpU9wZSwKb6MHnIxte3dN22uhcNe9UW8PMtyUqFZZ0KzS+tArvGbttCUDJzPrSUFTg==
X-Received: by 2002:a17:907:3f08:b0:ad5:68b7:b0df with SMTP id a640c23a62f3a-ad568b7b232mr1504511566b.46.1747902022820;
        Thu, 22 May 2025 01:20:22 -0700 (PDT)
Received: from somecomputer (ip-046-005-029-055.um12.pools.vodafone-ip.de. [46.5.29.55])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad53603a399sm998546366b.40.2025.05.22.01.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 01:20:22 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Alpine Linux Persistence and Storage Summit 2025
Date: Thu, 22 May 2025 10:20:20 +0200
Message-ID: <1826170.yIU609i1g2@pliers>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

We proudly announce the 8th Alpine Linux Persistence and Storage Summit
(ALPSS), which will be held September 29th to October 2nd at the
Lizumerhuette (https://www.lizumer-huette.at/) in Austria.

The goal of this conference is to discuss the hot topics in Linux storage
and file systems, such as persistent memory, NVMe, zoned storage, and I/O
scheduling in a cool and relaxed setting with spectacular views in the
Austrian alps.

We plan to have a small selection of short and to the point talks with
lots of room for discussion in small groups, as well as ample downtime
to enjoy the surroundings

Attendance is free except for the accommodation and food at the lodge
but the number of seats is strictly limited.  Cost for accommodation and
half board is between 55 and 84 EUR depending on the room category,
with additional discounts for members of an alpine society.

If you are interested in attending please reserve a seat by mailing your
favorite topic(s) to:

        alpss-pc@penguingang.at

If you are interested in giving a short and crisp talk please also send
an abstract to the same address.

The Lizumerhuette is an Alpine Society lodge in a high alpine environment.
A hike of approximately 2 hours is required to the lodge, and no other
accommodations are available within walking distance.

Please note: reservations for the lodge are not handled through the
reservation system, but as part of the ALPSS registration.

Check our website at https://www.alpss.at/ for more details.

Thank you on behalf of the program committee:

    Christoph Hellwig
    Johannes Thumshirn
    Richard Weinberger


