Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9513D280
	for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478422; cv=none; b=DteQRpA25+0Uw7BDjQ8ndod+ue3Rz4nkTeWCH7Au9RbZRFrGjsGOtLnUXJANt73TjhFNk26Z4oi3sM1HPWnxCk6JcaZ+/6fQanVpAmXnV5u96IgyAgcY4M3Q0e6jb49y5pDekejrK0f1pLNbq/q3arykXSJ6S0FCip55B0ZuA2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478422; c=relaxed/simple;
	bh=TFMQzQ3KoTmBi0ENmtnDwHecaMcjd3lh5NTw5ECUH3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XpQ6VzcW1XJuIakvXji1V0WOg5qjF9+PMZ4LVREvcpqDZw+WOiYiRinOn9ywCoeM4WwfqB1ntMK1M/g3kXiYi1S7Pg5bDVIWX7BC2tKG4j9Uhoxrc2/Rck5J/wzOLXwvt7kx0yKM8ILKkMriM1qtIVsniEkGGw9xIfkXwcp677M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-346407b8c9aso1217589f8f.0
        for <linux-block@vger.kernel.org>; Tue, 30 Apr 2024 05:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714478418; x=1715083218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uPbeNwFFvVQVTt9kBGbVaBibbnkr7+pEiNl32W3+iws=;
        b=cJZp0qQ0NCe/7W7INFE9YmYbV5MMLEuCWzZyDXoDgAW665nqNuzCBRIODJow5j/Xil
         tDWvmPYXWp7b67+8dGsYIWmFYkwTqzcbt8rjZ4UI56zpENcPKhdphlETujOkkR5K7cKd
         bZiqFh/7ezyMnYWOQcAXsBytrAtDzTOvQKf1aSJDc2L5jtxkYXU1TMHwgqkoLM8imUzj
         A/AFBKTVYYdG0+4V206UekkTmulTHQJGwA9f75xkh4XI6YzNk/OutjsYuVsUlZL4QU3a
         E4t+yRyi5jkmqweXb+XkSUpedVP7q2Eu46cFcmoc31eokO0X85eREqJ1m7AnDr3f9uO9
         rVUw==
X-Gm-Message-State: AOJu0Yxa7329p1rkwNIeBZ/NjI14m/LqmVIZpdedXhxuw8ckp2Zm8uiv
	Yk6PwrWVL2+PEMpTu0EiGghwvW+P7oUlGlzp7OKUIJGDsy4Abk0L
X-Google-Smtp-Source: AGHT+IHCvPZ4QhLNmWzO2EUJcP6+Q/VtFAhLnOAnwsswtmMF7vi8CXelylUavq4zKECCmZY0HPqn+A==
X-Received: by 2002:a05:600c:4f05:b0:419:f241:6336 with SMTP id l5-20020a05600c4f0500b00419f2416336mr9436889wmq.1.1714478418528;
        Tue, 30 Apr 2024 05:00:18 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0041be78ae1f0sm11919724wmq.2.2024.04.30.05.00.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 05:00:18 -0700 (PDT)
Message-ID: <0a21ba7f-4d0e-4368-a215-2b81a8cf562e@grimberg.me>
Date: Tue, 30 Apr 2024 15:00:17 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 10/15] nvme/{006,008,010,012,014,019,023}:
 support NVMET_BLKDEV_TYPES
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Daniel Wagner <dwagern@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20240424075955.3604997-1-shinichiro.kawasaki@wdc.com>
 <20240424075955.3604997-11-shinichiro.kawasaki@wdc.com>
 <6b55293c-0764-4922-b329-be393c9afc81@grimberg.me>
 <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
 <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
 <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <sb3syw5ysqvkxvvn7mubzk3n6pfsivq54ownkyju2sgagesxpf@ktfn3333dmt2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/04/2024 2:58, Shinichiro Kawasaki wrote:
> On Apr 28, 2024 / 16:12, Sagi Grimberg wrote:
>>
>> On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
>>> On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
>>>> On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
>>>>> Enable repeated test runs for the listed test cases for
>>>>> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
>>>>> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
>>>>> so that the test cases are repeated for listed conditions in
>>>>> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>>>>>
>>>>> The default values of NVMET_BLKDEV_TYPES is (device file). With this
>>>>> default set up, each of the listed test cases are run twice. The second
>>>>> runs of the test cases for 'file' blkdev type do exact same test as
>>>>> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>>>>>
>>>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>>>> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
>>>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>>>> ---
>>>>>     tests/nvme/006 | 2 +-
>>>>>     tests/nvme/008 | 2 +-
>>>>>     tests/nvme/010 | 2 +-
>>>>>     tests/nvme/012 | 2 +-
>>>>>     tests/nvme/014 | 2 +-
>>>>>     tests/nvme/019 | 2 +-
>>>>>     tests/nvme/023 | 2 +-
>>>>>     7 files changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/tests/nvme/006 b/tests/nvme/006
>>>>> index ff0a9eb..c543b40 100755
>>>>> --- a/tests/nvme/006
>>>>> +++ b/tests/nvme/006
>>>>> @@ -16,7 +16,7 @@ requires() {
>>>>>     }
>>>>>     set_conditions() {
>>>>> -	_set_nvme_trtype "$@"
>>>>> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
>>>> Why not calling separate functions? having func do_a_and_b interface is not
>>>> great.
>>> In this case, we want to repeat the test cases to cover combination of two
>>> conditions: M trtypes and N blkdev_types. The test case should be repeated to
>>> cover all of M x N matrix elements, then the hook set_conditions() should
>>> iterate the elements. I can not think of the way to handle this iteration with
>>> separated two functions.
>> What happens when you add another condition to iterate against, you
>> introduce set_a_and_b_and_c interface?
> That is my current intent.

I don't think its very maintainable.

>
> Another question is how it is likely to have more conditions to add on.

I expect that people will want to add more flavors moving forward. For 
example
ADDRESS_FAMILIES="ipv4 ipv6" RDMA_TRANSPORT="siw rxe" and possibly other
features that can grow in the future.


>   I guess
> such many, multiplied conditions will result in combination explosion and long
> test runtime, so I'm not sure how much it will be useful.

I think that running multiple flavors of a test suite is a capability 
that is bound to be
reused as more test flavors emerge. But that may be just my opinion.

>
> Do we have potential candidates of the third or fourth conditions?

Yes, see above.
