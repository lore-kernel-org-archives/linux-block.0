Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69043E9F4
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900324; cv=none; b=Qs0AhZayTKyywUY7ck82eX+B9s7obPClD1JgtYI+FqgB5VRpuK9xeFk1MPNXi60xlACcVCada/zO8w3kFcQFPF/xkaO6ADWAVxzC3U1WDgCESqfQwwqo6LbDIBuWsRU+kZMNuYIo7qD68OuszjHhouj4VD4rI9+z3Td+iLwF7TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900324; c=relaxed/simple;
	bh=Px96Koc+KE1Llq24SuFqyCNdFUV476yMaxYMtndJ/UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=enoSVPGQa0+xGZwUBPtnJOxnQ+G1ZkTXcIfTnX1/824oTyhHw7ootvS5YWeuS5aX5n+NfkWs7eODoTMo95O4gWYiqSfeoFQTIMhV8TE15Kfd66iYsL0oaHNlgd9Qh5kVxTX545eILJAYLzq41wqucwmsdbYEo7U7FXf8lUa7SOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PGmITyv1; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PGmITyv1"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e603d0ee0aso3357717a34.2
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779900318; x=1780505118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dcORsZ+6RO+FQOhB2NjtCmUi3rJoywVrFL/YyMOnoJ8=;
        b=PGmITyv1gFtGOc+BOGJEcFusxaA/c4h6dxbQwwTmpfDOcZBsxTqSevpcLmm6/xYdqB
         NP755Jb4bgoPiLU7FQr956I1q4JJoTIl0YFdFHQUN0igabqpvBU5aOxItBS6yBi80Q+Q
         DU8tpq3GMEMM1QlvywC3ELldx918nVUFJ1TNdWvc54VyLcgiXbb4k4Wm3xSNlWkaHbS/
         16ak2tv9pEvqYtNB61CUod3/Y9xLD8rYqm6FUASZNBjtE1dBVint5GTw/s4f8cFclvO3
         UIFk0ODzBNcdesQHJ/ReEEcTAhK5CWW4QQk9QIZVqBkELkBVGzkKlAdXKEvXw5d3Vs7k
         yhZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900318; x=1780505118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dcORsZ+6RO+FQOhB2NjtCmUi3rJoywVrFL/YyMOnoJ8=;
        b=oUVw2SYk/93/8pOijkZHhvsLXToClC19HEP7bssvl6kT9wvBYSenrIK1go4jo8V/LS
         UGxz9xE2AWfWsv5KzwQdRYG/87EOP0GD8V7idz676kdZzAbZCgclHGIB0w44RgZcKy48
         uax4B1x+Ssf2gA+O68bfgzaqhoz0/D+TEIEMW1d01t83F6PafXS6Uj8JWRpV0+kePRDq
         eZuj9VHcjZbrJ262/GRk1RcEt+LvsjGjKAfZOffwVch1j5GA2qNLJsyuI5ehZbN9kJDv
         SUgWQ6uLIZB+zjW3EbEcgRBjughhuCYznKG2XCttY3W5bsFsI6BFDvnIzL5mx/OvzohI
         wzDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3jlLUYRkJBWqx5CBVvnbjfxvIO3GapMvx0bnTAPZRfTkURsHY0mKQnwnNRs2EAYGsC0CSY2VfwAm6BA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdpy3g8YcLpLhkWC3B2yrLB/lasIx/QWR892dE6KTnJwoy1jEI
	wUWOGDYwsMkkV/OZfa9Q+pnaZisO/VC7aHKaEc/7sGZvEqBaaYhlOFr3pZmSi8y/xfU=
X-Gm-Gg: Acq92OExGB36sqG8axqatZS3ILu7yVEb0laKGMC2ERVV8f39/OznSJYIIvhoQ3i94+F
	nDrGViBwt9Ksj/+yAzdWqgzEJhf9ZdrzBnYThpqZQaGhqjynGSgf0Z8eX5OI8OJon2ciRURGi78
	Rs4zgSeCaJgvPM8JgmiYpuN8EqnTlNpTB6eEFOF6vQTVvIugVhvQFpep1d6XF9/PcmNI72zWEzS
	heuQN+Tozj40u34zcGatWEVEQbN/dNQTV0AwJmo3Ju8I3EC+pUAcSZ/aq4/X7wLuxZKSxH/pnDX
	4BTe9JcFUv1nMN2TlP9kOdAOVZzlVOE4AvSz4eaCo3GyNAzSBz3hkAiX2EedKj+i5CORD3SnBc1
	whR5+Pm6m11zyuzC6r22ykyZ4vZqjMv0UfjI94/B3D4h2m5kaQzgT3bmBMitVL7oIqRS57n9ywT
	6mpZsJZNZTWax+Bpfbk0dOVFqioF40xIQcopOYcnNk2k2mD3mqGin/9+Pugu5g2O2K+POoaApRY
	h418Nz6OVYUY22fukM=
X-Received: by 2002:a05:6830:270f:b0:7dd:e032:3ce5 with SMTP id 46e09a7af769-7e5feed03cemr14415624a34.17.1779900318314;
        Wed, 27 May 2026 09:45:18 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e606641114sm11987256a34.21.2026.05.27.09.45.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:45:17 -0700 (PDT)
Message-ID: <07c25a67-54b3-4ecd-bdf1-7ca0cefc8e38@kernel.dk>
Date: Wed, 27 May 2026 10:45:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: bsg: copy uring_cmd payload to prevent double-fetch
 from shared SQE
To: Caleb Sander Mateos <csander@purestorage.com>,
 Rahul Chandelkar <rc@rexion.ai>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 fujita.tomonori@lab.ntt.co.jp, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260527105931.3950913-1-rc@rexion.ai>
 <ee931505-64a2-411d-8607-3db8912b70c4@kernel.dk>
 <20260527161926.4071110-1-rc@rexion.ai>
 <CADUfDZr6LJckoVt2NRfRt3Njs-WAqsg5-QnTDi6xbUDiO950Fw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZr6LJckoVt2NRfRt3Njs-WAqsg5-QnTDi6xbUDiO950Fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/26 10:27 AM, Caleb Sander Mateos wrote:
> On Wed, May 27, 2026 at 9:19 AM Rahul Chandelkar <rc@rexion.ai> wrote:
>>
>> On Wed, May 27, 2026 at 10:06:44AM -0600, Jens Axboe wrote:
>>> I don't think this is the right way to fix it, ->sqe should've been
>>> stable upfront if this ends up happening. Can you share your poc with
>>> me? Your trace has been trimmed down way too much to be useful.
>>
>> Agreed that a core-level copy before the inline callback would be the
>> right fix and would eliminate the entire class for every uring_cmd
>> driver. The per-driver copy was meant as a minimal backportable fix
>> for the immediate scsi_bsg path.
>>
>> PoC and full trace below.
>>
>> --- PoC (poc_bsg_toctou.c) ---
>>
>> Build:  gcc -O2 -pthread -static -o poc poc_bsg_toctou.c
>> Usage:  ./poc /dev/bsg/X
>> Needs:  2+ CPUs, io_uring, /dev/bsg/* access
>>
>> The racer thread flips request_len between 16 (passes the <=32 bounds
>> check) and 128 (used by copy_from_user, overflows scmd->cmnd[32]).
>> The overflow payload plants 0xdead000000001000 at the sense_buffer
>> pointer offset (+84 from cmnd[0]). When scsi_queue_rq() does
>> memset(scmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE) it faults on the
>> corrupted pointer.
> 
> Then the fix is to use READ_ONCE() to access the SQE fields, right?
> Copying the entire SQE seems like unnecessary overhead. See
> nvme_uring_cmd_io() for prior art.

That is indeed the correct fix.

-- 
Jens Axboe

