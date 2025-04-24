Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64808C0B
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 00:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745453922; cv=none; b=LoeOKpD4mktPLn8tBjAhbGyCHKHaYUAi5aUyLIzk/NoQKMC37KF/t5Rlrlm+p+5AwBSstdgbb1PtqKhktBcphcd/qQ4KwsC/HhqjAZWPil2X9IpVw4DOG6zZXFe2fNLsj0NTTulGDXoK27nOjaOeiSsv7oOxkQj8IxqfZT0iJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745453922; c=relaxed/simple;
	bh=DXH1IO1hAdU2AUtjl6a4PRgTHigbz0MdgoHTabtuTrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+75PlGoB/cuHo7xZmu4ROSu2IqH700GN1stDoFMbYWbOJmcLPbOOjHYWn2xLLxQP1ksXAKzwY2owPfx1LVGaNoOYix7qkG++a9VLa1XSpP0PYnZEI9LS2ZcleeOOJSUZvo+AbTS3xwNPkN3uNLG0qBZnJb8iK+jlkBBS50O0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=d87D02gG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="d87D02gG"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d81ca1d436so3645705ab.2
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 17:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745453919; x=1746058719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=no699vHbUtCiDhtLMFa9ixz998D4Np4s8xMtsBpgtGE=;
        b=d87D02gGa/UZORutiv03V45T81hXnmmU+G3VpRlz9SjGV6rGeWbrPDPntpPLFihWPZ
         M9IfOkMlSenOm+fU53pdMJyWhBHTU7BWD+6UA88n4peLvi2fQDzWtZTuBwDYiRl/ejDQ
         Shp8YKMciKEDOvCiK/uMKf1GLqzt1LOG+yLZUijtwh3m5aBBV//RvPhmrlr0yG8fvbsa
         zmd1Pa+go8j4OIFHJ4pW9rylm+9ZZLERQ0QhxYB3sT1/YEnaonDPVEwuFHaE7u4vorwW
         4+/Tcs17BSq52Au8eSDu1pa098/AQ1IfXTaUUBEAaw36KRoQVoz3C54DBNLyxfczmYKs
         E25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745453919; x=1746058719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=no699vHbUtCiDhtLMFa9ixz998D4Np4s8xMtsBpgtGE=;
        b=wa+6XnWSTWMYr4W1CmJHyxh8kpHi+yjP4hdnYCOuI7r4Gck7IQDeRDGKQOsa163CO3
         qr1YJaI+r+8hf9Szwj3AFLHa+ZQkIkTtOaNbmcg5BBSZGD5O7mUZzfl6JosT1tJd1Z45
         xlWh3AX6vX49XFXOZ922JtjVFrA/Iasd0i4H2ttFH8LosyfypaffE5BtifggYmXbFeGM
         Ooef+zYzLMVPy5CpVBZL8KHPjajCs5hGQ8EInvckmthYQeoUsgc1S0w7mYczRy2ZAR4F
         ZomwOhm73KGJ7fMkxZPlEkNEzqXBeGpWYL30AtkxBl/0dBYbjahiRjou5Mr/Wp07bIcR
         n8Dg==
X-Gm-Message-State: AOJu0YxY67adQVfz5UCB5aPJnD9mrbAOG5StWI72JNIpH9VtgH/yyNRl
	AS4yoLMqx9Vh3NUhhxq/KonNbx517rCDpnS8aAoGvY4oLXCMtt0N+b7AixnLSG0=
X-Gm-Gg: ASbGnctYrWI8YFQx/xXRMRKZRVQEWdOTJb/TIGJUleo22tqN6PwxUW7U5mb/kKbuWMG
	DszYdQEWRp+JTOIzximhCwSTSm8jgihhzeQ0BcDWGAryhz3X7B+cVh8zz6OuK/Qb2vkd1+110hI
	qdElP9Pl6PD0i2fXc5GC61pprkqeTszyjb3kW+PT5Wlfz8TVz4bcF3gXGNmMZnSZnqdMW/Mx3xi
	k+cvAvFxe1FquyCONhDKuu9tvxzbQ8jcATkwflCaHSdum9bWc+med1PcoRIRgX2xAV+SVNoUD4G
	4Sa08nCgw/4VKrstO/Por9R74wVbSQWb235+0g==
X-Google-Smtp-Source: AGHT+IHb+es9H9M9kGSwtETCKJLbMt7YPfw3chQ/Lxuw7WSyGf0XVM1d+FlyYn7Hy8udiuXpl/zxhQ==
X-Received: by 2002:a05:6e02:188f:b0:3d4:3db1:77ae with SMTP id e9e14a558f8ab-3d93041d81cmr7327905ab.18.1745453918771;
        Wed, 23 Apr 2025 17:18:38 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d9314c828bsm410385ab.27.2025.04.23.17.18.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 17:18:38 -0700 (PDT)
Message-ID: <1c7744df-329f-4b95-9afb-a005a358851b@kernel.dk>
Date: Wed, 23 Apr 2025 18:18:37 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests: ublk: kublk: build with -Werror
To: Uday Shankar <ushankar@purestorage.com>, Ming Lei <ming.lei@redhat.com>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
 <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250423-ublk_selftests-v1-1-7d060e260e76@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/23/25 3:29 PM, Uday Shankar wrote:
> Heeding compiler warnings is generally a good idea, and is easy to do
> for kublk since there is not much source code. Turn warnings into errors
> so that anyone making changes is forced to heed them.

Honestly not a fan of this, it tends to cause random warnings on
different compilers, and then just causing trouble for people
rather than being useful. If you think it's a good idea, make
it follow CONFIG_WERROR at least, don't make it unconditional.

-- 
Jens Axboe

