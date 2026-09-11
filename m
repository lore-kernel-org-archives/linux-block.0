Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD5581228;
	Fri, 11 Sep 2026 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156517; cv=none; b=ljTrGdV8GFbz0LAlGDTY4EcWSt+GSyLsB//Y+JZKD6gdL7zmIbru9uQXCNtCmBcoX8bhH/hNTeXl9oYc7pQcQTQ1sXMwUmJcFeqSU5v5ggZ1W3HSaV9QbHb3me6vzSvv1mMMVQHF+lExutB2HkAU+Iwi8u8po99rsKxCOMpqaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156517; c=relaxed/simple;
	bh=09s0xLo9h2jVNXpQUbY4URcgMTLAKOH2UTphI9oQS5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR2OP5M/evOMKF8kSymBoJ/gR0qCTANuJKTiDuItwg1eTQLEl7s7oRqotoYnJRHySldZygiD/KHzhcRblIUESft65o2K8QV6w8qOp/wmDV8Z4qIvuEm32WRZJpqqy6AjajgTGD5mybvKb1hTrp/b2gP2snoboFRMgT/mHSKNKVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=W51aZQL7; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="W51aZQL7"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hhQHq6dwYzlfwJB;
	Fri, 11 Sep 2026 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1789156496; x=1791748497; bh=YOARSHJ8h/e0o2lCn0yEPcfX
	8dp5ATQOgjjDSqnExU0=; b=W51aZQL7NBFZnhjrf/R2yA/yYk8KdiBorDVzu6LV
	QE3iPh5OcZN8iY8GpGu+wk/OVWLEIa04uqAdKO3B7uGEjRwdT/Ff2LEdqZheuNjN
	X+bld6DCNK+36jiDVXZ3MKmOa0cTif1sHvWqrmRAdaRDP6QZcTG9+N/fk8ho5Dtz
	f2JC5t2vd7fapW2RMifXhH9KBK3xILmsC103tzMz3vvcnEJ/TbEchMWDfsBPM3AH
	ics11KanNCBw8zJncyR2uXaJwuI4KRcl97vPIjc5adSPE5kQo5tsmRHvsY53GNzL
	/8uVLS6agrXjCID69grvMS/QtG5SMhz1+prlRA1ZagL7Fw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fcqIHsJC0qS2; Fri, 11 Sep 2026 19:54:56 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hhQHc0P07zlfvqM;
	Fri, 11 Sep 2026 19:54:51 +0000 (UTC)
Message-ID: <3fceb17e-35f5-4275-bfa5-f1a018c732c9@acm.org>
Date: Fri, 11 Sep 2026 12:54:51 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Add post_release() operation
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 linux-block <linux-block@vger.kernel.org>, rust-for-linux@vger.kernel.org
References: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <60bf7af2-b84e-4056-9195-a26ad51ada46@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/26 3:48 AM, Tetsuo Handa wrote:
>   	int (*alternative_gpt_sector)(struct gendisk *disk, sector_t *sector);
> +	/*
> +	 * Called after disk->open_mutex is released in the bdev_release() path.
> +	 * Used by loop devices that need to perform synchronization without
> +	 * holding disk->open_mutex. This operation has to be idempotent.
> +	 */
> +	void (*post_release)(struct gendisk *disk);

Instead of referring to bdev_release(), which is not in the public API,
the above comment should mention that .post_release() is called after 
.release(). The above comment should also mention that .post_release()
implementations may sleep.

Additionally, why is .post_release() added at the end instead of just
under .release()?

Otherwise this patch looks good to me.

Thanks,

Bart.
