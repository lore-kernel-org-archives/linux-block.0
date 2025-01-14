Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5244F1D5AA9
	for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736874823; cv=none; b=MS4SkPvyemnV2DUE5KNR/YXiCa8avBwSEFzCV5h+aH5hBDRSLHD5kuN6XbXTdXHHppJr80RI2MoT5yWRmOG7qXwNgrXktmY1FVfhqD91Z3aCd684ASlRP1JhX1rjTrlCpuFBogUm6wL+7XKb6ZQNFLVJnmqR7g7NGjg/LZvhCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736874823; c=relaxed/simple;
	bh=gQI6CCfd8g5MTNMTx0/NRVJk0C1yxZYv6Tx99XLs84Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dXavMiAenzNkWLxiLNmy0/G0ikBS963CvrudP9dRLl2ImO1qG4ok1ZuwL3yrQonKWJVEDPQ4Ns7fhihNpbtqOZK+M+GYn+V0PDbOojE7FmMB4ZzjtaSNFYUQsdviYDrmFw9Yt00AOuoL6hK8RIxID2LYcLoFJmjyDA+EsQvdy5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ja9tIkd+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ja9tIkd+"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-844e1eb50e2so201394039f.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jan 2025 09:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1736874820; x=1737479620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5L5624Y/MFuS1PHDTmu3tjaPQoQAj4aHAtRknoeXWtc=;
        b=Ja9tIkd+PKRZDw19+jlPgKYc6fPCNcIjJWaF2Ujbnrn9HBi6RYKQzc162cj5FXei6V
         HKWlvaKaTL32WLro2VbrTXuspNkicGCAQy3XKgtSFatAD2q+4iR6YNt6Pg9OGwb2TbQW
         rTT2+dYyaO6dLppMFfRQxcykLgzDZJ67czDhN7jTiiaPbquyKSiHvkvGBl6lbEGA3xfE
         y6iBveIH6qRyVBMog5W+TwWfksQffoNOuEMYncrHUZtYK9dRWsTZuhIi89p9uTzz6QD9
         txDbJZN539EkAGCnkOXDJNBzkiuFaDGPMmJnOh1B/SeZKw5t6YQr4mvU9DfFxCHRTmdd
         mzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736874820; x=1737479620;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5L5624Y/MFuS1PHDTmu3tjaPQoQAj4aHAtRknoeXWtc=;
        b=YaJqpSK2nyf3PKr9CcDUFgvLgC1u0JKEA5+zwg2p+M9K+AyVLnjsxnnuPzhM+Rri1f
         zgzau6ODHdJhsT4BIUAIgOgdf4yURHig0T2uMHAiOUs8Sa0xiM4ghtrzeEJSbLFBDZ7e
         IxyyHLkynYLaqqU4Lw4VJ78k0lG21Qn0T3m+HwcZgnddHmVZekX0IBekjl5xldVgZl6A
         VtKw0plmRu9HB4/1U4tQEyQTsOYXEEQdbYXaFHWVYqdwl/qabUiiLKzXXpfMUoA9vBOa
         4lIsnb79spnvXsDSgZFhhk8oJZ5tIiGae7WxM6MQqy2UdywcUMVrO6lQ4F6CzKJZ/Tmz
         2TKg==
X-Gm-Message-State: AOJu0Yz0OuwxZDGb+2v2JuVmTDgtxurwRgO8V1qgVPYqeaCbzWyXlF1E
	PNuDZPYHEELCjzAMrrj5KpEkPu4h2SN73gT7cdgORdLt1fikLel2qrIDLSlc+rUB7ftGwXkZvIx
	B
X-Gm-Gg: ASbGncv8t11NJkUZRvyfLW3OA38Nky0xdZ0wnbW1HqtzVXtO7vjVhZaWceNKEm3lCT/
	l4tHK7ReV0D1Su/6R/xQreVipRsESjAINvBLBeBL0rKolmTBcA5v5Jmz66w4YNfQ8ODFyHU+sYL
	hD6tmo4L3W/xdG4CFbM77qlVA51u+G/i4EmajtwHr27Hgkkyduxb8W/FQvaorwJv09/IpyFYkBc
	5JV3kYs9s8hmGuTspbZbeD4SJP06SWav/KfAURI+yafScU=
X-Google-Smtp-Source: AGHT+IE8qeV4E5ODG65Duke1pF1DI9jlAJkpK6AFZ7QvNTq+xT4TYTN+9AfyjvYIr+FhAbVWOINAeA==
X-Received: by 2002:a05:6602:4a0b:b0:843:e667:f198 with SMTP id ca18e2360f4ac-84ce00488afmr2254177639f.2.1736874819920;
        Tue, 14 Jan 2025 09:13:39 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-84d61fa444bsm343080539f.34.2025.01.14.09.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 09:13:39 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
 Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20241218212246.1073149-1-bvanassche@acm.org>
References: <20241218212246.1073149-1-bvanassche@acm.org>
Subject: Re: [PATCH v3 0/2] Two blk_mq_submit_bio() patches
Message-Id: <173687481897.1295933.11460807376107814962.b4-ty@kernel.dk>
Date: Tue, 14 Jan 2025 10:13:38 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Wed, 18 Dec 2024 13:22:44 -0800, Bart Van Assche wrote:
> This patch series includes two cleanup patches for blk_mq_submit_bio(). No
> functionality has been changed.
> 
> Please consider this patch series for the next merge window.
> 
> Thanks,
> 
> [...]

Applied, thanks!

[1/2] block: Reorder the request allocation code in blk_mq_submit_bio()
      commit: 44e41381591dc5b4ea67a9f170b4ec85c817586e
[2/2] blk-mq: Move more error handling into blk_mq_submit_bio()
      commit: 659381520a3b13403c3051516317adc02e48259b

Best regards,
-- 
Jens Axboe



