Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5863176EE;
	Wed, 23 Sep 2026 17:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183785; cv=none; b=MmEkdzC7mpft3bH5mZTSQtw7O6WbEGT3kgI0EFmFKVrsOteMiFELcoiJlK5Tv5ua26/BqnaaYcuCzkUHMSvXr4mZrYzL65s3jICIrCb5YoUJbxfdwXLpmmKQv5DgIslaooi/7Upa3u2X8ui5OTJ0TXECtcfrPzec+T4Bh3Fz7VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183785; c=relaxed/simple;
	bh=PInkPdm778tudGb0L+eeglwtwNJE/NIxl26jezR9lh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfSGFsZUASjGpjI8C9hXOExovITXuu2SXxx6kln5OAAtHBs8YmV68nWVM+xScsZNaMYgjCJy/y+h8GVPQFgWhu4XsZS4NTTcOlYzxWZfRUpd/G674k2SWuHS55cmZTgPbYY7SRWZ5xRLjjK+TsjgudSSzRjMCwcQXlFlXYkHUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MWS5cI4f; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MWS5cI4f"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hqkC55Tn4zlfvpH;
	Wed, 23 Sep 2026 17:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1790183770; x=1792775771; bh=gtmKrsBS2ZFYZO6zpc7l8lDV
	dmtntUkBhpd10++5hZo=; b=MWS5cI4fMlsJpTsA2bR623aEO26R1eX+opOAQY+j
	A+CZypWyjB8Dzb27KI1+o2LfNfWKFjIxCcByRwgLbV39SCpuf1p2ZlmA+4OClIiV
	CGrJYWIMdxYfi637lhzfJ059spt5Txj0RNP8pWZJzRnmYdPlVVWpouWNRY4+9NsZ
	olriukBuXmpZ2Clke2c3TZML63DjySiGUNtPnTIlpAUWe0jLSu/AtcWyVo0D68vM
	3MZ2XBGNou42lSuhnqINhsK2F52XQC1sWpdXQV3Wbyz1k2cb0Jh42aHWnzdcKvxe
	P6oY2A4WlimQlGUPjwWgDLh9sOAZ8vPkBsBTHj3W1w72RQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 79K4tq8AqOFX; Wed, 23 Sep 2026 17:16:10 +0000 (UTC)
Received: from [100.80.231.125] (unknown [104.135.182.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hqkBq5TMXzlfvpG;
	Wed, 23 Sep 2026 17:16:03 +0000 (UTC)
Message-ID: <910e4d78-9ffa-4e17-bb8f-d4dbc7d83774@acm.org>
Date: Wed, 23 Sep 2026 10:16:02 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] loop: Perform __loop_clr_fd() from post_release
 callback.
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Jan Kara <jack@suse.cz>, linux-block <linux-block@vger.kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Foster
 <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
 <1bced9b4-83df-4702-81ac-fc0c44baeeac@I-love.SAKURA.ne.jp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1bced9b4-83df-4702-81ac-fc0c44baeeac@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 10:10 PM, Tetsuo Handa wrote:
> +	struct task_struct	*rundown_owner;

This member variable probably should be renamed since the .rundown()
callback has been renamed into .post_release().

Thanks,

Bart.
