Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431A016FF3D
	for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713372964; cv=none; b=Xq2JRWIKB7hyeYxyVmp57FwMFRwGbFtDJHQt+bsmqRkJaEWZ13iJeIhKVTLvEyW/jDkQ8JwMC3QXnbsO8kqLJU+w+w18iEfcXLUE+lwhUgb+vpankUEWuoqMDjQuy+L43wVkNIduwaVRWKq+bMPrFIX8E6eiPnov33w355VyVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713372964; c=relaxed/simple;
	bh=NVzcN5A1MDUCRNGN1j82k+y9l46oc2GyJO6/C/mgrHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XHrrGaCcRUJbKGvzsM0uL84xXrvGqlYwjN63hADWEq8YVTUbz0cg1Yha95uknyykM7Bwivv5bxnTgoQt9fqkPnTwtB1lu3QO4k6xo6/6sQPtmixKCGNlrJFHfoA4JeKC3k0SdqrTFrpJn3dmuTuxk4vfow/in+ma6iNQUX9w8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0WEyWUJc; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0WEyWUJc"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d9c78d7f97so16818039f.3
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2024 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1713372961; x=1713977761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUAHB5bPJ+iDHtRK1ERMDUYx1czMuNi349CzQq6TWhk=;
        b=0WEyWUJcrZR3aCAi5Ej9l7OgvRRvl7Lz27A0cl0wV26+Bv03MiiW97JdgbGrlH1EaS
         j8TxhrjPkSxDafHJXZGXrSC+LU4WFkoeASwLkWQDBrvHhepkD+pGOq1r9EPMXWvhslip
         vVvFFfgQnE0CQEEmSCGo963slscTIcNbWn14BNcetvJTJepuQEBsfa9JLOHWOjFVcr7q
         Vq92x1qtZJNCWaq7oNqnpku+y0OC3cjItCI27s5wHFVKbOu0sYdfKnTLXEfkn8ytomno
         YmhPOQDc62yfIml9ZuQDIFIzsVXRdkbZm0Ls8wHWmc7DPqZBbYlq1K9aPHTJzqxE/fUa
         /p2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713372961; x=1713977761;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUAHB5bPJ+iDHtRK1ERMDUYx1czMuNi349CzQq6TWhk=;
        b=ctUUKJkxRfCHVAF4U/ApdrtHQ7LFxqwVnc3tofhwWrqMjwMbWYMZjoFjc9fKxkqH8S
         FA24tQccpjfgba3VaG5Yq+MpnJIzpjE8XAVjXtwdDfenYP3vKQN8+o85slLcOai6ScDT
         btXDn2xvBUk+NUlPi8UvpSz9s7GQQbKK3E/5KNwNds6Piutc4FeXvSGpged396QNrbzJ
         A0XnsqiiFiIB2JuHiwCuYWXv5c7RfVpIElkc1xxCVDmoU+VyDJ5zA7tYUoGW0uV5JBwm
         dDdD+8nCerkH5zPtBk+BdmW7xGTb2M0YRx0cOMZ4lJIRiKtz0rHjLEGlIdfxmTZRX8hs
         Oqbw==
X-Forwarded-Encrypted: i=1; AJvYcCXMX6qoW2TUuIOkROuqKyWj302C8lPUhAQM2qEwXKTel9pOeYL9E7s025NSLuEwLlThP/yq0ndZhN5caKb/npXjafAOS8r4YFeP4IU=
X-Gm-Message-State: AOJu0YwvXIeaHaf5RCKPvEd5DaVsTLr62CU6rhE6K8uxKYnyjGVvNbLr
	wNHwqCxn4daxCBIFwsnCxbmbfy9k3Lrau6kMAK+VsrWcn481vAvurKUcD/m44Y0=
X-Google-Smtp-Source: AGHT+IEq1tXs6bVu+t+KS2pPXVs3KAV+KvjBYxSJrIs1bc6wfc93/z+DAVpdNKnzJU21HV/Z+81VKQ==
X-Received: by 2002:a5e:c907:0:b0:7d6:a792:3e32 with SMTP id z7-20020a5ec907000000b007d6a7923e32mr241839iol.1.1713372960935;
        Wed, 17 Apr 2024 09:56:00 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id dq3-20020a0566021b8300b007d5ebc40f82sm4010155iob.31.2024.04.17.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 09:56:00 -0700 (PDT)
Message-ID: <e843abe1-0561-4ee7-a73e-4ffd407d523e@kernel.dk>
Date: Wed, 17 Apr 2024 10:55:59 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dm-io: don't warn if flush takes too long time
Content-Language: en-US
To: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer
 <msnitzer@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <65c83995-1db-87ff-17df-20c43c1b74d7@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <65c83995-1db-87ff-17df-20c43c1b74d7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/24 10:51 AM, Mikulas Patocka wrote:
> There was reported hang warning when using dm-integrity on the top of loop
> device on XFS on a rotational disk. The warning was triggered because
> flush on the loop device was too slow.
> 
> There's no easy way to reduce the latency, so I made a patch that shuts
> the warning up.
> 
> There's already a function blk_wait_io that avoids the hung task warning.
> This commit moves this function from block/blk.h to
> kernel/sched/completion.c, renames it to wait_for_completion_long_io
> (because it is not dependent on the block layer at all) and uses it in
> dm-io instead of wait_for_completion_io.

Looks good to me, though I'd probably split out that dm change as it's a
new addition where the other parts are strictly mechanical (moving the
helper to where it belongs, and using it where we already do it).

-- 
Jens Axboe

