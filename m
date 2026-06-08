Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C882EEE82
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931745; cv=none; b=BG6Lv34WXXoCJQgKYVtVhysLs8JuK2Ij0ybguIafFP8EFxONL5MzXZB4u3kfnwpayuSwgneiAEcbsaGSyzuZkAtMIPkxaKQP95Pv8Oryvdt7dBXvnJ3Gcn1jfTKsCMrHFRippMlpd6aI6iCU2MnvKg6g+gwODh4p2PvcHIa11i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931745; c=relaxed/simple;
	bh=2QVwxrh4a/ZZYirQ5m2CzbMgnpm4A1vBhilyI2+vzpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QoWSD2Yns9tKtgx6teCqvJhFw7kBBorPDhSfi4fdbNIvxwjv9tswhW9RxVN8FEBWq6sOAIomfnGU6mTHfutIki9+PLOIC68WDULQLb//y5JDIABmXR74Bd3ryYeyYOK4Wg8l1HFK9qiEdOXBcusv+Pa2k3fBfAaNrKKG6VHGp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=z8hMUgra; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="z8hMUgra"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4863cd41330so3305460b6e.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 08:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780931741; x=1781536541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8359BKdjiJzlljcqmkz+cgMu1mtfDcXYE9249W7UZ98=;
        b=z8hMUgraU9hJul0JH7iF7DPWPg/fcQU/A0Qjq4bhkopzE+YfYGhcogcqsQsIsKUpvT
         W5lbBtdQkNVNyGBJEySni8wi1Xkt8gEdqqZ37A915Ccr0V/UENGFd/OETTPE6Z+wTLTo
         WZB16jbIgE1l0w36kR+7od/K4kkkVAduJyvn5jtVlG1HVg/yKFw2M3I38yW+16e30OQs
         ApS44ID40y+HHmI/wY4u4uG4I9G4haj2ebJOQPap2qXRfT6UEJXSmuolrVzCzSrFYBNe
         Ezgs3eJ0qnkJiYgqyLknq4qQJYZNQlmFrJmxJn1UXYx9oD63VbRKf/DeHNNfXVuv1VKm
         UTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931741; x=1781536541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8359BKdjiJzlljcqmkz+cgMu1mtfDcXYE9249W7UZ98=;
        b=MEjWkvs6dH5f77dlXVfDm8pTkOOn+YRziKvBxJOTfBwsPg/kcqQN9dEuj39GoEn5gJ
         5zI7wuvW70+y3iZCobRhLjYIQ12FEsM5F3hrjHl3mF6VziAO+V2i3XM6udAk2OpOg7J0
         9HqP+qZLjk5Na4W+/1SKjwa0CoVsO6vKnpwAPPVflmKbX3IFEo9aXkunso1QEin0sziI
         Qcewj4HOp/OZbzWb1zj6V1oRbPwjcgZBz7kTgDry9zeYplOUzVmj1AIJNwrpkp8/oubN
         SB8SFYltxLvrachiFiYTXo65Qh8ADdBvIQ+QI/4OulIATHb8uZ04dZE2EQqHhXun/2J4
         mUjQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Ef45nkCnkR/6wa9AM/tdQshSV77RjaNOI/Rvam27pV07GZPOrNvqfPXGfIthHBZzHFmdkvFK9ewQbwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZvHINVfLT7iMTdwNDWOWg49rdeF0l9qSEbTBn5C3aGmX3GjXO
	NjiP4tIXKlWHdlFrd9nEXufjKncp9ELArHUkl6ndw2AdWd2DIfSgAh0VUnIRGXrWR+k=
X-Gm-Gg: Acq92OHTc2rjlvK3wXPv8MLzOUyPrg40/wLTibbj5b9tNgUpVluuQiojVdR3a4sDaqf
	4eUAQhZ3Ae7dIaIBJpK7/hALXrpmQ4oGODvwV7Yr9cmFuEzKqQU3OcGRpVnFZm/KytNHZp4+qbL
	+O57OlpowXscm1mF/pIRKv187eQI0OrZAN2QXWxQ7eJesEV7HHDmRgw/YZL77hkrkFWCIGqFvaM
	Ua5Ng8cQMmrYTGQubCjjDDwqvBybyc43dB5mwVlzWmIvuzYfR3lzjhfSm9oyNg0nT7m47EO0Xah
	jp8iCafa+607yEB7kOXeefil/M/Q+xLKtlgO8xxY6Rl2LWmypl/y2VRk6B20GPFMkO/Pf3KKE6X
	Ie2Vm202/sJfAlHa6tC6MvGwPiJqbQbBjs2NF685HNpCE4WGtmDQbPcTGpnlE2IjMeHWb1QO35i
	r+pXd7/bXpnOTYxfbkmkYkaOXmKQbCCzQIam/Powfad392BVA/8kh1Ow++XFd2BoiM6Cl3vI3c0
	4jmMlOzCWFt+mJgx1AF4Zc+rVrNeTM=
X-Received: by 2002:a05:6808:144a:b0:450:b249:71bb with SMTP id 5614622812f47-48692e390c3mr5909165b6e.19.1780931741331;
        Mon, 08 Jun 2026 08:15:41 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e71fe69esm12877934a34.0.2026.06.08.08.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 08:15:40 -0700 (PDT)
Message-ID: <76b46c10-201a-4bd1-85a8-49ae6bace572@kernel.dk>
Date: Mon, 8 Jun 2026 09:15:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH]block: Observing higher CPU utilization during random IO
 testing
To: wenxiong@linux.ibm.com, linux-block@vger.kernel.org
Cc: tom.leiming@gmail.com, yukuai@fygo.io, wenxiong@us.ibm.com
References: <20260604162709.3006327-1-wenxiong@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260604162709.3006327-1-wenxiong@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 10:27 AM, wenxiong@linux.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.ibm.com>
> 
> Hi All,
> 
> Our performance team observed the higher CPU utilization in RHEL10 compared
> to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc6) as well
> when running FIO random IO tests. Random IO tests are more CPU intensive
> than sequential IO tests due to several factors: more context switching,
> interrupt Handling, cache Inefficiency etc.
> 
> Given commit 060406c61c7c ("block: add plug while submitting IO")
> causes performance regression. This patch reverts it.
> 
> Below is performance comparison with the latest upstream kernel.
> 
> Iotype  qd   nj    rmix    mpstat busy        mpstat busy
>                          with inner plug    without inner plug
> Randrw  1    20    100       53%                 24%
> Randrw  1    40    100       70%                 24%
> Randrw  1    20    70        40%                 24%
> Randrw  1    40    70        60%                 26%
> Randrw  1    20    0         14%                 6%
> Randrw  1    40    0         20%                 7%

I'm fine with the actual change, but the commit title and commit message
are pretty abysmal. If you were browsing git log and came across
something that said

"block: Observing higher CPU utilization during random IO testing"

then what would you think the change did? You would have no idea. That
title is a bug report title, it's not a git commit title. A good git
commit message should tell you WHY a change is being made, and the title
should be a short summary of that change.

I'll rewrite these, but please keep this in mind for future submissions.
Should not be necessary for me to completely rewrite your git commit
message.

You also identify 060406c61c7c as the commit that this is fixing. This
goes into a Fixes line before your signed-off-by. And you would
presumably want this to go into stable as well, yet that's not tagged.
Please read the documentation on how to submit patches.

-- 
Jens Axboe
