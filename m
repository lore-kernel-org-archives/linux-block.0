Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FEA39B
	for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589494; cv=none; b=fEPH0or4vz0hmku7i8d8Ug+zXK8TLulAYD9K1ZnPg3ILAfkX1zFU+8S+UAWNJuQ2lbTJvav2b863VrEidK91Pm5Yba4sK+xXF3Jq+xzy+zasoU1txdCFe/VoJ3X/CGUVMRHlhkZpIVAcg/22Entt76H83V2ntIESpLAX4gX+208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589494; c=relaxed/simple;
	bh=D6LQYOwdZcNYjklsfXHYW8lW35biQd2BvJhZRH9XpaE=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=BLCaJXY+0ZveLo7lKBYu+hg8JZE5kZtbxOdC1BXwM28Kht+qcmZIQiP+DOGQkif0p8ZmemVDRCZt+icQgt1CWYX/+H8dWqb27TxDwRat+rWHJkY7qRc0tEVBW+QjKGHK3X94b9EDamlzdZkSnc/jyCuAc1EbKB5RB2v64U8GRDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=TB/1Hzyd; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TB/1Hzyd"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-35d374bebe3so9753775ab.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jan 2024 06:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705589491; x=1706194291; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S2eMzECQ5AvlQFdpHnk1jkqzeOtRN5+enS73/qU9+1o=;
        b=TB/1HzydL1v9lbfGbZ87A2iTrMzzcFRieH2jd38yI/hOydCYCndbvIy89TwarTgBji
         c9isRKrG2QY8nC0cn/k24PdUzO6rI5Yf8MFiZKrYcazuh0TwIuvZMOu5X9fmkqCFAi17
         wMXc29L6UG+PdWYP/WE2oKxm6AaCUMQocfidYnM1P8C5IfIoCuuzskZ6w0Wv1J7yZqRo
         gRG7hp95bsgU2IjoGZ4ZU8BQ6hAHFppAfi96wGY9oBQ7XnLS+eL5V9gPLz3V1OQShhq2
         /dZFVSwtCReNJHv/efjFhFkGdWx52emRsbviCufFzHn1zstGiu+W45YO031TimEa3gGY
         5Y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705589491; x=1706194291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S2eMzECQ5AvlQFdpHnk1jkqzeOtRN5+enS73/qU9+1o=;
        b=L0mUBA9m8yrDF0h3ScKpLQGCU5DEJNs7dTb67IrUjPhz78AiT0F3BkNyF2xU2tbz/C
         A3ENsvr0zOftzTqddJos07ZGxpJ9R5WGTCRPm7dVj/qQbZ8UHRGO6Nh/lC8EpNS2xoBx
         MkbMYZX7tzc50B3kt8+j8JYuF2Z6/hZiBqtLgrrXgEDlvgl3N7pP/bkkxV9RKfDUen1o
         HMxrqYGy98omJuxeLWRYf7k5Nn4BlHqDfm/bYEFjPvVQFL4I3FHKOENMZLieqP+Ep1k/
         W5tsHZhDnuylPWs7GoJU75EXcv4EUsZRaAOsDzK2CcRro2OlayiOfryPaDuhlBvTrZ4J
         SIvQ==
X-Gm-Message-State: AOJu0YzMpgdO2nmvbbf1I0XM9rbv7SlALsFcKyhN00zkuQG7PRKAMqra
	MAXQub63PkOeq3xJBLazHGiEplLO8GNYF1yV1x5SI6RbcgRI9A6dDGdRpGV9zVQ=
X-Google-Smtp-Source: AGHT+IG2EYYIBRPloa/IpijdR69rM+noRVZ/01wQX4YDEK4OaVXKvwNDsETrzZqVmf3TKC8snYfnjQ==
X-Received: by 2002:a6b:794c:0:b0:7be:e376:fc44 with SMTP id j12-20020a6b794c000000b007bee376fc44mr1756358iop.2.1705589491605;
        Thu, 18 Jan 2024 06:51:31 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5-20020a6b1505000000b007bf2c9bbdd6sm3416975iov.50.2024.01.18.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 06:51:31 -0800 (PST)
Message-ID: <b590c534-2c5c-41ca-a069-d83549c93dac@kernel.dk>
Date: Thu, 18 Jan 2024 07:51:30 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving Zoned Storage Support
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Damien Le Moal
 <dlemoal@kernel.org>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
References: <5b3e6a01-1039-4b68-8f02-386f3cc9ddd1@acm.org>
 <cc6999c2-2d53-4340-8e2b-c50cae1e5c3a@kernel.org>
 <43cc2e4c-1dce-40ab-b4dc-1aadbeb65371@acm.org>
 <c38ab7b2-63aa-4a0c-9fa6-96be304d8df1@kernel.dk>
 <2955b44a-68c0-4d95-8ff1-da38ef99810f@acm.org>
 <9af03351-a04a-4e61-a6d8-b58236b041a3@kernel.dk>
 <276eedc2-e3d0-40c7-b355-46232ea65662@kernel.dk>
 <39dfcd32-e5fc-45b9-a0ed-082b879a16a4@acm.org>
 <9f4a6b8a-1c17-46b7-8344-cbf4bcb406ab@kernel.dk>
 <207a985d-ad4e-4cad-ac07-961633967bfc@kernel.dk>
 <e8c32676-114b-4aaf-8753-5a6d7b04fc4b@kernel.dk>
 <86a1f9e6-d3ae-4051-8528-13a952cf74a1@acm.org>
 <90de77e4-ed8a-47be-b5df-2178913ec115@kernel.dk>
 <08d22893-9a05-415e-a610-9b1ceaaba96a@acm.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <08d22893-9a05-415e-a610-9b1ceaaba96a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/24 5:43 PM, Bart Van Assche wrote:
> On 1/17/24 13:40, Jens Axboe wrote:
>> On 1/17/24 2:33 PM, Bart Van Assche wrote:
>>> Please note that whether or not spin_trylock() is used, there is a
>>> race condition in this approach: if dd_dispatch_request() is called
>>> just before another CPU calls spin_unlock() from inside
>>> dd_dispatch_request() then some requests won't be dispatched until the
>>> next time dd_dispatch_request() is called.
>>
>> Sure, that's not surprising. What I cared most about here is that we
>> should not have a race such that we'd stall. Since we haven't returned
>> this request just yet if we race, we know at least one will be issued
>> and we'll re-run at completion. So yeah, we may very well skip an issue,
>> that's well known within that change, which will be postponed to the
>> next queue run.
>>
>> The patch is more to demonstrate that it would not take much to fix this
>> case, at least, it's a proof-of-concept.
> 
> The patch below implements what has been discussed in this e-mail
> thread. I do not recommend to apply this patch since it reduces single-

No, it implements a suggestion that you had, it had nothing to do with
what I suggested.

> threaded performance by 11% on an Intel Xeon Processor (Skylake, IBRS):

Not sure why you are even bothering sending a patch that makes things
_worse_ when the whole point is to reduce contention here. You added
another lock, and on top of that, you added code that now just bangs on
dispatch if it's busy already.

I already gave you a decent starting point with a patch that actually
reduces contention, no idea what this thing is.

-- 
Jens Axboe

