Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488CC1C549D
	for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733905113; cv=none; b=puheKo1CXXc4Pe9yqmo6PBda5OjZi5bM0EiR6nXCg8g7fRV3rIj5QkXwngGsbOObjLl9ezT7iZUqn72qNJP06VvNKTOalR80gMvokuJYjEGHjxJj6roU0dGk2maAOdnGjAQ/diF9Vt5ajPewf560fWyc8r7sDB/kS+iTk+h4Y7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733905113; c=relaxed/simple;
	bh=XskHzUQ0wP3xisQAsDVTIVaMiwmap3TuSXWv2UwOOoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOORhf2tnNwyKGp2/E+QLyf14SSlD3xRXavPo/9VKBof+78BgUri07bKi+dkdnGNRjL9t0ck4r4xPX8LYHgtUUolgwIyWvrVvg9qLFx8ERjyjj1/+miqc0N/RQVzgSZwRth15KSbQmwj5zcbD8Ir/1CwUb2e02t8mqYykMDoIcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IoekGvcc; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IoekGvcc"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3004028c714so38042061fa.2
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2024 00:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1733905108; x=1734509908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XskHzUQ0wP3xisQAsDVTIVaMiwmap3TuSXWv2UwOOoE=;
        b=IoekGvccNyR3/8I0UHPuhLZecAyr4HJw3FrGwOlZnUyrpVBWhfdQVmXdzzu49yqvat
         1uMWuL6AJP5/rHSQRtmBLqHoP4gdsWWeZX0hoU3V3P71fSlzxMZgUpqiIfkxvkR77BeS
         HB2xqPsWS8TK4jmjivCUlpiXyZ4ZzdD5LuqQ/owoA4WnFLVodhfbCCKM3l9NTxUREITk
         P+r9yEoGDmBSLyznzXbHDdK8AsE9XAVrjfESe+flsVXPOaEqUoLluDMtFzHk2eSi1PX5
         CEl5D7XkONCmF1YX4dvA2bh965GgrnYMeJWeZpPCkJLGaqTSacwNZp2FhgKA2BKqQdu2
         zQeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733905108; x=1734509908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XskHzUQ0wP3xisQAsDVTIVaMiwmap3TuSXWv2UwOOoE=;
        b=QCSHDzisLPuYYadNfrPMkg4dV0n+pJWCeuR8IdgElAIsInIu3yL2tnENmVZB59OkMa
         d5jGYfXgSKQfK4NdgR87NhP8pD81vhzafDDv/O22uyXPSsckZA/fFvTUdK6xYDToq4dx
         1Y8XO0CONsUh+PPI8aLacqfhNW4WjOv8EgsFd11Oo5yYAnjWNJGY5AzLh6WbTOETeLXM
         h5BfwSVvkUb8utBhBupSYjHAoRvMUkp1XwoufaPcjJYvAP1QilZOzzod3LbxI8cu2ePZ
         7ALYgi5XUuwNbkkI38euDu2bfrztostba0aIObGwsOy3JGxfSfT4NDdSvoV5YF8ySBAj
         vpQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0BgPRI6GpUTcFHtuaQz7rQZvGXnxCo1JbOwzNICxBvS5x06pXay5YF5uK2T+cbK3P9xOsJuIUGRqCdA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVviI2uz/G9hwUaaY0ht5paT7Hs+h2BsIkZdDgfk6jBo9iELDm
	SkZo3D7dT3OICu8Nc41dswjV49Qr19f0rYrfqhnUEgHF4qUkPT0C6nY/IgKNI4LHlFk5xgMjuE9
	qajR16GNqOfcKHsIDYNB68RmfvSM+YGykU6ijZQIQis0vFWmi
X-Gm-Gg: ASbGncsxKIB4aCrxczXApKFp5lwSeAs6xDOhsHbiIcmwE92/sjeBXj5JQpJX6StRoMa
	+RIGNCQbIqtr7wwMaN8ziAMHGPdNvyKxLm7zElW5TGyiPFLwjushCN+M7NVE3svNku/8=
X-Google-Smtp-Source: AGHT+IEyqSnEBMMtZyEj5jF6bo6/CxMQUAS8l/Vem+Q0Tg0zwJltPimb/BXxYNi4dNa8OIsM4j3xdj7bHzlce3zdJRY=
X-Received: by 2002:a2e:bcc6:0:b0:2ff:c95a:a067 with SMTP id
 38308e7fff4ca-30240d08829mr5734311fa.13.1733905108362; Wed, 11 Dec 2024
 00:18:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-const_dfc_done-v4-0-583cc60329df@quicinc.com> <20241211-const_dfc_done-v4-8-583cc60329df@quicinc.com>
In-Reply-To: <20241211-const_dfc_done-v4-8-583cc60329df@quicinc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Dec 2024 09:18:17 +0100
Message-ID: <CAMRc=MdJuy9ghgLHxbygdHME2EkttZ7zBMJzCis=t94EUMbGiQ@mail.gmail.com>
Subject: Re: [PATCH v4 08/11] gpio: sim: Remove gpio_sim_dev_match_fwnode()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-sound@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux1394-devel@lists.sourceforge.net, arm-scmi@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-gpio@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
	linux-hwmon@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 1:10=E2=80=AFAM Zijun Hu <zijun_hu@icloud.com> wrot=
e:
>
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> gpio_sim_dev_match_fwnode() is a simple wrapper of API
> device_match_fwnode().
>
> Remove the needless wrapper and use the API instead.
>
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
