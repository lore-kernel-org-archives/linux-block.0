Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5F2E3381
	for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 12:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817571; cv=none; b=Wso4RVvATrKWBko0EGaMC5hAB5KTmxBIohdaSt6kWjB6RGVaLtr529J3cnj/V07ZoI37Za+SGT5LzQ0CpMZgtrJ5+FzkdqaNH+zScQdbYUhHY0XUxXWNnmGaZDD7dO1YCbFobZiv8QCXT1NJA1YPAhF7k2rbg7OxrnD4TfvCHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817571; c=relaxed/simple;
	bh=b36Cksb6K24TcQQ06TofdjDlLhPk5stFyFnU4B1CmtU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fmUcdHPZFXNm/ytag+1VKiuN6Thlma2jSSukwqJheUkLQ9QD6Xg0ZWBRF/Bv49gEsWecokWqPuMqINZGmAOcak7lb32uNC2Un7D9N7bSUT65vR3L0K4mOjUy2fK+x2auoWWFxdzHdcEdx6KAu4kMXnvELdymWFSx7n2P8OIKI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ef15xdRE; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ef15xdRE"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-735a53ef4feso1253698a34.0
        for <linux-block@vger.kernel.org>; Fri, 13 Jun 2025 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749817567; x=1750422367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tHRhJFEmp+pQCJo3Jn9wzl7EnfzSXqa7eI66lHlTG0s=;
        b=Ef15xdREtu/ItnmgLNPg+knQ1ds3VOdYgvq8+xpG7TOH8y8AuBupUYpAOSLlKhWaW9
         2jxe5Ql8Smlujo3iTOHNmjDrJ7IgSooaUX8YW1vMPB17c5lc0iSnj1YvJMJc8rsLxRjL
         RsznHgl9BzkrSzWBIq06PdQ1UCIU5ViYImVrtvcfDXNlrpJuqKb1eRCARxTDAdoo8T4F
         MWdO1yZW57jhaYs3LlFvY/WSTJzoX+89P01m5RUbK2cFknYIwEzwMnZdw80qks1Dh69a
         gh0PaoLHtKR187pIb5n1QSaQXFXvG29FCDMD5dtUvqfR5P0WPrfRnCgFTFfI8BLXdR4K
         rNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749817567; x=1750422367;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tHRhJFEmp+pQCJo3Jn9wzl7EnfzSXqa7eI66lHlTG0s=;
        b=w7yalEgeJnzN/LeZHaw/mPbBXwZpdHE3tjn801TDYrItux2M2IsRlD9eu8Xk50w9ss
         bUEPGlKqCTZeyjRz8SuCXzEZw74pbTI6l9Hl5Fl8rFjfQZpp38GEemvADDCofvGOimUn
         AUQdLRKyYsJYNicqedWT0KneuDZoBYQr+U18uja5qTGpxGOOA+07/UhWAzHcp6e/nL2Q
         eWLUgg7P40UeubHvF/7PZaArBjJYinPyYy7Jk3/R/EeyuRVhbi6vUgh7QkVdc5euLe54
         TZ8LZ12R/QFPCLE7nRGvwzzljeqHN0JcHEaKDs24NaNwqFcTXkba6sbE3jRkHYqaOcqk
         G/rw==
X-Gm-Message-State: AOJu0YxaqQCjMcxMtJlKb2ZkGSaEkKJWO7HlxkxZ/0m+MO4UoiY6ChTI
	GIk9z6ZSqt4DwlSIzABN1CSw0TUaKhRxuI9tBn/fztxQVjhaJX0C6cGTYiqASL55eSYQ0uO0mGl
	RfVTG
X-Gm-Gg: ASbGncsYcaWHdjL8BNed/366re7ptWIuT4jKxwfROnjfwAj6hpr7tnms0Gz86dHwtx4
	ne61uMxcyWVHovZU4bPgW1rxzHcEb9p+LBb7rCf9WnYTdntwm6EkoA6Cg7nbLoRGSCguK9VlGme
	VFuyp3WvEDQxfkGd41wRxt6maPPHhDZV5CHvWQltI2agwqBR8LxFyjrL53v+n3jJksUNwnfw0uC
	fzZJ4MsraxxomSuYFSL9XhSsgZC2ol51Pu/5kJOqKWn3p7OV0c6uzJgZAJN5keDbL3OpAjMRbcs
	s1X80rhqM32PRq9tCr11P0wLxgmq58hVtFHoLgH8ICFcyriZa3MxvQ==
X-Google-Smtp-Source: AGHT+IEure1Xp+tU0Vz/T/Nn8tM7J3yJ2vPvvxpbKmZ4H/HIw26vpk9uvW/XaK1iDWivIaU8qWfxhA==
X-Received: by 2002:a05:6e02:3a05:b0:3dc:87c7:a5b9 with SMTP id e9e14a558f8ab-3de00b9c3f0mr27866025ab.10.1749817555775;
        Fri, 13 Jun 2025 05:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149b9dabesm279101173.48.2025.06.13.05.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 05:25:55 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-block@vger.kernel.org
In-Reply-To: <20250612144255.2850278-1-willy@infradead.org>
References: <20250612144255.2850278-1-willy@infradead.org>
Subject: Re: [PATCH] block: Fix bvec_set_folio() for very large folios
Message-Id: <174981755499.676900.1081366053095435282.b4-ty@kernel.dk>
Date: Fri, 13 Jun 2025 06:25:54 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 12 Jun 2025 15:42:53 +0100, Matthew Wilcox (Oracle) wrote:
> Similarly to 26064d3e2b4d ("block: fix adding folio to bio"), if
> we attempt to add a folio that is larger than 4GB, we'll silently
> truncate the offset and len.  Widen the parameters to size_t, assert
> that the length is less than 4GB and set the first page that contains
> the interesting data rather than the first page of the folio.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Fix bvec_set_folio() for very large folios
      (no commit info)

Best regards,
-- 
Jens Axboe



