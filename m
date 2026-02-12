Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34335286A4
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900524; cv=none; b=gzriXcTfxRFLJxODdJ1Q+bcsyNZvhpYvN6FXbpvNcoS54UNKz+AgAPhIBCrRxjUFX7cYz4Em8tHOezaEr5HPr0v+UZQDS3W3ux5/UDflveS6KQ9JLXkaTa6HZscWgTEqnIf0w5Txp2VEnQ6OkqGRGdtdd9Ux9i/0Fus7o4akwwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900524; c=relaxed/simple;
	bh=a8KN6ahQn7rCW2n3Xxn/+xey0Z/suL5dtI8q5KSnQqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuQ2Ao3Ft1IxdMl8brCvfIVKGHBr8N87gBY6LcKlFHy6CjrDyUdLyI1eVgwlyBmElaNstsQ3aqV9DzIKldVP5onocjviiVNqlYTZnfWac6LTwe1eEfC/VodoEwxTqRT8WageEmmtOf1zoJPCzmsQHweESfo9aPiaB+a9ZxpLdDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=M7+yY1hE; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="M7+yY1hE"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d18d0e6d71so4214900a34.1
        for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 04:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770900521; x=1771505321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhhgOb9LysbVG9bbVsQCWTAloOdIqGb1FGL7MbEAI0c=;
        b=M7+yY1hEulvzqrFHHaf1QtQrLmq5NXwV51s4JQkhCsh2W9Q6+kHvZwnTiWpSRk4AYX
         brM+7sTKIqfTHOFpNKHYQuUmHLP0i9Obep7vMu4yUzYcCuqprsPXNBjbhXgzSVksFwPJ
         wStVd3Cvtrb9I/vYaux1A38JL7r6ghedQJULG1ylEV9XFKnjd/Zx9G5TS5z9HwDo3wFl
         q7LF4fejXXWI58IjULfHA+5lXu7nHf+OELc+24k+vHyeloE5h0U+k7/2uXgmROOZApmA
         hNV845ax15CCb74jG/wUdKFYM9ezi+xJjs5Dv/gWHR4d916nEUSpdicbA/cVzYOMNYwu
         dCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770900521; x=1771505321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YhhgOb9LysbVG9bbVsQCWTAloOdIqGb1FGL7MbEAI0c=;
        b=nYBnQbXFtDPjnM3bKmKEyl77CP0H+gvxSrkiJSS7fvwBgUCyMmEXe0baK+Xt7KmDQ+
         NhdlDSxoz8DiVsnjDV1Z+uTRAVRerVGgHgPUzSmojJP+5kKqo3IjUsVENh9xezbmRk48
         khmIhJPR3oqA91nrozPGdH5ZBA2MfRd8UMzWXGKTwTkrkPNZ9w3drCU5S/c8pl28mulo
         o0sWCHtx0r9s5nSNSPkRlQ82p/SVtRKvrOavB0Hc9ScXpAZMrioid7Op926vfFB5Y6Rv
         13T6l5lRWQkTyl4SUUAuwA1xFHhf1/BOu/ZshY1k+tx+4xgzy5+q4gg9z2OOacEyGJSM
         aiQw==
X-Gm-Message-State: AOJu0YwKwapTVLbKRVOMstFah0afoMxmc5scK8hU+ePomeEg1qpHRgsG
	h1Zd/x4i+R8zNiv6qBAvR4OFtp/tpRBafIbOn8bmoHMtKKtBAuCSbYr3r+haSn2+beo=
X-Gm-Gg: AZuq6aK5Ug+TH76JDQ1B/YrCGN36O7yBGSu2G//hn/ub5SmudK3DZ6wFK3qoV2qYQI0
	C8tZQBi/p3aRxh8RKxEjkaPfDB5X5sKJ3KI2LWwehHVfhT8guYwCboON464uz4C8DoU1JK50aKq
	3WLBjRXEP2/8NrcvBRWJrnBuFKlY8Yzmfwqw1CIt4v+bMSLlGNyvmcljY7I2CanWVfC3Z5yn9G1
	OcROw/FfqO1EvSVlVBf3DIe5VZw3v1ZQ7WWx8ovNh0WhaCP8nc1mDIdAeDdmr7kguW1lGEJf/B5
	gaOtjpdP4Bq6IG9whyKJYLnU59qH/UHhxTdkVSo/mfDsEiYBZQlxjWDmreSP9SQeBz4+HEkb1h1
	ZvCHflbSAjgA6Vls6VFFUmTF4Ss822eYFXyIx6EKrdD7TZztCagpZRBp1/p2A8uLfNkmgmSuULi
	baEVn8h+YwETu2HEtPHcO0LGetbHmuEL3FQ+Y6M1xtayHARxllM1Wf3TUfFesN+J3xKohO5F0gY
	D/EFLs+5A==
X-Received: by 2002:a05:6830:6612:b0:743:8af2:1af7 with SMTP id 46e09a7af769-7d4b2a7db1emr1727980a34.23.1770900521227;
        Thu, 12 Feb 2026 04:48:41 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530a8bsm3843898a34.4.2026.02.12.04.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Feb 2026 04:48:40 -0800 (PST)
Message-ID: <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
Date: Thu, 12 Feb 2026 05:48:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ublk invert part scan bit logic
To: Ming Lei <ming.lei@redhat.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aY3KpLbAOchXxXyi@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/26 5:42 AM, Ming Lei wrote:
> On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:
>> Hi,
>>
>> For ublk, there's this logic in in ublk_ctrl_start_dev():
>>
>> /* Skip partition scan if disabled by user */
>> if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
>> 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>> } else {
>> 	/* Schedule async partition scan for trusted daemons */
>> 	if (!ub->unprivileged_daemons)
>> 		schedule_work(&ub->partition_scan_work);
>> }
>>
>> where the
>>
>> clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
>>
>> seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
>> UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
>>
>> 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> 
> Yeah, the interface is designed in this way: partition scan is not
> done during add disk, and allowed since then on. The selftest code
> is written in same way too.
> 
> If GD_SUPPRESS_PART_SCAN isn't cleared, userspace can't probe partitions
> any more.
> 
> However, if you think the interface isn't good, we still can change it
> before 7.0 release.

What I mean is, if UBLK_F_NO_AUTO_PART_SCAN is set, should we not
either leave the disk->state alone, or _set_ GD_SUPPRESS_PART_SCAN?
I might be confused here, but the current implementation doesn't
make much sense to me! If it is correct, then a comment to that
effect would be good imho.

-- 
Jens Axboe

