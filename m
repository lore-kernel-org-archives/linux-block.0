Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581552010EE
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766446124; cv=none; b=BkEBwv48qx8gHRjQ8+YQiiIwYVe8FSv68wg2imR9oyK66C0p3FdzP/gn1DxWZ0Bd9r8pNbo9qa0xMg6+buzm+Zj8xDuziaxDsEMCnhCOFX1V03QzVB0ENDq0aTfr9LNzbcXYCSejLhWsqR8jLfg2nYBqg0HGqfpAlFWHaqhceY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766446124; c=relaxed/simple;
	bh=dvUmO57Lcf7jZ8Vxa8vGgo3LxPAdd0Jn82T9LvQzaQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw3cXvqwEs3OBoVtvHT3gxuOLWoIU88ZdCJYP3Fu2MzPEli4snh3o+UgtzDwV0jmB8en9OANPV8Pm4S3D2AeNlu39OITwuMVS5vg8f/qxu+VqpHSubA5SFADZHsT10EDZstGpfMCbh6+sCVNJGiNpeMkLojAPiQhV5hSbutNhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0aPp9JuN; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0aPp9JuN"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7c6e9538945so3722429a34.1
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 15:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1766446120; x=1767050920; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwR3w/RR/lGr849teG3c9+troT3fLKIh0jZYEUBPBsc=;
        b=0aPp9JuNbrEatHRRc8+eI260AH0cwCw09+HRojRNAq4W4pSnm2WOejipdLuWFX1hoY
         VW9oYWsVgb6tQTAcZZiCWTGWyf/uzT6zy7QT1tBEjVFdVF64lGypvjWkgvlkUNi0gWav
         IcYWTICfvdfwppHyzQjIA2nhchWpp0eaA/qKQnofSANkLEFhMkDgoNlhr1cC7CnsBJX6
         gDnzECHshLEzGg7dBQ7b124AWQY0zKdQEJbqDs4f2JKo2C7TWJT6PtGuGaNgo2ajQHGz
         a9gbfA0VJrrRz5BJw9n4upMBCA1K34MZn8tFV+bkrcaadQ3Ecp/yNVQtCRf+fItha4rJ
         ktGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766446120; x=1767050920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwR3w/RR/lGr849teG3c9+troT3fLKIh0jZYEUBPBsc=;
        b=dDC5/yFIhDXff9BD4dELXq1ylA7Q642AKMBckDBWHDlcYazBe81RZKhqU3ls0INb3R
         9iQWR+fwjBk8zaBd+XsVbF347BNgImcEQjhszy5SSTR3YZx/1jIE3lUN6zIMb5m1Q42C
         Y5CdaJcuWcFmunAhNprxKYikyB09vrsGW4S0JSR/in9tGSCtDlLvYQIWRnQ8QcF10fe1
         cDT7Qnh1iC9mJrV6dUGzI7tasrmJrl9q5tgaS+F8va1Q7e90LdJbRfCMNBl/JTGaQKjN
         Mg3xidTOhDLyAZ/4TsAA87d8PF/38T4K6XrPfibqscRLPi918AeqUOQ1RRfYGUTigwkT
         sklA==
X-Forwarded-Encrypted: i=1; AJvYcCV/QWnPvibV2IXCWX06HYDVLb3mHzP4jNGNeL21uU20Sg8NZTKoqD7KBbAkl0JWB0xuBzFPBdlpXJoS+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQazU9FmXDDVVmawALWkt/qI6W4USPW3KFgzY0GpAIsBdJQvF
	E/lLhHuax+ARp0SOaL9m4/wZVBQVK+i/WOCwdx96p9pOkYzdIecvatjuk2O+D5EwPaU=
X-Gm-Gg: AY/fxX5DI26eO3ZzIVAQGtTlh7NLboaKHVbXBMj9OBDIaxFWGTuH53K0qI63Ri/E1F7
	bDNkbslK0ZjjzqZEq0ADkxmx5cFvRaYJXilhBAxSZJDnV6kT5VhOLRof9wFpULeJdNUVDDvi64t
	1kimLHHlg8mZht40ADGjVvubjdUTSQUC8BAQh1JWbZqYXBBb8EVJdx2omegKJ5EkZmOB9ZJVjiZ
	mjpVUbuFh5sT2MERSNMJ9cfIxUCFk3vy5tcIceKLJx6gBhqOiUk7bxJMpD0yNirCjzYPm/X6r1N
	UnXuiTxczzokUXuC1jjVD9K2W6z7hVLO+bJd6ZZzQgewMFM4j6LEOZgjZXNWKBmLr4nx7LBEG4z
	U0FGlNDLsFpMbHoCfDJAPqNmarUf/tzX7Q2aO6kUV39iaBlYVtF4Jm8nbJ/2/n0oZ3GbVAr7/At
	9E7h88tEp3
X-Google-Smtp-Source: AGHT+IFS01bXT56Z2OAk13kViNpsWDgv/4WNaLGbtDffXOBP0P2+4pO2HSv0W7Hs328eTguWCmzD5w==
X-Received: by 2002:a05:6830:2549:b0:7c7:1a6:6a09 with SMTP id 46e09a7af769-7cc65e959e5mr6943413a34.17.1766446120180;
        Mon, 22 Dec 2025 15:28:40 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667ec281sm8038929a34.24.2025.12.22.15.28.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 15:28:39 -0800 (PST)
Message-ID: <03a59f8b-c139-43e0-94cb-80cee108f939@kernel.dk>
Date: Mon, 22 Dec 2025 16:28:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
To: Damien Le Moal <dlemoal@kernel.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, johannes.thumshirn@wdc.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 martin.petersen@oracle.com, linux-block@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20251028173209.2859-1-ckulkarnilinux@gmail.com>
 <bd88af0b-be00-4f1b-b089-6fce986e3cfe@kernel.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <bd88af0b-be00-4f1b-b089-6fce986e3cfe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/25 4:55 PM, Damien Le Moal wrote:
> On 10/29/25 02:32, Chaitanya Kulkarni wrote:
>> Add informational messages during blktrace setup when version 1 tools
>> are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
>> that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
>> blktrace tools version 2 or later.
>>
>> The warning is printed once during trace setup to inform users about
>> the limitation without spamming the logs during tracing operations.
>> Version 2 blktrace tools properly handle zone management operations
>> (zone reset, zone open, zone close, zone finish, zone append) that
>> were added for zoned block devices.
>>
>> Example output:
>>
>> blktests (master) # ./check blktrace
>> blktrace/001 (blktrace zone management command tracing)      [passed]
>>     runtime  0.110s  ...  3.917s
>> blktrace/002 (blktrace ftrace corruption with sysfs trace)   [passed]
>>     runtime  0.333s  ...  0.608s
>> blktests (master) # dmesg -c
>> [   57.610592] blktrace: nullb0: blktrace events for REQ_OP_ZONE_XXX will be dropped
>> [   57.610603] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
>>
>> This helps users understand why zone operation traces may be missing
>> when using older blktrace tool versions with modern kernels that
>> support REQ_OP_ZONE_XXX in blktrace.
>>
>> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
>> ---
>> v1->v2 :-
>>
>> Remove the extra () around IS_ENABLED(CONFIG_BLK_DEV_ZONED). (Jens)
>> Add a space after device name in first pr_info(). (Jens)
>>
>> ---
>>  kernel/trace/blktrace.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
>> index e4f26ddb7ee2..4a37d9aa0481 100644
>> --- a/kernel/trace/blktrace.c
>> +++ b/kernel/trace/blktrace.c
>> @@ -739,6 +739,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
>>  	 */
>>  	strreplace(buts->name, '/', '_');
>>  
>> +	if (version == 1 && IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
>> +		pr_info("%s: blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
>> +				name);
>> +		pr_info("use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX\n");
> 
> Please change REQ_OP_ZONE_XXX to "zone operations" in these messages. That is a
> little more general, so better I think since we also trace zone write
> plug/unplug events, which are not REQ_OP_ZONE_XXX.

Agree, REQ_OP_ZONE_XXX means nothing in userspace.

-- 
Jens Axboe

