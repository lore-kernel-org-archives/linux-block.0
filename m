Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76323B791
	for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707399; cv=none; b=qoVlmgWPSrLRmZ5NxN9EUJAkxwLLiX42eLUn0znkoQCipbjKIJdAXlMG9v8kFdK75FiQE05N58UspWAMU6ZcRzUBuHKGtnGkfVZ1QqVRFsAKl0DYULWqve4D6BhnG7J78FoW3foUrB/ctWh2tt87sAshtLmxu3s4Kv3NVNrSyLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707399; c=relaxed/simple;
	bh=oqQyyesnmeEbiQCOOiE1x5jiDnWP9HRhLF2l4y7c+1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZyDeJo1/qGRLsuf6cWgdRGMbkUUGA0a/qVYvGctSAtJL5DB59RgONj1D+n7gYMzuJfP15j0dIHFVgYffb0bR3NmZ1CJKZmAUvu5nFAxTregxmoO+j+4tMRDA1tOUX9G+7B7Bw2s72GxdH/mNrqQeVXa9YzwFAF/OuAoJFYI+6rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CI7RJdL9; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CI7RJdL9"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-844c9993c56so165694939f.2
        for <linux-block@vger.kernel.org>; Fri, 20 Dec 2024 07:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734707396; x=1735312196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBICG9sn8sk18dR3CL6pM0dBSbzEMAQH0E19JdBtGM4=;
        b=CI7RJdL9Ac7aRQT8sydgiNHli8dsE8I55POYLgTaWrKaGuGEVH5OX5DW0uu7uzKbzg
         kVkjjJ0PTgp1J0r9/yt2fk/eF8A5aXe2JBupZOvChxFKLWJ31yO5/j8dT60gjZgXZrFv
         UGSixoYirQfE7DiwaW5Rbfaqp/N3Epg/uaf1NST0kp5RidJxSOVKyH5+u6UGAQ6t6R9u
         M6r0bDcdeDxJOuRXeBLYvhe/73XSzJb2HM8+qM9TROeYe3xB85LCOdYi6Y8HR5XCVnTh
         PKhCgM5v65LjqqKKmoEVGgf7lBg239Xgy76gP1ertgU9jpfSu2NlnJ5Dja7ExMnQW40y
         LlQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707396; x=1735312196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBICG9sn8sk18dR3CL6pM0dBSbzEMAQH0E19JdBtGM4=;
        b=M7iHFd33xrll1LHILk/vIWGWSbxdpWzNARSrYWdKbAFUDlAuBRBftxYUh2HRETR3Or
         UQtC2jsSdjKZ1CyAc5rcG/g6tAKrR2U6LnigrxDofV2y/P2404rV8+1swwxdOVUP67Ml
         H4UH2cl9B6vF2zanfGVKU3FJxFdddPF5LzklYeOsiUYNJOqbVCVnemvG8A0iGTC02aSw
         sCRVe5nIETbFgDquNJD9LdBNpA+h4cVKLSGmeVJ3Rs4KfiuILFXsAv3eWmoJ3W6eakEc
         uxCrYqXJOfdsCcTe8bYjhrj4QExFBFYm1xFWPlCdie4nwFRr5/WqL5kkyobbWiSmdCvr
         mexw==
X-Forwarded-Encrypted: i=1; AJvYcCVNpxEwQlIqq+zXfEV1G657YnBHzizOOw/rzmR04h2R2evxTSRKusoRFrUKY5g2Xl/GEtnJt8Tiw42ATw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxbsBMMISRawLl74CgPk8adBngegSMX6ArQKdQl/x3MiESZV7KN
	RgWzCjxajvokdNA3AiBrAvNXye8htvhI+8c+uoIIp3UtcDg0yzpdMXyPmGq4LjU=
X-Gm-Gg: ASbGncv8p2+DdWBrlI00OUsGFk+uX3hSYd1J/d4CDt+lDDqyH/pn1llAGtB5B9GyDBG
	xRRZNHpSENOrX6egILO1S9iW3c6t+jqaTuIdxvhyXKn43Uu9DetSYKXn5pN0vUT1AMHIiZPWusV
	gvqKR7+mk0GmOYhQX72D2Vwz6prqPlZkYus3yhMr+2mFxgoL8/FQn8cE8JFJvoqhSZve5TPpFiR
	uPQX1By7QPHUzBDnxISL0K4nkx6EjMsooUro2VeFQ6FojygFBYK
X-Google-Smtp-Source: AGHT+IEAbFA9wWa17M+v/Z4qOj/20ROukuQrIJaDUh0bs/zYDwAwC5zrW2PjmNdgAWk6miATAuhxrA==
X-Received: by 2002:a05:6602:160f:b0:844:ddde:c9cb with SMTP id ca18e2360f4ac-8499e49e7d9mr286795339f.1.1734707395799;
        Fri, 20 Dec 2024 07:09:55 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e68c19aee5sm818743173.107.2024.12.20.07.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 07:09:55 -0800 (PST)
Message-ID: <d48795a6-cb9f-4649-8c43-e36639a39721@kernel.dk>
Date: Fri, 20 Dec 2024 08:09:54 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Revert "block: Fix potential deadlock while
 freezing queue and acquiring sysfs_lock"
To: Nilay Shroff <nilay@linux.ibm.com>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org
References: <20241218101617.3275704-1-ming.lei@redhat.com>
 <20241218101617.3275704-2-ming.lei@redhat.com>
 <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <23c3e917-9dd3-4a0f-8bf4-0a6f421aae0e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/24 3:23 AM, Nilay Shroff wrote:
> On 12/18/24 15:46, Ming Lei wrote:
>> This reverts commit be26ba96421ab0a8fa2055ccf7db7832a13c44d2.
>>
>> Commit be26ba96421a ("block: Fix potential deadlock while freezing queue and
>> acquiring sysfs_loc") actually reverts commit 22465bbac53c ("blk-mq: move cpuhp
>> callback registering out of q->sysfs_lock"), and causes the original resctrl
>> lockdep warning.
>>
>> So revert it and we need to fix the issue in another way.
>>
> Hi Ming,
> 
> Can we wait here for some more time before we revert this as this is
> currently being discussed[1] and we don't know yet how we may fix it?
> 
> [1]https://lore.kernel.org/all/20241219061514.GA19575@lst.de/

It's already queued up and will go out today. Doesn't exclude people
working on solving this for real.

-- 
Jens Axboe

