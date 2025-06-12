Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A981117A303
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730884; cv=none; b=GeE5hviu6VQzgdavrpCpko6rEACbkPxFqAt8q8GBVL0TRrOQT6LRUnp7uSmhtveuJR36H0AXXXxNXyb4fjOIb06nL8L1jikbaia3zLMM4YC31Yv2qpCUYRvVG06imhEu198Jnu9kIqXNm31PLvH7XMQB86KO97HK7peiCxiKpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730884; c=relaxed/simple;
	bh=IGlMLqT42xNNOp0ODzwgiqGNc2Hp7U8opvMrVoJgHUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwhS2EsKR8+fE43/uikNJFOTZJlYqWYCeroe25xzi92xv1p+whCAJP2jCJuuKyD1WzmDIi8xmJU0KkzACWejg0QfdGHp9+yIYAOwkxUXKoJPmyjpaejqivNKbOt414AxGkgFerGIpuHdB17Hpb1P4RI461d2WNKQlwUR5pMEHAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=satbWaZE; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="satbWaZE"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-86cdb34a56cso28806139f.3
        for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 05:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749730876; x=1750335676; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8bn0cm5WbpLPMdTw6LaFVooR1H1zspygg6frAPenZbI=;
        b=satbWaZESOvuMcGAV7qyZt9RzwwQXtZNWGm85AGMEuKNnbfCjFMjvXKcYZyE20Ae6H
         rCdKCDs5ijN7g0XHD3aOo0xke7rnCJKwp0L3jmiOYuBIn0WWOlzFs6GG2WcdoglgsHE5
         RBh+Hp6rjBT28flDObohQyUCWrdCDyjzOjc5SilIRUJno/cqLOjQqYUnrru7Fbb9HZQC
         9Anld05NqgrvnEFWz037NpneD+Ad3IRlzJmBpcaZYFQQ1MRSAyh/7iJqwtM3XhsZ1a51
         qiMo2JOrSGMQjILGDZ8iejlMYKi0Z4OHEs5A6YHq9Hu0kRMQLkMzwUBKqK6FO6EDgOYs
         HVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730876; x=1750335676;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8bn0cm5WbpLPMdTw6LaFVooR1H1zspygg6frAPenZbI=;
        b=q/1dJ1wyJj84zOOGE3MJwJ5E7M2q9MmecBjZimYt1vLg55ELVkgDdDG0WGy6xbTj+y
         lWt8DLTbmqmiG8Mx0G1HG8xOGU4Xh4mmq349YXT/LWejcM+A4IyBWqKH7LqGPca/2I7w
         P2qy2RCF3+mLGK9ubITkERej3+lz3Cx6F3z9Hzph5oEahDhZr14EcONXDBNWqT8Vo7k/
         +ChouqqOkEfUyuV4VnYhk2QoRAWm+A7jqj2EwyzmBTrrV5iMraImcLkRSHtOrSw8y/nl
         dF/WrOQeXPADv04FHpnJ3AYtnoqMWEU/VS4zIVZIm3GwFO9nHgMdLqnzbrTTdWZeMYwR
         n1vg==
X-Forwarded-Encrypted: i=1; AJvYcCW9sVyzDMIoxBIY8GtKnElzZ3SAGlp3FlK4XGhcu+NIRAADwJ6YaJasYAGJby57qv4oOu51x+Oln3PCKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ja/hgdOPRzuBDr9ugtrnfeN84xke3gvO277q/Vrr/SXDMa41
	FnOtGHXQAfnB8uKh6KGbqyuR13WVxe6clq2uU5XkDNJRmxA8qNw89x9iBtsdxfekzv0=
X-Gm-Gg: ASbGnctPgG1AZwDRiyNY0W2HLQ5HfpPfS6ls8cEcYeBhZUed9M1JVB4RviTk/Kij+Vs
	7/syGas0TdNdpCk4a/VJKrSMOFCT8ZULrhnRUvzKYxSNooexq0ZrEWHQs4aJRnlH1w/5CfV6kZ7
	x6OTakrBKB8h9GUyH7EJ8ry/bA0jBifKMbI/FhT1upt+CehbHbQfOaEBzycc82xcZO03LXPb1YI
	SDi4M8kmZXp30u/L1yTox6se7DgjYcFyKwuJTVGVXhF07bS92OW4DOQTbK/aUBAjfNAFHVMDZlN
	MrqcNqoDu0we4CkCJt1THXsTnjEibSkEMntF/vEUWt2FL5A5vrl5luopTPE=
X-Google-Smtp-Source: AGHT+IFWd8PFlCXIhUBE8jOLJn2I4s19fr9C0+OlX3upvmQMqGdbQR8Zhaz6SqEL7avEGDSYJnCLMQ==
X-Received: by 2002:a05:6602:3e8b:b0:873:de29:612f with SMTP id ca18e2360f4ac-875c7c7a799mr305325539f.3.1749730875898;
        Thu, 12 Jun 2025 05:21:15 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875c7f9d25esm33444939f.45.2025.06.12.05.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 05:21:15 -0700 (PDT)
Message-ID: <505e4900-b814-47cd-9572-c0172fa0d01e@kernel.dk>
Date: Thu, 12 Jun 2025 06:21:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: use plug request list tail for one-shot backmerge
 attempt
To: Christoph Hellwig <hch@infradead.org>
Cc: "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4856d1fc-543d-4622-9872-6ca66e8e7352@kernel.dk>
 <82020a7f-adbc-4b3e-8edd-99aba5172510@amazon.com>
 <f4ed489d-af31-4ca0-bfc1-a340034c61f5@kernel.dk>
 <aEpkIxvuTWgY5BnO@infradead.org>
 <045d300e-9b52-4ead-8664-2cea6354f5bf@kernel.dk>
 <aErAYSg6f10p_WJK@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aErAYSg6f10p_WJK@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/12/25 5:56 AM, Christoph Hellwig wrote:
> On Thu, Jun 12, 2025 at 05:49:16AM -0600, Jens Axboe wrote:
>>> Maybe byte the bullet and just make the request lists doubly linked?
>>> Unlike the bio memory usage for request should not be quite as
>>> critical.  Right now in my config the las cacheline in struct request
>>> only has a single 8 byte field anyway, so in practive we won't even
>>> bloat it.
>>
>> The space isn't a concern, as you found as well. It's the fact that
>> doubly linked lists suck in terms of needing to touch both prev
>> and next for removal.
> 
> But is that actually a concern here?  If you look at my patch we can
> now use the list_cut helper for the queue_rqs submission sorting,
> and for the actual submission we walk each request anyway (and might
> get along without removal entirely if we dare to leave the dangling
> pointers around).  The multi-queue dispatch could probably use the
> cut as well.  For the cached rqs and completion  we could st?ck to the
> singly linked list as they don't really mix up with the submission
> IFF that shows up as an issue there.

It's certainly going to make the cached handling more expensive, as the
doubly linked behavior there is just pointless. Generally LIFO behavior
there is preferable. I'd strongly suggest we use the doubly linked side
for dispatch, and retain singly linked for cached + completion. If not
I'm 100% sure we're going to be revisiting this again down the line, and
redo those parts yet again.

-- 
Jens Axboe
