Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6585E148850
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734465250; cv=none; b=YHE4E3ie4/ZY4jy9aYUvOAQ0swE5l6X3I6I0wiV1yuBDLouPPcyvAFvfULERQLeTOxMUPEUHZd3PDw2oP2tFWYGmChLyhkc52gV++jFmv0adW6Ul+c4YYoUSP8M5/PI59usgEgE5UJ4bbey5qsY3helmyIVl2tt/WoliMbmcSQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734465250; c=relaxed/simple;
	bh=vMTa5+jGV0JVXWX09IJE+JjobNEbCIpEcS+VrrdUlAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUvTAYc5vT+Mw3jUDovBxU8y1UrQFIDPqvpXWSUpvsx2x1cBA2EmY+QYsc/tFiluhVUDQ54i2+8PkjUBxq6Tad9uOlw+okkq98OehZ6p0P4IKrm6Cxba+y4Q1RcHAMsM8mzQfmVWg5w3sslVJDv3en+0LwucdBZfAQuJd2tkxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=b8ZccOyi; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="b8ZccOyi"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a817ee9936so19972495ab.2
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734465246; x=1735070046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oyifk5tjkmf9aKwHSxll/tA2YWs3zT03FY2kaEC4gO8=;
        b=b8ZccOyi2ZUoS4Aa7hyC/LCZ5dU41PkrMJsDY6LAmGA0GLXustEIE1sxt1k4JhuXqZ
         1/IWar/ims2KUd8voqOqxguGuqyJug7j2PACDGneGV5rGn+ickUzfhs2RHDKqn78ZU8y
         aOqbg4puVTZg5fdBbSarHLcWSaGuGAMcvXAFVGZHKoWTSkk3N9diI4UuWat5CVvqcPUu
         zOj2lUK7wvvEiqWOm9/v5XJOaAQjuMcBFuS/CNBS9T/Q6TI2G23gZTHRyhL98KmwmNl1
         6MeD6kl6VBT39rzWfi3iFV8Nx6kJJ2B7sG3X0EFGzgON5A+MrD1UDSoasNWzDltezk9E
         r4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734465246; x=1735070046;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oyifk5tjkmf9aKwHSxll/tA2YWs3zT03FY2kaEC4gO8=;
        b=r47yn6zX0mJXOs27G7Sx+Ve23hWuDTb9G6YBOAOQkiFKQb7elE+X065BDohvuLTUQ0
         H05KOHifNfJo8c8EA2tXoxeTeUMTtnrj52U+abmLmQFAeducRDTIV1J9Xi1nmf66cdwm
         vv37/eL9yIheOnnDUIasTS8xglc9YdBRvnthecP5/ccoexnHfi/GbmoTdTetR4o7bS5F
         FwHdbmq4GQQcyOD0PesYtOOXuPQLoskrsjNYtKVrBVqcXyvvjtH3Irqjo4f1sEoalGM5
         sRvRXdBt+lqRS7YwvCHOe7sAnpmCqffjcGhj0zmcRkhtXuwLw4fIvIXGYTAMD4q0bcbR
         i33w==
X-Gm-Message-State: AOJu0YzJNibB9fF5LqK0uLUH7meysaPWU4h5QeUEDdhgNcHXT1NR01tT
	MuPwi/mP3bLa4SsGQBhhaogp8ZbN+5TcYZmrks+JylBtDqjbsbVFKq9ymljv1fc=
X-Gm-Gg: ASbGnctZwm2hRs1NL3mXNogGI4U7ONjudpjznEFs4VQCQkn4ELMF8wYl4zorkftLkbo
	Sd6+6T23LTiqs+MeuzpusJunYQauokLpG67+nOUgGJiz3Muk13oPxEx8BYQVI2X3dnggI3JgxGa
	oBkLAq/2QbWD073qf+wHYWzU/n1QJYn6DjyJAeGIYaytad7WqPxCeZ97YGyDrHqrrEB5UPfVAfg
	jG2BpTny0o8fF8Zb6ZPI/43qmr7pYxWUkw2rzUxUX95hUrvjyeD
X-Google-Smtp-Source: AGHT+IFPV3kCoIzTrw9/NLWp82IP4Q/f6klD7mMqSoovshseW8f/tvu/Fkqj5FHHcYkHpn84KwY6Vg==
X-Received: by 2002:a05:6e02:1fc9:b0:3a7:a29b:c181 with SMTP id e9e14a558f8ab-3bdc174e846mr2866145ab.13.1734465246546;
        Tue, 17 Dec 2024 11:54:06 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2475b010esm22724825ab.16.2024.12.17.11.54.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:54:05 -0800 (PST)
Message-ID: <e299e652-2904-417c-9f76-b7aec5fd066b@kernel.dk>
Date: Tue, 17 Dec 2024 12:54:05 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Zoned storage and BLK_STS_RESOURCE
To: Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche
 <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <e75812ec-9b91-42d0-9ca5-d4bae031e319@acm.org>
 <20241217041515.GA15100@lst.de>
 <b8af6e10-6a00-4553-9a8c-32d5d0301082@kernel.org>
 <bf847491-e18a-4685-8fa2-66e31c41f8e8@kernel.dk>
 <79a93f9d-12e1-4aed-8d6c-f475cdcd6aab@kernel.org>
 <96e900ed-4984-4fbe-a74d-06a15fd7f3f7@kernel.dk>
 <3eb6ba65-daf8-4d8f-a37f-61bea129b165@kernel.org>
 <63aae174-a478-48ea-8a74-ab348e21ab65@acm.org>
 <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
 <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
 <5fb36d77-44cc-4ad7-8d64-b819bc7ae42a@kernel.org>
 <eb61f282-0e23-428a-8e6a-77c24cfd0e83@kernel.dk>
 <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <f41ffec1-9d05-47ed-bb0e-2c66136298b6@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 12:48 PM, Damien Le Moal wrote:
> On 2024/12/17 11:41, Jens Axboe wrote:
>> On 12/17/24 12:37 PM, Damien Le Moal wrote:
>>> On 2024/12/17 11:33, Jens Axboe wrote:
>>>> On 12/17/24 12:28 PM, Damien Le Moal wrote:
>>>>> On 2024/12/17 11:25, Bart Van Assche wrote:
>>>>>> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>>>>>>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
>>>>>>
>>>>>> Please note that this e-mail thread started by discussing a testcase
>>>>>> with --numjobs=1.
>>>>>
>>>>> I missed that. Then io_uring should be fine and behave the same way as libaio.
>>>>> Since it seems to not be working, we may have a bug beyond the recently fixed
>>>>> REQ_NOWAIT handling I think. That needs to be looked at.
>>>>
>>>> Inflight collision, yes that's what I was getting at - there seems to be
>>>> another bug here, and misunderstandings on how io_uring works is causing
>>>> it to be ignored and/or not understood.
>>>
>>> OK. Will dig into this because I definitely do not fully understand where the
>>> issue is.
>>
>> As per earlier replies, it's either -EAGAIN being mishandled, OR it's
>> driving more IOs than the device supports. For the latter case, io_uring
>> will NOT block, but libaio will. This means that libaio will sit there
>> waiting on previous IO to complete, and then issue the next one.
>> io_uring will punt that IO to io-wq, and then all bets are off in terms
>> of ordering if you have multiple of these threads blocking on tags and
>> doing issues. The test case looks like it's freezing the queue, which
>> means you don't even need more than QD number of IOs inflight. When that
>> happens, guess what libaio does? That's right, it blocks waiting on the
>> queue, and io_uring will not block but rather punt those IOs to io-wq.
>> If you have QD=2, then you now have 2 threads doing IO submission, and
>> either of them could wake and submit before the other.
> 
> That sounds like a very good analysis :)
> 
>> Like Christoph alluded to in his first reply, driving more than 1
>> request inflight is going to be trouble, potentially.
> 
> Yes. I think the confusion is with which "inflight" we are talking
> about. Between the block layer and the device, zone write plugging
> prevents more than 1 write per zone, so things are OK (modulo
> bugs...). But between the application and the block layer, that is not
> well managed and as your analysis above shows, bad things can happen.
> I will look into it to see if we can do something sensible. If not, we
> should at least warn the user, or just outright fail using io_uring
> with zoned block devices to avoid bad surprises.

The only reason it happens to work is because libaio is broken, and just
blocks rather than be an actual async issue method. If the queue is
frozen or you run out of tags, you'll just sleep, and hence preserve
ordering. For anything that actually works the way it's supposed to, eg
don't block on submit, yes you can run into trouble with having multiple
IOs inflight. That seems like a no-brainer to me.

io_uring does support ordering writes - not because of zoning, but to
avoid buffered writes being spread over a bunch of threads and hence
just hammering the inode mutex rather than doing actual useful work. You
could potentially use that. Then all pending writes for that inode would
be ordered, even if punted to io-wq.

-- 
Jens Axboe
