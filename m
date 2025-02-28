Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8912527002E
	for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760682; cv=none; b=Ij/YzGq07ewpIq76n5E1n1+POYwg9N3tW9pFwOxVuDhJYJGbiNTev3EcFohXTFWdzFUgqcBN4dQafwoXo+RdswlV/CoDXpVfBd7wcoKrtU1uVfBDx8WEVm09IoMF1t8yaZKAplc2wbX2eoCyPpu7KKUGvjzrixoKvgiH1OoRx2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760682; c=relaxed/simple;
	bh=y1wB1rZOrmX0R0zZBlG24+qq1rQ/bxMKeCH1YPRJs/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEMWrVol1kgjBXeaQ78WKgoVoO2Mtk2hfzSdqX1Uk4XrAAqP5Ig6ZJnBG8j46YF4hTXM2nsNaaqMyLU/t+0K9ySwHhxcVH1/3Xge9QX/sbXL9izYCSaEckJbTueYU842daozM3X93/UlAfHA9imbQDJxiN+P9nGitBCKROgpfsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TCUv/RSk; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TCUv/RSk"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85517db52a2so55093039f.3
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2025 08:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740760679; x=1741365479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v/JD/K3WPK+UkEyvshDQ6t7nBz4/vEcYUvTKahVnyLQ=;
        b=TCUv/RSkXrZwr2lWE1czeGwmp+7OUQT0bRTkv1bFtwAyIfMzM3XfW9uzFXgPO4cnKm
         nF8Eq91HybysW4szdIIDdR4tzZ3AY7q3wIo2Kq+viGVrjJWVyeKVN8/BcpRj5A5aaVjQ
         W2R/yOdLOwU66lD7zWrjd+RCzdeGdPhzYx9y012P2gIHj1yasIk5VC6EJi+KingqtsPo
         cfHj6wH2+2L+CwTTiHSnJP2A92yFmDJTOwV+184oNLjSo948jxRWfmhpMdmgevuQUoge
         rvNjUiZWM9mcQfyITYsGTsjAqmyVd8wskre/rX3M0KWb7xXmtpntuVha1qAZfRaG98dM
         /p/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740760679; x=1741365479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v/JD/K3WPK+UkEyvshDQ6t7nBz4/vEcYUvTKahVnyLQ=;
        b=XEEjUeJX5iOv29ff4GxxFCQ/K5wIe73lc8e6J/gKaJjp8h/DqxCjudy9eKhlYlYFwY
         ayoVT0RESWKsqnoQoQFQK/mUAfX2VC5wO3XvGaPJmvcxBYvEOk89iFTY0C5/btJHLcKO
         L7cXpZTWOId/u0CX3PWL/ldlnUsdWfw3g8Uw0vvZPHs8S5+yvPmoQBp9dwf9MgiZMLCW
         07wlxdWIwnNAQh7ZXNJKjqBK02e73W2GAFyTf9ohDE81y9HzxI52K+hRkJQcHF/yphBp
         Mw7JSH7v2ePwrhoUrDnA4MIp0BbS0s5lji98ATBjcx8KN4Q6NbL/XeOW9yEiIOFm2Don
         LEHg==
X-Forwarded-Encrypted: i=1; AJvYcCW2Y6BEcWzn2tEbuYGC/FCplwupgP5HTb+9Y8CdwMJDaRvTZAlU0SE3oWp8YUB5IOSAjQZh9QJQTtlMvw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJqp1W1ETBC8OUYrUpliXqBVGxJCThMOZ7Tz9YOVfwu4NUeBv
	6pAG2ydgUe5HmGO5CBGV/OYxXeMS1nj7tx4KmgqnGORN7TI08W6meYzW8pgKHQQ=
X-Gm-Gg: ASbGncvc7h/zr8Bt3YVL4N0KeiHC8xJPBtKG/bz1C0mKAQm6M39l8XqcWhpyDR1AgoH
	JLHtL3iA1Co/eCdf+Q9ZGEle37MnNoRgBtZHKw9mxhsZo+gGB+XHyzZaWydKBsMCNys1v3GKAYZ
	q4wLjRjO62a6F57bUZXbjBTuqumasPWFzGqdYLsI6oxG6T7Of4naQBRBNbcZt3prptYXK6f1xP8
	QMKdxCrfl9xS1pUeaPdnkNnSDrogFNJRiiTr3baY4wBHT3XBOxAeG5qUYWL3OsA1o+EPQ==
X-Google-Smtp-Source: AGHT+IFdzNIqDKvFfHcj7Uv92OZVPHjlkYTBlaPx7cbCs6c5XrM6o36gfg553FIyDRAGKWwgOUCEnQ==
X-Received: by 2002:a05:6602:60ca:b0:855:a047:5ee9 with SMTP id ca18e2360f4ac-85881efc6e4mr452400839f.1.1740760679704;
        Fri, 28 Feb 2025 08:37:59 -0800 (PST)
Received: from [172.19.0.169] ([99.196.128.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c718c0sm982593173.71.2025.02.28.08.37.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2025 08:37:58 -0800 (PST)
Message-ID: <360708f8-437f-4262-a734-b1bd680de339@kernel.dk>
Date: Fri, 28 Feb 2025 09:37:47 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/3] selftests: add ublk selftests
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, Keith Busch <kbusch@kernel.org>
References: <20250228161919.2869102-1-ming.lei@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250228161919.2869102-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 9:19 AM, Ming Lei wrote:
> Hello Jens,
> 
> This patchset adds ublk kernel selftests, which is very handy for
> developer for verifying kernel change, especially ublk heavily depends
> on io_uring subsystem. Also it provides template for target implementation.
> 
> Please consider it for v6.15.

Can we add the zc bits to the liburing test case as well?

-- 
Jens Axboe

