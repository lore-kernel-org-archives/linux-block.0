Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B48526E710
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 12:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170286; cv=none; b=eemoAQZy20Ne3Iy/+7BFb0FqELlikpRCRiz69AUYA1+qRPLFJPs2M91FqPvET7cMpSiOgkeJEHBQVwNZK5Kc2bDIto+nFNMjL1mZ1IHV+nprKu7sVkRT70P2tXTi7iCUQmMEDrF4Pvo51fNoehRvV7av2Ejjd1KJx+XUUfJ3UyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170286; c=relaxed/simple;
	bh=KO5ht6ivMRJvVkXUrcKUtUM4Ee7CK+8e/GCRfAIkOlg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=am84W5xGiVHmwxKn02fgcIieHIbYvyplIX3wBJ62wKOJ5e/ksHQ04emwC/to0j7YW9cMcfZM8Uh2azk+P5Z3qdQ/A9dShulb1d8miFvna1b1KFFSffcLj/p0ZilVuw15vASXr/i6dhgG/y0out9WRS0o11UnTgShMw8HE6XeOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=sQD+P0e+; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="sQD+P0e+"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c9c505fe8so689747b6e.0
        for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 04:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769170283; x=1769775083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJp7UhcEwfpBapMRmxLQNHx/5inBAeEm/IOxLT5x/vo=;
        b=sQD+P0e+51/YzSswWeRUiRWiV5VNNB/wEsa4Z575FF3IIVs5m2gaVezgPzJQdTrdZ+
         J7uuJ4la4K++XEKqhvuF0v7VSXfDbao3hQBCQUOOV8SjKV1wcIKQXm7CrZI2ZwSaU+HZ
         ZsnttgGKGHZD8VIGUBSwZRU4cQkZHI2hoV82t3wnl2dcXzEyC+3Pz2mrbY1nsqCvApAI
         5AQ6ybloze7Yy2GaDo6rsLgs37Nu6IUJO4VUxXF0DQLZKVIxV4DyzLC3TOsOudiNvfBG
         7mFIX+dclUpwdw4NjtGDacnAzHcak1tnRprAe2/bGpY+d2EgYkmknr/tzhAaN/7181Zd
         /e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769170283; x=1769775083;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sJp7UhcEwfpBapMRmxLQNHx/5inBAeEm/IOxLT5x/vo=;
        b=R5QRf9quT9vVm1egGzmbxYVF+qLsAm+Hpr6bAFPJveRULXo/nsyKRgZiIjLz/UHJf/
         wv8XQoUPtrEBLekSmtUhJiomt9u1yv/HIxndgmN9x3F+QO0CD5VrVP9KurJaBcdvZ2n7
         7kirId+7Ut8e5O4NVCQxPUUz2tQpDm99bVbEuECbtTepBbBjjamVbUOhXGymOZhTZMlc
         tbp+UEcGTAcxjASA2pcwJCBm9ycU4l3U16KxZ9BmOkVLquCEkYPheau2yk9SnRbkyPTZ
         EuDCBdD4ELBpzdrSbpiBa+WHK3aLLwcFc70OQVGq8IOD5AGqifqJheKoLdSjsn8D676F
         ozcg==
X-Gm-Message-State: AOJu0YxSep3MTYJoqSsoK+UmTLxGhYXV2oMHBHv24OiBGTFJLNDOgVD1
	HoGwFOGkYrRfeCvBFJCzG4NJPvLgEuhMfhTNL/JUb2fxKYdoP9geYYsXGbyUWAq2QVk=
X-Gm-Gg: AZuq6aKH2oAYcDGo7J/Uqcj4/f4VGpKLnS047dAqIQPSwr/tEHxyYSg+Sj0li0PcsUN
	4yorssNg1o+qb5OzrjkwOUfPh8nH0XY1amqguW9fzZpukrR80UaWFo0A011oSSR3jT1kep3cbOB
	j5KzVYkl3vPpcjtXkKcVbwT85NwCVnWn57RkEMZmN38WtRauqBePsvKxiHMw6fD3LU8nBg0GAfT
	ryrc3NH6Z2Z6Wpve/ewY6/BpTWeJ2o68UEjsD58CkgiAqgG/P9lsvouQE1xMOBolC9CsaJi5qzK
	QPZ+1PQcO3L4XZWlLcdhmqZFU78C9F40TdRsGCHUobnicWYvzOvyzhGsCDWQf2hmpBEujA4mPcJ
	HLSSobhnKc93Bkx78eW6ka8uLohqwRCmnD7EoPpZUbkoyMIGnFBXH31/TMoOIGgv5hSN4Ts8Ng8
	2ymOuosmbsunmFi8/r3p2CAsUQgTNCLRcMTo41FFpxyM3A5N5i4y3kuAElBrgCZePa
X-Received: by 2002:a05:6820:807:b0:65f:71ec:4ece with SMTP id 006d021491bc7-662cabc08aamr1282506eaf.75.1769170283142;
        Fri, 23 Jan 2026 04:11:23 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-662cb4e5f47sm1078850eaf.3.2026.01.23.04.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 04:11:22 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>, 
 Uday Shankar <ushankar@purestorage.com>
In-Reply-To: <20260123091547.2164984-1-ming.lei@redhat.com>
References: <20260123091547.2164984-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] ublk: BATCH_IO fixes
Message-Id: <176917028187.585247.11305048300228106196.b4-ty@kernel.dk>
Date: Fri, 23 Jan 2026 05:11:21 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 23 Jan 2026 17:15:41 +0800, Ming Lei wrote:
> The 1st two patches fix two issues found by Claude.
> 
> The 3rd patch fixes test name in test_stress_08.sh and test_stress_09.sh.
> 
> Thanks,
> Ming
> 
> [...]

Applied, thanks!

[1/3] ublk: move ublk_mark_io_ready() out of __ublk_fetch()
      commit: dbc635c4be7eba1d0e0fe0275a289ee3ccc63d72
[2/3] ublk: fix canceling flag handling in batch I/O recovery
      commit: e4c4bfec2bb8db9963d87e8ccdf89cd9e485d7b6
[3/3] selftests: ublk: fix test name
      commit: e4d3fc6a22f53e5bbe51e28b43cb32bc130d9f87

Best regards,
-- 
Jens Axboe



