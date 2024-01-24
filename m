Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76277C083
	for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 15:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706108527; cv=none; b=kFYKEFaVssqalW9VSl9o54Wv83MAGOv8VecvWc0Z34kpS3Cf5S2cf9cnd3SlzFytgsA2InRNTayPEYwc3AB7HiyGKz5DyxovnTVUCwFzAApkSYXOkAcp8lPcBHvM21RgzcM7ct9fVDVSPbCyrF8tu6Pq70pIOKdFl2/EbP/YoBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706108527; c=relaxed/simple;
	bh=aallZxoqaNE3SlcXdAIyZYinMmQrJ0FLWRSgm6g2Rf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GrPOVgjxa5ZDdLo8g+SBQYZA+E5eu3ZNOQz5cGSVKet6XfqmkIAmaV/kRefFN++Tf0ap9ufUNHd9Ye/3KPjzwB6BYiGXw1YdMBskXIngUqO/xV27KVzFX0qTnReqpxfcmFChiehxh3Kfo61qLJodiaYmuNHXXQlFv7ILhIdd47U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pg1Iobx6; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pg1Iobx6"
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso69713439f.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jan 2024 07:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706108525; x=1706713325; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kyS0lgnYyWV5l1pekZ2Khi0MYTDj4jqoD270mL7E+Pw=;
        b=pg1Iobx6X0GnFUDM7/LpD4dgNAZRqP8cre5yI67CbdJ6ptg9Xricj7QspArKOAeS6L
         ZreyeIpGxNGwHEl3QSay2JyyyTr0ErqvxF6KA6PIWPvEmhxecYN/dmdyXHlIWQ/Sgx1s
         iFMOFMNaSOMpCgOkudsVjG6n9tNY0JaBqK7doI4rBffB3hN6aD4G9P7nVi8uH9AR5BUe
         YFpCJCZ5zo54l7o3bTnLvceyDCqvDby47bs048VFzNperZ310XBcttuq1A5J2atO6b12
         jLBUhcSXxQ3vfr3Z1Yk8NIsnjqnMpfL6CjG5maHLOO1gCdH3NYtrF3jucfvdRLo3eHvo
         IG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706108525; x=1706713325;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyS0lgnYyWV5l1pekZ2Khi0MYTDj4jqoD270mL7E+Pw=;
        b=Z7luZa3n1JYmrvjkFZL9s+7mqTZXquONOb83UqjeAsYKjcnmRmfk/uUSf7P841QgYl
         IR+2tZ2lQzfw6KkDu0l6qt6XqEviEH3hy8h3QLUCK/34w+SL+no0RvG68bC30iy6tbLr
         fxGx+CXQIog6D6b7nOYo0QvyIWZ7Wv08tzK4l7oRjjWD3CugKEAfkgFOxdXgnUHWdOGz
         qiFFzJuzX5uomrw6JZV6C/AlkMBPNtqdgLA9WEjWm3T6+GLLFPPaPsnU9Nb5hOZRU/y1
         Cdw7VApxne/UiBxvX3kpJ8tgRG2r/Ej8zHGWczZzMVPRlH+z8ZcNX+Fa+JJPCf/2dwFf
         MpjA==
X-Gm-Message-State: AOJu0YzrQ6g7M6RXvD1mlpHdLIaeFLoMxmnf0eda0mNJOfk7PlDmiFJE
	RRhmPXgzMPp2LnGinKMRqHDGRLR7lFAT7WXER1/QO1dUa99q5xG67MEQIBAaV7M=
X-Google-Smtp-Source: AGHT+IE/BbWTHgNTOyE4GxztW35AHuzAh1wQqoQt6yrKFE+Y3FM8yyccVyxWWo3qPG4SN5h9CUwrmw==
X-Received: by 2002:a92:c24a:0:b0:35f:b9ea:16dd with SMTP id k10-20020a92c24a000000b0035fb9ea16ddmr2920782ilo.0.1706108524614;
        Wed, 24 Jan 2024 07:02:04 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id j12-20020a056e02154c00b003627b70d918sm2353477ilu.66.2024.01.24.07.02.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 07:02:04 -0800 (PST)
Message-ID: <329f60e1-2021-4201-872d-da127d46ed0c@kernel.dk>
Date: Wed, 24 Jan 2024 08:02:03 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] block/mq-deadline: skip expensive merge lookups if
 contended
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org
References: <20240123174021.1967461-1-axboe@kernel.dk>
 <20240123174021.1967461-4-axboe@kernel.dk> <ZbDZLUDwA8ObY+9O@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbDZLUDwA8ObY+9O@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 2:32 AM, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 10:34:15AM -0700, Jens Axboe wrote:
>> We do several stages of merging in the block layer - the most likely one
>> to work is also the cheap one, merging direct in the per-task plug when
>> IO is submitted. Getting merges outside of that is a lot less likely,
>> but IO schedulers may still maintain internal data structures to
>> facilitate merge lookups outside of the plug.
>>
>> Make mq-deadline skip expensive merge lookups if the queue lock is
>> already contended. The likelihood of getting a merge here is not very
>> high, hence it should not be a problem skipping the attempt in the also
>> unlikely event that the queue is already contended.
> 
> I'm curious if you tried benchmarking just removing these extra
> merges entirely?

We've tried removing this many years ago, and the issue is generally
threadpools that do related IO and hence won't merge for those cases.
It's a pretty stupid case, but I'm willing to bet we'll get regressions
on rotational storage reported if we just skip it entirely.

Alternatively we could make it dependent on rotational or not, but seems
cleaner to me to just keep it generally enabled and just skip it if
we're contended.

-- 
Jens Axboe

