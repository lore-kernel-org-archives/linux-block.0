Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D626495EC
	for <linux-block@vger.kernel.org>; Mon,  4 Mar 2024 15:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709566327; cv=none; b=RmIpCjNC7yX7dKu/e0hFAhw3Yx1oTUk8cI2m+RtKW+3A9O+BUfe8w5iDktY+kgO0RqU4SUMCnd6HST8QdTQKTawnmU9PQT1PKVT31LJswdl9ZfCqvauSz/G2u/kzWeuj2ngZ8JvMJDdff6xlNXzclOjtLaKfWy3MN3mBx35C1kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709566327; c=relaxed/simple;
	bh=jkZYHpu65nwrwTsuxM4amko09H/lzM/u/hvt7PWXRUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILpxyPldsl2lKL5h0/+17O3wv0VuHU8rq4bXoVqcU2oEWci+CsFZObtVUs0W/00sDwZmAofLTQa8XDppZLu+F4i+cgujOxwmhuJcBs4uB/MKYGbrEJyIq15dObZIKTLmeJ1skNdw3YcZE11KRIfb+n8+kREvsvSLchJ/TWJ/Nfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=APVbBsiC; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="APVbBsiC"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so5319385276.0
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2024 07:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1709566324; x=1710171124; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jkZYHpu65nwrwTsuxM4amko09H/lzM/u/hvt7PWXRUs=;
        b=APVbBsiC4r5Yh5f0trQCGYvtW7hQVgAgciZArgpTcKvs58dEcsKNfSm4f3xAf1qXQL
         j1kwow8rFuh9L69nJw6ki1Gdd0VwwXZ8W7GizqXr4zyXRVYYz+tOWmCM7TP1qDpv+MKA
         se8+Gx/RE4bR3IlXlAdcGSJ4aURzbvdA8BjGg4jdS+XRbUXWZSyZowHzTZgqAP0DKbOf
         fTIMBCjOnX0tOtwjQqghSjSA7SlvIZSoZWQn7nsiEW66O2gxlbqwqavLy09L65wDxdt3
         Mv/A7PlItYg0LAdCBpZeWyQ0XaxzWV+wJZUx4AyxkFq/kYFmpMawtD0EHI/HFWTZwIzj
         uixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709566324; x=1710171124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jkZYHpu65nwrwTsuxM4amko09H/lzM/u/hvt7PWXRUs=;
        b=k7/kkSGAg9DDK2eGatmhaFz329r5TaXWQL48hbtX5U9sp7EYqezMf7mr/v124OtKs4
         HQyyz/6PdgMO0wj6zYkR9jFV+LioAp9znIxFeRZ/7XcLl190nbhNnDLmMQTcd64X3XpI
         lxUJpVL68IhMYk3paokmJ2rX3mm1Nkpce/X84tvmZ8YD+CgoI4+MnwJkMv+ltCs8racc
         ufowtKsF0Rst2gld4T56Kk6cckwt5tPEpCUPxUntf4ACZBvhey8sw9TafgGs9EQq2zgX
         HNf3BuB7E6ph4+puksykI85Fevasbeger1TLQjMw/tNCMiB5xVAmkaXHCOK+Lgd0Q8iX
         eIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJPwrO0ptONpFW3dl1ihdot36h0ylRkt9+DZXRiGXtnHljmKtBm4nHaj/FPs1V50MPr5YQQq46OMpAw/uOOBiKbV5GMYiJ0Owizhw=
X-Gm-Message-State: AOJu0Yy/gwrdu1uS7AuAEI6T6W5FcQSw6f6d0qmbHNFG/VOP62azxOKh
	GtjnrDkee4r5FIgExge9zvdBtb/b+AEVe1Ojc4kz3ZCCWYfiUQjXZXlEFFmoI0j7kiLodJ0GgXy
	5e3qSb0bNWbKoF8zMbusb1rKv+5/20aMo8LpaQJ2pK/T6/noJ
X-Google-Smtp-Source: AGHT+IHY1zzIo7EvQhjnMmC8zo2BroV2k0mHjtxSH3c9xuozB1/KwhGD5Fi33Ama/05oNzEzJ7bkxUgZDWr7JcM661E=
X-Received: by 2002:a25:ac5e:0:b0:dc6:d1d7:c762 with SMTP id
 r30-20020a25ac5e000000b00dc6d1d7c762mr8613958ybd.11.1709566324642; Mon, 04
 Mar 2024 07:32:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226103004.281412-1-hch@lst.de> <20240226103004.281412-11-hch@lst.de>
 <20240303151438.GB27512@lst.de>
In-Reply-To: <20240303151438.GB27512@lst.de>
From: Philipp Reisner <philipp.reisner@linbit.com>
Date: Mon, 4 Mar 2024 16:31:53 +0100
Message-ID: <CADGDV=XqJ_3biGx-rX0jMMue4-dTg=J8NjyHOU-Ufonv4QiJ-A@mail.gmail.com>
Subject: Re: drbd queue limits conversion ping
To: Christoph Hellwig <hch@lst.de>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>, 
	=?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, 
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

thanks for the heads up, and sorry for not seeing it sooner. We test
it overnight and review the patches tomorrow morning.


On Sun, Mar 3, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Dear RDBD maintainers,
>
> can you start the review on the drbd queue limits conversion?
> This is the only big chunk of the queue limits conversion we haven't
> even started reviews on, and the merge window is closing soon.
>
