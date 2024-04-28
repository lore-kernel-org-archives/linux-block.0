Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCB156B67
	for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714309974; cv=none; b=njh6Mqa7vk/BRKej7RRSV+crTct0pVv5F03WUias3K8ZKUFFJRji/z+bt9aRGIiMNuhiv7Vl3E+YAElTa7wbbM6I1Q00ohurUPrvxodYsBFAlW5W+GBM/3KjQnr3xaK80vQAg2gmega6NjAKQspHe3505myyROMtFduYfqfTCbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714309974; c=relaxed/simple;
	bh=R+2bLjAUzFlPzf8ITV5zVXibpvK58oM5mUZ7zZj3dLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmyrBtFyn967nk3nA14AJPYTeWp8vlW58WIUd16f3LtKt4wIxyqNC20fqQthQhm2ng75exK3l7zZLpd9v4/bLvvvh4rBGem8VjNtlKxwSFJ7OSp9kE1Z2uqhI7KlLy9cn4VlvI70T5EbeUabudUP73wn5mRhMKYPUYF5HsC2V44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-346407b8c9aso959198f8f.0
        for <linux-block@vger.kernel.org>; Sun, 28 Apr 2024 06:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714309971; x=1714914771;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A51YtIzmxIJ/1M7PSHIJF2EUtzQtza6QH2kzU4XcYpc=;
        b=lZ1IUsxYMm72ze7rGGBSWId2A6AIbkEfhpI+0vFTwi4nIgk+zxMfGBSDy1EywnmjeS
         UQ+RJciwXKxvWLYOZwpUiXYA/oZ+ZCLqf8WVJLXKFxNh0CFsgKdnHA5Ubt1w5D//ofBA
         UXDY9cd7qfl2/Lo6meF2nu5flUtu4Z8sA7IkMS+0d0HXTkV1sVz/tS2NV1gM41bDcsqI
         1ouORwOKrpsijNMp6jYbPAoNZq8ISOW0qwqxShYmxbLcjPBgyOnwDZvIr+PvLmPQ0uWR
         ljHf28H91K3vKTxMhT2Y5uBFph8fFpqorffO/JjqQI9L4QCm4t5NpWmvQ9kjjHX8AD8z
         NpXg==
X-Gm-Message-State: AOJu0YzRdR8j9WBi3IErzC0tNjdXQf8QibD9+bOwlh8Wl38bGI6YE9j1
	7E8LWJ90Wzv6paBQFSKU8Addekvlrv3BYhZPBIQLt1KohrOe7YJddGCijA==
X-Google-Smtp-Source: AGHT+IG28shCoUSbiQL2zGzCWftX7TwpyTs0fmz6s7amnWJ8lD/U5GtkUTE5IxlhNdTTVEuCLgGJvA==
X-Received: by 2002:adf:e247:0:b0:346:e3cf:1394 with SMTP id bl7-20020adfe247000000b00346e3cf1394mr4418317wrb.7.1714309970897;
        Sun, 28 Apr 2024 06:12:50 -0700 (PDT)
Received: from [10.100.102.74] (85.65.192.64.dynamic.barak-online.net. [85.65.192.64])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0034c5b28c264sm6156930wrt.16.2024.04.28.06.12.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 06:12:50 -0700 (PDT)
Message-ID: <eeee5574-f4de-45a7-837b-74589dab423e@grimberg.me>
Date: Sun, 28 Apr 2024 16:12:49 +0300
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
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <36jinbbjhzr6erpfpnfqmk2jebf5tlnl26skuak73krwyyu6zi@i5qtgb4bqqgy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/04/2024 13:32, Shinichiro Kawasaki wrote:
> On Apr 28, 2024 / 11:58, Sagi Grimberg wrote:
>>
>> On 24/04/2024 10:59, Shin'ichiro Kawasaki wrote:
>>> Enable repeated test runs for the listed test cases for
>>> NVMET_BLKDEV_TYPES. Modify the set_conditions() hooks to call
>>> _set_nvme_trtype_and_nvmet_blkdev_type() instead of _set_nvmet_trtype()
>>> so that the test cases are repeated for listed conditions in
>>> NVMET_BLKDEV_TYPES and NVMET_TRTYPES.
>>>
>>> The default values of NVMET_BLKDEV_TYPES is (device file). With this
>>> default set up, each of the listed test cases are run twice. The second
>>> runs of the test cases for 'file' blkdev type do exact same test as
>>> other test cases nvme/007, 009, 011, 013, 015, 020 and 024.
>>>
>>> Reviewed-by: Daniel Wagner <dwagner@suse.de>
>>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>>> Acked-by: Nitesh Shetty <nj.shetty@samsung.com>
>>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>>> ---
>>>    tests/nvme/006 | 2 +-
>>>    tests/nvme/008 | 2 +-
>>>    tests/nvme/010 | 2 +-
>>>    tests/nvme/012 | 2 +-
>>>    tests/nvme/014 | 2 +-
>>>    tests/nvme/019 | 2 +-
>>>    tests/nvme/023 | 2 +-
>>>    7 files changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/tests/nvme/006 b/tests/nvme/006
>>> index ff0a9eb..c543b40 100755
>>> --- a/tests/nvme/006
>>> +++ b/tests/nvme/006
>>> @@ -16,7 +16,7 @@ requires() {
>>>    }
>>>    set_conditions() {
>>> -	_set_nvme_trtype "$@"
>>> +	_set_nvme_trtype_and_nvmet_blkdev_type "$@"
>> Why not calling separate functions? having func do_a_and_b interface is not
>> great.
> In this case, we want to repeat the test cases to cover combination of two
> conditions: M trtypes and N blkdev_types. The test case should be repeated to
> cover all of M x N matrix elements, then the hook set_conditions() should
> iterate the elements. I can not think of the way to handle this iteration with
> separated two functions.

What happens when you add another condition to iterate against, you 
introduce set_a_and_b_and_c interface?
