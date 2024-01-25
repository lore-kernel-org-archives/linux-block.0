Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7B17316D
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 15:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197610; cv=none; b=YMkebRyl6/VH/Ek+DtrofbDqHxOKZO1QLJo0thLnIkNhxwEUFCH4LsqmgzMpjJKotb851N1YIF6PAQW4eP1BYyRfgkbZW/7m9ENU77lYdgF3s1PX2U0kiXpRi0UNNbJpCjfeu7h7tseHLfx6VfNpxClNHU3wwl5/rk+Knr029sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197610; c=relaxed/simple;
	bh=yyoCTs/RpFJ6A18MuZB/WbDu8tqbZTOvPEZq1QHsXYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCXdaM1i9JHOwSrYWHPHCIZ59FgZSdEngXLozf4nxFvRex73wRcF6OGP7mZArd/dsdiqogquWw8gIFvgnsjQEDIMh1Hkg4z83kh03nBi1eZCzgwekulVmgg+3sq5lJ8FRVpKuCCOhSnXmG5EJ1ZZSN9Hc5Wk6GKfNeLJ/n5/vA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mF+gNEdi; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mF+gNEdi"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7bee9f626caso93977539f.0
        for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 07:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706197608; x=1706802408; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7hA0LbMdK90W0AjGVqfPzdQ7ttpPv7ssTuc6SmKrFw=;
        b=mF+gNEdiT32ypM9xbxcHT+PcWsm9xEWTUIbC5g02QTHqag1GtwEAXXYB/SJDXwSWGx
         c+y8y6VIPvNHTHNiNjzUd4z1TDLnBNDXUZ540AJWTbao6phVjpHBTV/CDcuZEZ0rl6pH
         y9O0Uvpt7CT+d0Rk0jNRB5jA5Xj7pd0aTP9WwUxxwU3rSg19Ew03Ws58g7kT88/DnsNq
         LZABDG258q6Ih8Trx1IrbxXEV/xiFOMwGKo8Mor8Z67YKy+2Z3KoEtRbkp/lzyWC1NwD
         +o+7KmfMCRDLIvJs4AIZIRIaRtAC+ljtjlfitMhAo2/WYOulJaJZ3nEkjNn6ujppaffa
         K0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197608; x=1706802408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7hA0LbMdK90W0AjGVqfPzdQ7ttpPv7ssTuc6SmKrFw=;
        b=eFwxkwx5cw0De+/7231vXRl7Kzqs49uHk0zL3skwLyWKiF1D9nakGAVGgUJi7PfpKh
         3KPlqjl2QL6rM8ZX+1g6YVLdNEQGrBbgg64Xjo5S5UoVE3JSIuNSPTU/X9bKhA7juVcv
         To+gY26c3ALGlDYrPQFc8Qe8+B223nJMitoC9hoAxpCjM/iiNtvb3u3I+91qulqPXqMU
         MT9RMiZWXa2jTfa2WcOmMT5GOc45jj3dnC6k0A5cjFfdhGie90WLXHC+KzeFnpbWQD5n
         a7aFNXKj+2mwI0cRyY3PjYfICxaQtvi5aheFwd7hW4u8lqEm4uDaejo/bSIICfhLeQj2
         klpA==
X-Gm-Message-State: AOJu0Yz8HXjORkVGK5WEnVndQWTGEEpdXmqWcAeLxPPnzD5nDluQveTp
	tECGkW59csaEwmQ9HFsV09hF+Vi1EMABtM6UyMVYyGTvDBRnO0VYJHeLfvxN/+eN9dU2SshvnMo
	sloA=
X-Google-Smtp-Source: AGHT+IFHmefAuXkwPR7TLRlcEvTsApZdON0Pz9hfoBtCwVdwioo7oLPBdLWfhSCFv+NNBGyNa4Na5w==
X-Received: by 2002:a5e:9205:0:b0:7bc:207d:5178 with SMTP id y5-20020a5e9205000000b007bc207d5178mr2368631iop.2.1706197605959;
        Thu, 25 Jan 2024 07:46:45 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id eq20-20020a0566384e3400b0046ee630f7e6sm2165647jab.68.2024.01.25.07.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:46:45 -0800 (PST)
Message-ID: <e3c4bafa-e43a-4f98-b848-1c139dc2c900@kernel.dk>
Date: Thu, 25 Jan 2024 08:46:44 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next] null_blk: add configfs variable shared_tags
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240116033927.628524-1-shinichiro.kawasaki@wdc.com>
 <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <481f2f1f-ee5d-4278-a856-1f0d01ef3b4c@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 9:13 PM, Chaitanya Kulkarni wrote:
> On 1/15/24 19:39, Shin'ichiro Kawasaki wrote:
>> Allow setting shared_tags through configfs, which could only be set as a
>> module parameter. For that purpose, delay tag_set initialization from
>> null_init() to null_add_dev(). Introduce the flag tag_set_initialized to
>> manage the initialization status of tag_set.
>>
>> The following parameters can not be set through configfs yet:
>>
>>      timeout
>>      requeue
>>      init_hctx
>>
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> ---
>> This patch will allow running the blktests test cases block/010 and block/022
>> using the built-in null_blk driver. Corresponding blktests side changes are
>> drafted here [1].
>>
>> [1] https://github.com/kawasaki/blktests/tree/shared_tags
>>
>>   drivers/block/null_blk/main.c     | 38 ++++++++++++++++---------------
>>   drivers/block/null_blk/null_blk.h |  1 +
>>   2 files changed, 21 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 36755f263e8e..c3361e521564 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -69,6 +69,7 @@ static LIST_HEAD(nullb_list);
>>   static struct mutex lock;
>>   static int null_major;
>>   static DEFINE_IDA(nullb_indexes);
>> +static bool tag_set_initialized = false;
> 
> explicit initializing global bool to false really needed ?
> unless I did something see [1].
> 
> -ck
> 
> nvme (nvme-6.8) # insmod drivers/block/null_blk/null_blk.ko
> nvme (nvme-6.8) # dmesg  -c
> [23228.355423] null_blk: null_init 2285 abcd 0 abcd_init 0
> [23228.357571] null_blk: disk nullb0 created
> [23228.357574] null_blk: module loaded

Just as a heads-up, a single test is not proof of anything. That said,
static variables are cleared, so they never need to be setup to false.

-- 
Jens Axboe

