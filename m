Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD94322A23
	for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 13:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781921; cv=none; b=NbZZFDSN1DQGe16uqlp6JoufWeHPd7Wlxd+98lDBUkCtow2NsPpI+cUtE0IOfLvi6pf8msq2EzsIvvM5f2R5hjufYCYRwnxe1TdVeM5gT16k21GsvQ+CvGiCo+mW8vvBT1IVCwSMo9hnzIA36dqWgeoXVoL9l6XDhIllmHnkMB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781921; c=relaxed/simple;
	bh=ynsd5patxKIbEZG3f4ujwFPtsFx1kM0gMc5nkwyt8WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6OLRphU7iexF0tXq5E9NzG1iUoQ05d+ZTuhB7eRx3UTBYQN3/dl43/ArA2DOeIGvjoyIahFivF2YLi6GWxpauy1lGTcyeyybjV5WzHxMAdmC77io5w6m/0g6z0OwoTokCVdoNwjsja4hob5OmGKYhCsjYdm4TX8me0BrWnBGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=DPZN60NR; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="DPZN60NR"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e570042988so9264055ab.2
        for <linux-block@vger.kernel.org>; Thu, 21 Aug 2025 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1755781918; x=1756386718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mi6ctp4jfXr0Yj3D0M/m6+bjtD7sQFjqRTmqMPnAMaw=;
        b=DPZN60NRvFz/76nQbP1syeZA/9RvF4qjXmDiGejfqYJYLPLUbqDOOMBwhsLWnxL9bU
         QVElrTtdtp9NhCuGPVq7ejA+AnDO7y1/EMAEQfwbw6hV4GK7aulzqMd0U61a4Oi3ykRJ
         LMrG4bvP6DlzDFuE0O/YVfH3l/O5H3SCUOjsV9PdaQzdxn939IqjDM4Sy6lawZCfws8j
         rH4cjy+JEYQUy+rGsenPYs5lSHTGnLbp8205+o333vWN7N1tMqruK+Cx6JzD4DFjX6uy
         i6MECcHnVK0oMFRIyUR0DG+WSQGoam9ry84d0CcI4htBECGh+g0DWEeqGRi69lD2tiIU
         aAaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755781918; x=1756386718;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi6ctp4jfXr0Yj3D0M/m6+bjtD7sQFjqRTmqMPnAMaw=;
        b=iHBg48ALaPX7ghu5NJ40xMKYGeSnijbThXj1hcOaR93XvTVzkHawjbR4UdKqFgrLBF
         cKkKAgIXpsIjHCvDwZ9N4mw4ALfvXmFBk1pzaaDL/FcvYtyhErE5dQ9wIgGmmjTo6IqU
         GM4x1QjNMmGqPY7nAHjUKOL0i0aipu40z/xG4IIsojkGvnEcR8CEKbKlQ29gnALuUln4
         NCc1ZlXsBy5A02+fXINhqNlfEvhKinR5614cIKJaSnrWspn3j8g3Vp7aSNCvAy8+VEMZ
         kBVbE+zo53fbwZeqF1s2yhz1uFKXsV594s91uBp4cPd3UjHgTculW+SJWJxq1JavEU5n
         b1RA==
X-Forwarded-Encrypted: i=1; AJvYcCUN6e0ktIm1KFgEKIHJxhL/YT1eXUltzWwQGGfN0GwcHu/sMOBfZdfiHHJfS1QOLwI66DQ58qQIlJTzyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtZgxX5l49QpnudiYdwv6bElTz8pO30ZpLe9u3DiewzD9aQQ8
	Iv1Tcu2DFU3aTyx2Mn3gJiAycOCaTHq9nhBTlTZ0qoQw4PtqUFpYyq2iAJtkjqg8XNo=
X-Gm-Gg: ASbGnct80P+Dtz+t7V6Hyl5wryVR4DMCpZYPfh+WFl9KkSinSm7jnrlZoS9m6YODAYd
	swCN1nWTpqEjQDDn/tpu4I7FSYEkJhE1ee078Zcix7eVGtwIneLf9j83lDy48lt5IeLDJs5D2ej
	D4siVWOjJfWB9LiCvvROo41+rxWigWRJ3prYQ+mkHDoQnUiqXOT+wVasQjjRGv3+HAa68qVEwut
	L+0zkuonpykcfv4VH6AVfXHbsaptw5bMND9/Uj911P7N6HkrUl0OHAD1nOxkCHf61uLV0ehgF3K
	oFj5HZgA4SMfgplbZxbXIyy1d+ow/qsXkEtFeOHzs6SsilUvt1Sv1y4+iktqC1gYXUW5OXKbLdP
	+dTzDX0L7ZwBMyVGYY4E=
X-Google-Smtp-Source: AGHT+IGVvUQf3DnQC6UrZ4nOhPWd0ycDMlb0FEtU/dnYHvJSO0pdt2NxCkH/lkSC0SitDjHIowAihw==
X-Received: by 2002:a92:c26d:0:b0:3e6:7aad:25ff with SMTP id e9e14a558f8ab-3e6d925cefbmr38771805ab.23.1755781917778;
        Thu, 21 Aug 2025 06:11:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e6789d85c9sm30709445ab.43.2025.08.21.06.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 06:11:57 -0700 (PDT)
Message-ID: <404c954c-e98d-4a47-861a-3a4e19bcfc4e@kernel.dk>
Date: Thu, 21 Aug 2025 07:11:56 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/3] block: blk-rq-qos: replace static key with atomic
 bitop
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: ming.lei@redhat.com, yukuai1@huaweicloud.com, hch@lst.de,
 shinichiro.kawasaki@wdc.com, kch@nvidia.com, gjoyce@ibm.com,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250814082612.500845-1-nilay@linux.ibm.com>
 <1c23ef53-b96b-4891-a1af-af32328139e8@linux.ibm.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1c23ef53-b96b-4891-a1af-af32328139e8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/25 6:19 AM, Nilay Shroff wrote:
> Hi Jens,
> 
> Just a gentle ping on this patchset. There have been a couple of recent
> reports[1][2] highlighting this issue. Could you please consider pulling it?
> 
> [1] https://lore.kernel.org/all/4f2bd603-dbd9-434c-9dfe-f2d4f1becd82@linux.ibm.com/
> [2] https://lore.kernel.org/all/36e552a1-8e8e-4b6f-894b-e7e04e17196e@linux.ibm.com/

Was waiting for discussion to settle down, but looks like there's
agreement to go with this approach. I've queued it up, thanks.

-- 
Jens Axboe

