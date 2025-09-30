Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF80F86352
	for <linux-block@vger.kernel.org>; Tue, 30 Sep 2025 02:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198581; cv=none; b=tpRyzCa+ICKOQPBBFuat0WFNjFDzmvY+C+z86aLDEgYPZ9I5dyAskaebsvOCe1X+NnBh4mw9VdF7kzbCW50T0e5rHOfpr9OjJrFP+HiwJTym/WlQQjX0GhpjYnyHgcoHBMH1WVk0GsI67NrotDkdvuDyEAhaeTgqN9a2nnKT/mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198581; c=relaxed/simple;
	bh=OK8V0cRd1E2z0rRcBO8+xTMj4ypqLXsS3F2OCs1KAx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mqGeVvwXqWPltzbzaSrFlClEg7MWPK7bW5T2LGjiSMUkYbrohfFhcCQ5LySuZQtoSUBiu1mfsTSAfPzJvI5uXUC+SzCREVlhJCL5daDNCjC8fVIMTN7XWlUwk47d3x5GWYsE7shiiSxSiJMrnnTccLwI5Ku8BGkJ3h+eB14S+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e0sgg2uk; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e0sgg2uk"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-426f9f275b2so18609135ab.3
        for <linux-block@vger.kernel.org>; Mon, 29 Sep 2025 19:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759198576; x=1759803376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gXCFk/3Bf3RjS4/2LYfa2eSqrDudJXNDNHB3VJj+cM=;
        b=e0sgg2ukHZ3xmzmJ4dcBbHoMye877Y6sx1vqg+XudhFweNWT22axGTp5H1Z3YGgDts
         mT2QAAZ/9PB6KtLj7bVFLiLVtWCn/IrC3s+omV8QbK+2pgwg+hsW2Qf7t13AYlMUkdaf
         5Ch2pi43h5AIqKqpiV1KKrQcmN25MbJt6ahh06kEur6wVw5SlT6lpz8gMLPLXVttRMuo
         HfQWNIuiGmdaWWVgfdUGBZGOi32h57rWGykfKPvlPjddArgUN/x3K3jw53sJE2AyJcbO
         X3Oh8+S1n3oR315tgCJjt+VmcXN4f1t2TmK7Zfk9P2qvuTdCz3s9X2w8SETUs6hDOz6i
         n3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759198576; x=1759803376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gXCFk/3Bf3RjS4/2LYfa2eSqrDudJXNDNHB3VJj+cM=;
        b=QOCjJNnx1O8E9154TpTW6Xaeg1CM6I+S/NBc7Q1JG+9lMDtJV+u8RDeGlP7ncxaEeG
         GwP8E3u4JRiYQay4+tq7z8XqA8vP4WwUcx6jFmxWT9b0Aae5BtTTYNSVk5xFgMuvLKrI
         q/8xA/wZDEYszWYLGNPregdfzLDKzWkKKyeIIV5ooPIGEkz1gXhclJqJeqdRHWCjFnlN
         Nl76Tqz+24nVoUiSSyGPrdn1S3W6kqFpFrggOf/scTBPOT4GhgrDQllQwYCrurejv3lC
         7a8+6P2mEUpk1J+pEi0jrQu/Dkq1x/wNd9cjuocZbFsVAUgOOxGqs1eIYzcvWzbMDD8S
         GAyw==
X-Forwarded-Encrypted: i=1; AJvYcCVWx0wkXjvOP579M5vj59Hx39AFVA1FelC1G9tC1PUbHc6tyloQDejdb1WpSfrGcL0AFfUFNg722w608g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKdipCOMgaKrabAM0w9XENS1e0o8scFEeyNw0O5pLSLXx2DL+W
	px1yMnF1MCsl8TcXr7u7F1zHzPD7rLxt23j4pJabnBdHl+6mmYq94lHhqbDkWCUhHWo=
X-Gm-Gg: ASbGnctdIO5W0cvP4h/sBBKbQ6+fptUYaZN3CDUWjBUu9UZoVFy1sN7/YmfqqGdr/4J
	snT2UbV2s+DKVuW9fga/XLRVLCOx7/rhNEi3W5+tNzyVJgCGrI5Zkv31eksY6FFhFFr830Fx/lj
	ZlLaAHGv0EPcekrYsaQ0agXEEak62mmQg6jbRTnOsCe1Bb8g3j2PXtlDw6rTaQaTdlu1K0xSOIk
	OJnD7usrCRPhE0X7MYgI1XVIKOvtOQ3GV7RjcGXUj/NGZSw6p6rRsBkXnXzGrcqANGZZwG7x7VL
	gL9rL39zLZOJmjN67C5mVhjNZ1kjerIg9bJr2e2zKdQ+9acrfw/W7XNx/b5RVsV9+mg6CwwxYJo
	YvqZI4EaKPEiZWsCZ7QxC/ZYTUGYW7jD5wc15ofXL9n+vYUMqCf5TdqU=
X-Google-Smtp-Source: AGHT+IE3+mtuTOLJBaGH7Hvq0YKur8hYTk23S2mEat93frrHRnRo75eeP8lSgxf76+sVwuvfKOedmQ==
X-Received: by 2002:a05:6e02:1aae:b0:424:7ef5:aeb with SMTP id e9e14a558f8ab-4259563befbmr252329955ab.17.1759198575838;
        Mon, 29 Sep 2025 19:16:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a69a1b7b2sm5293617173.51.2025.09.29.19.16.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 19:16:15 -0700 (PDT)
Message-ID: <c3444a76-4849-4b78-90f2-9dc760c6a232@kernel.dk>
Date: Mon, 29 Sep 2025 20:16:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] Block changes for 6.18-rc1
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <124c358d-1d50-4691-942a-76ff75396be5@kernel.dk>
 <CADUfDZoYDMF2BL4+yTKJ=Cr+_-h0j8eD8pjZXw8wTUFOa+dN+Q@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZoYDMF2BL4+yTKJ=Cr+_-h0j8eD8pjZXw8wTUFOa+dN+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/29/25 7:50 PM, Caleb Sander Mateos wrote:
> On Mon, Sep 29, 2025 at 6:46?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Hi Linus,
>>
>> Here are the block changes scheduled for the 6.18 merge window. This
>> pull request contains:
>>
>> - NVMe pull request via Keith:
>>         - FC target fixes (Daniel)
>>         - Authentication fixes and updates (Martin, Chris)
>>         - Admin controller handling (Kamaljit)
>>         - Target lockdep assertions (Max)
>>         - Keep-alive updates for discovery (Alastair)
>>         - Suspend quirk (Georg)
>>
>> - MD pull request via Yu:
>>         - Add support for a lockless bitmap. Key features for the new
>>           bitmap are that the IO fastpath is lockless. If user issues
>>           lots of write IO to the same bitmap bit in a short time, only
>>           the first write has additional overhead to update bitmap bit,
>>           no additional overhead for the following writes. By supporting
>>           only resync or recover written data, means in the case
>>           creating new array or replacing with a new disk, there is no
>>           need to do a full disk resync/recovery.
>>
>> - Switch ->getgeo() and ->bios_param() to using struct gendisk rather
>>   than struct block_device.
>>
>> - Rust block changes via Andreas. This series adds configuration via
>>   configfs and remote completion to the rnull driver. The series also
>>   includes a set of changes to the rust block device driver API: a few
>>   cleanup patches, and a few features supporting the rnull changes.
>>
>>   The series removes the raw buffer formatting logic from
>>   `kernel::block` and improves the logic available in `kernel::string`
>>   to support the same use as the removed logic.
>>
>> - floppy arch cleanups
>>
>> - Add support for UBLK_F_BATCH_IO, improving the user <-> kernel
>>   communication
>>         - Per-queue vs Per-I/O: Commands operate on queues rather than
>>           individual I/Os
>>         - Batch processing: Multiple I/Os are handled in single
>>           operation
>>         - Multishot commands: Use io_uring multishot for reducing
>>           submission overhead
>>         - Flexible task assignment: Any task can handle any I/O
>>           (no per-I/O daemons)
>>         - Better load balancing: Tasks can adjust their workload
>>           dynamically
>>         - help for following future optimizations:
>>                 - blk-mq batch tags allocation/free,
>>                 - easier to support io-poll
>>                 - per-task batch for avoiding per-io lock
> 
> Perhaps I'm missing something, but I don't actually see the
> UBLK_F_BATCH_IO series in the list of commits. My understanding was
> that it's still in the process of being reviewed, I hadn't seen you
> apply it yet.

Yep you are totally right, that did not make it in. It was part of my
draft but never got it updated! Linus, please just edit this that part
out when pulling, thanks.

-- 
Jens Axboe
