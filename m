Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A71CA80
	for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OGFeGQNd"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7bee9f626caso49308939f.0
        for <linux-block@vger.kernel.org>; Tue, 16 Jan 2024 08:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705421887; x=1706026687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IgCnhe//CqwXrORL5CxdgdvmaccHV7fgn8NA1YLhH4o=;
        b=OGFeGQNdAfI+P8WewrPuhZpXpVj/MaavFFoIA5nhJRFADw6Z6yFKdtJDx3sy0/nI4R
         3IZAa4QR1wcn+FmQRHStUVkE2EXyZXuxKX7En6cXGctgfD5evkncRACO8pOBG4UHOxmb
         10x0qqRSMLWV839K5y+gdAWSNh1yfxqiZKUlpxfv/rTerVU/Fj5FOM42bEI+begukybq
         4kf5v+6oX4kmCqKOEyANTwGYEB9E7yhB9eAwHnW9H53LOlmpJeJZzkw/RLYpTNC80VCs
         HkyFbx7Pqf5biVQB1JfB8xKxNvZVrXB7qMiWXiW4XLXylR9kQIYEWu2Ukkg6qypa82ej
         LNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705421887; x=1706026687;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgCnhe//CqwXrORL5CxdgdvmaccHV7fgn8NA1YLhH4o=;
        b=upA/UEcCERPoFcVwLUE8wR1rVi9U10Fm05E3NDgZSmjGEH96NqU4pVn2VmUcgxOckH
         U4RbiqBJ8A1ppAaQXgu2cIlppEo/HA7JDCZL0/kUBV1OY+RuV2x+OXIHdS4fqre6LnoH
         lBSdMqb4SRYjvOohoz/56w8QF7ABfn7T6RG/juAuep7qESurK01ochfxd5LqHsyiqxOf
         cfwK97f0RjDiIDgRK4qFjRf2/cn9iPsIxzzZQ2Zn0BipYfYjPThl4majX/HgMer7tUby
         rUzPHW96Qb7yHh6uCAg8cRWRGT2n6a3oJOF7nJkpMAq1Dxb9bP+OY9MXu+nTReoal9jO
         LHsQ==
X-Gm-Message-State: AOJu0Yyw60FEifa2m2AnGyhwXJ/vPHWSO0vQVIqn1JLg4NqFCoOFQoka
	eznE4qKf43OHNaIAJiMJmf2Vs3wpiwYlAw==
X-Google-Smtp-Source: AGHT+IH/l33VNC5fOqMlpY5pAQRUar7dZtjbhrcCrZm7ErV6upBOOVdU8QOaVxtA5FmJcs0lXL1ccQ==
X-Received: by 2002:a6b:c845:0:b0:7bc:2603:575f with SMTP id y66-20020a6bc845000000b007bc2603575fmr13945104iof.0.1705421887485;
        Tue, 16 Jan 2024 08:18:07 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q19-20020a02cf13000000b0046e9a5435a7sm457424jar.138.2024.01.16.08.18.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 08:18:06 -0800 (PST)
Message-ID: <977fd9a6-cba9-4c70-940c-9a5ce0caf189@kernel.dk>
Date: Tue, 16 Jan 2024 09:18:06 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] block: cache current nsec time in struct blk_plug
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org
References: <20240115215840.54432-1-axboe@kernel.dk>
 <20240115215840.54432-3-axboe@kernel.dk>
 <ZaarIH6-Elu2g3rL@kbusch-mbp.dhcp.thefacebook.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZaarIH6-Elu2g3rL@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 9:13 AM, Keith Busch wrote:
> On Mon, Jan 15, 2024 at 02:53:55PM -0700, Jens Axboe wrote:
>> If the block plug gets flushed, eg on preempt or schedule out, then
>> we invalidate the cached clock.
> 
> There must be something implicitly happening that I am missing. Where is
> the 'cur_time' cached clock invalidated on a plug flush?

It's not just yet, and it's also missing on preemption. I have those in
my current tree. The current test doesn't hit any of these, so it didn't
impact the testing.

-- 
Jens Axboe

