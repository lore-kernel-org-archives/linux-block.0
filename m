Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E22494F0
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 15:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771514543; cv=none; b=Qe9kjp2mTdBE1IGj9Nzcp7oj4IaA/TyciQm9JQjqzyVtUfTM61AqfmL2aQjuBJ5S6ZagFXYSwxjJvkbXJLsDwd2EThhPL7+PcybrvgLT0BA16GtjKfZf+Jxho7xoo/K2Lb2kA0G3WqqNcwpem7yYX7v9zQLmiF1eb24dRYvDl/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771514543; c=relaxed/simple;
	bh=YGmS0R4t4IPHMntYddopsqMYngP/3/s1j3SRdFIkReI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=H5qW61dh0wUI3CC5w6HOr17G6esGnSrvGW6jOI7PRo6j9sVopbhpjKxRnDnbjwwDMIGVjsd2Twwscf/cXuGo0juCBW+8XkyOtD/iwlqKQyXxI91/XB5Dq4ST5DwDlHwPESAN0BAwPwgfqRrtGyCRPqrhkIKWuWmU1WSmXca8ADE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Ia5HaE6s; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Ia5HaE6s"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-40f387a688dso810812fac.0
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771514540; x=1772119340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEw6ziLtIMYeEr1+4vym/6HQDO9fW9fuHMCrppee5HU=;
        b=Ia5HaE6s4goo6to9cMFONc779dxVxMQ6QWSRpGXi62ZlW8BIg73+UbKHspJdOITkZu
         0DejH7MQK6ysKhxYC2JzNobkV+7S5iGlj1rnUCf0khscJpGau8efO72K5Ve9jFfxKcQX
         TbetjZqHMyjF7MC0sNIvIS6/nUoP0ip1dSL5qeSmQ83GeeO3ikyx6VrotzDA/AU/WmL8
         CZ+fDQqMuLS+a3Fu++MLvIrJaX3su1jZ0Y9TSseXoNh/XDRQZwqr2AvTt0DgV/lJ8ynm
         2kDyQyVdH4xtdGeIZy2GfiO7PXMskVIM+5sYgImAzhJduO48IRffxdZ670hKBA1XLkjU
         rkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771514540; x=1772119340;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NEw6ziLtIMYeEr1+4vym/6HQDO9fW9fuHMCrppee5HU=;
        b=Lz47a5zLSFpS83CnKPETkPcRIGHf6zG/fIzJiS8h98O9gINn6ma98bVq+HxWhxgK+j
         0cHvwMgmcWjkI9UkALd4PJx0jhbxmCTU/HX6c5qhntmM7AiphLqrMXhfvt4GV/1zBH+k
         c3UEZ9Itw7uquuGKVLYPqOwCMsvhXlAHHNvxZRZeqWPPgZ6iOvfxzNe81gLpHalwqUpT
         TaWPN0D6T/mXpq5OT8+y6OK4SPFad1t756iBuOKQcQA+4LqEeGQug6kVVj3kh3eOR9Xz
         lIpyVMWkc1vSuw7pbkNFrObqa6knMPRaaR68fGubz+TZ31pUWwtYLwJQil/gXfpxpAFe
         dNvw==
X-Forwarded-Encrypted: i=1; AJvYcCXQpPjkW1bRBhmQ4qGb/qUfqvAGuyMcf4Fxxd6y1Me5kL5QWNj9kQkwVFu1S1MqMvcwPxbtCxTsy+/OOw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnZOqLXy16vtsWlKxLXbnv+wtiOn15WpjgRVuRUOd8bnarL8C
	0zP7jbwRtJnjSZOEuTD+lvJUA3t47aRzOAX3hV17A/KCLansR9Y9Xmq0ZlX7w3uCsBxWzEFpC7v
	DrqoTbKh/XQ==
X-Gm-Gg: AZuq6aIsPOomzd83151zwzU497O5rCrKg0jtmw/4ASkapTwJPehP4fmghHCYfGHw3Qu
	rl+UrNeYR/Sbe1hLZTuBYeREoWmKCvfjQGzOLGDw/zHm7s6B+2uw8FsaoruzDALb1AePSjIhzZQ
	wg2n2oftlqWtLFKlLAwQfz1KaYe2rio3AXe3um88CswxVwiQaPL4Pw2+y4dm4VK11iheOviHG5r
	o0vwSk+W5uOP1NqvXAJ+HAkOUjkzrkk9Q5LSQ1j2WCZMV/vwfAmgDDfGDTTbtKjolqoxO0SrhBB
	KJRkNV+dq5HlvGB7B65GHAoTY9dEMfdHS3KqiNbz4ZFxKxb1Iqs1vCJlPTfO37QBeujXrSCe+0L
	HtXXByvxGEGEXD5ocwx9nNE7XVEQUvlrI3ZKIRN0Y+H54cU5lN5Q0R9VfdLFhFr1nwqQerxIXYi
	X8vlpn73iuVNbWvRjZbQlLDHog3qw1r8iIr7dL7n96tldRh09pF0F7WX1f0gbv8sbC+Bm4xlvmQ
	xJMVw==
X-Received: by 2002:a05:6820:151b:b0:679:a6d0:e99b with SMTP id 006d021491bc7-679aef36b53mr1781676eaf.70.1771514540481;
        Thu, 19 Feb 2026 07:22:20 -0800 (PST)
Received: from [127.0.0.1] ([187.199.77.89])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679aebf54f1sm1954014eaf.5.2026.02.19.07.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 07:22:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: =?utf-8?q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
 Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lars Ellenberg <lars.ellenberg@linbit.com>, stable@vger.kernel.org
In-Reply-To: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
References: <20260219142012.97756-1-christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
Message-Id: <177151453921.556009.15485390943324050309.b4-ty@kernel.dk>
Date: Thu, 19 Feb 2026 08:22:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.3


On Thu, 19 Feb 2026 15:20:12 +0100, Christoph Böhmwalder wrote:
> Even though we check that we "should" be able to do lc_get_cumulative()
> while holding the device->al_lock spinlock, it may still fail,
> if some other code path decided to do lc_try_lock() with bad timing.
> 
> If that happened, we logged "LOGIC BUG for enr=...",
> but still did not return an error.
> 
> [...]

Applied, thanks!

[1/1] drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      commit: ab140365fb62c0bdab22b2f516aff563b2559e3b

Best regards,
-- 
Jens Axboe



