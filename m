Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372FA224D7
	for <linux-block@vger.kernel.org>; Tue, 24 Sep 2024 13:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727183901; cv=none; b=lgRNRsXQMR2b9Go52k8HOGLbI2VPVtxieAt38IUR4vEEIaj2wusRwXH1yAaUKQpZP9tAVYkZCYQAoN0ybK3YITcsszqj0u+1JL4dmN/XjNq51y03b4V847vDxrkfbG6Iq/BZlh8AfrjzYz7k4TmYu3XwEmUopWyYU/Gi4DVR9bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727183901; c=relaxed/simple;
	bh=2W1qcd+rAhsS4Z7ThTZUSXYikPy/hxqcVOewFXmp7yo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=cfOXUkkEVzz2bl5rhBInzbE+VhI3WWc89FVoSrXJQTzkKBlVLvJlWVF660mVOws2QQsX8yOibdfRAfORY6BRtSy1y5v6MC/KVTVtN4oZV3zO0ZrYgSJXLfQ4i50sXxzSEgyM7ieHot8+mK26Y1ReX/mCfcH6Cc0BoEPeVKj49xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5ddd7cca.dip0.t-ipconnect.de [93.221.124.202])
	by mail.itouring.de (Postfix) with ESMTPSA id 5B55D124FD3;
	Tue, 24 Sep 2024 15:08:05 +0200 (CEST)
Received: from [192.168.100.223] (ragnarok.applied-asynchrony.com [192.168.100.223])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 75B63601926D8;
	Tue, 24 Sep 2024 15:08:04 +0200 (CEST)
Subject: Re: [PATCH] block: Prevent deadlocks when switching elevators
To: Jiri Slaby <jirislaby@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: "Richard W . M . Jones" <rjones@redhat.com>,
 Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
 Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20240908000704.414538-1-dlemoal@kernel.org>
 <e30fe828-0786-40d7-9da9-4f570d261542@kernel.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <47b98ddd-631a-4b49-811c-c0c1fd555d63@applied-asynchrony.com>
Date: Tue, 24 Sep 2024 15:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e30fe828-0786-40d7-9da9-4f570d261542@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 2024-09-24 12:46, Jiri Slaby wrote:
> this broke udev rules for loop in 6.11:
>  > loop1: /usr/lib/udev/rules.d/60-io-scheduler.rules:25 Failed to write ATTR{/sys/devices/virtual/block/loop1/queue/scheduler}="none", ignoring: No such file or directory

(etc.)

Patch here but it's not in mainline yet:

https://lore.kernel.org/linux-block/20240917133231.134806-1-dlemoal@kernel.org/

cheers
Holger
