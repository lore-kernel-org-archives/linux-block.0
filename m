Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64C46FBE
	for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 23:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711062976; cv=none; b=YPn02nco9b8fXx7e6W+P3rOD1Osrj3r1p1ErrRs/6og97eQYwzWlLh9xKSZ33BmFFSDBrf11fjLnao12Ck+Pz+aY5Gjr5W5t/5JP0HQrGz/1ud7e9pl+uF8cAj5+bBVK2hyPU9S24gI/JAk9Oez+sfdCKPlrOz1oGf7dV3j6Mh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711062976; c=relaxed/simple;
	bh=xoFvvYznROZD9q8Gt651SQlF2ltMUh8dZ5X8gtcCftU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bi8H8aN7rrTB7XLtaqgLPyJl4+H0KJo/IC4byrp+xts6ZH6AkzIqzGS/fuGCTOmdiEirOg2zZYZAGAKY7wtsBXG3gmlfk1QFGWiz9sTB/z00jhIy+G9UOV9/5O+MECNYkNUKL5foRPiKvmb4RCK9n5ASTiCMgq1CMO5mdtVCak0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=1U6Iw9hQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="1U6Iw9hQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dee6672526so3062755ad.1
        for <linux-block@vger.kernel.org>; Thu, 21 Mar 2024 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1711062972; x=1711667772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8eftx4T96pfTgODc5xqEJQ9eXVMkVxAVoOALgQsA6SY=;
        b=1U6Iw9hQ5j8ssghHakBnIuW3YsdpK0UFWJaHzO5z64I38fM1h7Iqvhj2p/Znkm46qd
         BS43rcPH/H9OSIMMPkTy4ejm+kamMy1nqE+S6S7tQBTLzTf3fcQY7YqCBvdlHIUzw+Wr
         CTJxzqUPELERfOgLBjYjCRbTRvBg57ugJ5YdCLNFtHQD8Oe2SH/UtlBv+oKKT3BsF6RJ
         1oiU903Q0cEhoTFSYORSthFJmvghTH6/ywNHXfafigUbzkj2UyxD22aphEEc25DHh8t3
         ze3AoTBOtWnhlVb0GkH+jeK02/rTdTca9CSFIvr7ASLuYaqgbwtZjP3LjKrbybbBINF0
         /tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711062972; x=1711667772;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8eftx4T96pfTgODc5xqEJQ9eXVMkVxAVoOALgQsA6SY=;
        b=wdm2kOBPN59oV7A4aAAB065YuoLs9DJ6hHGYR+uO4pCjV99n0LXhQPIeT6YsU9Z5JD
         d4HcLQzdlL0cSDBR3doLMdY+RHuXEauLNp8jXmuaBQG5xMrUHIBYzqaAvGtYUThDTQ1H
         FRecDKskIHTmcVPerMCD09dw5YIdoVRJab34NsiFbo87+m68DleI/sLZF4lDPndeqekJ
         DHIQ3IP8SibNq5eaWIaCaVvhwO9v2kGMc8/vzM5a+Q7gcGpPv4GxjOYEl0045to+FxvR
         vBMv3bNneieS0nHctjCR79RsPvrHGI94lF/3ASDYtzvV+j/wxhfqLMcahCTFGvF9P7/6
         IzfA==
X-Forwarded-Encrypted: i=1; AJvYcCWCt1XnnkQmWYBp1VQrZB4E5MeCsh6GoBByHF43VsHQfzS18x82GrMDcTJdcdT1+bZYiCfgFjbzE7WY5ro2Z7bwAesIy5dgUzk8UJ0=
X-Gm-Message-State: AOJu0YxGoeh3VpkL8n+zy0efMAcn/XY/A1qh/pu59RZGiMksR2vJkgLP
	wADGQcddEdpOfVotNOl7TJIjGvRVzPr/UcrrNfqwAPcgC0/wLSFyRiucwln+Uhtymrz9/y+SbXD
	+
X-Google-Smtp-Source: AGHT+IGj7v6LRIJUOmeFSvVgAsQfXbdDEv5jNZUhVj0eRHieodiAGKEfdDXaNM4uNJF3cfIZJS7Axg==
X-Received: by 2002:a05:6358:716:b0:17f:1d24:1432 with SMTP id e22-20020a056358071600b0017f1d241432mr173146rwj.3.1711061446191;
        Thu, 21 Mar 2024 15:50:46 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id dr18-20020a056a020fd200b005cd835182c5sm317710pgb.79.2024.03.21.15.50.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 15:50:45 -0700 (PDT)
Message-ID: <1a0ac357-49e4-41fa-b0c3-f038ec995a00@kernel.dk>
Date: Thu, 21 Mar 2024 16:50:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: fail unaligned bio from submit_bio_noacct()
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>
References: <20240321131634.1009972-1-ming.lei@redhat.com>
 <979af2db-7482-4123-8a8b-e0354eb0bd45@kernel.dk>
 <ZfywBU9IRHGdqVqo@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZfywBU9IRHGdqVqo@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/21/24 4:09 PM, Christoph Hellwig wrote:
> On Thu, Mar 21, 2024 at 11:09:25AM -0600, Jens Axboe wrote:
>> Where is this IO coming from? The normal block level dio has checks. And
>> in fact they are expensive...
> 
> How is this expensive when we need the bio cache lines all the time
> during I/O submission which follows instantly?

This part isn't expensive, it's the general dio checks that are which
check memory alignment as well.

>> If we add this one, then we should be able
>> to kill the block/fops.c checks, no?
> 
> That would mean we'd only get an async error back, and it would be past
> say page cache invalidation.  Not sure that's a good way to handle
> failed alignment from userspace.

It would fail during submission, at least for sane cases, so it would be
readily apparent after submit. Unfortunately we still don't have sane
passback of errors there, this is one example and EWOULDBLOCK as well.

-- 
Jens Axboe

