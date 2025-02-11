Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3F1EE01A
	for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739261546; cv=none; b=TS7OPH46iO01slJt09h4ViMYVHepEsU4QfHwt5ssInnCDRnK0nfqhiqFJRABLwx57RhJhP1TTPxqU22XSxbJmGeZ7gGSo1JCvorLjABY3yknk3SBS/SofzOT1VvNPcb1XrZMuKByj1p2/tTIhz8mv+Y68FoeclnHL4Mtg1Vlz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739261546; c=relaxed/simple;
	bh=hDZF76s0+s3nQKWmMd335G35ca1BnoygOxqTHvKFjnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhSAyDKRcZAPyxYKOuxs9pBdP3NSmlYwyn04lvaQNQ15TPpnRc6RAQuphPenti8VizGVEPFM7mCVjObZhEk8V+s4sWE3xvwJ5KuIqNhDXtR7KXDVmyO/bIzU4t1kpgZ+oo2dZj/CjXqCOJdzJHLmrOuK4qP+MLXbptw0lHCfdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Srii4Zhw; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Srii4Zhw"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-308ee953553so19207641fa.0
        for <linux-block@vger.kernel.org>; Tue, 11 Feb 2025 00:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1739261542; x=1739866342; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZBPv6QOC9HyqG83lsiP8B3hCPsDW+zwfD1sc16aqzQ=;
        b=Srii4ZhwIpcHAV/jIHfFPmKfWk/E0t2DcWQ5xr3tqSSXwPf0gzdKhZ7P/9NfRSbNqh
         HNlcWekNIUwhrD5OBkeu5rnRkVPia6JIhzIJag2lx5/N9KNM0ZNp2308kS+guuYQxDZD
         zC5O2OaiysN+F9WW/VBtPFCNWPLptJel+mYVXpc7MkAQe0S+wdk/q7MV5mmatdLmWi/1
         mARSweym3rzCGN3ZFZ3002Mc8YKQ86J8SdkogDjk4G6vK838i3rpwJ0+JM2gxAJJ4HwR
         l16WxqA/jh5S8JnV20UxPB8C0HZmRwhZKMs44P/2T3UKxcWEyRHR/ZCyV+WehMWV9XWo
         ToEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739261542; x=1739866342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZBPv6QOC9HyqG83lsiP8B3hCPsDW+zwfD1sc16aqzQ=;
        b=LnbGfR2MjIi0KIHE2BYHNn7fFw549tdUhJ927pfLUzbGpYld3IheizP+QmE5X3VLqs
         laCalpyYn0L5bTM5eG3MPKOMcHWzc1ocsWO7GmGp7fAS5x3gGhG6erIHsDHwjyYZiG4C
         tn4vx2lWgt6s3GUPpMX14UtkiPGr9Vsjz0GiYptu6lfLfmLgP4LiOnuM4xufss49/IS1
         2iyAVK7WOVMlHDzZR9ZkYq83Wdhs7FpCk4bFnKgbNNv6xSBAcZ2zysiOVAUZoFyQl1jF
         6V+22VKxiL+u9SJSCNULjWYpcTDifQx7Y2jcNu57Ila9aiXvj5/cyk8enwpidixohbkk
         2Vjg==
X-Forwarded-Encrypted: i=1; AJvYcCVVc39V9G4T6m7DTqoFYBSVktu6XXavF8jBfQfT4mq9mWpQcNOsE5H9IZf6R1YJkL640dZM8vIbMusWJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyowRsx75LpkMVG+alG8fJTDQjUwXSAfp+gRwfb7/UmVch/J9tp
	aC+1gQYvDsTaRoDscSibiAW/uZF+pBPMudpu/GAtVfB0U5R2DcW7iY1aqoaH7PuhgBaOHNjRgE1
	pDQ1f/QvY1uOEbPmz2pNepSacJilOHwMeecG4aQ==
X-Gm-Gg: ASbGncsQkdi4PzbyBsvWSuRLmmIrYd5mRc/lwbI3fnHuZkCNLO4z+oYAhxiYiClg/WV
	H11c2BAuCbgfP26ZAfrBnjGYD6dpKVSsybYhHwq+R86l7AM76rQbhxByB0uQsTXYf7xDCv3luqN
	DMOu0dCfNs68nfzDWvcwZ1xdaMJR4=
X-Google-Smtp-Source: AGHT+IHsnSGZUFQMOoiXCGeHwOhkS4uzUDRmLLENwo/njPODTJnW3qTKSrQ7Ha1UrP2LHvzY0dNeNgevSz0lHNMxLPY=
X-Received: by 2002:a2e:bea4:0:b0:308:fd11:76eb with SMTP id
 38308e7fff4ca-308fd1179e6mr4836001fa.19.1739261542476; Tue, 11 Feb 2025
 00:12:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210202336.349924-1-ebiggers@kernel.org>
In-Reply-To: <20250210202336.349924-1-ebiggers@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Feb 2025 09:12:11 +0100
X-Gm-Features: AWEUYZkUIVqXHClndXAUtENhhMz-NcIhEeDU_e0vb-Z-ySUsEFA2hwDxIAg98Qo
Message-ID: <CAMRc=Md0fsB7Yfx9Au1pXi+7Y_5DQf2z430c9R+tyS9e60-y5w@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] Driver and fscrypt support for HW-wrapped inline
 encryption keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 9:25=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This patchset is based on linux-block/for-next and is also available at:
>
>     git fetch https://git.kernel.org/pub/scm/fs/fscrypt/linux.git wrapped=
-keys-v12
>
> Now that the block layer support for hardware-wrapped inline encryption
> keys has been applied for 6.15
> (https://lore.kernel.org/r/173920649542.40307.8847368467858129326.b4-ty@k=
ernel.dk),
> this series refreshes the remaining patches.  They add the support for
> hardware-wrapped inline encryption keys to the Qualcomm ICE and UFS
> drivers and to fscrypt.  All tested on SM8650 with xfstests.
>
> TBD whether these will land in 6.15 too, or wait until 6.16 when the
> block patches that patches 2-4 depend on will have landed.
>

Could Jens provide an immutable branch with these patches? I don't
think there's a reason to delay it for another 3 months TBH.

Bartosz
