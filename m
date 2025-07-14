Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731581F19A;
	Mon, 14 Jul 2025 05:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752469246; cv=none; b=Vbzw17cpsn3e1hDSyk22eLL60JlqzcJqs3krhFGonfvqApAwN8+ZjRCTDfIY+tmypaQMD69jr0rRjn2DF1Qrgq7f0BB5RcpQsZOLZHxYAT6GuapMKhmTEr3ulqFOrcb1pw3GygboLB9WtpaU96s0aLz1AFhx6r3fky7O/LXBYCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752469246; c=relaxed/simple;
	bh=8rlJcXzD2vMtvBDkRlcIRYWNrx6ZKB9MmYwHM1NpCXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iJweNd6l/GKsBN3zc9wOoTjga4ZT2FxU69Ilz/iddrsW+PIBjb1VRuuR5MaWCZ+vVwQA2FQKyuAQbrwSFA1r6wmd23ag5tjQUzt60qSH9IR97J3t6ETZCFHkYhZDYAv8CuJwBvIFpEi02G2kLA74XSQHPdYv1ch8AZJAOJyuw4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpK8vbFv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpK8vbFv"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-313910f392dso3272058a91.2;
        Sun, 13 Jul 2025 22:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752469245; x=1753074045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I4pDAHgPPftsl1IcIBceoWgKfpzUCBMxMdwFQ+U7ZZI=;
        b=DpK8vbFviC8tdRUp5fB0RgK3cT/f1LgZnRXEXThIC7fUjJ//iMtVhrVEsOiW1ToWpR
         W7CB8NtTXeTFuYbxiV3+ZUK1dVezWJjmFO6s5eKsDdo+LP3OdqH8Z83gjsPsYmqrKo2s
         jqfFq1geYwvOAJnN4/Rgeg6799OesisRjhogqx4k5Mr7ToW44XCFSGeh4vbhUpV+bBjA
         tPSn0r9VVLp+sCwysvp+oRJOvDYbcFyD8STePXd9JOw0Rsf2bDr4tXvasMsFuk1dSiLC
         ApG8WOYt0cLVybVUwYtDbGYQAecRnh2d8l2qNZ0K9DTlcODf8bjH6Pvp17+NAEezvbH5
         1TQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752469245; x=1753074045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I4pDAHgPPftsl1IcIBceoWgKfpzUCBMxMdwFQ+U7ZZI=;
        b=jJyZgvsH52Rk89kLz2bzcDldfELofg68sdyDQMG61ZUmaF1HDA3rXjEi7w0Lp6qnG6
         Y0HorhEM6V0QCZyS+Spl2o+uawxCL88h3aOvobvoF0oavlYhJnD/1Ce5ofShVqGl6jfk
         E9IS2mYH3nRSbU/hmbDU2ohA9/BS6roB5qYIP+C5hbQcNMXuCiIm0LcGDG/x7pf6XTC2
         cvDa7bKaZnls38IqKzBgn5RIQw/AAQMYKOK+c1TEaq4Zy6jJpLrXwtImezJfAlOBQ6ew
         WhpmvcEmOUPhgNf0GK1oXdKNyaBJ/daMpnYqd4ADf7ijeB3PvIQqdoAtvkBr1IRmyAVf
         0iTA==
X-Forwarded-Encrypted: i=1; AJvYcCXdaOZLK1tFebgLo5GELxTWHMj0BHynQKfP1BnO0JmrSX+64HV8MLwSkmLTc5QU9H+HW/Z+U8EJml6pWuE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4EXZdcvZg1hpkfuAUzriflgJ39eOe6A1F/JjszeCeflQayQe
	YBJKD0b2HPm1QVOfjLWmErxgSrK8Ddrjw3RRM0ieBET823lVWJnsPI4P
X-Gm-Gg: ASbGncv9XgWmMJhkLzTvBT21lCIxlBBdNaZJAHgqwHrgzlpDTAzkkYHkkiBuX+4Gzek
	cs+u3cQ62Y96kgcO+vRGtlU5uw9TNu9WUIr6iYjfh9hhTIynEMnuTN3rP8c0FzZBFAseRpv+mOz
	UeeSvf4gCqv0eclNSPQYL4y5q5KXLX9Nu+5mn67WaxZ16UNQXupsjUWpnqTgC5v3mt2krUcALk0
	hcqGUds8wnHEcrZaVcmEKjCfgbLaeahP21pzjFlk42/zu7Nn0T9AjE8mJoZYrpmoGFrWA+bUHub
	sOC+mnQQdYSkSzsryfL6yKbMcjhygO2a7bYtKhFdrWn85jtJLfSafslOpGFjLqWOLCsSEWN655y
	qlgkP77qeM4NPmiyksV51Kklk6XtdA24I6BG6zoZTmDvC4/vRvEJp1GJEL3MACKvNc2NvX0Aj58
	SybQ==
X-Google-Smtp-Source: AGHT+IGdsUO44y4ti5A3PNETw96c82v2mEYMqGNIB11nTYNYDyVP3CPnxzGVggPHV3BpCMAEyapD4w==
X-Received: by 2002:a17:90b:514d:b0:31c:203f:cacd with SMTP id 98e67ed59e1d1-31c4f53f721mr15386728a91.22.1752469244354;
        Sun, 13 Jul 2025 22:00:44 -0700 (PDT)
Received: from ?IPV6:2409:4090:20a4:5c0c:45b1:8db9:582c:7df4? ([2409:4090:20a4:5c0c:45b1:8db9:582c:7df4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3eb7f4d7sm10028051a91.46.2025.07.13.22.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 22:00:43 -0700 (PDT)
Message-ID: <8e854701-16cd-48a8-83ac-29c256d7deb5@gmail.com>
Date: Mon, 14 Jul 2025 10:30:38 +0530
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: floppy: Fix uninitialized use of outparam
To: efremov@linux.com, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250713070020.14530-1-purvayeshi550@gmail.com>
 <3625db90-8b5c-407f-bf8b-6c5919fec2ec@linux.com>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <3625db90-8b5c-407f-bf8b-6c5919fec2ec@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/07/25 14:17, Denis Efremov wrote:
> 
> 
> On 13/07/2025 11:00, Purva Yeshi wrote:
>> Fix Smatch-detected error:
>> drivers/block/floppy.c:3569 fd_locked_ioctl() error:
>> uninitialized symbol 'outparam'.
>>
>> Smatch may incorrectly warn about uninitialized use of 'outparam'
>> in fd_locked_ioctl(), even though all _IOC_READ commands guarantee
>> its initialization. Initialize outparam to NULL to make this explicit
>> and suppress the false positive.
>>
>> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
>> ---
>> V1 - https://lore.kernel.org/all/7dd94691-0b37-4855-be43-661f954275c8@gmail.com/T/#t
>> V2 - Initialize outparam to NULL to suppress Smatch false positive.
>>
>>   drivers/block/floppy.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>> index e97432032f01..24be0c2c4075 100644
>> --- a/drivers/block/floppy.c
>> +++ b/drivers/block/floppy.c
>> @@ -3411,7 +3411,7 @@ static int fd_locked_ioctl(struct block_device *bdev, blk_mode_t mode,
>>   		struct floppy_max_errors max_errors;
>>   		struct floppy_drive_params dp;
>>   	} inparam;		/* parameters coming from user space */
>> -	const void *outparam;	/* parameters passed back to user space */
>> +	const void *outparam = NULL;	/* parameters passed back to user space */
>>   
>>   	/* convert compatibility eject ioctls into floppy eject ioctl.
>>   	 * We do this in order to provide a means to eject floppy disks before
> 
> Reviewed-by: Denis Efremov <efremov@linux.com>
> 
> Denis

Hi,

Thank you for the review and for adding your Reviewed-by tag.
