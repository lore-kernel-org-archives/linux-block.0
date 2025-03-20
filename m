Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C521859F
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 11:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742468944; cv=none; b=ctGPIg5RcGNoh7Xj5S/MENUGHNQs4YMRnPq6sWjvjxyYwAfIC7Y4VAzxfDhYOKp9O4skQpwQAeLYR643lnR0nhsf4GVSd1JxuhyZAmWvZ6xOwUudGo6JhznXWSvgo2V/y9P9NgFb6P4l8a9NSoHD3BtbXPCpsAI1Y04z4qUE/0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742468944; c=relaxed/simple;
	bh=osW1kFCLI829UxP/FGQhh3fUcKf9g9/SFfLRTZNim5k=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cBp13p4COb3XgbZ7450tfboKEgT1/s1ZcQLfpUDsEpSiWeD5O2sBSlLpgeLgxsoSSX6xJTLEPo45hH/m8pOYGaxU16CvLswd3i8DGl8hBRnr6Es3Z469rjSWyPyOuFgboLWZIoxVc+cvIGHXOBa/epLrS+33wLKODA15RWVmaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QH+USH5p; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QH+USH5p"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-85b4277d03fso24053439f.1
        for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 04:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742468941; x=1743073741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AQO3nk1/bJyBeu7gYPGuEGHyQvMd43lPro8TsMhG7Rc=;
        b=QH+USH5pbe2pCHc2O7vFnkKbL33WdgH/koirnbQam18Nvain6xMXhCZkXuPsBMvN4k
         4ofrlhefzia1QvYdKlA5m8k911lQRRptphl02xdioqfcK9dmHEyAQ+UmMHtm3jW8DvOV
         WjCITeafkBQxKPih/+VTrsx31hdHwcIInWN4ihsXCmI2dxf8JZMdG/z0ocoDDmkXxDmu
         T/gQ2BqxKIuIJWFlo2KhF64huGGw9mjg0X4f8Sq2mfq3gcoxDbgzWJpiG1LMoF3EbDhx
         Lmf5WIjz1jkX9O8Prw+gYr+cHnxiY0Q6yi/R/BdSl6LDPDxIaPHjwI7kT0dXYIRInEFn
         3Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742468941; x=1743073741;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQO3nk1/bJyBeu7gYPGuEGHyQvMd43lPro8TsMhG7Rc=;
        b=OqoJisFfKtbN3eIIN2duskliBkCR1BdIdS0GArdaXY5+DaV9pIgXNqxBlgHvlSPt8R
         2+yldsD1jw86ylSEkJwIhtgDJD55gekhDgboRYm6j9dnBw36uu/f8tBZ8r/p8GjEu3aZ
         eMug4yFHG6zsEFsj9+9wIQFKFI7fypugk0MjbRTGzXZNDkp0Cm4VFV5VjiZV8PVr7CG7
         xLlBwn38ncRVTWG00iApSldGGU4WAnpFRXnIB26Z1wHbREpWGOHJ8uEyIJ8jMQKqJQjM
         C/OWS/q2UH0RLGKmv1OEZDJKFJgUowsalVxivOM/ERj8qJBbUFspmxECnykFu90Pwjde
         oPnw==
X-Gm-Message-State: AOJu0YygxZti2cxioI8Ii/+LckKFNol2R+IXIv7ZQxsDyarXNFb2bP/A
	F+CymVPaQJVxPeNiUHbK0zJPKK7C4CWRRHX5H+lVSd4QBwNL7mLP9x1KlFJw4VTp4pKA/cO2H4e
	H
X-Gm-Gg: ASbGncshdL1FktzlBB8lMZVbJZx/9C2eIbltHlYYhNmKIjMuYEqyNM4p4tAKf7p+wU4
	BKApU6wWrv9ZhHJL9AvI5Hb0G1sro/NRbxZhOdhFe9b3gomzKWkMv+NeYymt57Jxw669SyrpKkp
	g9j6ZyZKkl58oDytbRWWJf3gss6oskjHCBwx0EBCWhnXCPfcYUw15GBpPIwVpIkx4h4dObSOjoN
	3IGA9liqt+/l8ahnMRzVLMxPaC07MOW0Q8piH61BdEjeNuQXhy9LOCXu4Nx6gCZrEZNIBhpGuz/
	EcpkTYyUSiMt2R+AIgIcYUS6MekPU/fpb+H5pN7Aez8eqJ8=
X-Google-Smtp-Source: AGHT+IFcLzuD/j+CIrDvaODi2fe2CChlMK5uLwIgsrPIF4WrM4MdiSkKHy7UDBlj24twtpLAeMnrFw==
X-Received: by 2002:a05:6e02:1c26:b0:3d4:36da:19a9 with SMTP id e9e14a558f8ab-3d586bca3f5mr64346155ab.15.1742468940922;
        Thu, 20 Mar 2025 04:09:00 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d47a6471f4sm42719585ab.10.2025.03.20.04.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 04:09:00 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20250320013743.4167489-1-ming.lei@redhat.com>
References: <20250320013743.4167489-1-ming.lei@redhat.com>
Subject: Re: [PATCH 0/3] selftests: ublk: one fix and two improvement
Message-Id: <174246893994.142306.10519066135151858121.b4-ty@kernel.dk>
Date: Thu, 20 Mar 2025 05:08:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Thu, 20 Mar 2025 09:37:32 +0800, Ming Lei wrote:
> The 2nd patch avoids to show modprobe failure in case that ublk_drv
> is built-in or not enabled.
> 
> The other two patches improves test deployment.
> 
> Thanks,
> Ming
> 
> [...]

Applied, thanks!

[1/3] selftests: ublk: add one dependency header
      commit: bed99afa346e220bd3b2c767ded44ade21685d35
[2/3] selftests: ublk: don't show `modprobe` failure
      commit: 51847a3ed0ff088b83135d535dc9db26c10c706b
[3/3] selftests: ublk: add variable for user to not show test result
      commit: f8b2ce9ab8f8e0db224378fb1860e5188c89b2be

Best regards,
-- 
Jens Axboe



