Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6E63BBFA7
	for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786360437; cv=none; b=DGfspDqEiS0ydAk2GyJLzs/q38BcWSRhkl9FoRKWkl1VFP8FWt8+tJV9sfTnf4hpIpf+1gR2ZXqFdKOW7MXpnJWbKhgNRxc6pIOtV5ei71xOiS3n8basi9+QWqiDCNak1M6EehPbX9oDX+Xf1GHOxfrmPg06iJws+XszBZJGezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786360437; c=relaxed/simple;
	bh=0XX0nQa29jS3BYsHX3yCOvRVKWgcJVuXtxuezaUS77g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKiAHLpG9ICh5yacJWtUwHms8KitHMYEJB+zLv0e5hCSAVoJ4OmfAr5qGsptr0Ip5/ndqh1ga+XW55FcqxjgTroYE5A9cCvBZ4DNvUmsDNPR1uig4+X/0QyvrUuuT629zrkH8KMNvgsou7kdcwhPX2tiWg2r5aCeobmTbqtQkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=RUGM+Zko; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="RUGM+Zko"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-480033bdcf4so944789f8f.2
        for <linux-block@vger.kernel.org>; Mon, 10 Aug 2026 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1786360434; x=1786965234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0yLoMsGvnzZxwm4ZKw1RwkA/Sg9gcuHMRtAJWOOKK/U=;
        b=RUGM+ZkoL4qfmS6tu/HkuXIwfnWYDSnpvjhwTUV4D0TeNIoTBL7snHGQnMw1LCZ9AV
         EjBSSiHfEmyNW3gV6ggDOqd1NouwkOZsVrXosQEm+X52LTBfwqAHuCiXKtghVGuVc7/n
         Z9sFUZ72r/BmWR6GzLIOeGTzaVcAiTs6OarHzqFyIhknu9OXiIfItiCpVaeZLGu5oHdP
         WRlgDlqekfVAe0nW0rXdE9ZDRyPZWzZiqgvth6tBIJPXyX87+0XgZqwMs/NN682/jmdQ
         tg7vfLIbWH8twib/hjcvu107xD0o+XTXBIatP73FjfeiQ/okeG5a96v2hyrkfF7WR2mk
         /umA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786360434; x=1786965234;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0yLoMsGvnzZxwm4ZKw1RwkA/Sg9gcuHMRtAJWOOKK/U=;
        b=hyWRx/a2YNa6iWqlkKS6lDZFtXWB+8s9wC1T+GxgslDIbTruLgAfFMPDRBAHxg45Ap
         fvxzWvAw77L+WptcUohT8U4TFsifbumWLm9zYceYhGRfMkMIoXEasgdlEkU128Ho9Wte
         6UG03iuxpV7eydliZH6grNW0o76NM48UkFfpbwwU+O4HeuY/CfSi1MC9Hy2p5K0Uwa4H
         LoAHv0r8x6tYDo+Ez3ySfWBM+w59DObiramylHUzuL1gO2Ovf7d53E9Gr7s6i2FLY1VO
         QWW31/BEme+OCACqL295AwSXRq+lVDIR4U/Xnas9oIXRxn+RjEXY3aGQA1t6kzFe3Gtu
         gW4g==
X-Forwarded-Encrypted: i=1; AHgh+Rpk1SgmomjTTBClval0un2UQzqPmwoyA5Rd8+Y2GD1De4hQP+EvUlgM6LHZD0mM3Yy3ZoqbWx5qllN8SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypJgkT3E3+hsCMqMRYMs0x/RBRxE+r6B3Vd8uINnqScXAC3NMi
	Aza9g3MbWrpu34ZtYe4w5AJFCW/f1/6PkDgWrJ4toyEgqCHIiZ0/nJkBikJiB4u/+NmnYi2uu1q
	kClXg
X-Gm-Gg: AR+sD121UyBpkiYgyNXoLwgYSlTxHvDoqZ915B1scsANzlkTSfF1qYEFkRXeFkpl0ZO
	J6n3/O8ExeYcEoRiucMQEwWuy+pO7aSdVYk2sEWF+pkjiKDufr33hbqswZu/zSa8hZS4eQ+nkxu
	+nuZpoHAuMH6EZ7TNazYV6XA+NjfIvKEykNeDVygBrJkbLIP6ZVR2eHAexOH468uz//Tzo/smAg
	DzD2kwJviHR6D7sWjjYhO7GereSjKF1HOlHjAZKQzagSLLs7sma/gzVFENmf0FMg3F8yikQR0Hm
	SJSyFv6EFCbsLPM1/YkE3yUubppP4EQuf0iJIufFizOxSgKqsIJrQoTWlacfNBXACwjrjD0563F
	ENb1T83LyFwYgxXa75+edt/0SZDsKBl4R6wIMYWYx6BSvtHPGIuG9dIGNR9AenL3JuaBojt60j/
	yE8mJiBapQlbuf8i54XgxhlBtNzW+dhRj/kEodROiZlFnfivORFKfplKeHwOknkygkyDeGStsCr
	lQF3yFpu/4UNy0GZ44mODJMGUzwVh7dcsG0bULezQ==
X-Received: by 2002:a5d:5985:0:b0:47f:973b:71c8 with SMTP id ffacd0b85a97d-48145639a80mr1747572f8f.21.1786360434119;
        Mon, 10 Aug 2026 04:13:54 -0700 (PDT)
Received: from [192.168.178.55] (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021fd392sm31807386f8f.31.2026.08.10.04.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 04:13:53 -0700 (PDT)
Message-ID: <04df5445-167d-4ab6-95f5-dec123fdff1a@linbit.com>
Date: Mon, 10 Aug 2026 13:13:52 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/radeon: fix typo in comments
To: Guo Tenglong <micronull@163.com>,
 Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>,
 drbd-dev@lists.linux.dev, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260728090507.16847-1-micronull@163.com>
 <20260728090507.16847-2-micronull@163.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260728090507.16847-2-micronull@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 28.07.26 um 11:05 schrieb Guo Tenglong:
> Correct "sucess" to "success" in function comments.
> 
> Signed-off-by: Guo Tenglong <micronull@163.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 705c012fc..fb79c990a 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -777,7 +777,7 @@ bool radeon_boot_test_post_card(struct radeon_device *rdev)
>   * Allocate the dummy page used by the driver (all asics).
>   * This dummy page is used by the driver as a filler for gart entries
>   * when pages are taken out of the GART
> - * Returns 0 on sucess, -ENOMEM on failure.
> + * Returns 0 on success, -ENOMEM on failure.
>   */
>  int radeon_dummy_page_init(struct radeon_device *rdev)
>  {
> @@ -969,7 +969,7 @@ static uint32_t cail_ioreg_read(struct card_info *info, uint32_t reg)
>   *
>   * Initializes the driver info and register access callbacks for the
>   * ATOM interpreter (r4xx+).
> - * Returns 0 on sucess, -ENOMEM on failure.
> + * Returns 0 on success, -ENOMEM on failure.
>   * Called at driver startup.
>   */
>  int radeon_atombios_init(struct radeon_device *rdev)
> @@ -1045,7 +1045,7 @@ void radeon_atombios_fini(struct radeon_device *rdev)
>   * @rdev: radeon_device pointer
>   *
>   * Initializes the driver info for combios (r1xx-r3xx).
> - * Returns 0 on sucess.
> + * Returns 0 on success.
>   * Called at driver startup.
>   */
>  int radeon_combios_init(struct radeon_device *rdev)

This seems to have been sent to the wrong maintainers. But I suspect
they would have the same reasoning as me about the usefulness of these
fixes.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

