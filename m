Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB403603CD
	for <linux-block@vger.kernel.org>; Fri,  3 Apr 2026 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222684; cv=none; b=D6/9fcAhXQQrqs4S9KLnS+7kvBvEBBMDjuWY+LndLS1iey2qWQAJdw1LYYE9FqOEpB6MeHUCBaNpkMdSEpG2sZAGpJI8L9efRwQ2J1RXS8pNk2EPR72LbSyrdUJQbiVIO6nI1PUuobD2oDMf7QYg3Ix95RWM2stC3dGBIMVM5Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222684; c=relaxed/simple;
	bh=eH531hMqnoDhQ/nPqc+HwtFQ/7BavVdxPoga2NPj/r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RA9ko+z7CDAoHJwTRZZVdWz0qNdvSWQ/mguxl3mQVPJPejCPasYHJjuTRkBw6Q+FtiSIXKVYqic9IXtIvq13zgzvo0K8Mp76FwbYEz8ifwv/5Yu1+Ti18PxmzCsfstBBgKFQF0ZkdYnZvCkTPJQdKVHt+kAWJW7asE8ElbIGYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=fgSCD2cD; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="fgSCD2cD"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48896199cbaso11119365e9.1
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2026 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1775222681; x=1775827481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6n47rxNp9qQZiQDl+S0Q6ioYNQWFTnZXhemat2t0O4Y=;
        b=fgSCD2cD5ZBKiHRTSEL6nB7PtOcHZ4CPNkeI7JRPKfWEee02e2NQUdOW3TckVbsnTO
         I+lKo7RIrXlXlW77eJ2wB31tNWshccYCOb+uGNtSeKRkMX0IJW3axxxhK/gTPI5e8/K9
         OppXx78HLPGjJdmHIIq6e8UcZ2cSLqRAT19JtjAJUJ/VpCbFOqrPm5eft7p0+xpH72uy
         bOB70rF9v2+o4j7Sw4fksJf1Z/BKf/pZy9Li0sthTTyoMyqGsZ/SsXl0+9BC14A5m1YE
         lMP2Sd1qLeAchXxAxi7+IDWkFPMePus6dcOgbwQdbSJps4lCFRMbqvdMee013zHglMYs
         WyiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222681; x=1775827481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6n47rxNp9qQZiQDl+S0Q6ioYNQWFTnZXhemat2t0O4Y=;
        b=ExSQ0037nwYxz1ou7EaQdu8x9KYq1wGHeREcdBkhH6mDTk84nhqiADE72KbVvcMqRh
         vE8mnxEGMwxcjzff6wztmnw0Nhu/bNqupY1c84IrPbBaWax0/lMUEZOBcFY8hr1AsZBS
         KUJEgowgZGgIH+ZPSr61d3y8J0ILyxzdSqBxIntfuGDIsE3u/38pQOylQCBXn0ueHyI+
         8gp//0xf37Me5myW6dsP6Jji0Pp40b4Z7XvcqMQ//xBpQ5nhTOAcELosdSNaW9DEl5dd
         JPrdcPVfmTZVywWLXEOserM6ncAR0+WgJyvH0KMvjQqLl/TszFptY8pbJm3SNbHBsGQB
         RQtA==
X-Forwarded-Encrypted: i=1; AJvYcCVkPjMNS8GsXFJ0Vsv/SdzFiVQVjK3HzkcyQ1wZ1jP53JuoheAL17FXWn4y7Xb5+UScPCpDT6PbMiB8TA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZZwRCXNBxKZYKywGKhgeMGI18ZDznWH3ApCanQz9CWRfjW8+5
	dtYts28+cbwNpJTyp2ZCR+9d79O839GX4woJpsn71jv6qit4VJ2N8TCd93LGdrBj+A0=
X-Gm-Gg: ATEYQzxMbDeGXpQOo5ZdA0iVKeOY3J7YEgM+cjFdlzh/qCl0BANzWkkLRy8nSNhIvdQ
	WA7UouzxPPcB+cYutCryahiwUZnw9Ne+xEHnvO8Uq3j3lsxo/XqmNcpllriymvxUFsLgX89N6QK
	A12uZpNEcgdJA1tZnhcXanep4IwTa6LkkdG0Fz3WIeVWqyN2uLzMBY/H5s0YcmiAIART3hmXF3q
	pST7rzgnlzRLBYRkWRXtPscC4fJYy7mvoOODTBs7lSPw1LRoDC5CIw/v9kfIULNUrvzWwRtiKVJ
	KTH7x5C9GnYNINNAjFw+P+p+eztXg/Ivzu1jBpLJNftKgJOEMO6/JVlkE9tTckNiW9Ow2wBoha7
	2QzCMTIgrYlSHXbJaE0KiBkyKM3JVRkVBwkdD8bkNFP4ea4NrLxBbFE+agrCa77L+tdEXlBAfHe
	QTDvZoyMQZTnqJRPrVLLoux2f/7cDWVKtalS7HRFtdkHBKzmNynFWPZrXqfMdxaqTZtaVqR2pRg
	s0S8Q==
X-Received: by 2002:a05:600c:8b34:b0:487:1fb4:7e1 with SMTP id 5b1f17b1804b1-488997d530fmr48133275e9.22.1775222681521;
        Fri, 03 Apr 2026 06:24:41 -0700 (PDT)
Received: from localhost (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48897fdd2cesm24952245e9.4.2026.04.03.06.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 06:24:40 -0700 (PDT)
Date: Fri, 3 Apr 2026 15:24:39 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Philipp Reisner <philipp.reisner@linbit.com>, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 00/20] DRBD 9 rework
Message-ID: <ac-_fAsaSk-E_80R@localhost.localdomain>
Mail-Followup-To: Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com, 
	linux-kernel@vger.kernel.org, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>

On Thu, Apr 02, 2026 at 07:30:35PM -0600, Jens Axboe wrote:
>On 3/27/26 4:38 PM, Christoph Böhmwalder wrote:
>> As discussed (context: [0]), here is the first version of our DRBD 9
>> rework series, intended for for-next via for-7.1/drbd.
>
>Will you fixup the kerneldoc (nits) and the assigned-but-not-read
>issues and send out a new version? Also looks this series doesn't
>actually apply to for-7.1/block, patch 12 fails.
>
>-- 
>Jens Axboe

Right, the recent genl changes now cause a conflict. I'm rebasing now.
The nits are already incorporated and will land with v2.

Just for my own planning: what does your timing cycle look like for the
-next branch? I assume you also want to have that ready before the merge
window opens? Or is the schedule for -next more liberal?

Thanks,
Christoph
