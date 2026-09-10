Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FC13CB54E
	for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789073734; cv=none; b=HHAIskigGmgpxazy2N6SRaZrIbn/aFR2wd5rSFIMyTfpwG4tyE3m5ZAGmSY/xv1CP0T84Jj3WNR9WqnpFqo/cWuztWuJd2mTVjeYMi9QKVSid9blNjVMlCRynMZowkDsCGqL1PHYXjWiPjtkW/0MBPYAPAiU/l/5uuVdSGwMvaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789073734; c=relaxed/simple;
	bh=t6ppwnoW/+SGU7+SZTpQCy0ZyrHu7AGE6vmt1IJD2Xk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e39PFKc13vKVtH0CWMx+cZnKyeKZNvWq+tBYAI8jUm73b4QwiKDHkoHrevU7FDIDG2tZ1s4OdCL7ClplgVrTt8ZMVZnrfIAIVdT5U8TeptPl5HPUkrjg8Molsh5eIjk+BtQ+V5Yv7W/vRlmujEiWHu3hcQTYpSjXwXBNxV4OFRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=Vp+7ZKLl; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="Vp+7ZKLl"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0cfb29cso140892a34.1
        for <linux-block@vger.kernel.org>; Thu, 10 Sep 2026 13:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789073730; x=1789678530; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B/R1OOuoA7A615cqKW89RYxj2atLZSBY/Ou5CD1Turw=;
        b=Vp+7ZKLls41ZsActN33B+Ko9uzXa5TmRUtTWkEuC65XqHFmTroSDd4Q32h22Eu3lYN
         gEyR64HkUMPmN2/MDwWfLwSS1+TskHgIHH++hUeGn3rbPLcHGku1OECfjpSY6woYvlf5
         kiYSXuh69eG+Q8R9PjFXyg6FW9ETbPrtwR+/WOt5+vbHKu1b8UPWV4Ruq/FUfpI25AZy
         58camd0NXcgJmJdpcaHNPkv4PrQEdW5UrAO6LsND17A90OIIVG9l+aNj1Fh9zGxui5Uq
         ZXS5bG0Ef5W8AqQh7zsBA4chfq8Isp7P79IYyG4QxyQwR2bXmwSVmvawk7t+vd6Q5m2W
         k/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789073730; x=1789678530;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B/R1OOuoA7A615cqKW89RYxj2atLZSBY/Ou5CD1Turw=;
        b=H48D20DKuPr2lbjHxjqgYZTjDyYQCrAaJk7bG/LHqmRhDWZt0x7jlLHj8M8gAh0Bkf
         6dEgnHXW9nQoO/9E9Ell3cDaNw3xjcuFhuWIbAe8NdNYvt1iNjqdYUH2QTLC4gArysN3
         ET/irTvP5FGiXY65LZpK6WqIWp/qLHkdCBtG39uzOq5oFB1/WHsJ8J1RleDeQB+bDBFz
         PgxjW+NC7ae6PDmHIP3JDyuyPrRwVaoe59Xy9WJkkAwBcf5SsEXR21MrsXpO5/3bb0Z6
         0xgcJxP/LhIrxkPFsOtMke92Ay0u+db7lNKQd7cQIVWHHjTxFEMLO4httneToR+UNxLn
         5srg==
X-Gm-Message-State: AFuF++nY4q2C+EC3ODQEgjAyXqteoCDTPXjpVLTySJD0g/OXuBmgKbxB
	Qjp/SjjuyP2cpXCPbi0egXdMgkOWn0zHdKmxw8ACfPW+kpcJX5QUTHlMTRvIhyKS0u4=
X-Gm-Gg: AYBFou1gZrOWSuwq66HxxGK9ljpfzgl3ZxZwXRZHR2uNSXELswHrrxrOhxVrEN17rQj
	HhRbXS1u/eHTJhP8jpQDG7/8wJ3AQE/XkCGaLInGut++BTDES7AVtU31lf7rRqAoO4DyASIhfyE
	NNoX34GvqEmrSdE7u1uGduuACdI9G/JMUk9bsUa3FqjSDcu54gRhU29XbJqZXN0L6t/fF4Xh5wf
	Rv2KfGx/e4R5VzhvjSa6i+qSzIlNEv6Yy6KBunQblMMOC2DabEliz0d7Xsun3a7tiU0dPrejJHK
	PybF/wYI4Sh0xpdp+2p2o/XMv9DgJ1fh5URMQZzHcMGxMDA3h6uwe49r5am6dqJMrMzqFgd5uPD
	ZEse8eGUzkIVxEVvDrCiKKZAx9Du989YjJ5dWI+yDvYNKR2Vd7LPmXgbq+mZWn0KhbI8PWmDSJb
	YY2A2cq5J7ES3SvgF2k9wQijAjDGIXNUDjcRMMCvCkTvLKjI2X3lrvJH1UnLI4UczBDfU1B5YOr
	7A1TJpxSFrcOLi0Ysdt0PheBEOqqHJXpydaDuSDsMUltMVWKCw=
X-Received: by 2002:a05:6830:2690:b0:7e6:d384:459e with SMTP id 46e09a7af769-803fdfc94ffmr847414a34.3.1789073730048;
        Thu, 10 Sep 2026 13:55:30 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-803f60fe54asm635779a34.15.2026.09.10.13.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 13:55:29 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stian Halseth <stian@itx.no>
Cc: linux-block@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andreas@gaisler.com, davem@davemloft.net, 
 glaubitz@physik.fu-berlin.de, regressions@lists.linux.dev
In-Reply-To: <20260901173947.3292110-1-stian@itx.no>
References: <20260901173947.3292110-1-stian@itx.no>
Subject: Re: [PATCH 0/2] sunvdc: fix silent data loss under LDC congestion
Message-Id: <178907372879.484803.7974471214841698578.b4-ty@b4>
Date: Thu, 10 Sep 2026 14:55:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Tue, 01 Sep 2026 19:39:44 +0200, Stian Halseth wrote:
> Since commit a11f6ca9aef9 ("sunvdc: Do not spin in an infinite loop
> when vio_ldc_send() returns EAGAIN"), Linux guests in LDOMs see
> occasional spurious write failures that manifest as filesystem
> corruption. The failure signature is:
> 
>     sunvdc: vdc_tx_trigger() failure, err=-11
>     I/O error, dev vdiskc, sector ... op 0x1:(WRITE) ...
>     vdiskc: writeback error on inode ...
> 
> [...]

Applied, thanks!

[1/2] sunvdc: unmap LDC cookies when the descriptor send fails
      commit: 0c6da21fa35e03fc74f09895433ccd6d4a9c3530
[2/2] sunvdc: fix -EIO issue due to lack of retries
      commit: 5067d4ba713961d8ccea1e06cd4c453793f3121e

Best regards,
-- 
Jens Axboe



