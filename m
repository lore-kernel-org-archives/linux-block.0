Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE772657B3
	for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706536935; cv=none; b=mlqyCkxSF/ydQ5bhl5pT7H+gi8Q/jzzP1RG1QHtTsPp8llXe58OQeoIEfcBglyORAUWLRjWt794zMfRv45KiX5eslB73bDmBPgwYRtUM06Ti2LbjF3UOgxAAdirSg9YfqTIckKzNpcF6vzhoGS12v8PMNp3fYg9m7o9WU2le79I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706536935; c=relaxed/simple;
	bh=C7FE8e5ozjHtbhqoIxgDVbRkYxlr4MDb7tmKMTA79E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PwsCXXIykcM9VGBmtLNOOYvR82eYwhzgggXLvmHRoLmQzXoQ4onlAfyM8+biOP0MvQghZp1I/Eths4P6ew3wA5HfyOw4KoQfjhuOo4B4hYIJWZnFhG+XTiLQHlFUJ3DlgAnMYWo5SOkUKFV89d4B654dYR28AfwTMz7AmurwGWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Hqp5puvy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Hqp5puvy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1d722740622so5517565ad.0
        for <linux-block@vger.kernel.org>; Mon, 29 Jan 2024 06:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706536932; x=1707141732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5OvI/vtJ7Gu4DNDpcEZjkOEK0ci3i770elMXPHcH2do=;
        b=Hqp5puvycMxpC4i0gkQxwum3RPLwtMe1r1CDN0wTwv1/IbCCfzAeC4cy9/AN74Tk7v
         mZldnJkciBBgj/9w1bARTvp0FDQFZ5DZLTIWwachAePSrTtenNqDX0Hi8JPMMZ0jK2XC
         Th5dn/ZbheOPD0MPWBRiSaDMZZjkDgSlEW03HkvNBC0vcotDibXk2QIJXwEvDZ6g/k5/
         9qysUrQZlxk0V76H3OOv34sAcjZJuQs8o4Jj/dgd2Bi8Iv+2uoXCRakau77rvGh3LzPF
         T1E9NwK4EjGnj6zEvQzr/IBJbEyZcKjuZTeBjzo7ufxBuuZsxrXn/ErB7hv7k2PH2QDj
         V9Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706536932; x=1707141732;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5OvI/vtJ7Gu4DNDpcEZjkOEK0ci3i770elMXPHcH2do=;
        b=VOzFXmzvUQQlRi5kmKbbFw10xMiFHwdsGSvEU8CXltbbAV0DD1IGeYo+w9nKOlawT3
         tOjaqUjZ+tmqFhFUJ29UekFk4Nqg0TBrAomvwAlX1YqcAY1onHV5OXDKbIcxlKmwjefS
         oi8LzQxdM444KemW47YgDzPZF0n+n9lj+xUs0s8hYAvM9+w8osO3+WNgN8tU+cNxNPv2
         RgCIePFAjFvg6cHfm78s2KGuhVIYCFBizEZADIavb07NyAVoN3wdJzBnk0f17g7sO3so
         PnizOH4RMCDUZs2MJQcKTSXbEzbfcFJOVy17FZTAkMagqHOUE/BXj29N9Sf8dTLloNNC
         Sx5Q==
X-Gm-Message-State: AOJu0YySYu/W7zsZgNvR/FpNjHygqP2hS8pYztpOJGjBD6KRF9QLGolM
	HvdpN7ujpKGQ9Apmi8odKibvBO4AnpmbONxMBmVQryfu1v6mOzwLBINWyQ9htqFrfvUyYBZSmPq
	MNz0=
X-Google-Smtp-Source: AGHT+IH19rbjQyINdyYGdboqVlc7s2qA2AY+21ML0xbxRKwng2e/bPSkSO5BEA2l4M7YYBx1ma6WdQ==
X-Received: by 2002:a17:902:ea09:b0:1d8:eac8:5e00 with SMTP id s9-20020a170902ea0900b001d8eac85e00mr2158632plg.4.1706536931862;
        Mon, 29 Jan 2024 06:02:11 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id x5-20020a1709029a4500b001d5d736d1b2sm5354692plv.261.2024.01.29.06.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 06:02:11 -0800 (PST)
Message-ID: <1b0c9f7f-9b1b-484b-a9fb-bf2c42d9a18d@kernel.dk>
Date: Mon, 29 Jan 2024 07:02:10 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] block: update cached timestamp post
 schedule/preemption
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20240126213827.2757115-1-axboe@kernel.dk>
 <20240126213827.2757115-5-axboe@kernel.dk>
 <9e13afd4-d073-4822-92ff-936788f0c2a1@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <9e13afd4-d073-4822-92ff-936788f0c2a1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/29/24 1:01 AM, Johannes Thumshirn wrote:
> On 26.01.24 22:39, Jens Axboe wrote:
>>   static void sched_update_worker(struct task_struct *tsk)
>>   {
>> -	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
>> +	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER | PF_BLOCK_TS)) {
>> +		if (tsk->flags & PF_BLOCK_TS)
>> +			blk_plug_invalidate_ts(tsk);
>>   		if (tsk->flags & PF_WQ_WORKER)
>>   			wq_worker_running(tsk);
>> -		else
>> +		else if (tsk->flags & PF_IO_WORKER)
>>   			io_wq_worker_running(tsk);
>>   	}
>>   }
> 
> 
> Why the nested if? Isn't that more readable:

It's so that we can keep it at a single branch for the fast case of none
of them being true, which is also how it was done before this change.
This one just adds one more flag to check. With your change, it's 3
branches instead of one for the fast case.

-- 
Jens Axboe

