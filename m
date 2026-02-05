Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0033438FF7
	for <linux-block@vger.kernel.org>; Thu,  5 Feb 2026 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308788; cv=none; b=ib6VAgA++sqKtLkqqs8KVDg5j4pXkWt9SzQpztLpE7gbciQkNNzhfvqfXwJurIJAPbgF/+vHD/wJtgxETuHMwgc0lE/6FO9IeJ7EpBDVN2e5mLTLDUaDeEndLzTY2CAronaJY7kTPFYtUnk10iK+56EDim5iMZr3LBdL0haHvFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308788; c=relaxed/simple;
	bh=BAzmASkUd3bk20/P/JRzE+dyxAnpmFkFd+DECd5D9/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrMDntwmvLWnp2544FX/if1XtG50TYX0abKitgbnm8IQOXP1UP2HYwqJfmZ8UTSX++cl84Xjd8WUklmX32WfgcSpMSSElo2UMsaoTV+jztW26HxdtJpbRBDBvIztTzt8n/s/7EcbLfUE3i4igFTPltUtuCNNe4yFoytz7CmajVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=H3GbcA95; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="H3GbcA95"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45efde72438so729666b6e.3
        for <linux-block@vger.kernel.org>; Thu, 05 Feb 2026 08:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770308786; x=1770913586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wk1GfS0yRAYmlLjlsUtDUJXTZDSLHrtZ8wK9+wTTaD0=;
        b=H3GbcA95a0wCYinaNtmMAJRtbwaXV181XaAIxPGEWEZjzma3iSDpTCnoAesmjAhfEq
         h+RFvWPrAJ18TIZW1BoopYcuBU53HwLnF/+6wY4EVY1bcZCezYFXjlGXPRLgZtvs9TbJ
         B6n8aC9VZMTV8oMEzyavGW4EpblaXiipPGTOy0y9mgdu0QdoAZQxuBICzZ/sYAO6xxJ5
         QMllzwu+TYGI2hU893JR2X2ELed576s0eu5zrhCdPpBbjnQazVGy15KekSkPOnNtGmG/
         kbrWZoe47E0QqbLgtGijnjjFf0Ot33+DCLJq01D/j+7pDZIFoVyup6nFkSIEveX4xCK8
         Zujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770308786; x=1770913586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wk1GfS0yRAYmlLjlsUtDUJXTZDSLHrtZ8wK9+wTTaD0=;
        b=KAAyOTn7JeKFw7cmKyFeEUKw8YxpBa63EmbpduPJfsbWfwseAMa0x5KE86EmQfkmEV
         x8MrlYBdgX++PJL9LMmicly7A6dNloa77VBd2wYkiAtPw6JW1B894ZGNYe6uiSMgfp3v
         N1T5sOJSs7lewEu2yPGQ7Eiu1HTAx80xkwpNC8vmfcSUQntOf8/GAq1MXZ+wfBzXtrTK
         vAKQXsQ1WT75RQ8/509Vlmm/XteVhz8XvLtDjASKJqyg6Ypu9iHz6sXhTNZc7Sz0DNTX
         w3dgWZm3+Jly/NfWrKg8N7h4whVsJ9EzlinRlj4IsaULm6WZCO+s0GPYKWk6iVISieOo
         mBiA==
X-Gm-Message-State: AOJu0Yw/Gt6PX9YtwmeO4v2XhGxBqMdylUtVegjx+rxiwI3Z9lQKHulL
	bQidO1fwyh/ZEyY8HwNdWfKJf3mFtnNQRXVH4aKUCJNeMhKs0b0xDzOr2Bo+s/6iubBOAyvD5NL
	P4QpHewo=
X-Gm-Gg: AZuq6aLt4OFcsKgA/vd+BE7G1BH+bkqcf2qwysIsiareZq5F+cF+R+F3OzQi4RSSnjb
	s7c0cDMWZs22jgheP8T0tqorojonf/WDYyoZDAS7gt7sQ/opDMcJWYgbbW9bShJ4o7CrfhI9aTW
	ok+SVkyewhFgV9YrrTeo8quE+Ut9miWIpToTlO2G3EjIx+odLXnyjQf+R+Z1dqTPOA5UHZgB13t
	4d/AkVBy0bz/CQI4jrMs1IyKmf6le0iVkk/DL5JOSPIFssMHm6Qlwalowk29q/2IPV3aiTQPaX5
	MfC6NrdGoXjzgAEeqwF7FRb8Lv5H8HHHgx707N97Q32uCdtMK8fcmAQQQ1+H5JbbBdfMST2XfvA
	Jyx06QwAGCY9tsxxUoSafXfHSVyFbcZ+YKGeMAZzL3iNcH7H9lBxmW4sZoxwylqqewDCbRi9JER
	7vtmrQ8msiLNz2NlDCYOLcQNmS7QuSotFCJaTL5kq6W9DSDUyYLQzTL8EYzvNYsL/4OEjWzA==
X-Received: by 2002:a05:6808:4fd4:b0:453:860a:fed with SMTP id 5614622812f47-462d5a27fb9mr3222539b6e.36.1770308786621;
        Thu, 05 Feb 2026 08:26:26 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a544eb54fsm3973537fac.20.2026.02.05.08.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 08:26:26 -0800 (PST)
Message-ID: <95bfe9d4-5ace-43cb-bcc9-ee26791381a0@kernel.dk>
Date: Thu, 5 Feb 2026 09:26:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Recent commits break loop device unmounting
To: nokangaroo <nokangaroo@aon.at>,
 Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-block@vger.kernel.org
References: <20260129131441.7c574b58@golem>
 <62de4453-17e8-47f6-a10b-39bf5a49fdee@leemhuis.info>
 <20260205171600.1939094f@golem>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260205171600.1939094f@golem>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/26 9:16 AM, nokangaroo wrote:
> Still broken. The disk image in question has a UDF filesystem (DVD image)
> 
> uname -r:
> 6.19.0-rc8-2-mainline-00045-gf14faaf3a1fb-dirty
> 
> The fix is still the same:
> 
>   git revert -n 2704024d83fa9eb8e5f16925aae340fd9d246694
>   git revert -n 08e136ebd193eae7d5eff4c66d576c4a2dabdc3f
> 
> I attach a script to create a sample DVD image for reproducing the error.

I'll go ahead and revert these for the 6.19 release.

-- 
Jens Axboe

