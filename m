Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F264D5A5
	for <linux-block@vger.kernel.org>; Fri,  3 May 2024 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748488; cv=none; b=MezH+mmbTo+kQYU1K37+OZjktcpmpxGss4mUdBLwsGRgE/brvHPbJkhLon8IT397Twq5C8AqxYl6+YJTknwvLUiVQtq6kARThufjo4rtRPuXEBbTkF/TWFHjnIP/cyalC3GORrjToPHLC3n7UAebkTJHDFEpvfutNPUdnex0ngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748488; c=relaxed/simple;
	bh=bLpl+eLC3cHlS0Y9N9cx41AQObMR6LAj7CIJkKPbHdA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XQOMt+PXpsRxTYARO+e7QMXypNN+432O0G7C++SZ3TM3AN6A7a9IZzajlgKNH3oHSSCJ8WkTJTmhdG9FK2pyw0KQqM204moENOpkvQ3O3ygI6+EVguvo5AZfxEhlnCBKUNquJt2RB5pwvt3UqPbONOcNhd/MEc4QTit8EWchnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2tlIGmoh; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2tlIGmoh"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7dec9c65057so43995239f.1
        for <linux-block@vger.kernel.org>; Fri, 03 May 2024 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714748485; x=1715353285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/+W50mIXXR0V6D9VT9w7Mfos9fNAfLYkbxLUUIgBtE=;
        b=2tlIGmohv35flMaCpQjSMHLyGObI1r0uzW4c+JJosqZzfxWgvtPKGgEjE/Y9EmD3/O
         GHlYd6sjpQ3WxvU/OqVnGSxyGESG7aAU+LJ8sHcCB3Rk1WZuS3tHkZFEps81kZTC3G7m
         k+tA9EKM7Q1ZQIOxJ+oJM8dCGjMBfgFsPAPAnTeyOEo06DN/ICoa4zOK2WrvhURd55UR
         btPjkDvhcly6T/0zJSF5ZB3AWy95NJzOK8fkr80snlJhG3yqv9xguDSqQIstWmvzsPm7
         3VwJej302Qc/tUCkF4IKSzrUWAIxkk7S2vH9faiuH6T4KRdC1jvKBPJzB+7ADfHKrSJY
         sYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714748485; x=1715353285;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/+W50mIXXR0V6D9VT9w7Mfos9fNAfLYkbxLUUIgBtE=;
        b=srVMrYoGy8BFuiLIGoQLyhL5K+P+zZeEXnRt0UJjqM2ioIr8tGmp3Ypa/cxAmhes+y
         qmaiPvX7+aYL0+1WINV44lwwfNfYDtM4sNyNbJZk+Q/121Vjmk0DOXHOkV1x7nKPzFIJ
         MOWUvUqx6uOj0H5ZJbAHW1BFGtj+Ix4rD6PgOlMcKC8KKrMnaCpyPFI+cvnbNqpLXm7W
         EF/wkRfMaUi5/xxBl3t8cWv6CPEcx2EvuZzjc1t1kunJOLjHi/I6BPzPghzw58Do4GgW
         u+qW3hfL+Ux8wiXVjizx1UMOtRhDo7Zx08fjrGZZ0oupu2YAEHv6gpI9j84ZCJFIKI55
         zy4A==
X-Forwarded-Encrypted: i=1; AJvYcCXGQx/Wy0u5uCj7r2u/++1C6HDvJVD0CYc2v9GxdnYuCAXuKvwLGmaqOFkAWKU2q9LWUx+5NUeTu+UHQLHvrVYG3nnJQQ2FiWF6U0o=
X-Gm-Message-State: AOJu0Yxbl0pXq+Inrm2OAVDP1O+RhBgaDjepmAhN2jy6/31Ilj7uLaOe
	NMfu2iU6tgekc7PzvA+PsAxzD05s7Q17yq1vaAo5nuYjq51MG/vTFO/DRHK4QVzoJA3YdQhBB5Y
	I
X-Google-Smtp-Source: AGHT+IE1lmWXQZa1cS7tjNvbCvZtTo6DeWZPyEtnPU/rTj4ojd4A40hom53w34RK7kLLTnHcdDfQ0A==
X-Received: by 2002:a05:6602:29b3:b0:7da:8d35:8a5e with SMTP id u19-20020a05660229b300b007da8d358a5emr3200030ios.2.1714748484850;
        Fri, 03 May 2024 08:01:24 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dv9-20020a056638608900b0048804afe56dsm807988jab.133.2024.05.03.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:01:24 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Lennart Poettering <mzxreary@0pointer.de>, linux-block@vger.kernel.org
In-Reply-To: <20240502130033.1958492-1-hch@lst.de>
References: <20240502130033.1958492-1-hch@lst.de>
Subject: Re: add a partscan sysfs attribute v2
Message-Id: <171474848421.32509.14457923100343769108.b4-ty@kernel.dk>
Date: Fri, 03 May 2024 09:01:24 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 02 May 2024 15:00:31 +0200, Christoph Hellwig wrote:
> this series adds a patscan sysfs attribute so that userspace
> (e.g. systemd) can check if partition scanning is enabled for a given
> gendisk.
> 
> Changes since v1:
>  - update the data from the non-existing month of Atorl to May
> 
> [...]

Applied, thanks!

[1/2] block: add a disk_has_partscan helper
      commit: 140ce28dd3bee8e53acc27f123ae474d69ef66f0
[2/2] block: add a partscan sysfs attribute for disks
      commit: a4217c6740dc64a3eb6815868a9260825e8c68c6

Best regards,
-- 
Jens Axboe



