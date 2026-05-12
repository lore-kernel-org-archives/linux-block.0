Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606223D45CB;
	Tue, 12 May 2026 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607472; cv=none; b=KI1kKPu66qOym1kySLuMmrB8Cmm7vs4tMY+SiUMz9aJmqf0jrR8BBLYyGDwg4O3qYVdKHdWFlm1jCjn1o2esIK81hazt1az638ngT1aYNsdu4K94pvpPhFHBHrd1F3/0Hk60cSB20XiedrQwTEHa0tleUg94NBR0aW5vTUCQYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607472; c=relaxed/simple;
	bh=SfLW2oIpUw03aTO5iZJdt8SAZdCGgrQt7e5x0azW2GY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1nu9NZyg57pEYG79HnhZg4trIgI1zXHqTthEQ3I309d0vl3qL3hwyXwMZmoUxWmko9RAn6y1RpmKflemDqroJPU6yovlcJnlKvMB3AEueG2ZcGjJ1SD21lN+uF2JrqYrPQSZOFVCM7HhvmW9OTR1KOUraaSTholWuYI5odxQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=std5bWuR; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="std5bWuR"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gFP1j3RfkzlgqsJ;
	Tue, 12 May 2026 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778607459; x=1781199460; bh=NrqhSJnT4qTcj1WPsQDcAvv5
	PX774py0G/DOjV2QwJo=; b=std5bWuRcsIzL6nLYUKvBxFQM0DNAk9KjXXwHz+s
	5sgnzVwzagMjm0g4eulfHOdA2vhgz1NOxWQX8+Ah7gMSKcz3dEYMGiq4jFD18CEt
	HhrC03OADWb2SBRDvaxbfx0NWWpfPacbIhvOzj7NG1F412bY+oFR2Nqi8rp20bKD
	L7qML2T4exGGb60X9xN3kBoAj/FFlnCAxvPGb99RsTuJkBApm0L6A6w/QJpkLKp4
	V6ywsIbdwV0wXgXn3m5fR/ehG4/tfCB9iK6+Vem8Ie8j6acIgEDxPJKh4G17RrVM
	tIXQZ87f8nyvX278Rw9gQAjSzOk/m4eOVWM5tW8HSe3D1A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 7S3oCHixwdtk; Tue, 12 May 2026 17:37:39 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gFP1T5v68zlfwHM;
	Tue, 12 May 2026 17:37:33 +0000 (UTC)
Message-ID: <bdb6a81e-2ef9-4425-949e-11ad4b6f452f@acm.org>
Date: Tue, 12 May 2026 10:37:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] block/blk-mq: use atomic_t for quiesce_depth to
 avoid lock contention on RT
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 axboe@kernel.dk, linux-block@vger.kernel.org
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 ming.lei@redhat.com, muchun.song@linux.dev, mkhalfella@purestorage.com,
 chris.friesen@windriver.com, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-rt-users@vger.kernel.org,
 stable@vger.kernel.org, ionut_n2001@yahoo.com, sunlightlinux@gmail.com
References: <20260512062815.10815-1-ionut.nechita@windriver.com>
 <20260512062815.10815-2-ionut.nechita@windriver.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260512062815.10815-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 11:28 PM, Ionut Nechita (Wind River) wrote:
> Performance on the RT kernel and the hardware above:
>   - Before: 153 MB/s, IRQ threads in D-state on q->queue_lock
>   - After:  640 MB/s, no IRQ threads blocked

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
