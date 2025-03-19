Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0165920B808;
	Wed, 19 Mar 2025 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410488; cv=none; b=YRJEat/gdFEPmj9mvRF+5sHi2NVPLnAKcRe/oPuD9fyHM4bM/WE51fyxkSXARnjkc5m7BYdV4cdQHoAvIrF1L0LMC/bAT0BZXS3K3aP0STFSFY/G21zOQGJegr/PsqHfI6ldxleNAdhEiflDhT7MEoWAGWM+wfxmQ4IeuqHPP0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410488; c=relaxed/simple;
	bh=B0FCJ7Zkbt/So+72cIaSgUymVXf4MBJ+iTga2GM4ZQg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KceW1dHoFVM2oN3gbAWdr8veZ6mXv+PS0vXeBXuiZd0chGEAeBn2s/Z99M1CEGPzAzRmU25Q5S+XvuJsWNJAj8bngxCArvBwfmlyqqv5PqL6P37qg1cMoPmiUu/xxliDDMoRWWNJ8LFCkyimUkgyT4RaUyjF+gOJw9CsNGlusts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bzud6jv4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bzud6jv4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-abec8b750ebso5452966b.0;
        Wed, 19 Mar 2025 11:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742410485; x=1743015285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h7SA5z+d1gmTrKxq6Z/NWTwhJ4KshIax6c/w3v0Ejqg=;
        b=Bzud6jv4dR3KzWMqjHMUDfB+cZeqj9FDgFIHwsxdXQdAS7yRy5TDW5/yfebXfOHj6c
         NSPNfqMOQlgFuuUdFsQALvoEXK69q4x/wfCZXCfMc19b4LYjtni9YaT5q7NLIB1s0Hi7
         Tc/KFSh2Gd3T71BQz9DOytepIDUaOH+Gf/fSwQpObW/AtsUIdfpKXiri/VxX9fKvpFM0
         bsx1D8ZlbD+GHcmTqHnLY+8Mx69myfNVyyqN38RXrxtmi3t9Eodh/Iuoov7H8LmKfHov
         gvT1F39nhbQSNck/Lxd4rSxbkRIg8KOwBUwkQLrzy/zWP7TOZXpoVbKqxefxEx8cRkRx
         8V/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410485; x=1743015285;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7SA5z+d1gmTrKxq6Z/NWTwhJ4KshIax6c/w3v0Ejqg=;
        b=dCKt4VdW5fyZabGfRys2SNidpuFrp5XJuAKQqWN28eMmPTykahIFm4BPDWh3/G5i5N
         PqMUc+sNmTi4p93cNJFjZf9tRXI6dOJ9mKdezcpl6kQai/llsinwREKDeDp8UpHyu9hP
         NT/izKtrdh4fF0cYivTbD7tvSaeJv7Q/Q2ANe4lvIG/nJYqsJKyILMKHNhUWAXG1ot7+
         iHQW4HV9ZeKjvd24CrWR+SSJF+q3ur3zg5PMEMgn6hjaoexTVM0k+EpZgq16An2VVrhO
         IAma3eZet+AM334kpvKtlBqEmooewSTKfi0W9h8EIyYeQPBlXGv/0MYAHttP6Ig2B2h/
         f/WA==
X-Forwarded-Encrypted: i=1; AJvYcCWew/ZHyQOym15hUSxv5UlHmILIzZP01xjy5jVAa1f/ShnSvl+LGcujmZ2zz/SubYtwYJBlXT0fQ1L0Sg==@vger.kernel.org, AJvYcCXt8/3Zii0SF9ZCoXtSauEeE1sAwo6iacjXTiVje8dKmiANNToDxexFLSHhe4LHrc/ywcV87NE+@vger.kernel.org
X-Gm-Message-State: AOJu0Yyiowyz18eBEgtUFMF0FLVN/Wk/qxifzul7IGDIjTzUfm3PXxtE
	uAkjZ3/rscjBnMEVEExi6BopIQjaCcVaoZsy6dngwIXBHa5qtUkU
X-Gm-Gg: ASbGnctX0Qixs2B39rMBmO/5EGew6jxIZmihiP7p0y4ss8RBxTE3wpnrswHi+eKqXDy
	8VTuq5QIP0uXCGk0QjITGtAnobjKxWsUivQJOqmIcRchBfOSvphKFnWrQgLbzgC2YnghCBaUCr+
	NYsMGRBl24emRASgjsm7OGPjWhLZrSVsHDzpTc/r3RvM3XfMlhtcqLTTXAr1bZkpRx4gA+cfuWs
	XftwcVGQqZx8luoJeLxB1ZeYoeaXdPYTJjVwrW/wjneoXXtRkzIWxQmQLKpCAB+fmBLASjL15tn
	mJ69AgA/2KswaA2al3g41RRWlFibwlHs2iWLcxYlw2tmFXIIrFD9LacnFHhGvdXLC27Y3w==
X-Google-Smtp-Source: AGHT+IGkkf7oue+S7jXWJ4oNOyt7eHKO0uFR9zbkxHH3o3VlrtXlY+vhJdacujHSWn0whUtBjGjxTg==
X-Received: by 2002:a17:907:d1f:b0:ac2:9d15:2ec0 with SMTP id a640c23a62f3a-ac3b7dd75d7mr473548666b.27.1742410484988;
        Wed, 19 Mar 2025 11:54:44 -0700 (PDT)
Received: from [192.168.2.22] (85-70-151-113.rcd.o2.cz. [85.70.151.113])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9ab1sm1059914266b.52.2025.03.19.11.54.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 11:54:44 -0700 (PDT)
Message-ID: <38b3eb9b-6448-4684-9f47-f4b64e5415cd@gmail.com>
Date: Wed, 19 Mar 2025 19:54:43 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Jens Axboe <axboe@kernel.dk>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Ondrej Kozina <okozina@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Alan Adamson <alan.adamson@oracle.com>, stable@vger.kernel.org
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
 <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
 <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
 <cdc19799-fc72-4581-a942-adf411b19a94@gmail.com>
 <625382fc-8503-4e19-b571-6245fb4d1317@kernel.dk>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <625382fc-8503-4e19-b571-6245fb4d1317@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/11/25 4:00 PM, Jens Axboe wrote:
> On 3/11/25 8:59 AM, Milan Broz wrote:
>> On 3/11/25 4:03 AM, Shinichiro Kawasaki wrote:
>>>
>>> I created fix candidate patches to address the blktests nvme/039 failure [1].
>>> This may work for the failures Ondrej and Milan observe too, hopefully.
>>
>> Hi,
>>
>> I quickly tried to run the test with todays' mainline git and mentioned two patches:
>>    https://lkml.kernel.org/linux-block/20250311024144.1762333-2-shinichiro.kawasaki@wdc.com/
>>    https://lkml.kernel.org/linux-block/20250311024144.1762333-3-shinichiro.kawasaki@wdc.com/
>> and it looks like our SED Opal tests are fixed, no errors or warnings, thanks!
>>
>>> Jens, Alan, could you take a look in the patches and see if they make sense?
>>
>> Please, fix it before the 6.14 final, this could cause serious data corruption, at least
>> on systems using SED Opal drives.
> 
> Fix is already queued up.

Hi Jens,

it seems the bug was "successfully" backported to stable 6.13.4+ and I do not see any fix
in the stable queue yet.

We were hit by it today, as all locked ranges for Opal devices now returning empty data
instead of failing read.

Please could you check what need to be backported to 6.13 stable?

IMO these patches should be backported:
   https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5c2bcc0cd47321d78bb4e865d7857304139f95d
   https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bce6b5f8987678b9c6c1fe433af6b5fe41feadc

Thanks,
Milan

