Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3894B147C71
	for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141178; cv=none; b=ZfOLGcwDU9uPl3onvOFTsL4x1q73dp1NbQZpWZxTXbXwmwbLZv+3IMqIJvlFZeqBUFeZbqffzWNfDZP4u1UWPSa9QZoWqWHeRhkg751CAWrDQfZpvNpCXEFkh2xrnOSWprpubxqIGbRueVlOORBf96x9jYadgWYRCApbxyj7rAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141178; c=relaxed/simple;
	bh=3MLGPIYtfIkheUlBh9+SqHJPQyFLdMMHOXiMWNJSlbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkDoiZvhqjNw3CRQnv45teF8jBi8TyBYRjR85nCpkV7ObrTYWDk42bL254RYgDDDe9MgKxo2EOeBfXG/9xl9lha1wlx1W5v1V5vI4RKgADSVaM/dW9M05lbXCHDGe1mvcjXwHBwTSviuWOf97Jvmpe8/I4BCocpcxpia8EYehvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XwqE7vHl; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XwqE7vHl"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d9d591e660so7160939f.2
        for <linux-block@vger.kernel.org>; Fri, 26 Apr 2024 07:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1714141175; x=1714745975; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLE1VhiQpQ5OcS9V/M7lYJTy+r9DsERvO0PIhyj9Gu0=;
        b=XwqE7vHlXpTJ6b+O/ugTLgiWGSpQOlqQZNNPg43QzD1AdvMll20p0Wipv7GCV3RUwQ
         yeXNzHZuzPrgBWMn3KB2QEXeBNkIwzEG4jHNm6xOfth1V2xG1s2jzPn+JdoLMNDnLHZ8
         J0Vz51lwr0/iTZW0cz4kXYEcF3Q9VhbCByf0bP5Yn4ncNauNiGCTG2C9KBc2xPlh4mBQ
         lX3W04BWyYia14rgibqNPoY08s1dSDTbqMn8hRKAZEiBliM8bvc7DwQLLBTI9aRJsolN
         SIrOBDoQtY69ANPPDjJZFFwUbhV7wwKFNAaRFrPcqrucUCujt609tuHdRhYnTczWcW5R
         7cAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714141175; x=1714745975;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLE1VhiQpQ5OcS9V/M7lYJTy+r9DsERvO0PIhyj9Gu0=;
        b=s8MXf4xfmAdJeiODbGkOCVp9xjpBMKxZApuEXMyEtX8JGJm1syv/wDvyO6lCbPDyzs
         zmiWfGr3kjCr/OR1tCOZgJmwx0AR0bljBt/Ey5wUHzQuf8kMkF/iKLQad38BSFtUCPpH
         yiNb3DnCEVRBsb0v93yNIfHuhG7c6PEtjn0WnKP0Dzx3e57MEQhZA9l3fNChd++9GGcC
         A5+810kWyD6D7Ii78zBqIRRsALu3D0XJE+hMz1IQyqscYqA1vuajrF1xguk7jkGN2YeW
         Nu7vsUvpHKOpGJiSSvTXVXdIURVityvHVYKhS597D9rX7npDCguOvT8dRvdUn302pMcK
         wScg==
X-Forwarded-Encrypted: i=1; AJvYcCU64iQBziEfp+ufQs3hyac4xDeSIblaBYYWYDjsEnz/appQA97QQw5EDLdKPj1Z/AwIOtjvzWGDpCklF3eZ+DMIprcWgL/SQJG2d0o=
X-Gm-Message-State: AOJu0YztdQ/xLgHor4X8Sx3FogNS5OJU14MMGmv9YTVBi6F98LPjwhoL
	9m24ol0gZA05OkyZvvoep4nAzPbPtl2v62VnO8IfSdu8TlyTI0Ox1O4odTqvSoo=
X-Google-Smtp-Source: AGHT+IEs6ahfJZD0YETX4+8tBvgF8wLQ8qrIx4W8ZCh/u5tNqzsjvVGNUuw9621GGMdtYRmctPFEMA==
X-Received: by 2002:a92:de03:0:b0:36c:3856:4386 with SMTP id x3-20020a92de03000000b0036c38564386mr1137817ilm.3.1714141175204;
        Fri, 26 Apr 2024 07:19:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r13-20020a056638130d00b0048301287b9bsm5541463jad.162.2024.04.26.07.19.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 07:19:34 -0700 (PDT)
Message-ID: <16d4a454-19a3-4300-a819-b53cabf75b57@kernel.dk>
Date: Fri, 26 Apr 2024 08:19:33 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Read/Write with meta/integrity
Content-Language: en-US
To: Kanchan Joshi <joshi.k@samsung.com>, martin.petersen@oracle.com,
 kbusch@kernel.org, hch@lst.de, brauner@kernel.org
Cc: asml.silence@gmail.com, dw@davidwei.uk, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <CGME20240425184649epcas5p42f6ddbfb1c579f043a919973c70ebd03@epcas5p4.samsung.com>
 <20240425183943.6319-1-joshi.k@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240425183943.6319-1-joshi.k@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

A lot of the initial patches appear to be fixes on the block side,
maybe it'd make more sense to submti those separately?

Comments in other patches coming.

-- 
Jens Axboe


