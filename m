Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792897662;
	b=gGm3nEHPcEgk937zhkflheLV0VneA2GmbLL/g2BwIEy3CdzX4YvosIz2yLfbl4iHJC/Y
	 At5xu1YHYwVaYYugTmIHN61aUrU4ny7klPS/LvKJSx0pdXwJiGwidesOh9KdGD6mbliUR
	 rdeLMM4c4zz/Pt/pPoiAM5ZxvVhLvz/7nevt4ugd784JYl22LyUjydOEvGDOZpFr+s5M9
	 1R89v+m8I8GH9JCHSYj61BSi8eIMwY/GbCWG4jyEAARuaH7pOQm5wAXK/p69pOSx97Gqs
	 cejWRKnTp802QJNcAmyV9afiV60wUsZMBowOVK8fSGHieUWEbA7IaY4DE3OMJpN2XQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792897662;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=sU46yUAf9fpl1+G8OJsmObxc7Moi9Q2vShnNQxEzeYk=;
	b=S0Hd5bI7MemhW9BD11nx+CBKKisLosdNyXEUiif5ApiDNl8ivSVjutmrodwUYIwilYSw
	 GySeU+6zX9wP3RHEpVZeTAKQViDScTWGBdO4d/WPDEwn97kvVCFtbxIw7Z21MAZr35Pmr
	 B++PXIvBjB5xAbW0syKUiPNdRZkh372YjUoxJPubsI/G+J1JcTPKvuNBLPpDzwRbkLRqi
	 6nfd85e/dALmQBRrM2bBIGws8M9uBstfyzCYWZrWwcXiOtqFK6IwTf3+mKCi73oh4rejx
	 PRRzggBSSfojQYUJdYC+TV9BUcFyxAeWcBe5m9wgduXT0omql+83L/swhwBbYnFoe7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=MuMSfX8I;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD3606A328
	for <linux-block@vger.kernel.org>; Sun, 25 Oct 2026 03:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AFD3606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=MuMSfX8I
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15ea896ddc8so3403326c88.0
        for <linux-block@vger.kernel.org>; Sat, 24 Oct 2026 20:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1792897660; x=1793502460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sU46yUAf9fpl1+G8OJsmObxc7Moi9Q2vShnNQxEzeYk=;
        b=MuMSfX8I91h5yDHghR0un5ZmkgrgW6gXpPePZvjdFb0KZKvzOgsncReAQ7R4Q6gctg
         eBvHpKbpF9ElNGR7lScAldiz09zNUX9HrBQdjwok1xWYtUCuYtqvdF4PyYA0aKP837FU
         Lz9HlNJP65M7YQJyDuQ7oVJ+Vu983zwumqHY6fMmGJEofPnVxeL5UfDNwgKj+VEcLm0N
         WrY6n2pHDvPKk0CoQsES1rECZWNuo41Xms83ZQ1iHbCDq9mhah1NqgXMQB2C7sos5DX2
         Mm/7NOkmZtOAXvA/uXU1ISJuLjvb7KydFW2m5bZlVW8MOzb8G9IDLFsV8daSoSd2lgxD
         pZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792897660; x=1793502460;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sU46yUAf9fpl1+G8OJsmObxc7Moi9Q2vShnNQxEzeYk=;
        b=uMbFCn6sRVXednFJX5hbMiM0hvAceE6wnjn3Yt1+gNR1gSVkBMU1MiRiXOw81npDva
         kzBcFoE0rkPQ7jta5qCyGVdS3MC0kHJ9RjQozCVXPG5XInjNd8ofHMWq3GaTrhesWdQS
         FXXay3j16RbXKJfjUrt6GEsm0UdLSeKIthq5pr0JyJhPZD+AZiQgkfC+CZX4/XFcguJI
         kJAGipWqeXpUuS8X1480Xe0zYMEJ1U26s7QdQIRWZXTLf7TmIkxwS5zMUtPTQyLEIADQ
         mAKbgzyoe2aoVNnHCzTfjhmtZMNsXuMllgIfOPA4Ef5QudzBZoE/PFA7JPK3tk7Vl7ob
         TAyw==
X-Forwarded-Encrypted: i=1; AKwUvBxyzaJGX+eBasH9FDY5EpTu47C0/mT7gK9/cjwpAdFK5XOjXUc1a2L0l/lfIz/rLKRpz3azE5JPl+53LA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJrakNafNENe7yrW83nyyUjqsQ4lqqgLrYLL7sLnYlouHWgP6KC
	2+eLlXqhWAjLPJLhdjQFJgBDHzr9gbWeh6TfG2P/9NgWCq0yEINEazUX+efArlXoLGo=
X-Gm-Gg: AYBFou3dtB8d+2BliOBbCC7DOBcMuhaWWgw4ZtCWrGPJ7IFenzpRWVnQwkjZWSpFcIH
	WzefX52O3WedR/NDA09XzfryT2/jHY1rhjWqfRCT2loeEb7sQsQEUscCp5gXL3momLp3u/Kq8Cf
	b+Z3ZHUxngElinErXDfW9U51zlTlaBZlOyc9IfGGdizX3dnCtwhiBA8fNia0z8DsFG8LINuJgKj
	wbFLkvncyeOw49crA3xsPPMWWuna8mzxyh7+qySZoON0Kgk3aKNGow60XrT3nJGqj1fEc6CfvCU
	i8K8kOocAfz035QpdzNDnRj2BY2C7IsDLdIJBnPYjav1DsYf46bOgNA6vj/eMFh7tJZedzU9L0W
	YZOcoM9z26jJL6DFKyeCPenPFKrk9ecRn+7tB580RPx6lIhqjdeFL7iG8mFh+CBtbTdf/3agK+a
	6hsDr5UdF92EWvdH+T/hT5/N+VOaLlF3anqBwvQzbGIZyVBKq1WO7M+Iqq8zI587TRNohkLADKh
	D7dlF9NUjb7huRC3rEhwzmih+FWWESL8vrvJEkVl0yF1rhgLJRd8pMDqsSZLOa/q3CzKWFgmLmh
	QAdrDLPsFspCyRrQWRJ+YWO3VoDXSFusNZu2GEu99XC2zpcDa3/ADzg05RYJ
X-Received: by 2002:a05:701b:465c:b0:19a:9a93:c9b2 with SMTP id a92af1059eb24-19a9a93cdbbmr3541213c88.13.1792897659938;
        Sat, 24 Oct 2026 20:07:39 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a249c331sm26612823c88.17.2026.10.24.20.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Oct 2026 20:07:39 -0700 (PDT)
Message-ID: <31b5a611-2f6c-4ebc-801d-e1c5677633e1@kernel.dk>
Date: Sat, 24 Oct 2026 21:07:38 -0600
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.4-20261013
To: yukuai@fygo.io, Yu Kuai <yukuai@kernel.org>
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 Cao Guanghui <caoguanghui@kylinos.cn>,
 Chandradhar Kumar <chandradhar.2003@gmail.com>,
 Chen Cheng <chencheng@fnnas.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 Li Youhong <liyouhong@kylinos.cn>, Martin Wilck <martin.wilck@suse.com>,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Sang-Hoon Choi <csh0052@gmail.com>,
 Yogesh Gaur <yogeshgaur.83@gmail.com>, Yuchao Zhang <ndaugoing@gmail.com>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Zizhi Wo <wozizhi@huawei.com>
References: <20261013141241.2257621-1-yukuai@kernel.org>
 <c5690a5d-9553-463e-b9f0-617b4d29b011@fygo.io>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c5690a5d-9553-463e-b9f0-617b4d29b011@fygo.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/26 9:01 PM, yu kuai wrote:
> Hi Jens
> 
> ? 2026/10/13 22:12, Yu Kuai ??:
>> Hi Jens,
>>
>> Please consider pulling the following changes into your for-7.4/block
>> branch.
> 
> Looks like this pr is missing for 7.4, should I regenerate it for block-7.4
> later?

Oops, pulled now, it'll make 7.4, don't worry.

-- 
Jens Axboe
