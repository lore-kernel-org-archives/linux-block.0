Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24BB36A34E
	for <linux-block@vger.kernel.org>; Tue,  2 Jun 2026 23:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780443857; cv=none; b=ag7dzKk4QDTvZwF6s2ym7qTDdIhlYZdrJwlqFwbg6RH7Ul2ZcNXEnAODFU4zS9/QJEjp1KFR/yqPcQuvcsEGn/zCNtrKA65OVz8dG8ow8aS53uwxZQCzNzX83NPn2TzqCggvRFn74ujQe53Wykty7xVuw4Y90KPIzXcuGXLcfRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780443857; c=relaxed/simple;
	bh=SKHh9OtmNocvR7jSQRPQY4nKBEVhepxfUdxIH5P/40c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CDOJBn/YiOFysQ7uXCGOPhA8YvIpj8FBHj6B8zJUMks2EzxA+Q36hA/MqlKjm9L+SV0Zu6ZE6N3NAcZKAOppEm31677hn1FQYtyRuuWlA/btHGf2SQsF3vE/bDS5wm6JJi8bGqxF/rEumOwmB0GK7aT5izXvHbicwQ+qkAGzqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=O0W0v1El; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="O0W0v1El"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e6ec655c80so26731a34.0
        for <linux-block@vger.kernel.org>; Tue, 02 Jun 2026 16:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780443855; x=1781048655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VrlAfTJU7jtglo66HFBSoXs9Ai4qRIYV0ElRRn9ueTA=;
        b=O0W0v1ElFfePtlR1BybIYwJx9pLiWUaSBp73EmM6FTOa63GQulp5yUd0kcj6lewWGb
         e2ZcCDH37/wjzvFB0OJSFTwQnu0zxWyKxEEMzQnM2eVtdD4epbpNmXCY6e6B6uY3MTHG
         4n1+0ebjyuk74nuiQ99irlW+AWp1OYVv3IUHrNTct45yU5IlfdIPLIQxSz3KH0USkaUk
         TjnC4O/vaH0wKk2jCB9tU13B/bVwG7CgXCPj+DtS5TZ1PJArKC/cuemyyMNCM5uUAaDv
         xwM+oRZdWxEg0SdfhpCk0M3HsITI5WkmtaIj17c8DuYflnFS8g1JOmsBgCrQAARzjEZN
         vX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780443855; x=1781048655;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VrlAfTJU7jtglo66HFBSoXs9Ai4qRIYV0ElRRn9ueTA=;
        b=OlksLmmRm74I9ZFsJYGKrferU4mcY4Mk9ZPSG5BT2kIX7ECjeadyXzuuGSciKEdK/i
         DCIeyC+LykrEaJr4SIrbMg7lNdqvWDG6zbb//92NdFDsyqhMM/0JHPxjeoZUaGlDrCkp
         nmhAntDlY6C0uAsZ5Gun+orczFKjO3UyuKe+9i48Ho8/2F7TRaYme4y01YdjFnP9t3ad
         +Ep84hpSJklR94FsqP2xWxMSKRpfdVssIqqCcUiuamBoET3BAD9d081TTm6u6rh/wcpl
         zYVazlQS7+C1VKvv3n3USWmNTsKpayka6hI7XR1hpG6MTFfYgmll29URfqbiaWdz48GV
         Dr4w==
X-Gm-Message-State: AOJu0YyKbVpg8zg3uanUYeCWmDcsBksExVka7OW0rQ7fto7Khez2Zg8r
	Ejk+JQmj3vPgGI42nsvSLMkuMLwP2+2Jc8CvPI+NKwkhFhediPjHUWjg4dvH5lUcHwQdIn+3FTq
	9/MJm
X-Gm-Gg: Acq92OE173wKEMqfo8RX2jYeeoyeRGYwFYpj5LwHZY44sPcKbFnz6udPy5+58vsdtSp
	QN/vtwoRj0U9QOa4QisslvtFOHaB/gotpkQBJdJtxt0oR+dZQqwKLMRiRPmS37ixi+qN3p/QuWa
	BHWpI2+1w0SPA34hAR3CbDPem0By29IK9Zs69Yi39vvm8gbsB5wtU7KsI9DXieuMROPxUd1uo15
	uvIpc54u7Azox0P8vKX+9Q6cdEM6nqftt7wdbHczrwVeHxIKLG3Ee/YmBYsJ0bTSN8IGAeKAGUs
	1BI2ImM9ebBDiaI43GMxzSk19dz84ZLIB83xetue3//MSTDRHcg8U15yXIZpK6OCfjBhNTxUuoA
	+VTdMp3FAN6maItcXdhS9quVWST/q8p1CwwOvqkQNz8BPbcFvg4jkXxy3LkXKaZbBBsFS/RQn71
	iw51Of0qGZJBkPu47zit/ofCa2Lh1xVNGnR6Izb5APHJpCUZBwukfdb7Vrf/lNnZT6MAXdPUORD
	gkVp2uZJSMIPNc=
X-Received: by 2002:a05:6820:198c:b0:69d:6696:846e with SMTP id 006d021491bc7-69e48078156mr744831eaf.29.1780443855020;
        Tue, 02 Jun 2026 16:44:15 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4620b0casm827919eaf.3.2026.06.02.16.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 16:44:14 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260517172617.3954-2-thorsten.blum@linux.dev>
References: <20260517172617.3954-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH RESEND] n64cart: use strscpy in n64cart_probe
Message-Id: <178044385419.624863.17919260436001606240.b4-ty@b4>
Date: Tue, 02 Jun 2026 17:44:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 17 May 2026 19:26:17 +0200, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. While the
> current code works correctly, replace strcpy() with the safer strscpy()
> to follow secure coding best practices.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy
> 
> [...]

Applied, thanks!

[1/1] n64cart: use strscpy in n64cart_probe
      commit: 3f1eccd37282de91efd0575ee8e212af4bde39b1

Best regards,
-- 
Jens Axboe



