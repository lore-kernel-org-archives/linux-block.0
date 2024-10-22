Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E7019ABD5;
	Tue, 22 Oct 2024 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729603415; cv=none; b=hNF/aR8dNsafh7JSzCCCUeWgIazXKZYEUz/BNMGlO6YsjoXo7dU4HbbO3XIbuEDABijfSme2deSm7lbdA1zmBcHfmiqdosQmgiSUH8yVFuWPHEWLCxup3aqT8nIrMjcHd/RnTBuHzZytuKw6zEme8hGbQfdAU2buo/Zj8dmHEws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729603415; c=relaxed/simple;
	bh=EBBcu3Jy1dsTafAyGkwzDqbaieu6rHDVpF1F9KQZ0+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhrGkBHVowEGbm5kgE0nnJrK+fOdYguwFZsGmFcQqvdo0xy0PPXdTtt1WoBYBKR/kkYM2LTLu3O2DKpQ53OUI7lZRE6OgAE8lcFeNYzmSL6Vi8tUQ025ZFEemze+LoVZpJ3jOXpXZKYuB+dX+F59QIWa1V6Yl3P6YLbitJ4cqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so66343955e9.2;
        Tue, 22 Oct 2024 06:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729603411; x=1730208211;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=doI9dnYU9khV/lZLroP8Aji2iy4gTFD49z/1DNwsnjU=;
        b=u+76FGoaVylwOfqe30IeHuAK+7jQew5TA4FnfiiGMhSpRgrcSsmqMDlQJODT9bY3L4
         0MKETsI8Up2JpzuTNn5D6PkDOtMGxCXF4VWzVUp75Z18G5s6wblx3+SLP9oGtOoFudfI
         pB8Mh4taVwvukI0g0gNARXvNcdJP4Djs60fAyY692UJjmc4kLrw9UMqBfjaCV+Ogkih0
         J+ilvJ9jE/STEdEun2hrx/ekpRsAxReRCuqvGBbc7BiINaGSSzxDsazH/2yokKpxPiJ4
         3wN1VyjRz9R7O7aBp7Hl5oLAKTvpAb6aCpes5+YXiGxSNliYsTAelam3ggEjOu4+z6v6
         I3wg==
X-Forwarded-Encrypted: i=1; AJvYcCWT1gWAPg9ZPVRcfyaOI7ZJhXUsyIlmlO1wvhzASZaVjom6ZlL2So82PG8yqn21Vu2gK1iL8kl1KHhLkw==@vger.kernel.org, AJvYcCXMba6UPVBLiYd/Ulvjtq+HZtAENjHiP4BQ3FaXaQpQmz9i6azZ/QCPIvhsmx9QvZU+0Y2eNwIEkJxzji/W@vger.kernel.org
X-Gm-Message-State: AOJu0YxelOFNfhy8pIfx3qs+ekRbqoLkj/1JgdNr3DsUgEoT76+qoJVi
	3gEokO2AQBlMuK4PotSc8UVl3h9pAGrwt4WccugfdnxB4Sm5Py6X
X-Google-Smtp-Source: AGHT+IFtfcGtHriiS8qJidjpGvb1I0KhqA5oCBvkMBNtAdG2Qej7SWHcMOpQCTXGIcwwPTdSMBhvJQ==
X-Received: by 2002:a05:600c:5118:b0:431:604d:b22 with SMTP id 5b1f17b1804b1-4316163bcbdmr184358845e9.16.1729603411208;
        Tue, 22 Oct 2024 06:23:31 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a4856fsm6625100f8f.33.2024.10.22.06.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 06:23:30 -0700 (PDT)
Message-ID: <fe49daac-5990-464a-aeeb-c7c5f9d4d156@grimberg.me>
Date: Tue, 22 Oct 2024 16:23:29 +0300
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] blk-mq: add one blk_mq_req_flags_t type to support mq
 ctx fallback
To: Ming Lei <ming.lei@redhat.com>
Cc: zhuxiaohui <zhuxiaohui400@gmail.com>, axboe@kernel.dk, kbusch@kernel.org,
 hch@lst.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Zhu Xiaohui <zhuxiaohui.400@bytedance.com>
References: <20241020144041.15953-1-zhuxiaohui.400@bytedance.com>
 <ZxWwvF0Er-Aj-rtX@fedora> <064a6fb0-0cdb-4634-863d-a06574fcc0fa@grimberg.me>
 <ZxYRXvyxzlFP_NPl@fedora> <ab2ed574-5fb8-49d9-b6f3-5030566fc64a@grimberg.me>
 <ZxZm5HcsGCYoQ6Mv@fedora> <6edb988e-2ec0-49b4-b859-e8346137ba68@grimberg.me>
 <Zxb8KaoUVstRCxiP@fedora>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Zxb8KaoUVstRCxiP@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>
>>> It is just lucky for connection request because IO isn't started
>>> yet at that time, and the allocation always succeeds in the 1st try of
>>> __blk_mq_get_tag().
>> It's not lucky, we reserve a per-queue tag for exactly this flow (connect)
>> so we
>> always have one available. And when the connect is running, the driver
>> should
>> guarantee nothing else is running.
> What if there is multiple concurrent allocation(reserve) requests?

There can't be none.

>   You still
> may run into allocation from other hw queue. In reality, nvme may don't
> use in that way, but as one API, it is still not good, or at least the
> behavior should be documented.

I agree. NVMe may have a unique need here, but it needs a tag from a
specific hctx while the context requesting it does not map according to
the hctx cpumap. It cannot use any other tag from any other hctx.

The reason is that the connect for a queue must be done from a tag that
belongs to the queue because nvme relies on it when it does resolution 
back to
the request to the completion.
