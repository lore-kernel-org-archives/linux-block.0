Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3136C0AB
	for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 23:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837144; cv=none; b=Kuotli6h9wslNdlar2fnSVIDKCSodnpnAJXRgqviEZkAE+eGKt+O9gpb8WxfSTgpGm9Nd1Mk/Gkp6r3rJkPncy/5URn3Ji+RQN1G62BvOSjBoEaH/xcIN/zRXrvxPiDcCuTpzH+0xTgdb3t5N6vSgwV413cFP1THJHP1qDk+9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837144; c=relaxed/simple;
	bh=MfXhbakq6teIyb5f90CoM9h56piffmzOtlyLBqM0Er0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4p61bjPWzmvr9iabOhjXKR+E72fez9srtU7c5PaF1XcirayI1vevBqU8J1+Z2AVTBzVisX/eZRpTbywOOvJUNr3+68sf1kMzLVWWETgfvApoeszzMbinBrpNw0jlvHEgLeDMO1w09lvMyF38rkVDXYlV5rqPsLQcl5j7x/4ZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=dKzn88BT; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="dKzn88BT"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ecd7216cso1086292a34.3
        for <linux-block@vger.kernel.org>; Sat, 15 Aug 2026 16:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1786837141; x=1787441941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e438uvYsHZelLiRM7egZvoN6MhVvRzsj/8jIT9YSHRQ=;
        b=dKzn88BTsb6FLzwM8p4pucHN9Tdb9X1EYF5A60xNW6V5T7Pbduny37cbDZlT2qXv1t
         fGMBAM/Gt/IbsxeWES59QG41D/vRCpuR7yEg4AKkxVuIXiLOhavUzvF/Sn8vVFyfMVlF
         bBvDZ4ougOeByYiGOnh2L5VKCit0H+ZMbTbj8Ul6N+Rzqq+ap5Mr2SsUOXcS9AIIg/75
         pMRRaQ2CEMGwir3qLpmSUwumiBvuXAK2jeuQfPEbVLIhwdh7FOylqx9YAcIDdoaDuWHI
         PgUsu+ATfy+8N/rlKJOtYXZf2DS5RMLJQxuF5nVWpx5S7QvhQ6GTxPR+jz520gxJOy8n
         zydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786837141; x=1787441941;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e438uvYsHZelLiRM7egZvoN6MhVvRzsj/8jIT9YSHRQ=;
        b=MBn/n8vk8/tY1i9tKYjEjOg1+pV3MnZPz1lt0xt1Ekx/tDotOPJl+godiC+Q62ntC/
         tGd6gwu1Osqvqld7zFnH9kVoiJSCwNdk4PBYrx+ci9334f78hRDs/hxDXhcJmcFbn5+e
         y85pYohVeY8OUGTSQex4rrL4OkMjrUYwKXzTh9zaMQSLVudFVmDP8Vwr5MGPv9sQxQ1E
         bHF7NWSxcdgWR6LBG/UtMv2HKs99we6BBp8v2ebUHaugcsUMzlWpywYwJnV9RczSmL6M
         rBXGMOZt4j8/Bow4mEmHUtqw+kkO8xQcl0to2Hn5P/LfuDfQgmk/dJY096s7hZpdhwok
         VOew==
X-Forwarded-Encrypted: i=1; AHgh+Rq3i40R2GgxdMBvPUiuur1FeN9JTvPi2lltHkMcH0hUC4wg3n8MP0FwP/+c9Nw1yRRvQhJuEK4Xb87rVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAbGYcRfsaCT3Pd4NahIIKgDifmzwTMuiDwxL/JDBKJWq0M6qs
	p7gdewelAQ3zGe7OkH70ZqRjr6/+o5IuONuelMAdb9Qlsv1OaC0vEJWBA7F8cGAw4zdS99F4FHk
	WmFFXlyhZIQ==
X-Gm-Gg: AR+sD13v6W8eWAUN4cqAD4Nq/EIqBlfTccTcaSVEFmQgD5m7syq0ASATWt2575JP0dr
	GB/Nh/nj9rIPzCGoihZsx2Ww9kkDyieA7UmJsYERA6oyWqnt4SmJWRJyZYpkWn8+gdkkYdB8nav
	cb/qhHAJqkO2cdt5W+qYUBc1QldFXWdRxa5HRLRy20cY0ytKZZrzT8tTcqRKW4qyf9pdvCCwEHG
	9lhwqQQT8rzRgN2u0QW1vx+iZ8xL8zvvR2BVJhzRI+ynCQ5ndIRi3aBQ/ADFaCcKtwLNF999FLP
	ey5g4DrdZAJRag8djSSUF+Sz90KARD34QqqLppjhdN7ZSetSqPBckMjdhezFG3F6RmXS2oVJ9ty
	IXBynGk/FZsGc+7/4QgsfHtoUsbVBm7Z9hml+DLUXdxgbizsF37qM7nr11skIcdyRfwHFXEpSFx
	IyoBYuOz1TQDzwdeh82xey9a5dV7v5vvc7kIzlzvBGwyCz54xENj7hoRrLtcYqWf9RDIHoGYzhg
	N/g7mZEKkqCyEXcc3D2BJoWFdNwN8XXusxKWH7vnBZPq+o9ytGM
X-Received: by 2002:a05:6830:67cc:b0:7e9:3765:79c2 with SMTP id 46e09a7af769-7f3de6089bfmr16447186a34.12.1786837140889;
        Sat, 15 Aug 2026 16:39:00 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e862829bsm4885308a34.15.2026.08.15.16.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 16:38:59 -0700 (PDT)
Message-ID: <2c5431e1-1d7c-4b8d-a857-321d2d61719b@kernel.dk>
Date: Sat, 15 Aug 2026 17:38:58 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] md-7.3-20260809
To: Yu Kuai <yukuai@kernel.org>
Cc: Yu Kuai <yukuai@fygo.io>, linux-raid@vger.kernel.org,
 linux-block@vger.kernel.org, Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>,
 Bruce Johnston <bjohnsto@redhat.com>, Chen Cheng <chencheng@fnnas.com>,
 Coly Li <colyli@fygo.io>, Genjian Zhang <zhanggenjian@kylinos.cn>,
 Hiroshi Nishida <nishidafmly@gmail.com>, Martin Wilck <mwilck@suse.com>,
 Sajal Gupta <sajal2005gupta@gmail.com>, Wale Zhang
 <wale.zhang.ftd@gmail.com>, Yunye Zhao <yunye.zhao@linux.alibaba.com>
References: <20260809075555.3215963-1-yukuai@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260809075555.3215963-1-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/9/26 1:55 AM, Yu Kuai wrote:
> Hi Jens,
> 
> Please consider pulling the following changes into your for-7.3/block
> branch.

Pulled, thanks.

-- 
Jens Axboe

