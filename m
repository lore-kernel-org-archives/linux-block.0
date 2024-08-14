Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A771B32D2
	for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644026; cv=none; b=L3GsXrXgD/75w8ClWqoLcU0qGokAe+MBkDky4Fa0UEjvwGixgrJJopl3DHFIEE5Gif9G6CtsOSMZ2S47E7nstioEijrueky8ujos00lxB4OTjBd58v2f9KfSrAEaPiV9tTaCvAA5m5QdLESZpjdT5LrrNlX3RGEW5S9myXn0it4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644026; c=relaxed/simple;
	bh=Rm/3lW+0YffOquvhbtAmA9ex5ArcP5gTJnxyJkmvq/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jbW6QjEkHhk0K4okNuxlysgVJblM0aVBcscbYRym+dztI4rAQVTKaz/ioz1sT/gF2KKvPWxRITv+ebPVP12XXeML0Q05QUadIulzEfDn/UgW7tGzx3zjFoEQXn13Ftkk9eO/PkHYCC416FnCxg4AtAxvbVgAxr/S8hg7gVEjRGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GPEMgoXs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GPEMgoXs"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-72703dd2b86so40413a12.1
        for <linux-block@vger.kernel.org>; Wed, 14 Aug 2024 07:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723644023; x=1724248823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=GPEMgoXsSmAEvWDQVhP2rFop9ZJNj/3fFNafVSOWaTwYSBOlJuKNzKXFQ9KwxG2bsL
         MczgC/FPJ8/gK9YONMDqMXYAhE9phmsVUK2C8Z5BQKKYipxOef2+wgIlXFjniDg1IccP
         kMNg5iFv6ARx+mU8XPwGQK9oFPTRIBbxadeHjetJ3Mxp+yZFsxMSiC8hUOkEEuoulVF0
         /qvVLc8bZk1RXo4s/y+YPWm1rokwlGI88+jTXLXqIgPq9tTjl8gWENDDSbLVyW0zOMuz
         JjLEgL4NKbq/X1de6faEUlJFErtODtoA9Z/t+6fKaEPDUExdBo9pt9n0/DLXbqppdYsN
         OKLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644023; x=1724248823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPPbcnH9ElDp0HrPGBFxxmp8KGuGyOIeFoZaRnlkCRk=;
        b=GYUPMM3VdeceGTXv14gs5GoZBkUNtEoxP2ENDFqM5ogNzY430gTMb3OI99tADp80pb
         pS0IXqB2oL1p7G7XhNOSN1E47ar+WF1PIWcvHjbU96VusIMmmddewh92uN0K1ShqPc3s
         1ecD3WLRClO7bgvsA2J5SfMFuNgXUVa2+xxBf0aEvVC1azWF0n7z1FrKmmg+asgNTCR6
         kw5rwsNSsDctFODe+XSFu8yYsfktk2w2Yj2B/YUv1fwnHeavcZfiL3waPH3Q4HhvFM9j
         fJ2x1z+x5OxMGj3bWtiOgFTDvrkESMue413YJBzr6PAEsAboCHZ4mdWLD5ebgDhZdcsq
         obyQ==
X-Gm-Message-State: AOJu0Yw4ScTOiDORrrYN3Uuam4bggVIVf2og3J8EC4UIQC/PtIs+1LY8
	cGCUEjTSqLzq7xDxdb9mQCe/pqhci5ZV5+KoSojBUqe+po/ac3vSfi63zS/TTsI=
X-Google-Smtp-Source: AGHT+IFej6G9ENKms8sCLz4PlMZguobfmGkOJPwW8ux5QRbbPWvSalJ7KlkeiZXZ2VIdS4yhHVtNqA==
X-Received: by 2002:a05:6a00:3915:b0:704:173c:5111 with SMTP id d2e1a72fcca58-712673ee118mr2053455b3a.3.1723644022755;
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e58a0b5dsm7350482b3a.47.2024.08.14.07.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 07:00:22 -0700 (PDT)
Message-ID: <0f19dd9a-e2fd-4221-aaf5-bafc516f9c32@kernel.dk>
Date: Wed, 14 Aug 2024 08:00:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] softirq: remove parameter from action callback
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
References: <20240813233202.2836511-1-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240813233202.2836511-1-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/13/24 5:31 PM, Caleb Sander Mateos wrote:
> When softirq actions are called, they are passed a pointer to the
> entry in the softirq_vec table containing the action's function pointer.
> This pointer isn't very useful, as the action callback already knows
> what function it is. And since each callback handles a specific softirq,
> the callback also knows which softirq number is running.
> 
> No softirq action callbacks actually use this parameter,
> so remove it from the function pointer signature.
> This clarifies that softirq actions are global routines
> and makes it slightly cheaper to call them.

Commit message should use ~72 char line lengths, but outside of that:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

