Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC8E32D7DE
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 21:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833082; cv=none; b=ShglmfL4OU34cUJRu4Qd2u/DX/IeDxQAmbTEO4UJFu1GPnjvbWP6IyrkjjIEdS6/Fzt+59rsbeCi0VDs/tVhuG+P4T8LmZoGm6E8E+pijG5fqME7Z3pmucCOJ821uy/RMaPxSbthq+vKcIug4tTK1lA+rrMnkWmvcwQ3sQZ6fBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833082; c=relaxed/simple;
	bh=HGuz7UuHQ1z28hst0L39hYHb/guU9mp9qZTF7QFphVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oIAm3H/1djdG8lF1uKn4qjdaET2GAlgcoPsGWbQL9jAThY3YWyKTser0XwmVrP5+FNoGI6HiopRVcW9+1wPy+cHGPySz0+gWRcK+BhOFqbFmOWT60JHeINnXjwBdcuNtUx6VUFLU/GeBBaYcMs5PzPItjcqkjqnDdmp115305Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GN6Bz3aS; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GN6Bz3aS"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64aea64bf15so8963188d50.2
        for <linux-block@vger.kernel.org>; Fri, 06 Mar 2026 13:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772833070; x=1773437870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mFyCcTFmoiwLsp+6CJ7MCM/WrzjLTc+aH/kxO3R0bvk=;
        b=GN6Bz3aSRbi1H4dBT1lSr0cMt9HbSmsETBcbXamZbt7pB8hXxQCtVaexWBchv5qGiW
         UPV2qnSvZUi6hrYK8bI+p/O1nVJMn0S6XDd+bX7mjAwCAKJNlV5oVj/y1YpW0NsmyJIU
         MX8QvXplZXWBXJN7qAvOq4isKK5IXm2M3+P9hs3oWhldf3KvO+kAizrVLYgv34KvpOQZ
         SG+75pwRjI10qWNODxF/yrYMLXxsv+GAZIX9eFHZ1ml4xouXfYDIxriRh1hL0bFf+p5x
         3CQ4EWe0xYbL/RvZWSLKlBmqBI8w7fPLnllRv/X/tNhL1AvLisilY/VfaZH3bV4Rdd82
         Mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772833070; x=1773437870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mFyCcTFmoiwLsp+6CJ7MCM/WrzjLTc+aH/kxO3R0bvk=;
        b=PzPNckRIhvNNlTe3UCJoVWLB30RR7p5DU2QRsu2QFyJR5aH3Y3GQyKJwBmTzztbyve
         eoYVGupMoloHd/mq4k0yb3CEVEaEo0TVPiTovG06xTEMOGCuWk/9ITtn2iF4YLJJm4Ry
         veW7SSVwbozWJLjAFyZiic2T8BHH0QP+a+ctdnWWsWIil4H0zAgF2iiD4vSdg/Zft3U5
         bM8D9hmiDbRUqWbhMKL7ErJOZzmAB4fsSxS6fAQARZDcvF8RgYwRdvmECu536k8aat1w
         2Ujrz2aPuXX5mpBdv0ZKAzlOcvaeCoLBeXryRMPtgpyuWlifwP3b3MIfDJdBzvvt/jgW
         RNug==
X-Forwarded-Encrypted: i=1; AJvYcCUF8AGImFQnM7/wwtiZgsOBjf6SEtKB7BUmOsrrA/GDtlNJw/UaZfnOqGNARECfCjjESpgaMtEM40ZNIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwewbtwYI7+V02YwDEBU29ythAVR6v5AYYX+zv3xqDgg5zIqR7W
	lhkMqPcewdyCZLk66/XquOrmgzmJcXp0K6HEyUsbzNakD1XVfOCL1esC7pYB908M+RA=
X-Gm-Gg: ATEYQzx9quZ8y5p4iOFv/XeWew5ToYi7T8QG/fc7e9q7SweqHB7PxnGsHB3LM05EVcR
	bsigmYS0wSjytVa0gd8DJD+0aef464GP+y4YYXwxaHfG7uW+IyX4fbYcQZm8az6fgYt8xcAqoCc
	RDNG3dAAkJsj294Z1MxeiMFVK0vhp5glt5+wdE4FW2QgY81pyyqzPfLCgXENcVGDyM7ucHPzjYE
	oJyRDAk3SaslpL3hei6p58SZ/evMnKnlK20wkmmbpuYfFUWyBHMfamw6SahRg7ZNrzZxKUonLSP
	SV6kfs5S7+vRvxQR7NhsziPqIJqoaxM+DUu8CLJKOLZwfielljnOZrpI/j69pceMHBPOCR6rFoI
	s9HPyZWZCTAs4OtI2HnJqaZtOaMalLybrbuqTi2eHDwunmBiHdiqIG3xzmvzr+hQRRLvR0n9+Mc
	O0DvsYQyZgDwJ5JBJfG3zvlrHbOT5/AeZbiJJz017QcqkMhjBgeS8yv7YrRDe3r7WSwA/o9+z6w
	5d6Gj3lYVo1YZnWQw==
X-Received: by 2002:a05:690c:e3c9:b0:795:294c:fd3d with SMTP id 00721157ae682-798dd7872e8mr32847417b3.50.1772833070165;
        Fri, 06 Mar 2026 13:37:50 -0800 (PST)
Received: from ?IPV6:2601:703:4183:37b0::7115? ([2601:703:4183:37b0::7115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798decd087bsm11840907b3.12.2026.03.06.13.37.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 13:37:49 -0800 (PST)
Message-ID: <a0c07723-90f5-4bfe-b113-e2e146dc3fc1@kernel.dk>
Date: Fri, 6 Mar 2026 14:37:48 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Current block dev tree.
To: Muthukumar R <muthur@gmail.com>, linux-block@vger.kernel.org
Cc: axboe@kernel.org
References: <CAOnVdK5zgakTz0LTemK13bqigU0Ro+M7w8Pgvcj8gReY1OhavQ@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOnVdK5zgakTz0LTemK13bqigU0Ro+M7w8Pgvcj8gReY1OhavQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/6/26 11:10 AM, Muthukumar R wrote:
> Hi All,
> It’s been a while and trying to get the current block dev tree (Jen’s)  from

It's Jens...

> git.kernel.dk/linux-block.git but its timing  out.
> 
> Is there a new location  that I missed? Please let me know where the
> current dev tree is?

As per MAINTAINERS:

git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git

is the current tree location.

-- 
Jens Axboe

