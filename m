Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C82027442
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579125; cv=none; b=g3hw28iUkDX9LLY6TSNgjLLq29vGv6zrL7q/emAkOjOJ32+/gJo7nFPp11HvRzJKqd2tRvvd0IIVk3JMqEN/WBE85Lz5+BWF4vB/WvwgE5Bnnl4maLTOtBCxFeukeychz0VzBEavaOiWGZu6VpevHzqbBzWcjK+ihdrxzm4hDTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579125; c=relaxed/simple;
	bh=MBr1kV/JyKxZB4xGbeaAR/Yln+V99hFUWfEaFVoE1MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fubEhOK8e725VU0LziI23+2ZVNOLExXUwaMNwVOfGLjt/PCYMohfjvQBtbA/G6Ix64IoQ28o1Qm9F02cjhY6wTCjrlAU7tStQpIZ+QH7Q9BP3zgQ6Zme92OpxzJlvxBr/YeMsmD97eWkEaeRZSTAgbZr+gWJboZpEqGIGse0wA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpjZZv15; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpjZZv15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38180C4CECD;
	Tue, 17 Sep 2024 13:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726579125;
	bh=MBr1kV/JyKxZB4xGbeaAR/Yln+V99hFUWfEaFVoE1MY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BpjZZv15yne2pYuL7nzCE01Wlg2ml1ZtAR1Sohj3hCs2wCzbuudG6J32hUE32wcQM
	 Q/0jEK7Ad5OjaRIydpJilEvB5UgVvhAj7UY3jVrkIxJ/UsaAlfrvbGDyaPRipS0EDS
	 JAyZ8EFtF9o/V4PPkUrxR9u4Ty9ylLp7M20+isNvqRVP4zEp+BS/Upyrgd8jfK2huw
	 XfsHZVfRNFh6akh9Y4AIW1VJiFyYqDkX/qxTndCRDx5XZLcd6Gjt/b2YokCq1xWafe
	 ppyVZXuCEglIPnFGoLPoVsmCGd6UhJCP3xoADi79X7H4BI5l/JoFLvwLicTWiOS+Lw
	 LfF6mV6SZeIBA==
Message-ID: <3a93a3ac-18d3-4031-ba16-ce172d10e7f4@kernel.org>
Date: Tue, 17 Sep 2024 15:18:41 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20240917053258.128827-1-dlemoal@kernel.org>
 <20240917055331.GA2432@lst.de>
 <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
 <5ff26f49-dea6-4667-ae90-7b61908f67cf@kernel.org> <Zul97FvBsVuC1_h3@fedora>
 <20240917130518.GA32184@lst.de>
 <274ec9f3-b8b2-4a0a-bb13-f3705ddc349f@kernel.dk>
 <20240917131450.GA367@lst.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240917131450.GA367@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/09/17 15:14, Christoph Hellwig wrote:
> On Tue, Sep 17, 2024 at 07:11:22AM -0600, Jens Axboe wrote:
>> Whatever reshuffling people have in mind, that needs to happen AFTER
>> this bug is sorted out.
> 
> Yes.  The fix from Damien will work, but reverting to the old behavior
> of ignoring the request_module return value feel much better.  I can
> prepare a patch, but I didn't want to steal the credits from Damien.
> 

OK. I can send a v2 ignoring the request_module() result, as it was before.

-- 
Damien Le Moal
Western Digital Research

