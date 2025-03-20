Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9500629CE6
	for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475541; cv=none; b=aqdF9BW150yu8BM+QOwttplc1dKS0z3PfmF3Qbf6296qIh4rI3fBMKi5aFoOJTOoAF3GyXHmgXRc0JMQoCeMoWWeLii8OThqLGcrQzWee0AQbid/bdxygsURo83dV/uWO39vWBBsSMExaP9d5J6y7dl8+JFyHiGvbcK4iesx+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475541; c=relaxed/simple;
	bh=QJbjoUU1hkaoY/YmGkvIJJhYaQzGERVBOCIcORbR4ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gqYs6eA936oPNMHs1Fxrz5EvAlPKjxpIZ1C3Kpnjb8DOIkQsDPXZGtkSbDA962MoYM5Z9PBSgdk4GkejUsRvEYHt1/yenIGukBvHYpFxusfXAEd7HUlAArfWWyc3D7yLAL18+OkOJ3saQlLEkzP7bCNyKdv5P7Eaedb37ZEuLwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=UXpuhgeN; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="UXpuhgeN"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3d442a77a03so2042255ab.1
        for <linux-block@vger.kernel.org>; Thu, 20 Mar 2025 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742475538; x=1743080338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVnHryLbM4HSGexWSoyzqAnHzYi2U3F+uNUwYKaXBbg=;
        b=UXpuhgeNtcINsLkvzwk+IM8f6WA8bv6MVIM5ZU1BVIzouueGJFZtAOQq6aN0Uu5RCv
         QzqYrExB0/fdHqrzlXRrqh4/v/6a0WR8mX+YnJ0gW6NVNjx/bxEWttcM2yT8VQqswSbi
         6xg1i1Tszl+P1mWeN/B4DT+cUB9rrrTgC9DKlsl3AEDFJqxQwVtWX7WtsNM9XJEh0XLp
         JmXg5G/0OFa8as5AIXd2iFwrJAtiD+4nNVCsKidr4N27az6rqHAjQIeGlSUCcwMZ90JN
         EUFgGmzAp2HDOWDPSsfv69tZXlPOlUIgtXTG+s5DzFVdcxm9ERGV6jktH6ni6RxH/z/g
         1IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475538; x=1743080338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVnHryLbM4HSGexWSoyzqAnHzYi2U3F+uNUwYKaXBbg=;
        b=lZOZR7dd1cBkR5YLip4cv4YKQg5duYLIsQjw0hMGSNyunSqqjAedmdlAmBFEhimlny
         1+UELRpXCF6osp03SFGMBsijVafS0MWaSrdKV4W9TTYGWndrBPVAsXxyMJZ9Zb1lIGjY
         flovic2lkdonc6X/YZ7TTgLxKO81Oo+UxE3bI2o96TaEL/ze+pzMagJn+Wjs7nU8TDWH
         mRjRLYx1jLlw3PuRa+FVVewOi7WVollPFtL7W1yrG/Iaz6DW7sa5FokM7KabRAqN3ATE
         i6wK6CIOh8yPbUUKBSF0BRJggDCGP66JC38Nq6+XbHaqlZyKono0Mqp9+FQ2HO2sltnM
         SfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWASOkwS6UvK6pgtOTQh0GD8ZWMld/98xnU/7uDKuwc/f0kQO9iTo/f+SU3JzkaZgY03njjpF0LhyVSeA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqgLq7ZysE1linkjJS/U0eLImqxXqTQBZ863T/aJk+ikHTNPm8
	+nMmjpa5F3YFFCzoIM+HfvzoctCcbgbdrSKkt5NkKCF5U54noIqOoIirNUoUzTw=
X-Gm-Gg: ASbGncvlbo8wzecIMcbuf/P06P6Q/Ounp49c4fZP+Yve1YDLXn8J6H+tBkw5UJiqHPw
	WxxZRJHXLOaxplXi53BhrJfj79KC64wo+edLt62ZKICBe9OTlTQOiX84qn2ZfceTDMgiSyTd7Sq
	k2aHwdmU9T8xF8V7IFzCHD+NUwNsCz8ErEuPNEzCGx0XQVswnpIc0b1f8LINNYKoJw8q0yOrb44
	Pgs7Pvj+7vq4EE38G/rPF3uez37qqbQ8igz+oJAwOpkuZANdlx+RFRVo2ls/fiK/a4LROCQ+BGY
	bOsFLoBhNAD3o+YcP/Dg+93KKK2GsFueck3ysl167Q==
X-Google-Smtp-Source: AGHT+IFc/x57QJZx5favzhvE8V/QLoHjC7cHsoOW38xsaVU+AcJ3TJmBZSKivizLO8YzuV9hrOmDqg==
X-Received: by 2002:a92:ca05:0:b0:3d5:893a:93ea with SMTP id e9e14a558f8ab-3d58ebeb656mr26601915ab.13.1742475538571;
        Thu, 20 Mar 2025 05:58:58 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f2637198eesm3716437173.50.2025.03.20.05.58.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 05:58:58 -0700 (PDT)
Message-ID: <5f6c8dec-103b-4aa3-affd-f08fdf68f1dc@kernel.dk>
Date: Thu, 20 Mar 2025 06:58:57 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATC] block: update queue limits atomically
To: Ming Lei <ming.lei@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev
References: <ee66a4f2-ecc4-68d2-4594-a0bcba7ffe9c@redhat.com>
 <Z9mJmlhmZwnOlnqT@fedora> <d5193df0-5944-8cf6-7eb6-26adf191269e@redhat.com>
 <Z9ocUCrvXQRJHFVY@fedora> <6ebdd2ae-8fc2-4072-b131-a7c0da56d3f2@kernel.dk>
 <d04fcd9f-b4a7-100a-e9a4-b0d4d45b372b@redhat.com> <Z9t709DZs-Flq1qS@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z9t709DZs-Flq1qS@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 8:22 PM, Ming Lei wrote:
> On Wed, Mar 19, 2025 at 10:18:39PM +0100, Mikulas Patocka wrote:
>>
>>
>> On Tue, 18 Mar 2025, Jens Axboe wrote:
>>
>>>> Yeah, it looks fine, but I feel it is still fragile, and not sure it is one
>>>> accepted solution.
>>>
>>> Agree - it'd be much better to have the bio drivers provide the same
>>> guarantees that we get on the request side, rather than play games with
>>> this and pretend that concurrent update and usage is fine.
>>>
>>> -- 
>>> Jens Axboe
>>
>> And what mechanism should they use to read the queue limits?
>> * locking? (would degrade performance)
>> * percpu-rwsem? (no overhead for readers, writers wait for the RCU 
>>   synchronization)
>> * RCU?
>> * anything else?
> 
> 1) queue usage counter is for covering fast IO code path
> 
> - in __submit_bio(), queue usage counter is grabbed when calling
>   ->submit_bio()
> 
> - the only trouble should be from dm-crypt or thin-provision which offloads
> bio submission to other context, so you can grab the usage counter by
> percpu_ref_get(&q->q_usage_counter) until this bio submission or queue
> limit consumption is done

Indeed - this is an entirely solved problem already, it's just that the
bio bypassing gunk thinks it can get away with just bypassing all of
that. The mechanisms very much exist and are used by the request path,
which is why this problem doesn't exist there.

> 2) slow path: dm_set_device_limits
> 
> which is done before DM disk is on, so it should be fine by holding limit lock.
> 
> 3) changing queue limits from bio->end_io() or request completion handler
> 
> - this usage need fix

All looks reasonable.

-- 
Jens Axboe

