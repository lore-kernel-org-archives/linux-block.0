Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F2D2D839D
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 03:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770262971; cv=none; b=j/NYeRyGeF8heKS6xlEytnWcLdh9iK0ZJUhnTYyWe2Bfj5ovUI1IpnqXvloBtFAoyN79rpr3Ii+DNykdc0mPFtUB6mL9vkJVGP4oL38MbYlbufNSi+MICTmzWBOgSTJI0FrAKXpngPU+9uvZ/Utqbu/in5Wq3rsmURpqlS6hPTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770262971; c=relaxed/simple;
	bh=yTIiCoPaf2axh3yw/BOxlWdHS8hPHmnROAwOuIuJHy0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YSxkOF4KPhrRgd9k49cw3h8RKDxJD4RFMmO7DVDhaxFWIKsWQzb7G2EA8fHeB1lht31KVFoyDsJNgUYCJqSaG9XRViB0SRA3JIssv/aZv44g+B25eQKdo6wdC7dMmESmzI3FEF9xb/1SGiKTuaiSnhi8aL6Kq9iLfAmGtvgp6xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pLM6QYAQ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pLM6QYAQ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d1916d1e24so351477a34.3
        for <linux-block@vger.kernel.org>; Wed, 04 Feb 2026 19:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770262969; x=1770867769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8odmZP3AsmwWLVEEIesC2LXuxYRFDXqGBxQCRutSXw=;
        b=pLM6QYAQ5CfrvbDksf4Mmr3MPy2EfVQZ1L0qPsiGZtaGnPErGd/Ni6fr/653IYFbRp
         Kc8+qfHniWCFlpXqFTffcTgP1HTKOcT5CTLKCMOH0EUjOXdbJ5lCw6YH2NkQHNsnE4pX
         FWt882SOfdLZCaTdeHLU49v1/ZQ5D/lksOk12qEiN8Kxr4PVDSUrkGJf2D1P8gbEl6Lr
         DAXWfWNVOEgcyeuP/xwIvM9SO8F4NXvAV/GHIr5Eo9hLL3N7h3NJmK5sWt+J5bijidwJ
         lPGaxJg0sHTe2gyh2juXlV2b3xUuFVoGQ/wvG/nCpJ7wjAWihSngNyHrLD89/5Ap73uT
         ZxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770262969; x=1770867769;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=p8odmZP3AsmwWLVEEIesC2LXuxYRFDXqGBxQCRutSXw=;
        b=fkC9Jfw1Je95Ov6dejO2VVYvEeAt6Fp1QKsBBA+oPYLwZbOF3X0dUiIIglOyIeAu6m
         BaP+kvpeFuZg6jlKr7wYoqUHR57wBLdEHghY/ivBMNdRmxTupIChE9QsAaJXAD+y3+96
         MWBinjxOdCaFTTuZzrjIdnM3azCqZsM7f3sbgdTp5TgcYrEeaHvImIFOb9Q7MMEZzjGL
         uYEzLJgCzaQemlfl7bS22aY9/VkI0Mgnd4UJ27XaHW7wg/nYvEO4fHbVgiocym5HbnPV
         XiiNuHg9AOX6O3eYcgNB7EbNLjYaV0tUEnCIOsGPLcgyM3moJDj4xEhdVEUZGO2RW+2a
         Z7Sg==
X-Gm-Message-State: AOJu0Yypu7I9+283HELlTcDR/ZpdVsIg8XifGEtX9hQhbWGSMVck2Bt/
	eL/FsHN2s1JpiaK/82lXDRRRP8qYPakiAzFBl/eUe9qju4fntLKNiY/5BTeLn7DCF6s=
X-Gm-Gg: AZuq6aJFZX5CatKVcYYuvGfx7Fk6aPfH4LgsumsXc7v8ntlxYJP61M3akIEc5z97sQl
	WGGsPgxYurfiEmmqEeLVzlARTHdLfRJuyh0U5hrdekRhk+QPkyJz45Iobvty+Yg+fUBMghl0hUs
	0sYWipZqo0RyGtDO5+Oz21ynmDE78zggk5dKv2Rzk1ZlQ+dMK3pZiYCqNWnY/9oXQCdES5nF2qp
	PqZeUM3V7duzOVbRdA5A/rcREO0ykDgFfKe48uQd9vqn0W3gaIxce383vF8J3Rnv2AdPxU/ehGt
	HNlx0KmqlKZvOEER5NPinJT4gjQfQ2kQLLLmG9DmqWDqD5JSEwFn23nXLmtpNoxzdOz6bOXYcMF
	jujKkVuMkybtWaUNHtrJZ0yAPbC/Lppi2qHLcP1oaLXkbQ6AC877644xv0iao3p69sJSMRQLIpD
	ZHLEzuNljDzHl3A+LTPSURO0Z0p0BJPBXqbG3hj6yz7df4W74ZBWnq/D6mfcKNkiPTGPh8cApZ0
	ec=
X-Received: by 2002:a05:6830:3901:b0:7d1:4d71:95c7 with SMTP id 46e09a7af769-7d448abb460mr3043741a34.26.1770262969619;
        Wed, 04 Feb 2026 19:42:49 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4490f35b7sm2812181a34.1.2026.02.04.19.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 19:42:49 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: ulf.hansson@linaro.org, hch@infradead.org, ziniu.wang_1@nxp.com
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com>
Subject: Re: (subset) [PATCH v4 0/2] Optimize secure erase performance for
 certain Kingston eMMC devices
Message-Id: <177026296860.37701.668895586539274878.b4-ty@kernel.dk>
Date: Wed, 04 Feb 2026 20:42:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 04 Feb 2026 11:40:01 +0800, ziniu.wang_1@nxp.com wrote:
> This patch series optimize secure erase performance for certain Kingston
> eMMC devices (IY2964 and IB2932) that take a fixed ~2 seconds per secure
> erase operation regardless of size.
> 
> Currently, a 1GB secure erase requires ~300 operations (limited by max
> discard size), taking ~10 minutes. With these changes, the same secure
> erase completes in a single operation, reducing time to just 2 seconds.
> 
> [...]

Applied, thanks!

[1/2] block: decouple secure erase size limit from discard size limit
      commit: ee81212f74a57c5d2b56cf504f40d528dac6faaf

Best regards,
-- 
Jens Axboe



