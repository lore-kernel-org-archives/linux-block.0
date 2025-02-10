Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D27256C6A
	for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 16:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206500; cv=none; b=klD10FqjmAucunaEXTdVfSpAlTAME1XkjdBuyTW4tTDlvkjYx/ZLBpiqbdRDpBm5Un+Wzezp0gSD1JTGa6d/2dz5UcWiN9l+zNdRL9jvGEYQA2Sg4W7YNQBO/YMYWHIIsA0C0n2hyYgct+mZcqkVI7gxyRNNlNnUh4TMpJqREK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206500; c=relaxed/simple;
	bh=wZAt1whlXvPo2Q1b3Smutb7wMRiPUZhVkP2+sI5mmfE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uSmR2y3UIf+a3XuuRv35m+UkZA2sdL20RVyLK9Rsc0JLlQ9drvY8ZebG4GPm4Lkw0M2ZeQsR/F2mu9sZ97nXXibsMsTf2CzPxqOsSC3pj2hyaXlDvvbSxKbzYmeJcMb4jWNiY1AoGJfwQIJkcyWbx3H3VEZB3+ZCva+PumZN9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=EEK2NvAK; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="EEK2NvAK"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3d13e4dd0f2so28808765ab.3
        for <linux-block@vger.kernel.org>; Mon, 10 Feb 2025 08:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739206497; x=1739811297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8PMYtp94b1is643OuACwo/j12Ah7BR/XT3SC/e2pDuM=;
        b=EEK2NvAKPWynbUphfQLW3JALxZk3eTEAgOt7UDWFhkD1ggey+S+1IlA22MoQc9Rfur
         Z9rOOBIF9ss+ERLQmTbob8SdCB5UI/Xjai+s7g8fHOV+zsnlsXEHXtm13z1tBcVKLzpk
         K6WCLIXy3HnpE/7AXnPrvt/2IC4IQCzqQESz1i7brXXNnvcm1nbh0bq1wXyZAc+aWbzW
         7VnEJzB0RID2nQyvAD9LURFTfGRCh/M+OI7r9f7h3LMDMcEaUWQyYCtdN1y2w+0wPziw
         sYAJVEd6d3+PudbG/zJ6hugV5P7mmuHVgr8Ny4IXRaAY4LmhLl96GNZkNQNbXzNQDmBx
         BcXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206497; x=1739811297;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8PMYtp94b1is643OuACwo/j12Ah7BR/XT3SC/e2pDuM=;
        b=eIlewvWSC0cpfLuGyeQ7xCzcPyeT10M4qCYkEOgs6jIgjIBb64gpZNCyLlzzu4NWFo
         hPuBW3i/y51JEe9JjAXEv6PfptqaT3RVHUulcV527aCM7tne0UeNxlRrhHu7cG5FcZ7t
         SHY7zF/p6Xyg7qETBPdNRIuO1u/N26MghNGCAy954ex3NSljmGScHlQxzmQ9euTusiVJ
         Q5ZKHTh1xP51DFoYOJqiC0LnLPIZ9sA3IvkU+c6HRZvvpxf58qUzK65Ji1yM1Ltjrm4r
         nIvFg+Maym+PP72hWS4HesiBSGT9oeQQfldDF+w5ixtn0Y9vMxdDC/i5WYovFTusCRyE
         PEFA==
X-Gm-Message-State: AOJu0YzrW7myRVgtvwEGRobgjH2KZ3uNJPMrwWH3Rm94jqBxUOfSopS1
	JGANT/zc5hjs+jvUnzWnqW9VZrStwftzL6mXZb0p3M9+JcbKFVujciNkKTGwjss=
X-Gm-Gg: ASbGncuuJG1c4cBFawd3QlAutHIEbUHWA7l6pImKIx2N6RG05gQU8Xx2jaIZzPM7gL0
	o9Z7Jtfdk2v3cx98KwctKm7GGed48sT6ejeMcVPTbmGRifog5S1cPfZjuMhaQ5vxIqRvrG1wQRs
	Ay3paQ8habr1MS8oFcDPm4x06a8mc6vsek4OB5bSs0TnYZ/a9cHz0gK1JVEGpSrvR9xZJV2RcP+
	0dbtBSSMY1U+XXX7AIYxiaP812TTGge3YlWbRTrLouEoA3wnuT7bxB/xpaxBiPGF7AO3ZlVCzq5
	Wx5dSCM=
X-Google-Smtp-Source: AGHT+IEKwKkbjlM00wUkqD43ricuqMhdM5OtDdfTR4TyublFdzI2jLfPM5oMenNdauctjvOXP8xpKQ==
X-Received: by 2002:a05:6e02:1aa2:b0:3d0:1932:7695 with SMTP id e9e14a558f8ab-3d16e494554mr5686395ab.8.1739206496700;
        Mon, 10 Feb 2025 08:54:56 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecdb903a89sm1796514173.70.2025.02.10.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 08:54:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
 Eric Biggers <ebiggers@kernel.org>
Cc: linux-fscrypt@vger.kernel.org, linux-mmc@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20250204060041.409950-1-ebiggers@kernel.org>
References: <20250204060041.409950-1-ebiggers@kernel.org>
Subject: Re: (subset) [PATCH v11 0/7] Support for hardware-wrapped inline
 encryption keys
Message-Id: <173920649542.40307.8847368467858129326.b4-ty@kernel.dk>
Date: Mon, 10 Feb 2025 09:54:55 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Mon, 03 Feb 2025 22:00:34 -0800, Eric Biggers wrote:
> This patchset is based on v6.14-rc1 and is also available at:
> 
>     git fetch https://git.kernel.org/pub/scm/fs/fscrypt/linux.git wrapped-keys-v11
> 
> This patchset adds support for hardware-wrapped inline encryption keys,
> a security feature supported by some SoCs.  It adds the block and
> fscrypt framework for the feature as well as support for it with UFS on
> Qualcomm SoCs.
> 
> [...]

Applied, thanks!

[1/7] blk-crypto: add basic hardware-wrapped key support
      commit: ebc4176551cdd021d02f4d2ed734e7b65e44442a
[2/7] blk-crypto: show supported key types in sysfs
      commit: e35fde43e25ad725d27315992fba8088d1210b01
[3/7] blk-crypto: add ioctls to create and prepare hardware-wrapped keys
      commit: 1ebd4a3c095cd538d3c1c7c12738ef47d8e71f96

Best regards,
-- 
Jens Axboe



