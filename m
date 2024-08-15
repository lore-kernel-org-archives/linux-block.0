Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29641C64
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 17:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723743343; cv=none; b=XAVqJaOq1Ep8lLRt/X+4K51H2m62slLbTGdq/RdV/W+qSDz3eGlpZTsouq3GcTgVauP8WnOl83KS5NdY8Ypwk6YRAcmzRaocdePrUbJS2hvdXDpWDhh7/XGN1NtLwFAPBIVFAYH2lEteq4dXu7Yr/11a/PvtaexKY7L/gdC/TJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723743343; c=relaxed/simple;
	bh=yTQ3x9UK8HBDNuDJlzJOqJNNTmm6uXlvMqRj0y1jNzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTCJZRM6G0FBCVQ5gCEgrbBTme8uCQ6cZeIVZUDVeiMw4C67R3eGKIthfav1zZHCFmM9htStCe63yxLS7Hu+PE8Ep7Y4rMM9zikUZjFd3mwnh1r2DtzottZK5uinzpCKZ1TAC6Lrm1sHvfdrOQZSmFlR7IdpmmZvqGZcpCpeu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2fk/tckh; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2fk/tckh"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81fdf584985so4375039f.1
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723743341; x=1724348141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=2fk/tckhwHrgEPxypfU57kGwGU79+ji1zWxkBnG+t2cczJnyCfZy2W4Ojwn4f0/U5d
         VM9DJIx0d5RN7w4CcgODgkQ18seVXLstHSfsAaQUZS5zw6gdQVr+xcbgCjqKKGKiNcAw
         V5fALKlo/YAEE8ho6hnBvhlYY2coj1fgdHzzwzxBokTNwTGTXCgu/WwJh0Eicsdlcuum
         wQ1nrNXo7Igvh42zh3LcplUcxH5V0gBzIYMHvVa0sI96Ok/iCwv1m97AjBujczK2UJ8Q
         xdICV1pLGQym7JPgWs14OXr8QPjZNKqPZhjgkfKL7rNkSdqVqv1WxnnyQh03ZPCYlkQw
         BsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723743341; x=1724348141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2U1MzKHB39OLu5TW/dEOIFFTFZ/Iz79ypoKHI4vCvHs=;
        b=U54/D4qk18zICkE2CzSXDigJqB2oBWbRaysS7BX0bCmkPbfxNOiz3Tw7dw0qaKkFDs
         7uMYc1k+ZQb7lpOAAyRp7Ze+bi4LzY5k7MqKCdc1kDBaGlLFjlzix2Ystnj/seOs+GN1
         MCqCvP0o2UWO2ClvG5TD2C2GSGGokuZJn56gMSJe2wjGr4fU3Py1KZVgFu//bBgK3NJO
         moIh9FL1kSIdjnsjtS4Nmen6yOIfNm+YVcmYS6zv4DSyBnYuFn06lFHJThJovjzG56Aj
         CTtDUxd9ulf6MwjSlEOs7LqXFY6UNtHqQB+Ne1YaGk5p4r4lS5R1VhqsNrgv5zvxai63
         Vr1Q==
X-Gm-Message-State: AOJu0Yw3/whFmtx9v16pKLz/adVWuEU5l+Re5YCmlU6IFCYOE2cLOWND
	O9bMOJ7K7X80NoD3DCmJ2h9CfMPP5Skt6ScWMVCAm0dXH3KRJoIfyBbn8M0ov5I=
X-Google-Smtp-Source: AGHT+IE5ACwMUbOKC8B7NJcnH44RVQzKIjxHde1N8h+vFIG7O/NuCcv1jNns9/9MwYQlU/mxJD+4BA==
X-Received: by 2002:a5d:9f4d:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-824f26e3004mr33789339f.2.1723743340509;
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e9395csm617646173.38.2024.08.15.10.35.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 10:35:40 -0700 (PDT)
Message-ID: <8db12b3d-08f7-4c3e-a403-177285b0bcec@kernel.dk>
Date: Thu, 15 Aug 2024 11:35:38 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] softirq: remove parameter from action callback
To: Caleb Sander Mateos <csander@purestorage.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Uladzislau Rezki <urezki@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, netdev@vger.kernel.org
References: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
 <20240815171549.3260003-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240815171549.3260003-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 11:15 AM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the entry
> in the softirq_vec table containing the action's function pointer. This
> pointer isn't very useful, as the action callback already knows what
> function it is. And since each callback handles a specific softirq, the
> callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter, so remove it
> from the function pointer signature. This clarifies that softirq actions
> are global routines and makes it slightly cheaper to call them.
> 
> v2: use full 72 characters in commit description lines, add Reviewed-by

No need to resend because of it, but the changelog bits go below the ---
line, not in the commit message. Whoever applies can just take care of
that.

-- 
Jens Axboe

