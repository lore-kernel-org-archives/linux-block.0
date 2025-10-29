Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879F41AAC
	for <linux-block@vger.kernel.org>; Wed, 29 Oct 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755521; cv=none; b=HTWr63nNn3Wli6Wr2tZvhabF0AsjuAPNGRP+svREGsPhFzTy01qG+iheAZrJTurouBmyLF3Jim5Vc+RVlHIpEgXxjiGAOGm/d/ukBJiqSLlDoKQD9UNLaaLnYCqzMFwS1QLpG7jPuiK4HQPo9tdVKwiulgIJpmtgKoTOV7AMSwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755521; c=relaxed/simple;
	bh=U7/nFIvcOT9rzsCiTPlDzHt0Qm6kyb7Py7+4Mo6Qp7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVeTOB2ebpYgW2+y/6M3vNqXpLgflCvSNRY3tjKhaTneqw3XxVdfn14E9L1gtZbjetOLcW72P0tJuStFbY7Gqnt75GfdyzaMWxErE2VHlUBs3oabiyRacD//8uahTnOkGEn33H+Pm/Mndd6tWdO/kxf+1S0t/WV+QdNzQQ9+GX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=vVWqRPqE; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="vVWqRPqE"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cxXnp0MjFzm0yt7;
	Wed, 29 Oct 2025 16:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1761755516; x=1764347517; bh=NfepDtihiqA2vSkJgVHnrUSA
	S+7j1DTgQ97Cr72YIlw=; b=vVWqRPqEe7iN6wS1s9Wbbb4PXdin6vR8beSqvIf1
	HzaeEy6WP9bwrCsvkj+w23FZooDtu0IjQipi3defldG/cIyE28wm+4mMzEqkMGND
	kySrKuSjPBe2QJ+sAKxIpuGOhOpyxePMyeyVTl/9fNwgne1ngjd/92s0RiZwqTvW
	D5fUze0vwpkySvVYj5KOPKHlqRAWaI5PzYIgn2mB3rTn9IHqkaigQhwZUZWxXW9J
	S9aor/UfkB+Oqlg68TFBIwH7nF2GzE37ZzO7azCGVx37lGeBSQpjbiwAgEkQ2VBa
	WGtJbpTbUSZRJv6XDf588S9FRULve01vzHCqLJL62/cYvw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id fC_cHXx3ZC3o; Wed, 29 Oct 2025 16:31:56 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cxXnh65d4zm0yV6;
	Wed, 29 Oct 2025 16:31:52 +0000 (UTC)
Message-ID: <07b9a54e-a627-41ef-afa7-651bdeda0cbd@acm.org>
Date: Wed, 29 Oct 2025 09:31:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
To: Christoph Hellwig <hch@lst.de>, Martin Wilck <mwilck@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Benjamin Marzinski <bmarzins@redhat.com>, Hannes Reinecke <hare@suse.com>
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250703090906.GG4757@lst.de> <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
 <20250708095707.GA28737@lst.de>
 <b23c05be-2bde-424a-a275-811ccc01567c@acm.org> <20250710080341.GA8622@lst.de>
 <563ef9b02d49fa05418c7a1b0b384d898819e0e9.camel@suse.com>
 <20251029085810.GA32474@lst.de>
 <91b583c2fad9f1e72ed5dc794a709289de363a39.camel@suse.com>
 <20251029093833.GA1066@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251029093833.GA1066@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


On 10/29/25 2:38 AM, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 10:36:30AM +0100, Martin Wilck wrote:
>> Consider it a "trylock" type of operation, which is a valid method to
>> avoid deadlocks, AFAIK.
>=20
> Only if the operation is an optimistic optimization.  I don't see how
> setting an attribute would ever qualify =EF=AC=85or that.

Let's take a step back.

Before commit af2814149883 ("block: freeze the queue in
queue_attr_store") there was a risk that modifying a request queue
attribute while I/O is in flight would result in a malformed bio. Since
that commit a deadlock occurs if an attribute is modified for a
dm-multipath queue with I/O in flight and if queue_if_no_path has been
set.
How about introducing a new request queue flag that is set for=20
dm-multipath devices if queue_if_no_path devices has been set and only
calling blk_mq_freeze_queue_wait_timeout() instead of
blk_freeze_queue_start() if that flag has been set? That would solve the
deadlock for dm-multipath devices without affecting the request queue
sysfs attribute behavior for other block devices.

Thanks,

Bart.

