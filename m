Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128FA175A98
	for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456973; cv=none; b=uUL24JwC/ufFFH48Eekzsu3pBx7GHyqj/tShF6Dq6tzNN9cp2J2vv3Cc8p50hWQ9l7ceUUwxsD7pbwAcMRqbOnypZzgy8c8aY70gku6ETloxA1CJWpW+6PlQuubb1FmDxodlnrWhNaOHNrNrem2mC/lijPgzyJh9JP+xOVdJrrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456973; c=relaxed/simple;
	bh=9/uDzK/SOjXU4mSKbw3OpUSLDaawOW13d96k/jF0MlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WRltKoKlDnS+RfPNe48YGFXWZIDP4BTRq843d7VmyW/bPjm2iwHDZ81Zl7H+4B544ur9gMQdEcKUnUBc2IpXCaJ68Va4W7g6sgggTRzGuo0QWnaMbRKrHZlaLHpLncFzeo7jrt0lTcC4bUuuOa+hLhFEwrjQgAOhymSW4kZYtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=WELJL46R; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="WELJL46R"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d1872504cbso950826a34.0
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2026 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1776456970; x=1777061770; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wR3h0fB21v1lOefDO4Gu/l+DJ7H1n/CMTlqrzlhma9Q=;
        b=WELJL46RrO9LlTrUNQ66XMpOWld5QRqd3+dYXXxJbXki/5SR9UD8fDTVs+3oufhsnw
         PHh+ofmYpTZxiNNLakant3qhYHfbJkbGvUocOhQa9MKavH6f3EmNaIpXXboPV8ckps9W
         G0p1RCyZUaKvxwDsvWgxf0Ej5RCjpCN2aeibdku34bqSrg1OiowO0BeFGqigeGSKcqsh
         v91Ebq8OMfi01+hxftCmUtNP3v2sQ76G+lIVJqlp65WKYlH+7AN5d8PKTOpHbcqOwWZ5
         2TnX5Q9tBijI1SIX6bxK0EL0Jw3mW7rcomR4azc4TxL9X/Z/61jzwf6wtMPnTdm8He//
         waaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776456970; x=1777061770;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wR3h0fB21v1lOefDO4Gu/l+DJ7H1n/CMTlqrzlhma9Q=;
        b=mv+74fFaXlA4SPORde3I1V1VOixegfQGbxLfkbfoz3PGMT0BbW4AEgO43xJ23gn/hL
         53TLAMNu2WdWtRJSr+lAw2ap/krMhfYV6OQlIFpUHY37XxilfYS3z+T7qdbAPkIsJYfO
         qaK5Hx7XfTzs2ulh6J5aMTrlsAdVBoFnx71eIoAK7CCRvp97dsMToGqrIQQ2A+ncN/NU
         Prvskbbk5GhL7L21ByIhRgx7dd3XIX9rnrGb4eFmXBhxL2GxcjvO8aak8ur2TX2+MhVP
         wcfuM2ZloOvdZeX1aXhoT/eCDEgBzWYj8Sa2ncbJ7bPgtPScN2TY+b7b71oIYq2BJcoq
         YUMw==
X-Forwarded-Encrypted: i=1; AFNElJ+SyeEoZ8WTb5iERlMfhvSQ23bebqBYLidE5KnyDnQu6GFb860h50lug0xrPvS8rLWBuuCs0QKlzPOFkQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7KawsnuWCwmvy62zSd8f0UtxvN02vUFBEQm174FMTGuYijpuS
	ErZpSr8S6QVwGSR9GBIZMF4GFSj/z10TXUYhZeg1ELjWoEAvFOMwtMRhqPAYwKnQUuw=
X-Gm-Gg: AeBDiesvjLPjThbhFxckOPhZcLfDtYiEEVjv8k1NgSCqtA5JPvRy++3d9h0XPR1W1+6
	XwgK82Lx1L31GmJ0CujLr2izxlCY+ybqZOINQGPFNwkQhU9nwV1J/dAVQUzPS16LThdelwYNG1r
	yT5Ekozr9hVMI9ENzFWRXbjHmt9W8Q6bTjt+9N+h77cNpfV+/543fxxK9y05IUcM2RGP2Ak/Pwg
	xkpSc/kcxfWf5o5KakscHsHY2JUPn7vDgZb/fVD7WYH2hFVr+WjQEKbNHJceo4N8m37XMzOKPGr
	t1QwRYvXpZyK1wPDtbANmKoEIRUev4q4iHSx8DvYcOdtiyIGuKL7IZ63GOtDjQs1ohJ9GjIxNX9
	3lYMPXnPdn61eZ+C54Hz1J72XYqLSDfuFPCl/3jxwFvUXsF7uC9L8pwKudPVe9bS1k+qk1kt/2U
	xWSxYB+hYu3g6HNwxB/tu4ppxCH0ABavIPNvg8PB2D31vp9MoyEUgH1l7Zi+qSDHjd/D2uDtuJ/
	7om6OCVALjGvb6sq6dg
X-Received: by 2002:a05:6830:668e:b0:7d9:d3f9:a82f with SMTP id 46e09a7af769-7dc955cf42amr2480101a34.10.1776456969837;
        Fri, 17 Apr 2026 13:16:09 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc99425167sm1585605a34.16.2026.04.17.13.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 13:16:09 -0700 (PDT)
Message-ID: <424110a4-4e14-4e40-af0d-59ca7a30d904@kernel.dk>
Date: Fri, 17 Apr 2026 14:16:07 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] blk-mq: expose tag starvation counts via debugfs
To: Bart Van Assche <bvanassche@acm.org>, Aaron Tomlin <atomlin@atomlin.com>,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: johannes.thumshirn@wdc.com, kch@nvidia.com, dlemoal@kernel.org,
 ritesh.list@gmail.com, loberman@redhat.com, neelx@suse.com, sean@ashe.io,
 mproche@gmail.com, chjohnst@gmail.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20260319221956.332770-1-atomlin@atomlin.com>
 <20260319221956.332770-3-atomlin@atomlin.com>
 <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ac8d9fd1-15c6-44cf-ba5a-85bd4aefce9b@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/17/26 12:28 PM, Bart Van Assche wrote:
> On 3/19/26 3:19 PM, Aaron Tomlin wrote:
>> To guarantee zero performance overhead for production kernels compiled
>> without debugfs, the underlying atomic_t variables and their associated
>> increment routines are strictly guarded behind CONFIG_BLK_DEBUG_FS.
>> When this configuration is disabled, the tracking logic compiles down
>> to a safe no-op.
> 
> I don't think that's sufficient. Please use per-cpu counters to
> minimize the overhead for kernels in which debugfs is enabled.

Agree, this is the usual nonsense of thinking you can hide any overhead
behind a config option, when in practice production kernels very much DO
have CONFIG_DEBUGFS enabled.

-- 
Jens Axboe
