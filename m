Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9812F285C96
	for <linux-block@vger.kernel.org>; Wed, 12 Nov 2025 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931652; cv=none; b=ZsL4dAOlHLL8r6fWEv6zNH/cW7iCkdQwJ4ORyurTxCaq5qcv65FGWdI7I5vZrDwXe+Gqt6sofhuYTz6IKWv0kvcZm1Y9D5SaIKBcO3n+A76J3EmFysY2TFdKnHujn2Yyy4IGkKpOfNwo4V0iW+Rsu8OzDuULLC/bq/X9rEx1TKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931652; c=relaxed/simple;
	bh=cUgCmt7/S4H78nSegwnrwPgzDrfISuJQ8hnVSCrlVDQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C0PajoTe2n7/+0Rv87IVq1sYUeG/SFKkc9MnGiSrv6NqWOl1Mu/ojlM5B0S2bgHCNgxaard+In+BcCnTBDa2w2yzYAzt7WA9uqeUHTMUe9EKiqChWH88YyDG4p07+kaLSXfop9KHTwTyAt+Bq8vtNHYNS2K3Fcj3MMId1uds1gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgH8q1jr; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgH8q1jr"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aad4823079so486620b3a.0
        for <linux-block@vger.kernel.org>; Tue, 11 Nov 2025 23:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762931650; x=1763536450; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=XgH8q1jr2+XQgLkfDKCa/eUWE1ZvSrkjRxtr5lBbLGxRYdtzxNaRzJKM50Ux2SEHOn
         0BlAjFIYdWeA6qeOVyyZmDrK6k4OKLxGTQYKjGI7qHlLKCwbVIW0OFzrgEv4v5ewBziv
         lv4ohKUGv7dG6To2zsCiMcMO+Ruuo3xwZdTgTqKyLYSvet1wbq7QLkzDOvfx78zFlOw+
         MR3w5gfbC9TLFm1qlc0UjFCOBC78Zar1o6Tx335kme/yEGz0nsP3JeYSRpYmnGxuxOuv
         z5Wpi3dE0zdK4SoBYUa7rWSOkPUcOAf6XQY3Au3eII4YW4J+vud6XV4zDnR1hSYZ39Yj
         SQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762931650; x=1763536450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8sb02e1W+AKeJ6wR0eYaD2KkfiM6HqalBahoIkkYHA=;
        b=un1yCDMrqz3UlldI9H+EoEyt3pWlWFUOQhc3Al7kcqPICppK3Ex1JAWQ66bodfzKmw
         7YM1xc+lXWpT1XrSVTvk7zZyMnj/s+ks5ivDCY5dsRleDzbf3TDc6qXxUSWHjyzZzwZ2
         f5qYSGfJp/MnngkkEromT6nOkPTbeLUjJGvdoB9joJUZaKNA2j+/1nUTGoC9YpEIUjr7
         sfrsOmaDUBnQPp97v5jIbF7zN7d+XLbWYOcSPcs8bw/bLaT49dRBfAxUr0etl1odBNtW
         +40gYu7XJzcLIN/jwG6YKoZKfHWEnAQB4mJqO2qRPK8WZ7wYkO206RgBfqNeVix8ZQuG
         OPiw==
X-Forwarded-Encrypted: i=1; AJvYcCU+6TgjyryfQgX/dYW6Kc2G3Wi+KReoseqvMXZqQ7gnqvmpeRwDWAt1rHMjbN1gvvGitG0I1EhHwBgwkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gDNbjnqfX7hpRUyFNjm6Wx97CNjBaIgeK8Y59BRE8qtb+w2Y
	FmOcAbyvEIGnXUfQ6OHIykJrIdg4lJ+Y3aybKpLGPX0+Ryuu8QVFaahP
X-Gm-Gg: ASbGncv6nSrqLBs16TzOGICNAne2a4Cm99AW716ueEEyhrVrCrKvVo1NSr7PiCRLDgx
	4wnHAJUwWHnxqUiyB3VPcdtS/O0iUaUkwCPfB6magsXkxWvD1iW9M8OtWilLiWZCH8pRrPAu9Tm
	5I+DcR36BGOJKZ3mMiIiiyYqM+GJ0Olg+9YxbIg1zutyMIeUYrQGJGz3exemuTONP1XLTeVTyGq
	9mp4w25OiqbMAaOXlbOFPTeVoMOGgrR0JY8yCADMRSXPHHhvY7aG3ysAdxq1dwkrP6gdgRoXSP2
	/cbOfOkCtIyQWJA4tsHmMX8mMr0KOqHXt/KQSxKHmH7CAb3ND2RPssOpKyWxQVk561RvuuPLmUU
	HvSawWbm3NFZM12WsIxRmR6mL6JmTUDPItkbp05gNxrdtHoEFTrXL0pC/hCSdOItXRBqAheRlvd
	2E9n8/wl7Jph2iRuac
X-Google-Smtp-Source: AGHT+IFxIDHbMDQtJnDd1j29er8I9W16ktyYHaqy/e9kdgu1LMq6asMSVrMWec36NOc6lpyOhk0v6w==
X-Received: by 2002:a17:903:3d0b:b0:295:9e4e:4090 with SMTP id d9443c01a7336-2984edde5demr21733055ad.52.1762931650013;
        Tue, 11 Nov 2025 23:14:10 -0800 (PST)
Received: from [9.109.246.38] ([129.41.58.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dca027esm19947645ad.70.2025.11.11.23.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 23:14:09 -0800 (PST)
Message-ID: <c91c87ab-dd85-4c42-9af4-a25ea2540de3@gmail.com>
Date: Wed, 12 Nov 2025 12:43:05 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] xfs: fallback to buffered I/O for direct I/O when
 stable writes are required
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-5-hch@lst.de>
 <7f7163d79dc89ae8c8d1157ce969b369acbcfb5d.camel@gmail.com>
 <20251110135932.GA11277@lst.de>
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
In-Reply-To: <20251110135932.GA11277@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/10/25 19:29, Christoph Hellwig wrote:
> On Mon, Nov 10, 2025 at 07:08:05PM +0530, Nirjhar Roy (IBM) wrote:
>> Minor: Let us say that an user opens a file in O_DIRECT in an atomic
>> write enabled device(requiring stable writes), we get this warning
>> once. Now the same/different user/application opens another file
>> with O_DIRECT in the same atomic write enabled device and expects
>> atomic write to be enabled - but it will not be enabled (since the
>> kernel has falled back to the uncached buffered write path)
>> without any warning message. Won't that be a bit confusing for the
>> user (of course unless the user is totally aware of the kernel's exact
>> behavior)?
> The kernel with this patch should reject IOCB_ATOMIC writes because
> the FMODE_CAN_ATOMIC_WRITE is not set when we need to fallback.
Okay, makes sense.
>
> But anyway, based on the feedback in this thread I plan to revisit the
> approach so that the I/O issuer can declare I/O stable (initially just
> for buffered I/O, but things like nvmet and nfsd might be able to
> guarantee that for direct I/O as well), and then bounce buffer in lower
> layers.  This should then also support parallel writes, async I/O and
> atomic writes.

Okay.

--NR

>
-- 
Nirjhar Roy
Linux Kernel Developer
IBM, Bangalore

