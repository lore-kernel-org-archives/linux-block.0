Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB463428850
	for <linux-block@vger.kernel.org>; Fri,  6 Feb 2026 19:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405245; cv=none; b=SWjlZ/d8QrV9B6TWQq3VKe+lNB76G2YKK1vBjwC31SriyYm7D5R+Q2Iool4+i3h8ELGy3Z+yRH84RV5T0maEbi00YXwZkLomJUGaBLr7P4MKRZ+xk5V9Mh4XeGieBZFPsJ9uEjE3RJFAstIlqAar4Tx9b3yb/oHeM3ANQSq2aIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405245; c=relaxed/simple;
	bh=dwOWjFnIQ+K3/fCjrdJd6qvBfQlNhJvyopQgB7RMreM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lj8IIpwFFWrsmiZW2uBeU8wI4XZAIfTm5Ka1LV9hQIGjua3ZXOfrcJj+4mZu8ATmG77SYL+DHxrhrYB0zcimK4+GnKMZbKKdsxwrHw8Ix2RkPxvmb0TomZ/0T/8DYmnwpU2lWzhYz4CHrajiNPkmrLQ2KdNgPgs+UewAhc3hpI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=X6nShXZm; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="X6nShXZm"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4042f55de3aso2039194fac.1
        for <linux-block@vger.kernel.org>; Fri, 06 Feb 2026 11:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770405244; x=1771010044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yz6wmJI8rBmajc7BgZbgwjRLJlMBH2inAWKVbS4/ZRc=;
        b=X6nShXZmkTMyhVaEBnAGhyiGfdAi9B0mhJ45MBok4GuTMBCatu5XJwxnpqijVgnr+l
         TL8OsH3iUltg+RfOUspwF5XsZRHs/bIGvRwPrsM2MzGvpO6WroXpo+a9vaO14JpCC+28
         n3x0VZ21XkEvTMNXk3CddvIg4+KDlH6I9FIu1VJZIdEBMFh5gD5bj61QCZ/OH9firlAy
         t5gdyvyEi1fb1dnO8d/fOsv8uUdTSCdrgbaBoiKan5Zx6k98GIkKwt/rZUBgtfEn+to7
         j/wif3BZpJRFDshlRliv837iZ57etQd8w/FkjAVSd3/QKe8yO6U+3ZYx3Hea5vG+8Zgf
         QGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770405244; x=1771010044;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yz6wmJI8rBmajc7BgZbgwjRLJlMBH2inAWKVbS4/ZRc=;
        b=YOeJNgaFezNutPNpNOY1/prTDKbt9n+skV1w4wYn12zAOf2hVMbAtWSEV9C/3jzV7o
         A4QlWOTIRb/ALVwAMRVf+hPzSlR/5gB02Z2ZVqxUO6Rs/lYTup0ju6NBNs+Na5dDwJGb
         K7CR4mN0HzFdI0zFmey3zFsw/zfn+XTxrXQyDBcYT9s1tE9qv5rThKEFawk6LhM0/G+a
         nrFTs8v5fsJqcSIx92O3cgXWW1B2b5M13qEwMWieo/pUQicRthCV3bhEtDNVrAWI2cDZ
         ruiui+4XUnsBHx7zVDEmnjIebON8oMER43B9y91LV0Ly0WPHgTRNh12oi32kFeANV1fe
         LQyw==
X-Gm-Message-State: AOJu0YwK0W+khenYw8Tj6RwAdVwcGxTBd+6xAgZh8Ou52E4ysuYX93ri
	2YyTYe7wb1kS7ltdiIuiR3Nx+wJdxQeCoZ6dWa79FwqqZOdzJNUYfg8PiBIr9gALtceKSQk3bJq
	MQNCA
X-Gm-Gg: AZuq6aI9Fh9SUJJfGirt8nZDhpQfFfP7Vz9PB73ukoMlnOzEnTwKK3rpg2q1rDOAYXU
	i/3+0QBiFHVs78BV/QReaD+eoejePMMaJUHXE/dTqYh6pg3JgfLlFcGjJ+G7RXqCeu7Mk95hfPh
	uOIFr0PH2uCgcnBQ3Ho3SZSQdn0iIA0DYtQb2Nctzl4Uuo9NGVZ9dwFmhfqfsdzSxbXqlgyDi4v
	dF51VqVncl3+5lT9fcEmk2/HK4AtyhA92D6KJUX3cJVOjIK25EzPuuseAaKvcMAKDEu1KI4IDZH
	URFD3IVYhRzCMI9susAYrUGScou/MYkFbdlMZSqNBW8oHtDe7VT5Wrzhyym7BGx26MIIyf6+zFd
	Uk8CfPodJRD+9SCS1EzTmdNjR2VL5WNBcBQkabf/VuGU38u/mwNdsY0GBeX9H7mUE7WgrojRMia
	orRYPsT2CFZJnEHLnhAAyjFJIFzgFqY3E/0uikR27lLL94m8sAZUubAeTJvoorddRnkav2
X-Received: by 2002:a05:6871:20c9:b0:409:5df2:a266 with SMTP id 586e51a60fabf-40a754341acmr4183163fac.12.1770405243840;
        Fri, 06 Feb 2026 11:14:03 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a996429c3sm2294956fac.12.2026.02.06.11.14.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 11:14:03 -0800 (PST)
Message-ID: <8f4e9f2c-fcb0-45f1-80c3-9ae0ae24efc5@kernel.dk>
Date: Fri, 6 Feb 2026 12:14:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block changes for 7.0-rc1
From: Jens Axboe <axboe@kernel.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
Content-Language: en-US
In-Reply-To: <ae61b996-c874-4afd-b8e4-4ff3f90dd3e5@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Forgot to mention, while this merges cleanly, due to a late change in
block-6.19 you'll end up with this warning in NVMe:

drivers/nvme/host/pci.c: In function ‘nvme_pci_prp_iter_next’:
drivers/nvme/host/pci.c:848:26: warning: unused variable ‘iod’ [-Wunused-variable]
  848 |         struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
      |                          ^~~

So please just delete 'iod' from nvme_pci_prp_iter_next() while merging
this in. It ends up being unused with the combination of the late
block-6.19 change and the changes staged for 7.0 in the PR I'm replying
to.

-- 
Jens Axboe
