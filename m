Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B343F1AA6
	for <linux-block@vger.kernel.org>; Mon,  8 Jun 2026 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931912; cv=none; b=V9+jGO36vjb/7uyrje0jlN6lZ4lxtZJVEI5RITNsyEaaDPZAQt9kvIsXc0oPB1wIa8Olttqlik5BGfpvpwgt5JKQHhDimpcBYDJPlFdz7YgbuSyxZXjZNdEh0qg0rqJVogUA+k52UQI7g8vCIKurR6x3UqBirdWYRPoLJh7aoy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931912; c=relaxed/simple;
	bh=o0puYPPim4DUrzgBG9/Emc8s91+qJPiAOCOEiacZMTY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DmXnqOO1raZl6z0el4uDbHphJkehEP3xQnwnlnUQsdiHZ7BQ/3jepZVUFzUySGvtjentrjkhwr1LBP/AfGeMc31S37dGkwcS9IaGf1GGdg/ta5+jwBNbseq86sSQMuJTdauGcfnZY9vgzI20dPwNTNwbB+JYeQgsJH7Y8XxWEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=HoJ0JeMi; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="HoJ0JeMi"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69e7dfcea4dso1124738eaf.1
        for <linux-block@vger.kernel.org>; Mon, 08 Jun 2026 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780931909; x=1781536709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6+aoZLgIF6RxB4GnlL6NukkvD6+OSILH5OgbCqQntZM=;
        b=HoJ0JeMiR6Y4XuuFjeZ/ScFGK1QPyos6ZJMw/4QpoCcz4aYFCpKpT1FVvI3lkBrok+
         D9Zt6q+K/K7dNUGxLW+E3d1TdElNv5+1Pwgqrm2IEaHNM4h7D8zUh50PmivUBgSMi4Y8
         +Q8g4EVXFyYz+BMYGw4yFNt69Ai18Syf8vCsglwFfkBv7iwLkTMBW33KCXC1pi4fhf82
         8/+WfVi48+2+jGhuWWxy9WAmT8+rAyjar00WF8wAaxPa970Vj3r7zHOTdlLCkN4sTUg+
         ty3XLVEUjxgbdh4MX2jDwkgFHHXQ0Pt98sIr5dJ7nzzhj6NQJ4AxSujvlHx3mjusUW2D
         n2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780931909; x=1781536709;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+aoZLgIF6RxB4GnlL6NukkvD6+OSILH5OgbCqQntZM=;
        b=spSAEZ1Wh8CWPfn+jBm/G/fJaB8/99+Um0qT7con8irPSOFZrTwG3Na6EORpPblyun
         3wJKeX1AH+DPz2upoIk5lLVYXS+Gf67iLn5K0bA6haEcN5oOpGHJQZ8SDu0vZfXEkUC5
         6C/OOdr7eCPMPU+i4iomODN8pRaSWOamtIZoWP3OWXujBSh/KIju8vCbSMonjBHY+NQp
         U+4T4Z4qyVLYIXoCPcUe2YQK1UdBNwIbb5uMcQis4AwapEjv/S63PpCWPqAzbdJmMc0j
         diTxveGJeAf2Ffqqy9lfrUVfZG4uIqnTkideK7loNbweyXbebNet4DalyhgtbBfBQ3pH
         l2WQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C2Hc3AMhcJFhV8TADM/TWLERzxYP5Y68kaov/vsBJg+NloiePoJa3X7ZrO152l0IFuYMstC3jY8K4eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6M9TinODd3+VZXW7L9BuSMbPBpgORohRW+PJcOjYK5T3hGdRt
	9p6gRPc/tzCDGjZKCQOOhaF6XIkvFy/NstscsSYIagqLa86tPYZVk/7ZeV6zu54YT0I=
X-Gm-Gg: Acq92OHV+gq2BbYTBGpUQNjJZ8iDwA/Py/DtxhTGG24x1u/JaqIfUr6RGZB5kBGI306
	FXM9B9MSgA9q5n2xZrfvsfbUsEqwaAOBXe3irlefzsXR14YA2UoLABSd6/V4S8hIHRFPYm9XwnW
	sBHyA7NJy6dn3V8RDbH8PAQfNwC4BDzqXwBmxnbJYfdYopgATZopvwPH8ZAXNOeOSKsPjewS9/w
	uYJ2PO0j1jt19/3EJuNPFd5SDmh91dXbHzgQ00zCqf4sCT23c7SKO9RUumwLIrtpp1wzmBzdB8g
	Q2sYm1HpoZtk73EujijYMgYIp0JdhIT1+EYYnz4hhzsIGuRLjs1zsX29otumClNus98CUxCLWFD
	b/cxiUcCkmheK1Mp8EzF6NlEJQEGDmuQ2zXuNxEdIs+bbN1pyhEavTw9QcnwmT6KwOmmFb0K68J
	bgs1NQdVmVxhNtuB1mpblQbydxHWmWBnM9OnkVf0vsxmWDllTPHEzOLBLPeIKHK3xoTAQHo6fo2
	aVzGM9PFfDju450bmaI
X-Received: by 2002:a05:6820:168b:b0:69d:7777:75a8 with SMTP id 006d021491bc7-69e6d38eaebmr5354332eaf.11.1780931909570;
        Mon, 08 Jun 2026 08:18:29 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e4605ec33sm10213223eaf.0.2026.06.08.08.18.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 08:18:28 -0700 (PDT)
Message-ID: <138e4acb-1525-4449-848a-d9d07abbe4be@kernel.dk>
Date: Mon, 8 Jun 2026 09:18:28 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH]block: Observing higher CPU utilization during random IO
 testing
From: Jens Axboe <axboe@kernel.dk>
To: wenxiong@linux.ibm.com, linux-block@vger.kernel.org
Cc: tom.leiming@gmail.com, yukuai@fygo.io, wenxiong@us.ibm.com
References: <20260604162709.3006327-1-wenxiong@linux.ibm.com>
 <76b46c10-201a-4bd1-85a8-49ae6bace572@kernel.dk>
Content-Language: en-US
In-Reply-To: <76b46c10-201a-4bd1-85a8-49ae6bace572@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/8/26 9:15 AM, Jens Axboe wrote:
> On 6/4/26 10:27 AM, wenxiong@linux.ibm.com wrote:
>> From: Wen Xiong <wenxiong@linux.ibm.com>
>>
>> Hi All,
>>
>> Our performance team observed the higher CPU utilization in RHEL10 compared
>> to RHEL9.8, observed the similar issue in upstream kernel(v7.1-rc6) as well
>> when running FIO random IO tests. Random IO tests are more CPU intensive
>> than sequential IO tests due to several factors: more context switching,
>> interrupt Handling, cache Inefficiency etc.
>>
>> Given commit 060406c61c7c ("block: add plug while submitting IO")
>> causes performance regression. This patch reverts it.
>>
>> Below is performance comparison with the latest upstream kernel.
>>
>> Iotype  qd   nj    rmix    mpstat busy        mpstat busy
>>                          with inner plug    without inner plug
>> Randrw  1    20    100       53%                 24%
>> Randrw  1    40    100       70%                 24%
>> Randrw  1    20    70        40%                 24%
>> Randrw  1    40    70        60%                 26%
>> Randrw  1    20    0         14%                 6%
>> Randrw  1    40    0         20%                 7%
> 
> I'm fine with the actual change, but the commit title and commit message
> are pretty abysmal. If you were browsing git log and came across
> something that said
> 
> "block: Observing higher CPU utilization during random IO testing"
> 
> then what would you think the change did? You would have no idea. That
> title is a bug report title, it's not a git commit title. A good git
> commit message should tell you WHY a change is being made, and the title
> should be a short summary of that change.
> 
> I'll rewrite these, but please keep this in mind for future submissions.
> Should not be necessary for me to completely rewrite your git commit
> message.
> 
> You also identify 060406c61c7c as the commit that this is fixing. This
> goes into a Fixes line before your signed-off-by. And you would
> presumably want this to go into stable as well, yet that's not tagged.
> Please read the documentation on how to submit patches.

Patch also doesn't apply without fuzz. Please submit a v2 that's against
for-7.2/block and heeds the above advice to turn this into something
that's closer to a good patch submission.

-- 
Jens Axboe
