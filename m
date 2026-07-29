Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495AA3BB109
	for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311746; cv=pass; b=lv31w2pRA0ViWx15NejhWFutd9ZXvTwRGxitaLe9/eX4bRs3jPlGrYtil9zCyeeTVVPYOfOLBvg5ev7V65bx9w7760by6x5AziZRXEZiU8++r9tSNC25vxFCp+CugOsBM2bolZ/1LIMLnN5png/92sIWn+KM1kIAZIlGAgRu7ys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311746; c=relaxed/simple;
	bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBqFAyBfPuxeATdXY657uQhZxiWZ22r+lgx7Z/LKu1dhazFjGbzRGcK16Z1KoEz/cKM3SbdhOCjOUavBd+jYk1TZx01BJRxDeMxrmgguA+eXhM7KtfiPUp1kD2cvqnaw3UmaIepcBXqN1DAfWHC64VKgr7BC2TsDlh3e6gJDkD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UhLVYD3e; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UhLVYD3e"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-69fec980a30so637388a12.3
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 00:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785311741; cv=none;
        d=google.com; s=arc-20260327;
        b=JH8M/Vqn4csh80wt9xDlaghYCUJ1GW0yX5sDUfA3uXTxT9hFig1DyEVk0VH5VvoAxC
         lFbI5/OOoJGZm6sk+8/71Ryrtc0PjtS7b6exeoa0FTt81tJkZO75fd3kEtxWRTbnl60Y
         sD81OtrogpRTdL4mxGY7QVR4mnB6sX/II1F7Cv5riZmT6tXeTvAwTM8EUCl+tjGVx1HQ
         0F2KojIjH5ixH9/GXrrntIoRFwlPm02oI4jZWxFnPUXKfUuyNJKMhf8jFEx0PFxKSm9L
         CVw2MfxwBlSod6Lw0uzXrYeO2DJRXXGxJpx1Kg7OyZpIf6AZw5LlocoPT5hFBfJGmS5O
         ltkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        fh=frMk0+wh8NN7iCzTPnBCE5+cXbp0rScws8PSc8Otszg=;
        b=A/eu2OsOHlAFRuCjL6jo6hC1d01FhDaw1BLDsx911ClHLOXdqAS6Tkhle+GOLbPyvo
         lzeA4K4d/nG4sy6Yjb6sO+Fc3rrG82mdOrnjwvWl/4iLtt4kqOt6brCKWpYjDqmR1vQi
         SdXuKqIDWfZL4lG90ZkQsGetJ7cue3VPsbjQ7OtTeTvROCOhCneOKQFsq3Y7I3yDt5to
         9nkGD1LKE88xE/cEenxKsCxL5tGAVMgsSDScEN6LyAQk6qOwfAMvjK8vHwhtmk696vFm
         JEd3QPSX0On3+bc1af/1a5px1CWf/6OgY/VzpWejmMk+iReUo6Sb14CIyuMUsZAp4FIk
         abeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785311740; x=1785916540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        b=UhLVYD3e7yEYNYzxHDgQejinV/JUwNP4KfcnXI9Obr2aj91q16MQQu3muT9HMK2IIa
         eJB9ujnX90U8oqvoA/oaDfVPrBn0PlZrsGZGw+DaDdnIceie9Z6tRCA73weT6IhZI4Xf
         rPRU3rLv5zFuk03lASRdUSKUC/xsLjAxhI8x/GJ/l/BJ/PV1zPYtXxNxjD/QQT7dNFnY
         njDsRDrfWovErpKJpqyqwpemOoC8FeyIfnzvM04w5XNa+gLhyPX24SrS9XHIOZVA9bCk
         4HN4Zr00tfk1eknEWPOlLORVQMF6eQjZV5fi5anf5/eghwucdXcT1L0pVKMfVV4WEk9t
         m6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785311740; x=1785916540;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=usrfVYHsOydTgFDHdwjdurPUbbzlE2oAC72hFVI74H4=;
        b=soG+s91kq6j6LxLLeUxu6UvjanO6I/g3xtnChIdYYAzepwL8qVroIxqFjzhL3ePwqL
         kEbLlvM1y8l9hqS3URREZWdWHFcqt5eIqECbfm0itbadjlkwq+DEZZYkepUx8JBL666Z
         02jeOs1xQNaagUSAmv0PnaZmEdsZYDzBY2ZM99dxbeot0dhHOs8Z4YzDSjSp7/m8WOD5
         IyLCocN9gat5V+0R1N7ORrNOKSZ/+cpx9vMoALWellCw+RoPbKoHNi3h2Q+35SFl3L21
         NhZvPuHIolO+Twfc9unxKs478bK2l4OiUD1mLxt4oiigscIlQhgAJ90txaDh83QKI/ES
         VDtw==
X-Forwarded-Encrypted: i=1; AHgh+RrJ6A+FKftp8dKn+93H1XODiWizTTA6JH2js1ONuY9uKM7P0k0QO7mdPXJ1p1e+CvXF5n+qbPj6TJ3aQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGO7frzBsD07SvdajzkATxA7jHwKAU91m4AHlCphE9eFscQ7US
	PMl/gb/tyRx4Eltph8HlAtDeieat2YrVZ+2bhY1Inh4n03VZfcrrREsPKwgvUc17LLjfgFU4M6m
	BAE1wuLyAW0pAg3eWEOhafOuJAMOILvE=
X-Gm-Gg: AR+sD13tH9cBrccbuypgavQRj+yoaSJWEjLSsWGLqAiZblXhR+b10XvcQwG6KPxzZZQ
	x2488xLERqxDIOHvbMZVgnWq9PaS+FR3lvfAPsjDXaQyfJm8fgARtzMsFjxE/u/nzYvUuBU1fXB
	/2SexjaqESGNcOS/4mhSM6eOJ7R0BZiTfTNn9EknMmEWHlWTmr+WxKbtcHGTuDgUP80EkBgV2+y
	WNzW3TNFeZwpFs4hcBhZh2SmohPVC135foOb/IAeqxLhTtn4XXsMkbPCDT6zftXEcXgWafVIFOH
	SWSOMIBssZySSGIWnCIiV6l8VJuYCrzz8mwquol8UuVNyX+uTzSqaJwsXSZvE7eXKJUvdve+pL3
	D
X-Received: by 2002:a05:6402:52c9:b0:69a:bba:a526 with SMTP id
 4fb4d7f45d1cf-6a034a737e8mr2702089a12.29.1785311740595; Wed, 29 Jul 2026
 00:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727201257.211635-1-coshi036@gmail.com> <20260728042356.GA19874@lst.de>
In-Reply-To: <20260728042356.GA19874@lst.de>
From: Chris S <coshi036@gmail.com>
Date: Wed, 29 Jul 2026 03:55:28 -0400
X-Gm-Features: AUfX_myr7JpqXMkOy9tcHEjoMtEEuRi-rrvzumCtNMx_grG_fNvGn32KWtLiE5c
Message-ID: <CACd_6n12dp2E7URMaEFtD-GUkL9K6viDWjU6JRd7ozu81BPJ=w@mail.gmail.com>
Subject: Re: [PATCH] block: stop the timeout timer when releasing a never
 added disk
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>, 
	Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Weidong Zhu <weizhu@fiu.edu>, 
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you!

Best,
Chao

On Tue, Jul 28, 2026 at 12:23=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
