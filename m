Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4D156F3F;
	Wed, 23 Oct 2024 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729676571; cv=none; b=fItZ6tFUGlqeBP52KllcDp7vHrQqG815g1y/02FMOH1MNPfMBHWeWTzfYGIfVEL36r9Bv38RuGdzi5/GHDHNNyWIj7gZTWb3mKe2l/rCPKcjoc2xGnjv3oAwYZQg6Vm6h1fK7IMQHxtruPFkKz9ppZq99CorfERb0bGLoZjUSyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729676571; c=relaxed/simple;
	bh=ZVO+m6dd2TbPk1D1NrHhok/pFrVC+SLZu4rcLUprNi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NC2KS5Hpu6Y0JKyyB20HZl74VAAA3u0D4/ukYPSFR1Mtt2hBpaKsuPCYCfQhHkmmipaoEjaEEqN6VoSutKKEo9iuDnR/FsC+Psk+6QxpHTEIH55h2Aft/SPpuLd4VasVHuR2UcmHvODqdmT7qJlPBTAfeKIqJU1kUqINlzs6TT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so426683a12.0;
        Wed, 23 Oct 2024 02:42:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676568; x=1730281368;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO4IKSBHt1Q1mT9S6U7vhhQdn4yhc4ey19Jpo4ZbbSM=;
        b=C50gzFk+Hs1aOMxhehCOgQ+D6gSDCY9/d659E4K7fqZQ0DMoWP+CHss9tUMVaVv7tM
         WEcFRQZFSpJ8yrLFN8aaM35wYcmeihV2vjXKkVJ+fTrTgqirKG0PDI2/pTu8Ux2c2og9
         E9e+TJpH+6gqfKjLvnPHxsyDl7alZumRvtpW5eGwD2ZYvzBfXIIQ4d22yrLiQmmTlBMi
         lZBpuYgmRuINn64TK3WvzLOesQd/Ia34yVy5DzffKu5pZ+9PVCFFoWdBLhUErt1WQ9GJ
         WAgEqe/NZEW05HtTMxpewr1sWzoDezxDTvOpi6nEMBilx4zRN5A/sDYspmK/H8l5EAGe
         qsQA==
X-Forwarded-Encrypted: i=1; AJvYcCXGyCArSvE6hUMkSDAw24qiBJKdXyv+QPH6qWKj7JgUuYLyMRL+0ZMMUBBwmSsudAbGx+J8+LyKZEGvgNCi@vger.kernel.org, AJvYcCXy/qbe3GAn6jHOKjUk7vWlivvTPyBF2ZK+dQGKBUUVDvuHQjQRJhA7TBAXOBaHReZ3Dsmpbsy3Cd9+wg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxtBL3qNeR3LafJrnKehLH+Qr/77IaztQRy0kBb2IxfscUgvUai
	jR7NRN3FHCSU3W9IEpF7MmC2P4xAs4rUFDLw2+5MYh4MtD1spvvcRoMwnA==
X-Google-Smtp-Source: AGHT+IEY9r0hhRI68S05Re1NMWBeDSLewD/olC9sdYV9K4kcHMpuA1lxmq2LKhabH/W4oqe0Yo2YEw==
X-Received: by 2002:a05:6402:1ec8:b0:5c8:a2b8:cab3 with SMTP id 4fb4d7f45d1cf-5cb8b4e5b8dmr2190463a12.4.1729676568263;
        Wed, 23 Oct 2024 02:42:48 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1d8sm4181729a12.72.2024.10.23.02.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:42:47 -0700 (PDT)
Message-ID: <1a948684-aa1a-46cb-a51b-e16b1da1c358@grimberg.me>
Date: Wed, 23 Oct 2024 12:42:46 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, zhuxiaohui <zhuxiaohui400@gmail.com>,
 axboe@kernel.dk, kbusch@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
 <Zxb8KaoUVstRCxiP@fedora> <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
 <20241023051914.GA1341@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241023051914.GA1341@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit




On 23/10/2024 8:19, Christoph Hellwig wrote:
> On Tue, Oct 22, 2024 at 04:23:29PM +0300, Sagi Grimberg wrote:
>> I agree. NVMe may have a unique need here, but it needs a tag from a
>> specific hctx while the context requesting it does not map according to
>> the hctx cpumap. It cannot use any other tag from any other hctx.
>>
>> The reason is that the connect for a queue must be done from a tag that
>> belongs to the queue because nvme relies on it when it does resolution back
>> to
>> the request to the completion.
> I wonder if we should byte the bullet and not use a request for the
> connect commands.  We've already special cased the AEN command because
> it was causing too many problems, and given all the pain so far connect
> might also have hit that treshold.

That would be trading one set of problems for another. We had some hard
times in the past to correctly fence AERs against controller states 
because it
is not a normal block request.

Plus, unlike AERs, connect has a timeout, which we'll need to take care 
of...

Not that it is not possible, I'd just like to avoid this option.
