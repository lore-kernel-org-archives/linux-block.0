Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D19837107E
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769690862; cv=none; b=PN6cqWkJznYsoPvFkA0tvdv36+gnSYAgmLXhN7DJxExVTZotEs4h6iTyZSMXgjaiIbvMdtIE7OA59H7XGnFfBa+hr2kbf8TT37Tc0E1Rx/gCSdCB3/fiUOMwO3yxlzRUDXATKVjtiy69WfXGsoe/p4iAgLTdbX/mLRuqj3jlW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769690862; c=relaxed/simple;
	bh=A+uH+FMU1M9LPW8x3vGiKxIKk0sSXlUou4sZ24YDWOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QiT/d6/nwr5pk1ok3vedThE6PvpikqUJL6TzZAU+3hcEDXFqDlid2214papu8voOY7e9MjW/0uHfqk0M2Q2fmAogff7UpsAM7IfjP9grb7bgndXLHcofpud1HjMbu9frZfIlwFaqFcxvByfRZLQsY1c6PqNYwJ787+uMKpvab44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Nn5W5ZcD; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Nn5W5ZcD"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-45c838069e5so632234b6e.0
        for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 04:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769690856; x=1770295656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I49rk0mJMeOtsVg4sLszBeHOn8VTBgFPuk/FrYrQmbg=;
        b=Nn5W5ZcDgd9jS58kA8G1Yn3tVt0AOfaCHBLZzrQZsW/R8CJTKojApWgoYr5xyD5ben
         ij7zkgL1L404aTTmf/TzD65zPJXMeamrRmlxJSlMOm3E0gBpa9suiHZLG79iBER/ZLjD
         5845LqMrvNmTMA8i9RehTTsxqSwcoe/ihQCxtVw7MD7CkzEqgajoGZRKnWrx7vFQe5Ae
         s1W94PcQKoZn1KIDgvh2v4qHUBHEW5m4/nj4xMbGMPGGjUW6hEkrKCg3EAz+0f2MefHT
         dGGgGnGL5a1u8c3oymjatUaTu1Vam4/+XQV/qvCgdLNz1WCr1K+hMMQ1AiDgb10A9EJo
         6Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769690856; x=1770295656;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I49rk0mJMeOtsVg4sLszBeHOn8VTBgFPuk/FrYrQmbg=;
        b=fGq9C3oG1IOFdGoS/vHoOf36lcWOAwSSkQaybSXEP/ZSvRUXOfjwBM/MJmLmP2nbhz
         orDc2AsNrL61F1/TG5f94aFcvZcrl3j1O2E9nowmOiwPfmTkUluL3ReSkrXxyiMnpkJa
         WRvfeliljgefOni9B3M5qM8i3Tc7rYBQGBpPQOW1zNzhsw7UpjRps9xKQj9IrAz7pZzl
         CIEpfE6UVWEG2khG88KbVswnv3pguJGIpy2B8RQdOoXtszmDTMdDTWtgXBMUsJS8gkVv
         YuJ8SpNuNi/8TGc006vtdfhzn5uka0eC5klg/cMwIzbLD7HhMZTHEHPtg7KaWURzws0q
         +SBA==
X-Gm-Message-State: AOJu0YxND3F9AmfdTTGY9pHKj+hjqkvfkg6mdQ2fN3lTeL2SFTHVqr8R
	DdBVYUFq4UlAAJsfz1JpdRYTR+vPVyFKS4LDjEkPO3xj/xAzU6sVBw6CxtpCGw20KNaUOFZ20Dc
	ZlicCGwi/7g==
X-Gm-Gg: AZuq6aLg6/kYQQn3ZLNSBBA/O3R3IVMJP9ADscBjIMvUfi+cdlqaPDZSEAVzdHC+LaZ
	CYnfIQVG6HAxqd5H40LEsVkPnV5LcVHOqDY+Ol/1QksSpurWGWE+Bg3FLQ5W1G4fqFz9VyAjK0A
	prX4I+/or0dKmnxGaMyY0gVfT9rqXgK3IdLmPlkjjtLJ7OzdWzFxdRZVbkRufgstb53A9hXw9CX
	JKRRxywyy5vw1T7dzwP/OKjF5+BgTlrgpZIl6XOkcyCD1kswaW23IIatI9prAVM638/3p9T3QxV
	3oZ6hBW0mlxvo4J5Ah9lU23ptlbcn1gf9hdLrYoATbjJU1YsL0GGM9iGIc51s3k81hwDhgMZ6Xi
	VEleoSaywOxcdxhjheBtc0v+j5RslH/UERCQYvKE9NkoG5mMEjQ36s/frIFea7fRHBUyi9FGasi
	BQpSyYVlcW9yWx2qRue+z5TM6tBOa17ZeIGzn8NVEfhaJIeOjTficrVgL6J7r2MCtz
X-Received: by 2002:a05:6808:1926:b0:459:9630:3742 with SMTP id 5614622812f47-45efc5ac8d8mr4472541b6e.22.1769690856526;
        Thu, 29 Jan 2026 04:47:36 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4095751ea47sm3675072fac.15.2026.01.29.04.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 04:47:35 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260124042716.2314690-1-ming.lei@redhat.com>
References: <20260124042716.2314690-1-ming.lei@redhat.com>
Subject: Re: [PATCH V2] ublk: document IO reference counting design
Message-Id: <176969085566.453880.8016909450526060679.b4-ty@kernel.dk>
Date: Thu, 29 Jan 2026 05:47:35 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sat, 24 Jan 2026 12:27:16 +0800, Ming Lei wrote:
> Add comprehensive documentation for ublk's split reference counting
> model (io->ref + io->task_registered_buffers) above ublk_init_req_ref()
> given this model isn't very straightforward.
> 
> 

Applied, thanks!

[1/1] ublk: document IO reference counting design
      commit: 0921abdcbd1cbd6605ea425e85758bd4a19b9b32

Best regards,
-- 
Jens Axboe



