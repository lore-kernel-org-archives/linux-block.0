Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3501F893A
	for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734464036; cv=none; b=Bb5KBc1fBD+Dus6kgzX+dGD/DhOOmw0uDGwrjEmFjDTMZTrHjUvTSejJjn/4kbFtmZRZZlnFOdBMQLGa+Z1rc9zPMl7vgGjr9biYbUfSMToI4az5t4wDvxttc902TdjAqhCuuC/GKdTwDeaJDUbLeBdsOCyYKbMYLM72vx+7MCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734464036; c=relaxed/simple;
	bh=iJAX6y+ps+bw96nPuusFfaJ7L93JjEhnuuEc2QQ6Cqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehW0/SQmZKrpsoYVLL98B1Z5FVPxKmEPu/SDqH8stl7lwsVoS0h8CtZ78drVgnwTEXxTLyqbz2JeHQME4Z0QB7OWTCJfD/0JhJXrZiSLhhFDLaaqUiw0SvIwGsE00RyKSf2a1AgmjlOUwZDWLBOHPbU5xgFisMiTOyoHsN2wfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=cIJCm4Fn; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="cIJCm4Fn"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a9c9f2a569so42969055ab.0
        for <linux-block@vger.kernel.org>; Tue, 17 Dec 2024 11:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734464028; x=1735068828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9wkYAYVEw4kjd6muK0VCjOPrjxatN3DqlqYWYZmfkqA=;
        b=cIJCm4FnAV2EMXNBc9YCfvrVnCJQo29n1ZzufTdTv7D4hoeFGZrm2Vpaj5CQ4CmBh1
         OycVTvA4E6Sso/+mMLiJ2zzIQzmSO7o/F9AN0d6Lu5e2mLSDGkuRnlxBUrNTIy772q4K
         q9T3vPoPTf+lAcnr0RN6THSahc1eDi+qjXqEaBVqqq+AFbI/76xC3c5Qn9vzWwcbnR2Y
         SwQ9TqLCgt4Jj4CeWSa4M3SJKHYazHohtc5QldK33WqsvVvL7YVQfE7vZl2c4enpiqPE
         4cPtNEsw3jXNr4wXMmG8ZF9xvCkrPKp/xnAVJjqJDTbbblsXkPJ5cYNcreAraGyeH0rD
         /ZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734464028; x=1735068828;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9wkYAYVEw4kjd6muK0VCjOPrjxatN3DqlqYWYZmfkqA=;
        b=CtokjQxypTn1FyGQcnKhnsv8hodhwQQ+X9cqKykjlDu/Qk946Qfzh1+7QoIgxkVoTB
         M/T4V2brhqlL1f+EmcOdqMuQh/XM7mOE1ucEf2As2mdMrvi1aDQsxSNht2LRtAPbuOMe
         4aNsqXn9SpYNXbv9m3je8kUdyyBc+YN+2VWZhQ62EPQcI+ub6msWvqjbcpS7OjlNQvTJ
         dJy/Wm9W3/icf2yj7088CZLEdRAdmPFVUNbeNy2js9P1kMPhMDQLWNVfTycVxURN7CXO
         ngNepU8S8LisEn5tJf5CWnuhAHa/MZ8nI6erAvkqtUAvYzf1KxUPXSHO9YQoBnK+aAuc
         KFYw==
X-Gm-Message-State: AOJu0YxBEjixqRXCC1yLVhO5Xp7ycMnNbnOuRfqE43vPhIKBgjuj/rPW
	4L2u7kASLknlaDdG/v5tKCrI7NQNbwCSGEWbU88WJxjIjt4/m7YZocAJ++/CFLs=
X-Gm-Gg: ASbGncv0HF82rGX7/HxEPM6uxslucbZXAiBHwxbGWFzT0wIBsrVNMH9K9NpQnSTmnTj
	FB23diccIIcq9r3tEfEwY/yG0HBD7Lq0GZiftb14n7jjgD9BI+eFXx1E2OfEsEGRgoF8cH55Wgy
	deoH8iosvDWNO2aDx5Pw6husPOBLa7JeMzNYKAb4rPR98mAYmjGeJxxJp2mRX4PqMuhATKt+vLl
	hABNCxBnA1ZdbReP2nDy1ZPrsCLylrbMAdiSaju5FbbhB9ZDlor
X-Google-Smtp-Source: AGHT+IHkwNfeMrgiLkFFGZg458WHwHHgQ1S0SiZl2tciB7ES9dHeqqx0U2tVzZgseY7W6pHLXgA3lA==
X-Received: by 2002:a05:6e02:218e:b0:3a6:b783:3c06 with SMTP id e9e14a558f8ab-3bdc437ae8fmr2618085ab.19.1734464028715;
        Tue, 17 Dec 2024 11:33:48 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b2481340f5sm22535065ab.19.2024.12.17.11.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 11:33:48 -0800 (PST)
Message-ID: <548e98ee-b46e-476a-9d4a-05a60c78b068@kernel.dk>
Date: Tue, 17 Dec 2024 12:33:47 -0700
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
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <83bfb006-0a7d-4ce0-8a94-01590fb3bbbb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/17/24 12:28 PM, Damien Le Moal wrote:
> On 2024/12/17 11:25, Bart Van Assche wrote:
>> On 12/17/24 11:20 AM, Damien Le Moal wrote:
>>> For a simple fio "--zonemode=zbd --rw=randwrite --numjobs=X" for X > 1
>>
>> Please note that this e-mail thread started by discussing a testcase
>> with --numjobs=1.
> 
> I missed that. Then io_uring should be fine and behave the same way as libaio.
> Since it seems to not be working, we may have a bug beyond the recently fixed
> REQ_NOWAIT handling I think. That needs to be looked at.

Inflight collision, yes that's what I was getting at - there seems to be
another bug here, and misunderstandings on how io_uring works is causing
it to be ignored and/or not understood.

-- 
Jens Axboe

