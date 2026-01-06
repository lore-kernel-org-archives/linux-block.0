Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B032720D
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 12:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702684; cv=none; b=lc2n/3/UHaFMf9M64puFSoI7sVAvecoRyvqbn8ifW++K5ckv8zI2stOgmD1Su8HklE1hbUDRMbJQgap86QcnOylwQUi7JevnP9DXj3AH8oP6z5vcDl86xa7RtevWR69aD0q7ijqdgUD428LF1f8Di6IH2i6X9nji/9pOX+l3SAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702684; c=relaxed/simple;
	bh=qD8hj/e6z16uKWh1w4gLB+YgxeA8Uk3YdEu2DzlXjDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJuWJ4uDRpg33xzeWyupkciOkSNG5fKrvJJJWg9qnxENPhgy/xvua7W+txJ/rfu1vvwoYTd25S5eqNpIRHbfbMDzpGAhkT8TNatxQ8g9/gLheJakKjKFWEj2aOBfyg93kq4cyAwX7EcqUsMaaD4pe7dJLSkiDsIIwoAdikZ8dqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cQG+P09h; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cQG+P09h"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cdd651c884so575908a34.1
        for <linux-block@vger.kernel.org>; Tue, 06 Jan 2026 04:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767702681; x=1768307481; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n9rhcERV84OCmGmDX1M4WvV3XbLq3vCBRVDBIovbxsA=;
        b=cQG+P09hjkoCprH/3DMRAubwgGtOdhFFyLn/2CT8i0IGoq2xL/yJBM1ekHjYCbZsiu
         6dzzT1ZBwO0s/KnqzS2EGh3zwnEUsnOPf0m3RgcyTxYgpILfk8NdTbpPI6Vp+8yMEJXZ
         QWbQvN25U8hMDWpDGxVkVwA8LzkGSvw1NcJ/iovXswN4KYnpuL6wYt9zr/Ksd6nQM9uD
         JMIhNFEOw70cFKW1TF0c7JAn8V+iSCIxKd/ttBnRUGHEVsBVAZ7PzGVqpVp8tlCllfg9
         K8+lKNOhC2SAUUTXK5EO+2gSVViovo0xcG858J/G1mpG9H69LZNmaNvSlZTnuM6Tcu1G
         3ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702681; x=1768307481;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9rhcERV84OCmGmDX1M4WvV3XbLq3vCBRVDBIovbxsA=;
        b=HD8Y/b7HoB499nMkEVDdZZWYuVlOEE03w+/r+NKQUEB/XS4uwkCOASMjEFEdHSaH4Y
         mm2AMz+wUtWaHwC5SAkjrqO2pZqrbRvl/b2kYFVBRYVhwuZEdvQvkCsDgt1Qxcx8/IG9
         t6Jx7zWr6q0DHb8thLr/nAVOfNY2lEAdau32yiNuPcZxtwyZlh5Ty9EnzVPzFe9yKRyR
         o/MN6FDWtYYkD1IQK5mfjtWFrzplzeeZTGkh7bFvBT+kPXJLawSqogvON866D5jczlfB
         yZ6WW/SXLhZa6jPTxowdNutUVFLsUmzKRFAuHfMWyQIDvs8gKlsyZaeKtWswASBZKHHy
         llAg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Seltubx4i/CLlMkCG9GuOV2W+Xby1LIX3TRHSBbui/nSz+ktBpUqWFzzXePqSQgr5sd5aDpMu1/W4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqDyeHzqTWyJ1G+m2QPl+qi0aHy02qzUNVBTjcCFMwA+yYkiZh
	AXJ7P7+zDwrTNgNq9a/Seeccx7PcAwru6MWtKE7OnHDKmfVG5w9zPPd53m5Wj5vxWmQ=
X-Gm-Gg: AY/fxX46OIxsVCBKIovPipmu9Z8LR4kKE+l+sNAsixxuHl4nRWYnofRbtiy7SlaFcO1
	IN7ai4vFlCV6Sk0AJ7ueBIziQQci66+oQm68H+pAHvOcGttkHs4ZPCDsDQoVMGMH4URoax7FH86
	8UWupPywI++YVo6cN7hFnS0z7Fea2OMTwlPyYQH/tI0YLew9UMlWYbc5Bglt4qu+0NkBWs7r6at
	Cjor+nXSqDWSiW/HanUIDMq/0KSGR10wE5zkVVMNkrSjuCX00aPNDI2GtIg787GAEsuItGCmR7I
	jOqT0lRPKqsgDc3tf0uuN6vZEcuaXxvJz4uv/wFcB7fbGutxgBmrlDOwNIeUbXBNA05tv3C4Uu0
	MsJVD5KXlKYI46aKGJrdTiM0gciMmSDHMQ+ZO4iHgkYyvUEuieGbSehbrHSg8Fgk+NgCS0W934B
	u4P4SQpwUX
X-Google-Smtp-Source: AGHT+IH5Yiil0wcxvs9oiN90uHex83YlxafWRtrKx9Wzl/T3/UdFMXwlQhRkTvju9BYVuVbHAMuVlw==
X-Received: by 2002:a05:6830:83a2:b0:7cd:f5dc:56ea with SMTP id 46e09a7af769-7ce46c33c90mr1505197a34.4.1767702681615;
        Tue, 06 Jan 2026 04:31:21 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce478af8besm1321261a34.14.2026.01.06.04.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jan 2026 04:31:20 -0800 (PST)
Message-ID: <9a687e88-7cf2-49ae-8b79-1b87a21c070f@kernel.dk>
Date: Tue, 6 Jan 2026 05:31:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] loop: don't change loop device under exclusive opener
 in loop_set_status
To: Jan Kara <jack@suse.cz>,
 Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Cc: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <2crvwmytxw5splvtauxdq6o3dt4rnnzuy22vcub45rjk354alr@6m66k3ucoics>
 <20251217190040.490204-2-rpthibeault@gmail.com>
 <f45muigy6nwxtbfbxidbqyru73qtntuqfby6lgnt32c6eyyov6@eg2mbf6pncq6>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f45muigy6nwxtbfbxidbqyru73qtntuqfby6lgnt32c6eyyov6@eg2mbf6pncq6>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 5:08 AM, Jan Kara wrote:
> On Wed 17-12-25 14:00:40, Raphael Pinsonneault-Thibeault wrote:
>> loop_set_status() is allowed to change the loop device while there
>> are other openers of the device, even exclusive ones.
>>
>> In this case, it causes a KASAN: slab-out-of-bounds Read in
>> ext4_search_dir(), since when looking for an entry in an inlined
>> directory, e_value_offs is changed underneath the filesystem by
>> loop_set_status().
>>
>> Fix the problem by forbidding loop_set_status() from modifying the loop
>> device while there are exclusive openers of the device. This is similar
>> to the fix in loop_configure() by commit 33ec3e53e7b1 ("loop: Don't
>> change loop device under exclusive opener") alongside commit ecbe6bc0003b
>> ("block: use bd_prepare_to_claim directly in the loop driver").
>>
>> Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
>> Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
>> Tested-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
>> Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
>> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> Jens, ping?

Now applied. Heads up in general, don't nest v2 or later inside the
original thread. It just makes emails get lost, as it appears part
of the original discussion.

-- 
Jens Axboe

