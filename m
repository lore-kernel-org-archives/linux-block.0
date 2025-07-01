Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAF288CC;
	Tue,  1 Jul 2025 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751334649; cv=none; b=GQ83pmyK37rz2SUtQJZNQhK71ET/E/hU8xVGyW4xe7S+f4Fhl2Y1EQXgNHXI9tRYFY1xFHLefBjCl5Jg77mwL7o3rhnChYHjHbCzhARosk7rqvIk8l8eYvckgcoFckzHL8QsgXQe4DrRUHUEkUB/B28FNvBwGr6d2IrhIgxN4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751334649; c=relaxed/simple;
	bh=uOn/E/NMWNFcIAAoPEqqSMz59V68QnU2eWW+KmUzTBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBa9NjkZICTS8fE3f1CRtWRh+PH9/uUlKF/GWW8UO/zs/4xFpMnplHYjynOXm6P9gPBBRTi+GxbhxbBCkpOxlv9DsmV69xAol9dOo5FVFL5KDHk0hEyJSRBq26MoKcxBkCtF2qzwpA1gpRXtP/tuU+l4g0f92l2dhsUj0Nax558=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TgBw6gR3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TgBw6gR3"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4bWQwP4HDhzm0yVH;
	Tue,  1 Jul 2025 01:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751334644; x=1753926645; bh=7W+SjNuCJvOiuB21TNN2tfZs
	8/SeweAQf/piHsn0V3s=; b=TgBw6gR3bLH2BnnJ5r9uzcycaPGVhXHLhPpuNLqe
	KHpLMVEt+TzlQkvmXlBqHhj0JIK5PAN8/ctxlRNvDQSCMfElCcKWokFfTlLcENFv
	xOjBPI9DBOqvSGqjOZQM+s9QtItLUsIvA+9e3yaxpBSXK+QY8BS5HLL0KzoeJr9P
	N/XeVuvLXiSswhDMKWsaa4thmJxc7058L3RmVYVuFvm19gYJfBcM8Nh1CGdIa5EO
	qhmY+n0ElARe3VJJM1d527PBfLS8GNXoPkFizMvovRXMR7xiQoGjJw62HvpOfvbF
	3hbPb+winTcOKy1+G1gtGSXUwQl+f+GCI2u42OxDvQwngw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rYuGXe6yn3M7; Tue,  1 Jul 2025 01:50:44 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4bWQwH0QNwzm0yTL;
	Tue,  1 Jul 2025 01:50:38 +0000 (UTC)
Message-ID: <ef79ab48-f047-4f7d-a6f9-25dcc275126b@acm.org>
Date: Mon, 30 Jun 2025 18:50:37 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Fix a deadlock related to modifying the
 readahead attribute
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Nilay Shroff <nilay@linux.ibm.com>,
 stable@vger.kernel.org
References: <20250626203713.2258558-1-bvanassche@acm.org>
 <20250627071702.GA992@lst.de> <d03ccb5c-f44c-40e7-9964-2e9ec67bb96f@acm.org>
 <aGMvCXklxJ_rlZOM@kbusch-mbp>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aGMvCXklxJ_rlZOM@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 5:42 PM, Keith Busch wrote:
> On Mon, Jun 30, 2025 at 03:39:18PM -0700, Bart Van Assche wrote:
>> On 6/27/25 12:17 AM, Christoph Hellwig wrote:
>>> Well, if there are queued never completed bios the freeze will obviously
>>> fail.  I don't see how this freeze is special vs other freezes or other
>>> attributes that freeze.
>>
>> Hi Christoph,
>>
>> Do you perhaps want me to remove the freeze/unfreeze calls from all
>> sysfs store callbacks from which it is safe to remove these callbacks?
> 
> But don't the remaining attributes that are not safe remain susceptible
> to this deadlock?

For the remaining sysfs attributes the deadlock can be solved by
letting the blk_mq_freeze_queue() call by the sysfs store methods time
out if that call takes too long or by making that call interruptible by
signals like Ctrl-C. I think its better to let functions like
queue_requests_store() fail if an attempt to freeze a request
queue takes longer than it should rather than to trigger a kernel
deadlock.

Bart.
