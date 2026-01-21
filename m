Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBA63126B2
	for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 14:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006738; cv=none; b=G1f3fYFTctNkyK2onoDqj1ECYUnbtvNXxQAfVkZ7bcjpkSVY4z1LUpU1ecoc1fSWoebTrJjTmrDsntr+qzJky7hTbz9huBzQHbgHtm2NatY57XcPtBPjMUaOmLj9Q/0DwVKmkn12YTnfohsdSgVn7iCqNLmYWIdBcVxFmWuQIIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006738; c=relaxed/simple;
	bh=du6gKJXrQs6RJhJZOe6uv2xtSqobAVtxvVa6PU3+Weg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkxR7PPV1sbt/ozwZ6uUll4DErrn+3LF4ihwwIveMTZTHNPgOugTSekFn7HvVbUyK0vLvI1dqlCcpmADU3WShmdL3znSJqgQQPvDKxpv8fXpj7wW2IYeHvR2/9PQyJaRTdwg/njrbetVRXw4+KbOkSZT3hHZppR85oCylM8bml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Uu3SUHxZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Uu3SUHxZ"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-45c958d480aso3160502b6e.1
        for <linux-block@vger.kernel.org>; Wed, 21 Jan 2026 06:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1769006733; x=1769611533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nfv55OSEk4T+D6o+9c3xawnnfmZ6Qods0Pwv8rYz6bE=;
        b=Uu3SUHxZhoVGcTGTvqkHgi2n+QsuSvfGWTDNtid01VV+SYd7gP4AqNBhpZK534xWcI
         oTG4Ornn410WIPYAA22RLQRjUtuXv3mKxjepCTTDfUGc5PPc1NDif4cQmxFiFD19iIeS
         Fgkv+JIWXZBPyoLquyuehBGhxY0Pnl2V/gX4+5zSKxlu4aP/jHg+QGjGICvIixTHFKP6
         zyjM+8QNoNa3ZM3Se8WYvlkWbeG8gq1xTSYfyJ17+h0Osagg4edc6IS1f8YikIbE8VlO
         +n244PUwAlr1Vl0EBYGjQbTjGsU8WBVjG6v0u0bvKz7vht0VCIWpDGyK1xDMH4JvmPJs
         z7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006733; x=1769611533;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nfv55OSEk4T+D6o+9c3xawnnfmZ6Qods0Pwv8rYz6bE=;
        b=piKPT4qPKykDbBTYIORGVRIW5q+7Y5iBVtWu2ycb3t6Dw4D8F9YbShtJ6E4NdbKp15
         vhIUTaXoUrX+vatMIbYA8h1aTgiFdtzLbBEvkczwL68V10BWfnkMIGhmsy/qp7xksTmu
         /Ck0nWhTqiqev6gajZkbXe/oMYxV9/lz/o6fl9xR2SlNw7LuloUoHT7WrXzTbVBLhH09
         erY6K5AmtlBCKutSJaVk6MMFKq4w8y3Yq/ICgB7nZu8LLXtMW8fdG3YyuZgSdATs1uCo
         Jkqj6RbG7Cq5waO8u4w72MJYjMzbWDdgt6aEH9QpoOylBNp9MKcHcPlxHnFUhe6XK8LR
         CgUw==
X-Forwarded-Encrypted: i=1; AJvYcCX47Ybzw2QXSaaIdNfOWIvxuX2jAbmoLuSCwEf6R8+u+ii5Fo4mPpBmSMmicSKy8LX7wp+Jf613AJmelg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztxLEj0GE1z+1llpI4UWOqWf2J/D18o2v3/WdSiUgy/fiwUs6C
	s2xMqPPDd8w3h6EvbuNUuEIGSwfKRQ3zeR7s4b88K+I7YaTlGzlYa+RfwwcktpwvCowQDaKxhgI
	6vjmFVrk=
X-Gm-Gg: AZuq6aJfgpTSWXsDmkmC1EuimbbTqckk3+nYX8oAZJIiHO53kYjODBxgusWIG0KHgFf
	j32fvKUuCvlOZjk3xGpcSuzhdznZ8/9mD9UPyX0qTTuYRK+PArusDoDCTm327tmHaY/MyzSXNQj
	KpH2a60aa7KY7WMba/g5SE/tuYXMYsQl8elNnn6TfQDYJoWmTKqz6ozzn7ObiSQP6sCeV92sP9N
	dfUYnFtA6DDjYI/uSp1s2LzmZ3tPhIkfbK0br1K5/obaDO09GP6VgN5oLWJhk26gW4l3DZQznzd
	mvbwgHdY5BJs47PYK2SWEYgPeGbUdPUVdsKqB7aA8WOH7fEJdSF1xk0ShAVVoHtERkOog+yMB+e
	J10biBTpBXxPBfPzawqBukQrI1w+NTIqRuQlem6yZmk8h2RNsAJj6MYc6OA06PIhTsuJB909RW+
	cZwDZu6auw5lKFpK4fQ1LrSm6yLhkQH/nZRfQqHfvlCGXn0VFLOt6P6noy+O2Fl0TP3d64WJAxx
	YWz46o=
X-Received: by 2002:a05:6808:3088:b0:45c:9a6e:1ea1 with SMTP id 5614622812f47-45e8aaad5b4mr2707763b6e.66.1769006733341;
        Wed, 21 Jan 2026 06:45:33 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45c9e08dbbbsm8824394b6e.21.2026.01.21.06.45.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 06:45:32 -0800 (PST)
Message-ID: <0faaa7ff-597d-4b25-b03a-a01cf8b2a013@kernel.dk>
Date: Wed, 21 Jan 2026 07:45:31 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ublk: fix ublksrv pid handling for pid namespaces
To: Seamus Connor <sconnor@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>
References: <CAB5MrP5YbxdUe0378VfKBMb_n9=6G-C=TPixYoMaV48trgtWBg@mail.gmail.com>
 <20260115025952.2321238-1-sconnor@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260115025952.2321238-1-sconnor@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/14/26 7:59 PM, Seamus Connor wrote:
> When ublksrv runs inside a pid namespace, START/END_RECOVERY compared
> the stored init-ns tgid against the userspace pid (getpid vnr), so the
> check failed and control ops could not proceed. Compare against the
> caller’s init-ns tgid and store that value, then translate it back to
> the caller’s pid namespace when reporting GET_DEV_INFO so ublk list
> shows a sensible pid.
> 
> Testing: start/recover in a pid namespace; `ublk list` shows
> reasonable pid values in init, child, and sibling namespaces.
> 
> Fixes: d37a224fc119 ("ublk: validate ublk server pid")

Where is this sha from? Looks like this should be:

Fixes: c2c8089f325e ("ublk: validate ublk server pid")                          

-- 
Jens Axboe

