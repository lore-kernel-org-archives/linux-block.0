Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AB26461F
	for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755537529; cv=none; b=jr5YT+z7Gg/jCWXj8gK8o1mq27r/+aVnbBZFCogtgzi5rKKQQ8a0OUmOLSukVT7Zaaz/N2J+UJN4lnganTHQEtla6WxkDloCXshZFrZo5uhM3MAIbngcrWno3ob1zwiCYX6E3zXiDbfX9xcjwTZsHZCaOStN9S4MmrtFXvYx71s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755537529; c=relaxed/simple;
	bh=I2Y9f6HTNCdz/i8iZn+y6eKyu1wXCQbTreQdDmi89v8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uAMTArC8djw8qeptmCx6jx1JULHd6rEY/7kqEEK4TtUhEHUdykLIfUXp6H32M9xrmPdwukQcSv2rfeWeHYBhogjSV23bIP0OY2lL1zCrJm1l3JBZ63xdpQi7md5Y4wSN5BDaI9QG0MULsL99a7FLYtGijszQMKZux36ZJuQ9SVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rtFfBuxf; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rtFfBuxf"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3e66c013e4dso5093755ab.0
        for <linux-block@vger.kernel.org>; Mon, 18 Aug 2025 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755537527; x=1756142327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2q2GiRwCyrStVHviQb75voz5g4GkVn0PiT/uA+RUvCI=;
        b=rtFfBuxfgmi1UgYuQwHRafH9AqSEsisBDF19CEmWi4f8bYDVSsgcaeZlJp180fleD8
         3z7hiDNzgtMx7DDBYgCVNDm8WJKuCzQdTgzT+tXdePFMWV/N18UotME1jOMteccO1ed3
         TEP7S+i0zvIMwrjne//YRPdRAE2D6pRQZuHhh77Nol1g+XxSaV6l/fVUYEDKhOcjS+Fq
         ovo+ybeFdbounCC8A4yJ074RrMKHscl0ukhcUz2RUG5U6U1YWFHyHFHlXZ8isi9PTTjz
         VSbOSFBFS9muuQMgGVyFzS1XGqFBEXUsvxykvmctHICC2dXzhfPGIOmKdDCe4i2EPVE7
         NiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755537527; x=1756142327;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2q2GiRwCyrStVHviQb75voz5g4GkVn0PiT/uA+RUvCI=;
        b=mGva99wVOy0lnFzwtXavtje5Ryn1xL2iqoaac220IWucLq+1lY5DB1mpw+6/uqU3GM
         tVdrF772hHgyF7QaclCRmmZ/YU2Lq1AKFzz4n3B8kHM4CBFP0QRC0gwM+h1pjKp5lRjj
         auqFs5Ipe13ENf+JHhzGeuKiy9LV9ET7uOriKyigAQjIVwhMFU9rEIABMPw39KuEKGbs
         tOpUGA84C4DbyDPW2fdJOUv0KjAVUYIy1ma9YAqlxpzg0+jVqqyBF1j785Al+IoVGkac
         lyeiadAGXhTN0oDW9gSdNCDKNjrLNZv48C9u0CUWShfFWX1YEPNaJLtBou/2bpG1Jl4K
         9Bug==
X-Gm-Message-State: AOJu0YzN1afgTvR4f18nZ5ZJ+Qxmd272qDw2EpomwZQQ88yGzYKvbmMu
	GxXmNVQQFNbsV//9Sr3T92Ty79EWPkcVNtX9nZO1YnFl7yZthN/M/ZYWwLSh6MkpVy4=
X-Gm-Gg: ASbGncvWFv+NRnhkLnR0XCR0gROtNEdzc1vih930nAxb/dlJEbLgs2fGUijPleG7M2K
	DNer+GraHygXAco1+KQ79r68dU+RSkp4wMGCsmkRiLyLNyXMjlP0SgeKgQcFjn1qsq3UvyiGf8d
	FkajlXECOCXgmhaCEtciJGGZfEAvdIdyluLz5CxdtbRz3mJ7h9Sr0g8AeYqPp+KEf4kLbpItC/i
	voBga43j3L0VH0QJIA0dcti2mvbKMOT95d4maVqzwIJFZzNcUGxOMDTGDfSyIqFPOfZ3bWll8cu
	23u0wyggUeF25SfuPg+xHzeEE0Qj0vPXz+MS57xvIPgX1b2ut3xxHxQ5khYTbfyzp/8umPsh4CR
	cK2YhrLmRaIhQEHUIn1S7CbK9
X-Google-Smtp-Source: AGHT+IHbtat8NIcMoxtMIiLgN6Bnk+HqyIo/IRxl3kjOH30/T6Sd64G/ZSakOgGR2pysjZYeGvl/sQ==
X-Received: by 2002:a05:6e02:1949:b0:3e5:7150:ebf6 with SMTP id e9e14a558f8ab-3e675014028mr5314465ab.11.1755537524467;
        Mon, 18 Aug 2025 10:18:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e57e58c321sm37866815ab.1.2025.08.18.10.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 10:18:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, shuah@kernel.org, 
 Akhilesh Patil <akhilesh@ee.iitb.ac.in>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, akhileshpatilvnit@gmail.com
In-Reply-To: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
References: <aKGihYui6/Pcijbk@bhairav-test.ee.iitb.ac.in>
Subject: Re: [PATCH] selftests: ublk: Use ARRAY_SIZE() macro to improve
 code
Message-Id: <175553752359.87011.5736670614642029375.b4-ty@kernel.dk>
Date: Mon, 18 Aug 2025 11:18:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Sun, 17 Aug 2025 15:06:05 +0530, Akhilesh Patil wrote:
> Use ARRAY_SIZE() macro while calculating size of an array to improve
> code readability and reduce potential sizing errors.
> Implement this suggestion given by spatch tool by running
> coccinelle script - scripts/coccinelle/misc/array_size.cocci
> Follow ARRAY_SIZE() macro usage pattern in ublk.c introduced by,
> commit ec120093180b9 ("selftests: ublk: fix ublk_find_tgt()")
> wherever appropriate to maintain consistency.
> 
> [...]

Applied, thanks!

[1/1] selftests: ublk: Use ARRAY_SIZE() macro to improve code
      commit: 0227af355b50c526bf83ca52d67aef5d102e9b07

Best regards,
-- 
Jens Axboe



