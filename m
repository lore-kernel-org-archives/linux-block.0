Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810798;
	b=I5+mgVizVJHHO/Cui1Pxj/Kq2TtxbgiiCzZdpy1qZt3bt9Q+7bCnG5EdLRNbZBP/Jjme
	 5UvQsn4pDnvKvLqPKxb6gX2U59VKHFBzuxlO55NIT274Ef5cFZ0Lx7zYyz5mpT2I5sxjY
	 dnT5tewIpSAiTNvCtVkK4dDp4EKrlW9KVSewMflVMW7PSLRrs+pcZP0JpJzBeFEYEKScU
	 kzY6pmk6HSPBotE+40GIypu1Xyslp4hz59Lcs7Kol2LJa+QcGtnDEGxUPSGBgKo5XRDrt
	 oIDzPgyxcJMPO5gHAblbojZVtqi7paa7pzmujXf9/O8XBnxL+VnSIzOtI/H6Q9CC0zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
	b=ZOZ/Rw5+ALIy+7/vEk7P1FVdQWQI4YXSXd7yv+YOIt2gxnMlMC/4gmfzaFIC7R8imeaa
	 XQiOuT8TX+jOyUxkme+1uDBzGMVrMiJ4Eij8Lb16mPZXQFZv1YLgNOsS8vGm+EJEWiw5k
	 YOkTe0IWVrMpAEcLwPnBg0//AxOIEtwUWBEwExRH+xX1gQSAJr00NkEu8Clhb0LmBP5V8
	 7J7Wbq7ddI48sqAXrkhfvPL6HDXzhqbcOOxBYog5D/AW/UxTBqYLtQeROAscxiXniLO7P
	 BdRNMw84WjXNngR0suA7ue46OP9yDo5NtKM/fMCigq0s5GEST/RkaetL+5GZ4mLjQhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JV7jvcyh;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301CC606A31B
	for <linux-block@vger.kernel.org>; Wed,  4 Nov 2026 16:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 301CC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=JV7jvcyh
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-14fc585291cso896924c88.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793810796; x=1794415596; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
        b=JV7jvcyhDzFZgOzyiXMsrrE96csI3o5reJpHhY1rZC3R+/mUnsqjvCmXEjOL3OVxrJ
         JkdmZ7gnsvz/rc1SGznFGm489hIxWfufBaTe+g/2UZU6OFp6XAoftty8q01wNHobQd8X
         wch1oNFN1YQPF6MTpQuBWXmoCzX1jPassCZJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810796; x=1794415596;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAaKlrwhgxVSTJYKvS+Mu/JmjMNNY3TaQOKNMaH3oHI=;
        b=ixvpIvOtyY6hoZiXMqzv80ZH5GMYFpabPwbWp1dQnha1QrAN3Q3RJkV8zr6X4EAbOY
         j4Pl4P/qVQV1zRQbv8SmESvv0Qh5gg7f05VuV+BSO7VW1tNSLHN2X0JA+Anpz7jH5iFF
         wkq4Xn8HXmeTidRHK0+QltPl4B7s5frCiN+zXoSsdtRsmA7zOhti1McOLswt+rRbUfxc
         YxH77DfgNl69X3sr4vPX57g2Z+j0TDvvz5RHgwij1iPaaoYu0gb530DdSoE0LDoQ+ody
         EwiB0Qy3X/sFHrPPqbvcdkmmh7w9VlYg+r1nXfov4LOKDCbU7eXKUOK9kddmD+Aok63l
         /2AA==
X-Forwarded-Encrypted: i=1; AKwUvBxgT7YV1qZlEyFwe6dayKFtgFEznJCUoGZbKGnD9R8khCidTm6gpO5ZywK/EZoeLBM31LLvfNEufyDDEQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+U2xtmLksc5+0PdRQqpuErGawja7MsYKKk/TC6xx5dY58CKRC9
	W1gT6YbTO7u7wofYz8qjEIcK/6WZoIGpyfXK5d0YUDuKqPQ7nA31p6tOF9dVUMonKA==
X-Gm-Gg: AYBFou1tHjePRY5bzUthJUABhFySQJJEKvZYbtPlI0DDwxEflRyuUFCNUol6dhAgjMv
	usmR3eJ9jTJq6djTazbsLilzIssoqBzat5NC+BRMKCGeUaT79u12RmefEM+qHtPcY9/Rbz40i48
	TYI2X5FTWfuHprKMT6c4Gdot1h4EAir54+mAQaVKNGNqNq/RE97sSLxBz0vv2nOGMYDrME+hC3C
	OGso/TKh8E2odCxKrlfkPrUcOgpagDYY94BF25YHAKP8HqvQy0uKl2LXe51iF4odPkq4WPn/5vp
	0mR9EFmS+4XYBPK0imcovNdmPhrlGEizqzRfOTl5eZiRZFjvfrjV/sU4e9EJU/YMyKMesNrIdGm
	R0b5QVORq2XAQUo6S/JZjSmazzXAACEevFp/f2pmfcaRnuNl4YSEEXh9erxdN2389yLyaOnLWHx
	xUp4ifwUmx/phju1qVDvFvYVBlvv40s1lHJ3zvLNdJiw63t3ShhpuhnACRc+6ynWzgkp1yvvs7r
	Iimz4/cUfV/2ESgvWxY2m2nss87gq7EoMpJVWqfSxR7HjnL4Q2xHfZ21E49S3pxPkhAuBVNJyhN
	AoDGDx2XAc2YDuAH4UQFqBs9rz+g9Q+xUaLJG+41yPgXbf8ahKlNx6+br9he01Pfzlw=
X-Received: by 2002:a05:701b:42c3:20b0:1b2:366a:e7d1 with SMTP id a92af1059eb24-1b2366ae854mr11976510c88.32.1793810795926;
        Wed, 04 Nov 2026 08:46:35 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245c2de58sm8522268c88.12.2026.11.04.08.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 08:46:35 -0800 (PST)
Date: Wed, 4 Nov 2026 08:46:33 -0800
From: Brian Norris <briannorris@chromium.org>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Praveen Talari <praveen.talari@oss.qualcomm.com>,
	Jonathan Corbet <corbet@lwn.net>, Mark Brown <broonie@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PM: runtime: Update runtime_pm.rst for non-fatal
 resume errors
Message-ID: <authaS5a_NrY-NLd@google.com>
References: <20261104151651.3035537-1-stanleyjhu@google.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104151651.3035537-1-stanleyjhu@google.com>

On Wed, Nov 04, 2026 at 11:16:51PM +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), rpm_callback() no longer sets
> dev->power.runtime_error when ->runtime_resume() returns an error.
> However, Documentation/power/runtime_pm.rst still states in both the
> resume callback rules and the ->runtime_idle() comparison that the PM
> core treats ->runtime_resume() errors as fatal device errors and blocks
> runtime PM helper functions until the status is manually reset.
> 
> Update the resume callback semantics bullet to state that on error the
> PM core resets the runtime PM status to 'suspended', returns the error
> code from synchronous resume helpers, and unlike with the suspend
> callback never treats resume failures as fatal, leaving the Section 4
> runtime PM helpers unblocked so a subsequent resume request can run
> ->runtime_resume() again. Also drop ->runtime_resume() from the
> ->runtime_idle() fatal-error comparison.
> 
> Fixes: eef1d74bf88f ("PM: runtime: Only set runtime_error on suspend callback failures")
> Fixes: aedc51762a0d ("PM: runtime: Clarify ->runtime_idle() callback return value handling")
> Signed-off-by: Stanley Jhu <stanleyjhu@google.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>

Thanks for fixing this!
