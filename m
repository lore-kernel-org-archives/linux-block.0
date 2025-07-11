Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C622E9739
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752245256; cv=none; b=FPcE76jHF94aYDk4tR1duPvfKyFWEIy10lOaW8DlbtXM9qWfpvmZcsbQbR1BJchV2UW3ZNPnJOevOXWgfhZBhT9Na4KW1S9TM4/I9gKETFG+1yCY2sAkSmSFv3fh49eFxiqx/Ovrfo9+SrKOvLKW8Q1XOkQEhclbmUb1JWYC5og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752245256; c=relaxed/simple;
	bh=40YLiJGtlMV75vim5GTwj8WRKEQtxPlQPilZVhGD5Vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L7DWjbaZ9FN2NgOuaM7tR9XhsKDu+Z659DdAxBGcPNgqJff+nI89ENIujOoypW1IjhouwRDBQHd9gd/MOonj6HMVUCu5VeyZtnSDYQFWbP0bokx5kR1e9sGYSvznp4CKDty9iNux6JBS7dtj6NbBZ5V8HA1enYpji/31uBfugRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VXYxD055; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VXYxD055"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso12834485ab.1
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752245253; x=1752850053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd/YQds+2VAgDHHik/Mx+4kMgTfoFA0V9ZGlHTyX8Y=;
        b=VXYxD055b4Dyv5c6uiHkCkNBXbe6OtAH85SXrXCDidViW8PJw1ynj+f/Y7o76Tm+Lc
         kB4F4DuxiECjGttJ0GmwZXYLLxXGDDG0Wds47/R08zTjMExObmsYv7hORVmJQB2Ezp5I
         dbaJ1zZ52Do65Jd+AkO9pUI+YYnQee9xKigdfQSv+h4xxK88een8swj3rgSl4lXrWTqz
         tB/aPE6gnhakf2lUJNg9SaJd8a/JhMOk6GG+LbK2YtqUPAF98WlsuKAdaMZ4+RhXZEDh
         QQ0XTD3r1TAH8ebQJ7+UUPUjTE1K9TI4FocmPWsoQO8Uc+jeHU9JHwVbwl1691QvxIg6
         ljAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752245253; x=1752850053;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zcd/YQds+2VAgDHHik/Mx+4kMgTfoFA0V9ZGlHTyX8Y=;
        b=MT3Aby14KQ/RUEWLN0OPhS6z/ru+dM+wkggqzwu7lXWYmxlOvr6KN2Ew63V/lJr7J5
         pvfRiVWROit2x65VDah4psmC9pdXHVV0gIWKDjk7AfJYQqv1Fb0MOBzzLg+YhAPnTcND
         UCowC243OGOF1sgspd9XHJQCOzOZIA08YvNM+004g7iwzJUDZjPvYBN9i+pGiUFhQr/3
         huulpStG/8WwJEA8Hye5zMTdCi6x6Yeode4ImfRtUgug9URUXjI8/UgZAE+uS92gaLB2
         sFM4H6Zj5Kff2wRcmDieMD/YwN8s3tGsGttam9NeVTRI36piELuTGhgUmajWxJKcqYFk
         N9+g==
X-Forwarded-Encrypted: i=1; AJvYcCUkOKrsQ+uQBS8EYhX4cUEEPb45JmCSnfj/0CY1GOkeeMUryKFNDeAcIROaru3UloGLuGlc+OOnmoHLHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hltQgrkszbUglNIqgO0ybXTwDIv6m8jp9eheDlk/cIXTUwpS
	UZV6jwaGwOtV8zp7IZ5hWFRTs66pn200BmujA7P56MFxJ+VkkDOqI9Iz1f2n34XjaCs=
X-Gm-Gg: ASbGnctpEKaUNmT4+Yy5OL9WtV+PyUT94izPSDNX9xxQpMfuIpOZfstvZ0n8knSWAsv
	UhphmKwZDI5aZaEGlJ24ojOFwyk36MU7fFsIc74wSRN81xVo6enA3R7ge0dbKkhGoAL4ZlhV1zz
	f8NHfKfG0HW0DC6CLGrkQ9NvHDj4VHGop9P6nKeAixXGxCbbSm67qx0L9HpiPjB5xSOLu43PXUd
	+3qJbJ/ryC5LNMTBJ0xaPgNHQbSlEUBpw75RNU3HdkzmR/SqyDU2Qk0ho5syHmHe87BL2pfuGac
	W+jodattg5t4zQTJAOTtY+MtF8lIsn0vqR1m+IY0h1GQjPAtnsRaeGDZFQ31IP0dRB4SJ15PEQn
	6CWn1NUe31YPuGYa/sUQ=
X-Google-Smtp-Source: AGHT+IFHa21P15JH0dsJFMLE6O6OM/qUMychTO2XSL+yzRmWrNM0AfUhxkqN0w44VxXhBk955nhVuw==
X-Received: by 2002:a92:cda8:0:b0:3df:2cd5:80c1 with SMTP id e9e14a558f8ab-3e2541dc704mr32741355ab.4.1752245252959;
        Fri, 11 Jul 2025 07:47:32 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24613447asm12376765ab.17.2025.07.11.07.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 07:47:32 -0700 (PDT)
Message-ID: <e3450519-dbeb-4741-9772-7e33462155f9@kernel.dk>
Date: Fri, 11 Jul 2025 08:47:31 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] block: fix FS_IOC_GETLBMD_CAP parsing in
 blkdev_common_ioctl()
To: Arnd Bergmann <arnd@kernel.org>, Anuj Gupta <anuj20.g@samsung.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Naresh Kamboju <naresh.kamboju@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Keith Busch <kbusch@kernel.org>,
 Caleb Sander Mateos <csander@purestorage.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Alexey Dobriyan <adobriyan@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711084708.2714436-1-arnd@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250711084708.2714436-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/11/25 2:46 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Anders and Naresh found that the addition of the FS_IOC_GETLBMD_CAP
> handling in the blockdev ioctl handler breaks all ioctls with
> _IOC_NR==2, as the new command is not added to the switch but only
> a few of the command bits are check.
> 
> Move the check into the blk_get_meta_cap() function itself and make
> it return -ENOIOCTLCMD for any unsupported command code, including
> those with a smaller size that previously returned -EINVAL.
> 
> For consistency this also drops the check for NULL 'arg' that
> is really useless, as any invalid pointer should return -EFAULT.
> 
> Fixes: 9eb22f7fedfc ("fs: add ioctl to query metadata and protection info capabilities")

Since this isn't from my tree:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe
