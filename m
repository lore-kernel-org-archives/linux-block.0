Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F370CB1
	for <linux-block@vger.kernel.org>; Fri,  1 Mar 2024 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309407; cv=none; b=lJAqVAMJXO1v4nbSiGw7KwOK7TtRjzd4huLtVyUNNNb/3ivaIme+h9HUQwzUJECE0ZEWJOHWQEEGcPYjUMsj4URWvGwLoawfjXycecbVj9L3WTD32sZTtsdUh2ESANGqhRRhdjj9BMrTWw6UFLUY4QWtlHEyXEKIPoEB4BKGY18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309407; c=relaxed/simple;
	bh=Y6+jWBd/t6CiAA0kp9R8h7Cz6SqJvgjsnNxHqUyPW/o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S+wA5KCABNn2lndn6l/72JLlLmOlTBb9DgH0RGqCaAfCq3yRrxxUEKqWHNYDZPLdAStx2gmC2OTEzf9YozyniiygEudyYji6y/8Pa/+de43f9upsWm/LDdSeGefuljaMLSsGMfSaYujXmi+Xnr29yNgTwVsmOdtlH7rw/A9f+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=xz7lX7By; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="xz7lX7By"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c787eee137so34014039f.0
        for <linux-block@vger.kernel.org>; Fri, 01 Mar 2024 08:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1709309396; x=1709914196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJew46mGVrQcepDWbKAtHr/vU7a6ybvJN1TJ5Pc2mp4=;
        b=xz7lX7By/LtONYtboBVYlKjTL9MXYNtmVNgXzc+GO0VzYElNtQh0ddvUhXQXEDfQup
         hFkJB3kBuPgRI0lrW/B8n8t4VHg9/BoxEO/Nu3LLLJjuVuAHraQcS8vYHrn8cxS309jM
         x2KgckGir6a0ZFvWK4vTpcxYazd6pjcchyu1KGmGgGwBdDXJFYyVoaMR34kc6gcJ/f52
         adRUlNqPG3l82Eqa6zk2Od77yPGk3pf2tWUB84YwpyvncO2pI1n59kDffFGw1ZSAymU3
         yCkgKN22OCL+VXNaHuYZW7UbSwhKsihXyvCbNysQ+jkt7thY4y9U4FMbTn3rRrxWfQBB
         h+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709309396; x=1709914196;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJew46mGVrQcepDWbKAtHr/vU7a6ybvJN1TJ5Pc2mp4=;
        b=E/TzAVGrR9s4Hwfw7HGVSmyAnNEJmQGpI4NEaPHsLG4uO/Jsw04hDG7AR8gTYW5TRP
         uCWFe0lB7uREOHz76tXPAKR6V7xkXLP8us/w6HYa9D+laMiDGJmkaEENLYpt5QKCGACp
         xBVOh565hhm3VKUTwIFSoKgRD5gXggbClwqtRL81w8BPYpgd+VpHT1zryk3az4iaCaNz
         vhvWTPeU6s5Oyq1AYKNjgtlAnbn0D5fWm5XjWRaBwdqlRnLDcxFw+HM2IKd3/kEeHt8Y
         qq7fhaKgrURfyQzDwehaIFs+sWORLSAracySKTLnmGgZGi9WcjrLurHH7H2qBs1bGivI
         CCOg==
X-Gm-Message-State: AOJu0YykQs44grQXQj/PBuac9CtHXlsFNDhpN+t3QcuYnz95KNF7o3BG
	PrHtRpGojlSQe2nrj+2s8baX1ILwcPFODnLfqqbA4Xc1aaaQ8t8/BC3Pqny5/+F0wdVaXo93898
	k
X-Google-Smtp-Source: AGHT+IHa+2XKvuX/YGHbVraqcL9Od3Ukf1I04lrjP8hK/gZGE1PtSs318j1J4WJuIZhddUhqNtg3Mg==
X-Received: by 2002:a5e:950f:0:b0:7c8:2946:af83 with SMTP id r15-20020a5e950f000000b007c82946af83mr1066682ioj.1.1709309396427;
        Fri, 01 Mar 2024 08:09:56 -0800 (PST)
Received: from [127.0.0.1] ([99.196.129.26])
        by smtp.gmail.com with ESMTPSA id j13-20020a02cc6d000000b00474ab85e3ebsm865136jaq.130.2024.03.01.08.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:09:55 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, nbd@other.debian.org
In-Reply-To: <20240229143846.1047223-2-hch@lst.de>
References: <20240229143846.1047223-1-hch@lst.de>
 <20240229143846.1047223-2-hch@lst.de>
Subject: Re: [PATCH 1/3] nbd: don't clear discard_sectors in nbd_config_put
Message-Id: <170930939076.1106749.1495501234832632960.b4-ty@kernel.dk>
Date: Fri, 01 Mar 2024 09:09:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 29 Feb 2024 06:38:44 -0800, Christoph Hellwig wrote:
> nbd_config_put currently clears discard_sectors when unusing a device.
> This is pretty odd behavior and different from the sector size
> configuration which is simply left in places and then reconfigured when
> nbd_set_size is as part of configuring the device.  Change nbd_set_size
> to clear discard_sectors if discard is not supported so that all the
> queue limits changes are handled in one place.
> 
> [...]

Applied, thanks!

[1/3] nbd: don't clear discard_sectors in nbd_config_put
      commit: 7ea201f2cc1da999b9a0a23ea20b64eb2c4719a9
[2/3] nbd: freeze the queue for queue limits updates
      commit: 242a49e5c8784e93a99e4dc4277b28a8ba85eac5
[3/3] nbd: use the atomic queue limits API in nbd_set_size
      commit: 268283244c0f018dec8bf4a9c69ce50684561f46

Best regards,
-- 
Jens Axboe



