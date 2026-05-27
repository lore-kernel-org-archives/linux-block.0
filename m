Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03C42EDD78
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900527; cv=none; b=SQi6SWLKR3pNBxaT6T8GMzaAIsz6lPzvjTnnLiuvECMCLue77f8it8K0P29u5fBx5cl3YnA98bW+UUVp6LGlIizQVx3njEJ64Y8lpEjhhz6BL7mccmvUDryKJhKWXslCcCcPmoJ+ezPGTk+BF9fxW88l5iBd15jhSpv0QJAos4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900527; c=relaxed/simple;
	bh=FmxYLZ9T7HBDAy6wBD57To1ee/XxE4n60OIHR8rubDE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ll9ZJkbXWYh2Wg1fRjGBZ0oft1zXTNKtibNP5aD7N3451TxwK8IqQSX6CLlfKwpZn73tLrYExaV4YOTkVK4R6+Zb9PUNTsiTxN5xuN0MTYuJpQyLIcuFGCd67cRvxoFJrot9wNj4MsvksRO+en585pUrH9mM6+S+Mw/0aP/qpZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=kAPtv0ez; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="kAPtv0ez"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-4854166e1efso6059363b6e.3
        for <linux-block@vger.kernel.org>; Wed, 27 May 2026 09:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779900524; x=1780505324; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CZP1fzAKg6xSaEJ8PTmlIuF0/KF0E0yGfcRKbvHI5OI=;
        b=kAPtv0ezeTDePp5PrnKl6jSFG1izpSbAGOk5p7rRKsNwTWHfBBLpPhyMYBWw/l9Ov6
         OpGi5cj8J1lbcNXv2Jh9kUGKiyl/vBkyQoxemCTaW1lnLvh5NiEpWk/uTIOlrqRDcd1+
         P5+YGXwDMNMNoCyTYIeiSoZFZb3bDVqeGBt2S1rIrgyYMK9qWQzjMHIbFac/ahQsPohe
         U1TXwy3vHyHli/jhEbpKrV+1pT052oBUBlUy+4eb5eB0Ep5QcWcGCt7Sz9Wn9l1UtJvb
         4753a9s9I1TXAbxdpUGD2rPbxxyh/D0DBULN6PacGUXycaCPgQKkw17LCItK2AL4lchR
         oWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900524; x=1780505324;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZP1fzAKg6xSaEJ8PTmlIuF0/KF0E0yGfcRKbvHI5OI=;
        b=RZnS91QpYbzUAIsIsM+QBO6rEMH3zAll81hKl+C1ISaLpmAsa1oCxLHoE8oKfG+F58
         f4GSq6/8tgAnQT0rc37VmIJFedZGMI94+KKt/XpuYEe478pYexXaS43Zu+JMSKYE09Qj
         +EiDvbCbY72+H9tKq0EYh6PMCDBV10XDgxlKF3KKhT4TTgnWdWRlZb4WAJ+mq+U/PvNd
         CvPdEwBnow3shmV5fj/Swa7Ny6mkJ7PX3HrsR+mW0vB1ztWcfZRhJVVCst0vesCugFWE
         osrB5hK5Zgc84SzdcSoxJE0hWPteuWl6j/8+G445g8V34s5LQFR1hx+zRlaekDgocybL
         E44A==
X-Forwarded-Encrypted: i=1; AFNElJ/Uk8UuUkM2rThOd7xWU5VpkQOhL0lB94OINgNy58XZvWM86MN0xR1NB8zJlQgKGCLKvHaIzV6gd0sTBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4SSh2t8kAYNOIXUzJ292+vPPSXI1Mwl+ViXVu/Ba+sayB4Ltp
	4qXF+nvjHlp3xP4adc9lzEfZ6p1vcFqrZCH1xZvddrrMEvKSkfEu8CLjh5DRY+1scJs=
X-Gm-Gg: Acq92OGBGNsPaM2RSidDNzsONbS8u9yzJ5bSFHJvrPlOg4lcD61Cf7+l2bVb9mKvJ9W
	8Y4dlAAZIMTgE68DMw9Zt2Fk3g4GyMX4huzm0PI8LJ3p1yMJ+z8fEDh6nkRWj2XOgEsGyJ6p/5L
	iJGDwJBj0erebtKf5TlSnox3EfsPU1xhPl3a/MnhbqTEZlLbJ+sbcPVa6ufP769b7/eUk55nEJX
	ZjIn4u4BKpoV2rnlolqKqQn/QUlTuR1ciuHBiaSymZu1/FZrcwuRj/T6KYKfy//KApHT+6iJjCB
	1hdSce6ClIuQqo1ei/e89Fr5YW8q8yzz9Emhr3vTihnQR9UtKh6hA1SAiajFAvoqBmcXTYXE0Oz
	xBFpODyD2wfg6z/H/DlVS2TjE17yTdQiivp+kZaexbuUzDn4NM9lv4W7ZUleS8U9K7zhjUckM1Z
	ot1dX+jno+/GDelyoOKEuohZzb8PfJxR5ua65vPciNZ7gA7S4dOvZX1xEhhSPmiE4uGSRBiOwA+
	s2cbTR2
X-Received: by 2002:a05:6808:1492:b0:485:b864:4ff7 with SMTP id 5614622812f47-485b86450aemr3139766b6e.22.1779900524609;
        Wed, 27 May 2026 09:48:44 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b6350ad6bsm17352084fac.4.2026.05.27.09.48.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 09:48:44 -0700 (PDT)
Message-ID: <8947eb1f-9b49-4452-9c9d-f95dacab65c1@kernel.dk>
Date: Wed, 27 May 2026 10:48:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: bsg: copy uring_cmd payload to prevent double-fetch
 from shared SQE
From: Jens Axboe <axboe@kernel.dk>
To: Caleb Sander Mateos <csander@purestorage.com>,
 Rahul Chandelkar <rc@rexion.ai>
Cc: James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 fujita.tomonori@lab.ntt.co.jp, linux-scsi@vger.kernel.org,
 linux-block@vger.kernel.org, io-uring@vger.kernel.org
References: <20260527105931.3950913-1-rc@rexion.ai>
 <ee931505-64a2-411d-8607-3db8912b70c4@kernel.dk>
 <20260527161926.4071110-1-rc@rexion.ai>
 <CADUfDZr6LJckoVt2NRfRt3Njs-WAqsg5-QnTDi6xbUDiO950Fw@mail.gmail.com>
 <07c25a67-54b3-4ecd-bdf1-7ca0cefc8e38@kernel.dk>
Content-Language: en-US
In-Reply-To: <07c25a67-54b3-4ecd-bdf1-7ca0cefc8e38@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/27/26 10:45 AM, Jens Axboe wrote:
> On 5/27/26 10:27 AM, Caleb Sander Mateos wrote:
>> On Wed, May 27, 2026 at 9:19?AM Rahul Chandelkar <rc@rexion.ai> wrote:
>>>
>>> On Wed, May 27, 2026 at 10:06:44AM -0600, Jens Axboe wrote:
>>>> I don't think this is the right way to fix it, ->sqe should've been
>>>> stable upfront if this ends up happening. Can you share your poc with
>>>> me? Your trace has been trimmed down way too much to be useful.
>>>
>>> Agreed that a core-level copy before the inline callback would be the
>>> right fix and would eliminate the entire class for every uring_cmd
>>> driver. The per-driver copy was meant as a minimal backportable fix
>>> for the immediate scsi_bsg path.
>>>
>>> PoC and full trace below.
>>>
>>> --- PoC (poc_bsg_toctou.c) ---
>>>
>>> Build:  gcc -O2 -pthread -static -o poc poc_bsg_toctou.c
>>> Usage:  ./poc /dev/bsg/X
>>> Needs:  2+ CPUs, io_uring, /dev/bsg/* access
>>>
>>> The racer thread flips request_len between 16 (passes the <=32 bounds
>>> check) and 128 (used by copy_from_user, overflows scmd->cmnd[32]).
>>> The overflow payload plants 0xdead000000001000 at the sense_buffer
>>> pointer offset (+84 from cmnd[0]). When scsi_queue_rq() does
>>> memset(scmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE) it faults on the
>>> corrupted pointer.
>>
>> Then the fix is to use READ_ONCE() to access the SQE fields, right?
>> Copying the entire SQE seems like unnecessary overhead. See
>> nvme_uring_cmd_io() for prior art.
> 
> That is indeed the correct fix.

To be a bit more clear for the original reporter, in the hopes that they
will send a v2. Doing things like:

	if (cmd->addr)
		validate_addr(cmd->addr);

	[...]

	Use cmd->addr, we already validated it.

Is not safe, as ->addr can change in between. All of the sqe related
bits which cmd is should follow the pattern of:

	addr = READ_ONCE(cmd->addr);
	if (addr)
		validate_addr(addr);

	[...]

	Use addr, we already validated it, and it cannot have changed.

Copying 128b in both places is a big hammer, the code just needs to use
the proper access mechanism.

-- 
Jens Axboe
