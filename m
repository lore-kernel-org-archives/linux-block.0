Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19C1DED4C
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 11:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762515528; cv=none; b=W0qxmdhwlj5v7qp900UlqOALTr9EUUssfNXKan78GdP+5HVEfZk4+Xq56RkvXMU01wJnW+WHnSfFNG4Hs/PX2A1ztirN+BbrOX5tLPb0flee8JTAYBk0XECYfJqa7kZmJu8Ps86C8BjA4IKAXlHYXUGJ/jhYd6elkxGVoHwIS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762515528; c=relaxed/simple;
	bh=2Occ7zZTpN/Of5vcFlMGSUg6672eUXFXj5cryrAXF/A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SYqa30M5OF6uwCFU5dr0EWDFhPOfyRKr8GkPaiyU4zZPlwbCgiIjqWqae3CZPDymUMOgKvzjSCv/rjec0FK82IBYPkECHvVJE0qv0BKzi2CbhKNJmwLo1pSEXEPBbi9JeA/lqdzSjvquVqKWqdeyVuykHALe0Cu46ZXfpwLgx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VgfeEPHI; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VgfeEPHI"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8b22624bcdaso87032285a.3
        for <linux-block@vger.kernel.org>; Fri, 07 Nov 2025 03:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1762515524; x=1763120324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRQD5jRfTZhyNAIY2g7MjFG8bclA5Dmpji90LxZflsA=;
        b=VgfeEPHIvrSh1MzPkAO4e5sK8NZ+aweFyRmIbSrXvXngjAUkvsyPt1t4UyijYUP0dy
         Ct2Jt2qnowNS2R4pOaMJs5RgA1otmUuJOhyypuaIyYXF8lYiogqNVf/zkxTjJ8HEintr
         LlS2mELzCIylPoxmggsXqwS4u59z10VsmNpqj+rfj91P9FMXup9gwGTRhbqRHcZ+lsQh
         e86CJPKiA9Tf1oJE4y/cqDGEj+UrgVTXqkS+gKEE4/H/V7rrTonn+rB+4dY83zAJIMw5
         BfNl/R5dbavmBLSs28hUjMnC2i5bsaRwliZUGyzpnjWFgnGRSeiZsokzo551SetZDDmK
         WGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762515524; x=1763120324;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NRQD5jRfTZhyNAIY2g7MjFG8bclA5Dmpji90LxZflsA=;
        b=eXh2hZC7TKCaaPY1Jb1o33XE18KfGfuSoLgHWNLCaWvkNl9Ac4oYu9ta3PFTKxNqRy
         mCZbCtTOGr8zKrEivK+hlemA+XL2cZfMSxtmdLMt0AjgIcLWmYItf8zUSrdkdOEyMajR
         YF9wktYzgogy5bP7glQNr3+D7Q6EyV/FhiXZeMA82FUzD69tydokgrEtV62aqsOLbIQ/
         4EsMgCxvFuq32TH+g8rI5qjZMejjlhJxkzDtTIHPFYYaEn+P6cfE2VNdfnMygFskgPmc
         ocSmbdN/bVdK4CjEKZw0hPBrdkkZL170ibFaRrDjNM24TSuxXPl73DkdbUuNKZhiJbbd
         wD2w==
X-Forwarded-Encrypted: i=1; AJvYcCUPQvPkr0ePce3MeB/j7hD0cqqWniXSGHOo3elmdZRQ4t9Jf53wsQQvHME2OX5q+imD99p03S0HKJ/cVA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5NkMVt/bmoOjM8NsLQiAI3wLutDiCvF73lhjKEoOM91OJ32Fs
	jm7/TZ3uxozQsgkbdIHgIkzTUV5BXXOX4NjvReGy9HRtqGBwz8DM72HDirgo3VTY04URCMuvO5r
	qVF8R
X-Gm-Gg: ASbGnct8p6Z0wIiqDjNQ3/XD75pMdrnjbxx1g9AV/SDO6f7kSd/tjtQhSt8Wt8+OHds
	lX80S33iZ4gno0sKNL+g5KFe8rufvvgHp/B2tr3NRIA25G8Z/RKTpko4CE6U3TmEvg6Yj9Yh9xP
	CNdxW22f+eJ4xTNIMxUbfUTwMTQrRrYS7aBowFoCgrS0QHmM7MYEEd4AaIZ6OQn9mdl8V1gVB9t
	GasHGm/LGWg4TbwiJ6plrYaoWd4/mCswfrw42d+gbbB55rFnfrFLZrSppmONLPKhvSXSPwgNYnU
	yFxkg9S3g/CU9S6wGMFXo10NJi/FQt/In3qTRS4MRI4MTpu+H9YAn0OWRU0bdkGSqDOqaIvHk7E
	ilD1zIoqypZ0jb3pAFlCxqs18tTiTbHZLrhObZs2RRmPmnpulYh5PTd8bah5tyeAkXfXNnUgcLQ
	==
X-Google-Smtp-Source: AGHT+IFK1miVza1yD0mEZZEv8sYVvv7ZVNruZwzASgrN9P5emTzoE6xXhVA3tcIqvzROnJEbvkXJkQ==
X-Received: by 2002:a05:620a:710a:b0:8a3:87ef:9245 with SMTP id af79cd13be357-8b24535ebcdmr303632885a.85.1762515524110;
        Fri, 07 Nov 2025 03:38:44 -0800 (PST)
Received: from [127.0.0.1] ([2600:380:1865:be24:546c:e307:b658:1b6b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b23582bc14sm396726185a.59.2025.11.07.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 03:38:43 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org
In-Reply-To: <20251106145332.GA15681@lst.de>
References: <20251106145332.GA15681@lst.de>
Subject: Re: [PATCH 3/2] block: don't return 1 for the fallback case in
 blkdev_get_zone_info
Message-Id: <176251552260.20701.11023481051299407523.b4-ty@kernel.dk>
Date: Fri, 07 Nov 2025 04:38:42 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 06 Nov 2025 15:53:32 +0100, Christoph Hellwig wrote:
> blkdev_do_report_zones returns the number of reported zones, but
> blkdev_get_zone_info returns 0 or an errno.  Translate to the expected
> return value in blkdev_report_zone_fallback.
> 
> 

Applied, thanks!

[3/3] block: don't return 1 for the fallback case in blkdev_get_zone_info
      commit: 86a9ce21f5b781c56eba23cbbd2264ab74778ab0

Best regards,
-- 
Jens Axboe



