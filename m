Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA3C383C88
	for <linux-block@vger.kernel.org>; Thu,  5 Mar 2026 11:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772708934; cv=none; b=dQNCOZWK//8jvtZpMPchXnye95aekt/3Yi2WTx1dKH1hWnkmjkG+tw1xSF7EuAFr2P5/+WcYIOF+zYKuDudyBMHJcUHbwJ99yg3q/Yt0kVbWMo8rq6cdJdWx/bOKPlASr15HD4XDGC9YUsIkiP+XmHmZikFpCF50ldYhNF2NkJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772708934; c=relaxed/simple;
	bh=FDV1UFpNDyC4iS3F2XShJWOkvPHnFKhP4zOwlM1364Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=XSr04rxDkXnnXJ2mw539/2wcC8+oQUjIyUigy1ig92JM+02+PXXzNiJ/sqQWk5Ywg6c8/pA20641CYwgJmay0NpTMttHK+uMFzesDU6UfKxJVbtjCkjbTTyTmMWJzRZtGvHXC/ojyPLZac8eYbvLk0DQNq88AK6F7xkY7YG2QBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8rIvJDz; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8rIvJDz"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56a9402b52fso6598922e0c.0
        for <linux-block@vger.kernel.org>; Thu, 05 Mar 2026 03:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1772708932; x=1773313732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uYKtZyrHMRmfsrGjqt9iGtCfDVYbxBNH/xhoLATJFco=;
        b=m8rIvJDzFgrLITaOoSF32cHduDFH/u8+aunwwyJpU0oY/KffMdAKyritSKdCOS+S6P
         9N7QYlHeMLr0qTXhqPt/XHdIjTKnnBbk0XTddStWuzoJLgZusIV9sLq2g56NDBHqtQez
         Xs/vmv4WbkFl0UXep7DZXND7tBBYAzDVNV/+aCMP1UugsAeWHDpoMTGAv6h/hx0hqhJN
         Tm9GQx+K3pzj7wr4biW2YGnRI/ozR6gNQapXGPZg9/edExgkzcKoQS5VIU0trZuvQO6t
         W9inIULPnpggbOMgLI1YZo1BOWwF8caDBy+dp2qVbEmv8tUKBVeJRx4mA9+Rsjp6UviN
         MmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772708932; x=1773313732;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYKtZyrHMRmfsrGjqt9iGtCfDVYbxBNH/xhoLATJFco=;
        b=ZwKNOekfGOdms1k3tO3vQT5W55PxhCvhgC0t572efgy1TgbUacW5t/VGiwmFqlipvs
         l8X4FHEz/BIHdX8AsGapfwRbPrLmeOt3t+sKXoeL3rd8RKyQFH+c/JS9Bx5K0AbOwsn3
         AfXb4kLxBAXVjZo6aSlfGJmecZN10VMnCzoZmz+NQ65ndS7kHKQVeCatk4ArE3J+WAzv
         P6U4FTtWNyWpVzdH40EIlDDtzCqsH4ahBdupaq70lRI/5jw+Qcfz0f+nsu5COSEaUFmg
         r43RmOvhLEzIj65gYjWT6UDEVIzoJwpQyzQe9uqiN3KDh8P1WjARBtwB0J4oouIOsrgG
         0B7g==
X-Forwarded-Encrypted: i=1; AJvYcCWqzAkL3mfHw87+TuWD9NIg/eI94EwxdyKWZrOb38Gkob54GUynXNJvpAPAnQZbtnqo6j4DiujcDFzc7w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIzYhlEc+s/D6RGeEy9E4kvPMmtXVkbr79YnnYVN2WnoqBdcWd
	q+dcsQwK3FIO8n0gTDEX7qAcs7ItNrBilRCZvqmYbsl6RWbuyjyG5msiH+jtE9yh6nx3u1jG9ro
	xlvsLJNU=
X-Gm-Gg: ATEYQzyWSjAH7crrQ83ARKvq7R882v8mA8T1ilmMrjvTKVoECLwGUopg/BQXqTAEqMc
	Q/tEhDCuwkwzbyKn0s4RgXYcR8zfGilYiwdSdZPkPGpP1ENV4sPJbzAhOTFFi7/O1VImy6Qd2AT
	Si8+0BhE71o1x81hqdfBEhQURykVEHY4uch6oobp1pyTaYbSjcH1fZ607jg6Ft+UIpKEgY9P+32
	wLvdoradHr43lTTv6Ps9AJTJEJ6rq4gfNzB6RKSuqBRyPT5Ce/Z98bsVFhYv9AhrdWB6lpupEm4
	2kBFb2uT3YFylSk/EPHxeKFPcfvkLO8yjUT5T99Ukfqd23h08S6ajsnAzldu6hG1IeEK1bYlGk0
	aEuNBrzx/Wu53vDeAiLOHHzRA5N1ZKvOlN0uRn9DsNOmEHnvBozDEfc/+zWIgR0aMRuobCeKqmv
	xmCjmbSAO+oCvC75XNc5cMKoI4foEatRxnew2DTUuyiPmZe/yWNu8QqrkDogFfKG9yGsxhTCryD
	5D3ulXvhc1spfjMAsBIRa2VO2ewck8oH+MdqUhv7cfn/k3Rl75DeTujjwhu
X-Received: by 2002:a05:6122:1308:b0:557:c6d3:5c0f with SMTP id 71dfb90a1353d-56ae7793a3emr2597260e0c.13.1772708932416;
        Thu, 05 Mar 2026 03:08:52 -0800 (PST)
Received: from [172.16.0.133] (syn-071-043-216-131.biz.spectrum.com. [71.43.216.131])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56ae35d455fsm6387070e0c.4.2026.03.05.03.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 03:08:51 -0800 (PST)
Message-ID: <6d40385d-e447-4cb4-b327-bb10aa6a8563@kernel.dk>
Date: Thu, 5 Mar 2026 04:08:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: use trylock to avoid lockdep circular dependency
 in sysfs
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20260305031550.1161328-1-ming.lei@redhat.com>
Content-Language: en-US
In-Reply-To: <20260305031550.1161328-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/4/26 8:15 PM, Ming Lei wrote:
> Use trylock instead of blocking lock acquisition for update_nr_hwq_lock
> in queue_requests_store() and elv_iosched_store() to avoid circular lock
> dependency with kernfs active reference during concurrent disk deletion:
> 
>   update_nr_hwq_lock -> kn->active (via del_gendisk -> kobject_del)
>   kn->active -> update_nr_hwq_lock (via sysfs write path)
> 
> Return -EBUSY when the lock is not immediately available.

This does mean that scripts can get spurious -EBUSY they now need to
handle. Which probably isn't a big real world problem. While it isn't a
hard thing to fix up in a script, it can potentially break existing
setups.

Not sure I see a good way around that however, without queueing these
to a clean context and having the store helpers wait on eg work item
being processed and completed.

Hopefully this will never be a thing and we'll never need to discuss
this issue, I'll get this one applied for now.

-- 
Jens Axboe
