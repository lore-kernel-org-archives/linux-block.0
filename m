Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330DA1CF7C4
	for <linux-block@vger.kernel.org>; Wed,  4 Sep 2024 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725457773; cv=none; b=NqDjSXUOZPs9uwhWxKUULjtxniqTBAD/Wd1l0rLSEcWG2DIJBY9rXX7YfwoTrz4ZAoRfSoRopx0qq9u1KrO+NWZXY4nMQpKmkjP6uu0rO2vQQUfvAuSSEPMw+5KUPei9UgDlllMkrj4pEUai/nNhx3MFnXgeqtp15ESEuXB8G3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725457773; c=relaxed/simple;
	bh=YMNwSkqEJW9uN7bSMftt+qatI3avzVnQiPt2E71884o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5pobLAWLA6Twbpuc9mapDzJddcpTeTFCykcOSY6OPfkuzktjQz4BXQPAZKmg6jd1cmigpP/2eqBgq/khE7wI4M1HUDe0vkIaZDzM9HlG20o1E+wfHrwK7qACFUhd2TIRfYXbgnvVyLrvXpbUNvBHFq9IGk9wqejfewxDrPKA70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WJ6w3pf6; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WJ6w3pf6"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso254715939f.3
        for <linux-block@vger.kernel.org>; Wed, 04 Sep 2024 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725457769; x=1726062569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=WJ6w3pf6W8VidYgqQ953quYRg0VvCiE/ixf2+h67LNBe0Ot2QZI/1TgIWEIJ4piM2L
         mfAC+w2YRvJxKtWaUvHxFtdH1exmdayQHPsu5+HTCuyEaQYBqjivjB6f8QQ05MhrGJQm
         YnfAPjq5TXMjHxdJzV18/htxDuRx9G0rub9qjtF04EhhlaHo4K3g2738KVAmsUkzx+Dc
         fOMNDL2JuS9hy8TiC3ZjzvZrOP7eE8hX4nbeRD5heka621SuN6zS3n17829WSLW0v+oe
         rka55tlb9pWROWbOIqUp4jIRaWRdePL7ItHL9ns0TPwYva/ilmVJWjQuKezxP7K41NX2
         DQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725457769; x=1726062569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3OzM6yNBga43RZi596yJbd4sFGmjuH68EJYXdCc694=;
        b=e+aW8xe3OPWBDsKKXBlTl/X0g9riwIxfBzEVQndvK2GyjPZJ0+EVphTt7IcM3041y8
         c6jGWr2YzT4AMwXdc8bcDT8Sx7QPcnc8JfMf4hqBJMF0ZZHnghM0KLdXYMlJJ+Shieps
         Cgv3fg9ac7ogC6cv8ak+Ni0dFlOuEIujUr4OOQohefcmdc96O0avHbiIdJjSBeHWqrgi
         9Q1a3ClZp/WQFeOeEKDUSbxJ3cwIiLX1tg2YuafyQqMn96VR44LDs+2tdS3alkFxHYSW
         hsNWcdCPwV3zfy3gPdE4FfYWozZ6Q5Aebqxt2P9I7Hj0A0Ht/hP9jnw25Gzdmnvnbcjx
         Xzyw==
X-Forwarded-Encrypted: i=1; AJvYcCV63Zn32tdkFlFXW67fChJzvcIiV1aAma10kmCh1qH4rnI23w9usQXXgrKQP2+OHRDzWwq/Anx1u/JdqA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2v9BMYWCdlIQisrmdoLvUGFMqiDcOpkzsilbmVwdizbo4Y3RN
	pIg+YYs4+VBnBXMrPSQWjeiVw+RJQFwUjLfMzNOOpqUpvhx5KEl5ZrRRWVpYKFE=
X-Google-Smtp-Source: AGHT+IH2T9+Rvn5lvq34B/1/vEVjOaoiI5vLsNmFeQ2xw9WWhAETa9+lwOKBoTbedzjte9E4G4daJg==
X-Received: by 2002:a05:6e02:180e:b0:39b:3a44:fe8a with SMTP id e9e14a558f8ab-39f6a97897fmr86244235ab.4.1725457769293;
        Wed, 04 Sep 2024 06:49:29 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d05da81bc9sm351855173.104.2024.09.04.06.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 06:49:28 -0700 (PDT)
Message-ID: <c7d9d97b-991c-4b84-a99a-60473f8ce929@kernel.dk>
Date: Wed, 4 Sep 2024 07:49:27 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-6.12 0/4] block, bfq: fix corner cases related to bfqq
 merging
To: Jan Kara <jack@suse.cz>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, paolo.valente@unimore.it,
 mauro.andreolini@unimore.it, avanzini.arianna@gmail.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20240902130329.3787024-1-yukuai1@huaweicloud.com>
 <2ee05037-fb4f-4697-958b-46f0ae7d9cdd@kernel.dk>
 <c2a6d239-aa96-f767-9767-9e9ea929b014@huaweicloud.com>
 <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240904122953.fkwyfsfwhrwwmnbs@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/24 6:29 AM, Jan Kara wrote:
> On Wed 04-09-24 09:32:26, Yu Kuai wrote:
>> ? 2024/09/03 23:51, Jens Axboe ??:
>>> On 9/2/24 7:03 AM, Yu Kuai wrote:
>>>> From: Yu Kuai <yukuai3@huawei.com>
>>>>
>>>> Our syzkaller report a UAF problem(details in patch 1), however it can't
>>>> be reporduced. And this set are some corner cases fix that might be
>>>> related, and they are found by code review.
>>>>
>>>> Yu Kuai (4):
>>>>    block, bfq: fix possible UAF for bfqq->bic with merge chain
>>>>    block, bfq: choose the last bfqq from merge chain in
>>>>      bfq_setup_cooperator()
>>>>    block, bfq: don't break merge chain in bfq_split_bfqq()
>>>>    block, bfq: use bfq_reassign_last_bfqq() in bfq_bfqq_move()
>>>>
>>>>   block/bfq-cgroup.c  |  7 +------
>>>>   block/bfq-iosched.c | 17 +++++++++++------
>>>>   block/bfq-iosched.h |  2 ++
>>>>   3 files changed, 14 insertions(+), 12 deletions(-)
>>>
>>> BFQ is effectively unmaintained, and has been for quite a while at
>>> this point. I'll apply these, thanks for looking into it, but I think we
>>> should move BFQ to an unmaintained state at this point.
>>
>> Sorry to hear that, we would be willing to take on the responsibility of
>> maintaining this code, please let me know if there are any specific
>> guidelines or processes we should follow. We do have customers are using
>> bfq in downstream kernels, and we are still running lots of test for
>> bfq.
> 
> That would be awesome. I don't think there's much of a process to follow
> given there's not much happening in BFQ. You can add yourself to
> MAINTAINERS file under "BFQ I/O SCHEDULER" entry and then do your best to
> keep BFQ alive by fixing bugs and responding to reports :) I'm not sure if
> Jens would prefer you'd create your git tree from which he will pull or
> whether merging patches is fine - he has to decide.

The usual process is that you start actually maintaining it, and after a
bit of a track record has been proven, then add the maintainers entry.
Too many times people start by adding a maintainers entry and then don't
really do anything. Not saying that'd necessarily be the case here, but
maintaining first and then adding an entry down the line seems like the
better approach.

I prefer people sending patches, as there's less risk there for messing
it up. Maintaining a git tree may seem easy, but lots of people end up
messing it up, particularly as a new maintainer.

-- 
Jens Axboe

