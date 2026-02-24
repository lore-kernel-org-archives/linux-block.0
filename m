Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E77A39E18C
	for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943322; cv=none; b=ZatL9fnRzQpiZvE0IH26e5mY4KAOHMvSDdXDBFVDrVS70UYVNpoZfry3CvlPC0UBggrHW6D3S49bzAqLPfLlMz+5z7KN4LGGO4XDetvGxcUxYybIVfINi6AikNP9BZADnCRX3kIDbzLCVvnOYHp9EdJnSxrH1S1UOZH7T16oWKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943322; c=relaxed/simple;
	bh=HbeAMq582A9z+G97NykvUDrQegiuawefgGe7H7Duy/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bk/o0blmCK4gM2qLGuGEnnpRZ083qyl03Gjz84ov9+CYd43jKhKRc5sy8PKZ7QBQ484Q2U6O+F+DlUj67xqB7grbnkZtWFhqEHEd8PXsQDgE8XoeDxiDZJP5s9AiAeg/cayD+Hiy5B6hYK45wQEzQDLp+ZsrQdLnY8dS9yD44x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Vl9lb38G; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Vl9lb38G"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46392972257so3760085b6e.2
        for <linux-block@vger.kernel.org>; Tue, 24 Feb 2026 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771943318; x=1772548118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2HGGQfAteJxa/z4n6+vUqrmhg74qyKNk6vF173syhMc=;
        b=Vl9lb38G5GMmhAqu1wEaTe0PX1UUh3ZwU8GBUNZDH3YinoFi0zB8wn2TjYqUsDYxHN
         oNcVugM2QanBq6xsSPhi9nd2MJfZdDW9bIKUPqQsurFZh9j1xDaTCAcxUzRLZDs7pM9G
         cV8SBe9V7v0bGfNJ6rn6OV6C5kevFWPDaVZvDKTwc1Vmmp7+LdBUFoDuRtjOLO/WwV/8
         iXIU/APSzgf0OE5GZsyj02GmyJAPI0tfTBslMWZKicD7RQ82WT41lCiycsogsahalDzY
         cIAJ8CP6HuRN8XX8ORkJehY1rMylassvG7eQcFqsbdfFjoXJ86VMdv8KN20KFfNsCFT3
         SpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771943318; x=1772548118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2HGGQfAteJxa/z4n6+vUqrmhg74qyKNk6vF173syhMc=;
        b=eL5NpBSQwcUwNAEMBT2HkAAqhS75r4rfmI2Go/laEmUOfOtjNXVJ2k9tt8zXVA+j5U
         PvboX8+FUWcdnjitV7RD5uXogcqWn51e+bacqWCLbmrbpyaqJZ6+hIbvlhUtsMYKPLFi
         UgofLa+IWXgA6TFFNY+sVctnfikxvVR75twuJG/r39sijXtxhwURB9r+PUl8vhNNoX4T
         Jjz11wm7WXpHwwXZaj87dd5uuhKHt0BGs+En9rnpMPC4ZXFP6KHOFHZtd80KWbhxtHIq
         lgo9QTNWXjCxygxr9fJYb/9ierw9n5yfN/w3PomY5JM9wIEskup+/HLs8xqA6417d2CB
         urTg==
X-Forwarded-Encrypted: i=1; AJvYcCWnXw6gg3BXygBvh5DrExIMB0JgkmchXhKUlYYSn/fy4qfgKmbEnNEtlreVWcjRxDWZ/VZAEyxY0ILPJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0qro9SEKZA0F674oUPRsUETFzFmdQPOgBz78i36dh3AgtYUFB
	NRjWzEjS5fW/TJuHAipyOQk7cNKIuZW5pk7f2Z+xL+STJJ6d6oQBbpcMlIzXtLtsbKhX49ZuuLo
	Sgdbc
X-Gm-Gg: ATEYQzxBB/33g9EV+XXvBfmnjgEgDMjbZ6b936F4B2PGATupTB/oseSipNjsFW70Mx7
	rTqEbusp4TPvqzet81Nw2c1H4AevrMyVaourNzDWd7xWP+/d6i15zyegizsv3J+6KdLNgkXP4iM
	J7IQ37c1dtMK8WS4xWyxr8lZyB5zNZVZ6I+05lpeQ5B0Y3/fJPoh3oYqqYRDkx5jkaRWGVYtZaN
	F0OBzhQ4sPL2fklgvMgz0DFQQMD+jEUkkg4e2bFm4PC6JVbMttImwPL2PGy/xFwEJi9XWHXRtWc
	6ZdMcjwYj8T0zVoiq2X7qyhNkNJNVNqL/twMi273nS9vTdraLofmEny6eDQ04oo8n9ayTRntlVA
	Eti2TU7Q4RTR/BVePVQQr66g+C8VjxVicD4bT1oXQIvKC/AU8R1hl4CUw9PAppFce62//T7/am1
	sXjKxtHMOJ4PheYzdwRv1AeU+WVovXmqQ4hEFpvUvN4CwfCc3Gyx5Pm4QnOyyEIgC18Di7j2AGq
	CyR8mg6AQ==
X-Received: by 2002:a05:6870:8594:b0:40e:e9ab:f6f0 with SMTP id 586e51a60fabf-4157af8a521mr7483495fac.25.1771943317693;
        Tue, 24 Feb 2026 06:28:37 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4157d3a24bdsm10037152fac.18.2026.02.24.06.28.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 06:28:36 -0800 (PST)
Message-ID: <8a6e89f2-d93a-4497-b22d-09142f5a828e@kernel.dk>
Date: Tue, 24 Feb 2026 07:28:28 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7] blk-integrity: support arbitrary buffer alignment
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 csander@purestorage.com, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251125185718.2190305-1-kbusch@meta.com>
 <aZYy3L-UVjgNQS11@kbusch-mbp>
 <b1c7cb9b-f790-4e3d-b1bd-4f4f516f9b3a@kernel.dk>
 <aZyAxTqM0ABwDswl@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aZyAxTqM0ABwDswl@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/23/26 9:31 AM, Keith Busch wrote:
> On Sun, Feb 22, 2026 at 09:29:50AM -0700, Jens Axboe wrote:
>> Looks like that got missed. If you rebase it, let's take a look and see
>> if we can do it for this kernel release. It is on the bigger side though
>> for this deep into the merge window... But since it's still early days
>> for the release as a whole, we may be able to sneak it in.
> 
> Just resent it. That would be cool if you want to squeeze this into 7.0,
> but it's also fine if you decide to wait for 7.1. As long as it's staged
> somewhere for upstream inclusion, I'm happy to backport this as needed.

Let's just go for 7.1 if it isn't a huge deal. I'll queue it up.

-- 
Jens Axboe

