Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E8327A15;
	Tue, 23 Sep 2025 16:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758645021; cv=none; b=c8HWKoGzvAqNg0XyopoOEeKI57Rz4UM/2h3BRS3jmpJQthYof68hgWjXkscfBSQ2GrNhhNYcU/J5mA/OapFVTAXNEZVQjYO5oDwBzq+6u3Kto3fty7EWciVLJli8XmHVARY3JwhIk9UxLbNoUXsW2gFQWFSuI/JtSgRO/OlKWEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758645021; c=relaxed/simple;
	bh=xxlfqxGVzmOevvcQOd7sSEOgVs7jyDvb/Tj8lHcCIeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sy1vO+GbutR9/7K1TpHfjAc8deKO73pLFTazFbrh0gBoYNXeytUG5U+tdCNYajNdW5Y89p7/IZKaVyUAEg4UVuSVVXIqPyWzzPub2FT+E+HETrx22REGEYZ7xMDV0wXdT06W7ORhddZb0Nt6d+sm7PP3CS/Kd1bGOd4j2ja0f0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yOTZEw1I; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yOTZEw1I"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cWQSV1HyBzlgqVZ;
	Tue, 23 Sep 2025 16:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1758645016; x=1761237017; bh=y99uiFJpTg3J4KVIyd3kcbAn
	72jmKkYosX7Y/88AOVc=; b=yOTZEw1IonbK6S4YQu8OWISBLAJhhYSP/5b1yztt
	FENOZVRUHQYT3DFTrdQIFpH0G4xhr6eV90/OGPXWQk3Lm6nUcLhrwnvNgnb4H8zx
	LrFNE31WMK/0aRLQVMgcYZWhjhH/PBoMUMW/StiIQ5FxnObg0GLyRu4wLVmoDPgk
	iblmp101VvAayHANSSGUBWU9+ycDBnnM0tP7ifpBUlD8M24UNbp1TbsQA8qTJOS/
	oSgRSYO6d4KyumKliD+qVt8L8H6X620qP043WBF44DZRNQndVYAsEk93+CmZ2vYk
	h//10Nm4QGas9Q/F5equAPpNER4B6a+26Wz8eDMlMPqd1Q==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PM0XBfolZEbQ; Tue, 23 Sep 2025 16:30:16 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cWQSC4mDZzlgqV6;
	Tue, 23 Sep 2025 16:30:01 +0000 (UTC)
Message-ID: <31091c95-1d0c-4e5a-a53b-929529bf0996@acm.org>
Date: Tue, 23 Sep 2025 09:30:00 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] driver: loop: introduce synchronized read for loop
 driver
To: Zhaoyang Huang <huangzhaoyang@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Jens Axboe
 <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 steve.kang@unisoc.com, Minchan Kim <minchan@kernel.org>
References: <20250922032915.3924368-1-zhaoyang.huang@unisoc.com>
 <aNGQ66CD9F82BFP-@infradead.org>
 <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CAGWkznGf1eN-iszG21jGNq13C9yz8S0PW03hLc40Gjhn6LRp0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/25 8:50 PM, Zhaoyang Huang wrote:
> Yes, we have tried to solve this case from the above perspective. As
> to the scheduler, packing small tasks to one core(Big core in ARM)
> instead of spreading them is desired for power-saving reasons. To the
> number of kworker threads, it is upon current design which will create
> new work for each blkcg. According to ANDROID's current approach, each
> PID takes one cgroup and correspondingly a kworker thread which
> actually induces this scenario.

More cgroups means more overhead from cgroup-internal tasks, e.g.
accumulating statistics. How about requesting to the Android core team
to review the approach of associating one cgroup with each PID? I'm 
wondering whether the approach of one cgroup per aggregate profile
(SCHED_SP_BACKGROUND, SCHED_SP_FOREGROUND, ...) would work.

Thanks,

Bart.
