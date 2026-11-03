Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793714792;
	b=GEHoOoQ24tATxCdigSdnJcgh45N6vHtMRSrFI9NHKwD8i7P2qVcUh5HwmgepYInJ2VMj
	 j+hWUruU7FenGTYK3bimOGJ7M4npGNRdWSXvD0r4c32ITqae32td3LD5TMkNIeh/XXrJ4
	 7Cr1e1JRt8ikkjDGJoS5+Yu+o+9BqK/ftseJjRKfP07B+GTJHElfkObHPoC1ZZ9kcJhjl
	 LeZfUct3fcnlG9VBo/r1gDc1BwEhKtvoVx7sih6rVnPFdb1DPzMKiVS3w989/jOCOOuvs
	 LZnCx1HEPXezmiFgHfmT7xk6NttxrmFwa3mov1Sks6NdGU+pyQQQ6AOuKT694J9mkLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714792;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rXy+hT+GwvN91RjiAPqGZZe7u+gyV8gNKc/Oopg1PG0=;
	b=3F4/DPQBaPf7dJkbQo+H2AFyoI9ny17NYrJT06lK3h1u5ataJTnL7LyKfKDrDJxvSkl+
	 muY86EyT0CRkDoB52v7VCuF/F5eTTMqqdcepE5XDuHGfAjJuLib7vfVVnzkO9SwqjTdet
	 cZen9tPmyMSisy+DmyVnyQQZyDa4HxgsomFGhVmnYQnU+44NWOxsRZPlD4CMeePkkpPWH
	 UfpcnHnyeXEpR5LQKHrEyH6TeIuCnRdVigdIHaG9sJO3XQSUnKqpJSF1VynR1x9NvvhBL
	 zd2UBHtn+dnRd+B1xnz3Q+EOSUyNl+xusWbCe9mv/WW3LMcV0rvos3eZw7BCyPvUhIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnhRH4q4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5E1606EE90
	for <linux-block@vger.kernel.org>; Tue,  3 Nov 2026 14:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA5E1606EE90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MnhRH4q4
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8479f46ecd8so1784292a34.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2026 06:06:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793714791; cv=none;
        d=google.com; s=arc-20260327;
        b=PNkxMD4t7vcmJRCH/wWa5W0zPanosCUrtFwnxSE5Tra513OdUFTOE5FZzq4AE9OSPe
         YB6C596GLiFa6PEkIFgfqeDyar3+907Ctg90WoR7+vRpZOzRqcu3RXCF512gM+ZOPF5+
         ohgR1K1c8nxYh8lIyBR5dFj7XPLK/LjvarnAmALU23PWgL3tPt5IXG55d1gLzYpp2SE0
         EXRW8a/YQsyC+ihSho4YhEn8njbYBvjeXpFUuO8mc1NVA97uQDCy3RjqMTXxpApjWPA4
         /y3J0pDoe5rhqDpZZfoi3bNFZXnOggdWLRaZPNt3/8v2UE3i3KefV6y69qdbcsNesiZ6
         Bmmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXy+hT+GwvN91RjiAPqGZZe7u+gyV8gNKc/Oopg1PG0=;
        fh=efriBH/i/wSQtDGfFYqKsq9GAmPdnzaSnls9I0ld48o=;
        b=mCjHRX1uWnkPvi8efR8H+do3fgl7smOXapx68x5ifYB+mJ0UOFU65coJhDHIe0r2T3
         4a+JU1rBEVBVeYYUqZ4BGxrllF+KH1SDUwjI0MlPEfq48PvIiz7GYyrcvzvZbD8H7wtl
         gtxjyi5a9PbPkhBBUeH+lv4R8AL1VGZhAwVeRN93sTWxeqzi7yw4WuSMwJOw08Do+lcs
         R9zwXPBvf0ehOAdfX98H/hN+Zswp95Dkb0cF5JtYldxO+rU1A0VWQvVsiEuorrsqeo7Y
         gp2LGdJFZ3lJTjv9SJ0/d+G7aOy4Wmmm241+O9uumu0lpi1eXrWf0/DdqQrbM1AQSvma
         uFuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793714791; x=1794319591; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXy+hT+GwvN91RjiAPqGZZe7u+gyV8gNKc/Oopg1PG0=;
        b=MnhRH4q4kEx7MQV7Rveki/MdNDXRe1zt023+RsTRp9ZgP2RKoKBip9q3+52kK1z81+
         J+SrpZbE3mPFTr97SFKGpBZHbx2vOHLztgUKJGNuDoCwkJa7yTfqOJL/+WbeeS/kj6Lf
         pop1st7WFkcaMg7e7KhcGXiN9gl8ISnWW1X0PnpbWFA8dMnjYUZna+T2K78K7QTg0aXP
         APg9pg4MSSJPUhy0peHKAU4G0leLOdzbGiCRXqtqerLqxYGt7OKn4L+jaiKAua+u6Ydn
         tfKdonCTEocezY9or2iLYhuvlK+OaD36riqELJfDrgMaQKK93Ehu5Otc3QT1jmTtlhhY
         3Wyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714791; x=1794319591;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXy+hT+GwvN91RjiAPqGZZe7u+gyV8gNKc/Oopg1PG0=;
        b=1VTYQu2hI9ifM0l6Z1JSuQwrSV679lb5JipH9Ns8XRKlmbCN90dDq6NyyLA8TF5qIu
         LWG4pQCuipL/4UmyH2FrwDbqPantUqJetsVqINaSC+prZekwwAzVxyHjTpxNraWYuCwa
         NLqUXKa8JjpLCdrvVmMXpBpVcQSCFeYb62Hh2p/G4khESlg/vUl7Cz+IKIbitdPeouCj
         H//AcwxzacAXy9gRiMF8bHQfr07B7UmoGmdjRbaPzuoPpe1P5K91IP7Qc3A5F5BtX08U
         Sd6/ktUOuJvwnBPrkCJsH71qjXsD3rALkZzV1/+qoI8ZTUzTAX1UozNRIu5BlQj1CGd0
         VkSw==
X-Forwarded-Encrypted: i=1; AKwUvBxbkQvUMK1hRUJCwHsSQ5lkH4jxgabugtNha2STWoK/UpPdbQvyacjwojjs/X0TaFRWY6ClKNhSBDjznQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/aaxv4W1qX6czl2yh4yENbFOSy6RIXBDxRPKQyq9PqP+tsGViF
	Y7QGD3+O2HxPxPZZEsU4tLN6KAHZwFN4XBnCrIRxw1Zf84sCiW/p/0PdcBYE52ELUdFV0j2kRBU
	uXk4jjFOjZNMfVdyRg0TP2AtdYbmhbaE=
X-Gm-Gg: AYBFou2BaxUMpkHloUtD1bRSjbSrrW4QYvIUbxPEyTUjPQaYoisU+rmi2SdQ5HQ2eEC
	y+MILMw7GwlLCOWK4KrYr5re49fTbAGdBKeM0LRWLBQ1JMHVAGAkZ5PtHskcbP1CXUCOMYs52KQ
	hpDiqV72bYoegmnhR04nZnnJV8701KN0ukQnmYayV3jX7pwwV0lW9Cj5rPSB/iMGMTT+dpqrSFw
	nVkOxxoYKUzswBcycBlbgyE7uQ3kVQ8ZXwG4PjbxB7BzH7mAEnjkmbqo/aIbK8VaZxTiDk7AhvT
	p8DsrrGNAojbSRoSF4Oe79aKju4dRn/MZ1TvLtmC23fQTCEBYT4Cdzx1m6bMyCoo5dh7CgFf9A9
	Vgv1G91+Paspt6cIBWWo8zMiBlpFLE27Y5tKLIRlKirkdPllY4CKP1ubRKH72TpaPv/22duBNjb
	84tfL3fyJ9eCVO47b/05LpSU3hEwf81epZTDuH
X-Received: by 2002:a05:6830:2647:b0:823:e626:2765 with SMTP id
 46e09a7af769-85d36641a21mr9639694a34.31.1793714790698; Tue, 03 Nov 2026
 06:06:30 -0800 (PST)
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103130131.4069212-7-sashal@kernel.org>
In-Reply-To: <20261103130131.4069212-7-sashal@kernel.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 3 Nov 2026 08:06:18 -0600
X-Gm-Features: AclHuK9jA1t6T_L1_qeaqjfhfdt4HQoTqtOL_ZuGwvDN3vPKQfefu2TCWCSIAkA
Message-ID: <CACVXFVNhw7HP7SkR-1aokfOguBprsSdGBPtkZ-DyZssz4XaVAg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/ublk: use the configured kernel UAPI headers
To: Sasha Levin <sashal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>, 
	Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 7:01=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> With generated headers in an output directory, the hardcoded source-tree
> include path falls through to distribution headers. New ublk flags and
> structure members, including UBLK_F_IO_DESC_SIZE, are then missing.
>
> Use KHDR_INCLUDES to consume the headers from the kernel under test, and
> add the headers target as an order-only prerequisite of the ublk
> programs, as nolibc-test does, so that a standalone build installs them
> first. Baseline builds fail on the missing definitions; GCC 14 and Clang
> 21 builds succeed with the output-directory headers and target liburing
> development files available.
>
> Fixes: e371b9d3368c ("selftests: ublk: kublk: fix include path")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> Changes since v1:
> - Rebased on v7.4-rc1. ublk_cancel_ready got its own rule next to
>   kublk in the meantime, no other changes.

Reviewed-by: Ming Lei <tom.leiming@gmail.com>

Thanks,
