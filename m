Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D35179654
	for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654632; cv=none; b=fIoh03ztPod7uQSL6Wbr2ob769EiVyZYjPBrbJuX/HfAtieFW/Cv3/z21Dj+uTs3/MxfeUYBVIq9TLLntwo7Cy8nYZwFnQ9EuI4IvGASlQqXFh8V679WvFTVX9Hn5fy4AMCSHmune0PDmSlqpwGAzLVqhvofH5+csygis8KXPaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654632; c=relaxed/simple;
	bh=+tpJnY909VM1M+m1CMhX0xl6c3hIZ9gIwNHSsoAD8J4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=n+WxgAsHFwQuf8xgUEYbY8YZ5Yo4TbW1uf874EE0KXRKS229AyRRhztMaopcxUWTJbc+AoUqaU+A5cvAeWUsMoskkhL6Tpwd0PZPL9jDagG46JP51sDZjP1rRzl7L8VXBpZjPZ+4V089kHMNtwaq+VaWS1XS4ExVu9Crob+L2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=g/0RNlEh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g/0RNlEh"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c6187b6eso4833190f8f.0
        for <linux-block@vger.kernel.org>; Wed, 18 Sep 2024 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1726654628; x=1727259428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xmRlfgY58bu3lgrbHWfq1PnhjWfcGquoMknYxltLHw=;
        b=g/0RNlEhZ8yqQd2ys9yx4Rbl/rjCpXGI0ubNLOYG6dPrAmwB34cNeVodCV2XkAvBhj
         2b6D3UZVaihlE6VmUQsDWPPKQklE/zTCdJuZZEUkz756pmoxio3ugq8AsZL4BCR2jyxI
         2mNAzCJo2Qa+kiIFIqNBpk4fN1YV33iumDo8jVe3Kwb6kH6ctvGn0w6QZv4Qzh5CfCgf
         AdHCXa9zEs3/3iZ3TEPsN8NH/bzgd/0gamP8W7xlbeSzvdf1D+CiJFS8MeV591McvmVi
         sc6WCOvaQ4Fr6M6xO0Kbp4ovTzlIc7N/0NbFWycbqTl5ea7E1epqYzpOhHbiLieuP0CW
         +vyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726654628; x=1727259428;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xmRlfgY58bu3lgrbHWfq1PnhjWfcGquoMknYxltLHw=;
        b=X21BqNNVxfLIyufaRl3Ln5Gx7roJymTjkbuQiCDeD2wk4wC33DTHIWDTaEJZxmWoRc
         f25Ylw0iQnxol6GTBX7QPssWPpiUNfV/dy1IfIElYHrbm+ZhdNg7rhAEaGYOwq1doJoi
         a8U237chXbenR4dd+BI/DZlpQkRjcmgKSAYMCGPfOeaIDzkJO/ESkzV0riF4CbhYO1C9
         +Hx0JfNR8Na7i9TKCBrswKqNV6tjM/Jo8KAd56oKgfPcWIQGNvVAbFF6ZwlbDGNxosAU
         IVZvaPhvi5/co+nLozSjZ6OEhEp8qs85TzLxviBjdmbf3keBalQZoAvP0I4pt3+TR8CS
         c9jA==
X-Forwarded-Encrypted: i=1; AJvYcCW4o0EYK0wsbtvmWKWklP03HBHsjxt4EFD4tD5aCRNLfddIBZTIM0dfBKH8dL63tFkcreyqThlD0cQpWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn9utNOOhac4dyFVL2XsN9pNMQE4ArDW5riGpabbWNd7q7iSr+
	El2YRt4GNoRzrRTMzukrgIe9ZmKW/8lyL9JK3koO4jXrjN4EgBJp+U6PkW8ut0I=
X-Google-Smtp-Source: AGHT+IEt+88MOqjxAvT4BA2X407wtBcTy4RsMgu6zlhxdOqsfDfTg/sRarmUG6UIBwTVkHUeUeJlPg==
X-Received: by 2002:a05:6000:128c:b0:374:cd3e:7d98 with SMTP id ffacd0b85a97d-378c2d062fcmr12084591f8f.19.1726654627726;
        Wed, 18 Sep 2024 03:17:07 -0700 (PDT)
Received: from [127.0.0.1] ([185.44.53.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e7feesm11837758f8f.29.2024.09.18.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:17:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: philipp.reisner@linbit.com, lars.ellenberg@linbit.com, 
 christoph.boehmwalder@linbit.com, Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, 
 stable@vger.kernel.org
In-Reply-To: <20240913083504.10549-1-chenqiuji666@gmail.com>
References: <20240913083504.10549-1-chenqiuji666@gmail.com>
Subject: Re: [PATCH] drbd: Fix atomicity violation in drbd_uuid_set_bm()
Message-Id: <172665462666.8208.13856585668352326031.b4-ty@kernel.dk>
Date: Wed, 18 Sep 2024 04:17:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2-dev-648c7


On Fri, 13 Sep 2024 16:35:04 +0800, Qiu-ji Chen wrote:
> The violation of atomicity occurs when the drbd_uuid_set_bm function is
> executed simultaneously with modifying the value of
> device->ldev->md.uuid[UI_BITMAP]. Consider a scenario where, while
> device->ldev->md.uuid[UI_BITMAP] passes the validity check when its value
> is not zero, the value of device->ldev->md.uuid[UI_BITMAP] is written to
> zero. In this case, the check in drbd_uuid_set_bm might refer to the old
> value of device->ldev->md.uuid[UI_BITMAP] (before locking), which allows
> an invalid value to pass the validity check, resulting in inconsistency.
> 
> [...]

Applied, thanks!

[1/1] drbd: Fix atomicity violation in drbd_uuid_set_bm()
      commit: 2f02b5af3a4482b216e6a466edecf6ba8450fa45

Best regards,
-- 
Jens Axboe



