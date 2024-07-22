Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA8938DEC
	for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686901; cv=none; b=E8B9989XC4PFHZr3PA9R3ou2jC0IS1mp37URx+ouqQAKJKzXqfc/T8oVGE1VC6YyRAJXsa63eSaJEw0YtOiISnxm9BawO043xnbYpDAtvPzYz4e669T6CRT67gfBu7wDSppNtXxNOP0Tc4w+F+9+qoqCgURPUyLFErZZ2tpqr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686901; c=relaxed/simple;
	bh=34HtSC4duPhf+8JCQbGf+fUCRFdJigXMf/wWHTIHDeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph1jf/nw1k+ffe0YwedlxIDD4km7T0TMosVmL3qntbjK+aJj36SwMUu8izEneT4ot4ssLnBFS/tR/smhHcoU2yOgb3yO/JTwVlDbU5GA/fsFWMv7M7D3bgyTfL0bo0AOUtWpOqbY/nV68bKg6J0/LiiHXCtRTQbXq32g7zJAjKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=U2espImN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="U2espImN"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a12bb0665eso33335a12.3
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2024 15:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1721686900; x=1722291700; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=U2espImN/kPsCHZbznGWrO8qY5uFiuMkyF5juS6aLqDjSgJ7FJzi7fEJ1Dy0V7PAVi
         gBfSnQgp30/hARg/uio5lqpLqJVaPmlFBRUMFBv8+r+Hm6OJmyeX7YI9HwqgXlymjx4S
         c5LN5YKsrMOWcTi+v2ogYl3Vo2F7oxhzKtwbzAttGrdux8szT/DebBdBjuBD7XjZt0kP
         J2TW30lvPN6JfO1C6w4ELbER3oszH5Sh/PePfCrYaUo3xUs4nz6iqtib/PkmAEVTGiJE
         ARHqFEFBYeAh6TkTwknAigQi9Rbo9ucwor2WorhalcwIiHbA6wQNKh9s9Mz1iSdgFokq
         hHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686900; x=1722291700;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRJ2uTLG4AE1W2r135WxVjYfrIn0tz9jHJj9trzpqw0=;
        b=UAOBur857xF9jCReggF21BfKoY6VkWiEPbIGuaiyn+o1Lt8hMfkvSzBMZEZaxfUdnP
         msDB4x2rcBl2vQmIxOqjnwEASj+m6cc6f6DhAeel6yYRyhSF5auFBK9jddvMz0qacyAH
         EohXBC+5B+syRmdd67L4o2WvzYJiR+ZODr0et3nGRxWMGWjcjjRPecGxKrxvR+6JxZqY
         ptPvqdoQ+EcNCZewutShv775BKwAjX2BV7TT+bzFw9BOya/N4xTsCKQNLjDwJVNByypO
         Evt6iCvTwrXOvXiRDg8YxVhuixY2uTV3nUQIkSoPMsiHY7WZO9Mvr5VUKddp7cZJz45L
         KBnw==
X-Forwarded-Encrypted: i=1; AJvYcCVI01q9EVxIpMRIE7t1nPUw+7rgFNMJxM98Ag3oRJ1y+WkP09JEnoRBVf/P2JGseHPSN/LdiCPCOnNk/68+EFB7X62Yi+p5CpxRKTE=
X-Gm-Message-State: AOJu0YwlhIhyjc6q9HNSLIPH/iODz5eVs+q/0Xj20nsUiCa17lC1Qnj+
	IbKcFJkJAR63M9nab+3N2mIlegJEERoVU8eQ8us+Aes50YR9ONh4lets7+EMyms=
X-Google-Smtp-Source: AGHT+IGScHD6XHoPrstmVFPw+Xo8947sWS5UFvpK8ufwAvqfdOvxadY9ZmmXoO25QdpiwaLvvRLgSA==
X-Received: by 2002:a05:6a00:6006:b0:70d:2cf6:598 with SMTP id d2e1a72fcca58-70d2cf6127amr2260050b3a.5.1721686899902;
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d1fc869cdsm2974888b3a.170.2024.07.22.15.21.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 15:21:39 -0700 (PDT)
Message-ID: <0cc50a53-fd8f-433d-bb69-c9d3f73ceace@kernel.dk>
Date: Mon, 22 Jul 2024 16:21:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, idryomov@gmail.com, xiubli@redhat.com
References: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240718084515.3833733-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

Who's queuing up these patches? I can certainly do it, but would be nice
with an ack on the networking patch if so.

-- 
Jens Axboe

