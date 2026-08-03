Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0A841D11A
	for <linux-block@vger.kernel.org>; Mon,  3 Aug 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778927; cv=none; b=ZVPcvCgJj7uso6t9sAZtjRZ0T6U3/buvEhhWsmYRietvIv9zH61Dl2AUy58OUc41stMm5Jh/394Ak9GRudq2dLp9U46f28KyAQ8MgecjtObGfr+8qKZSkTqbr+MOXFMtdsP1s/kfEw6c0QsuJDcHOCHMi6bduco0DsYfagQcRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778927; c=relaxed/simple;
	bh=dpN3l4JLoy1FBj5WEKqYwz7/8FHMs1PtgDX13sLBQUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KtOJzhE2tPCfxCWXmkfnCLPoD1TiUf4GxsPTKyf2rMPMwwHOeJj8p9ZuD/QEImDxlZFLn6NVTfvJbX0k9w/e6sJF2fSbs3EB3R7cRDl/Epqr0MBHV3eLDrCvHUDG1pVahjSXGp/wQx/VwADIvJEL4deYjbk1t9NKiRUEjojl8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=x4rz/KJX; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="x4rz/KJX"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4hDPBP6fySz1XM5kY;
	Mon,  3 Aug 2026 17:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1785778922; x=1788370923; bh=R9RFLs9r3E05cNEfDTlqgzTi
	CVbH0BkGfuyQg4f8Rtk=; b=x4rz/KJX3/5HjQxlXEUP9ipdd4tIYcE+rHqDxZ10
	dNmB5BrPMyRkJexRI7uDgGWshK3HP5yqPU02O/q3a9dCSZHBROHueaueFzj3vfJR
	P87kZdzEWomAthDLWm/FPhN/IhfbNvkD4uUjeZvUS6KIpaHyfSMnfhIgbw+Hpn+x
	f4uMgYKNaXUmCv0I71oXS0LIUWmDZV0oookvoQg2E/CGt+5BznnFBm64W377tasM
	rW51a01i/srR2v3VsfE0teLAW1/Ut/QjN+Q8LlSQOjzt9TIAPVkSSuxG8Lq8LXSt
	IM355uxXgilEGHJMz05Ubimx58i5BrFK6z1LYNr3dJSTEA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ORsFaMWuXv5a; Mon,  3 Aug 2026 17:42:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hDPBJ3Tjwz1XM4Sx;
	Mon,  3 Aug 2026 17:42:00 +0000 (UTC)
Message-ID: <437c4abb-0f63-43f9-a283-2687c374d3e2@acm.org>
Date: Mon, 3 Aug 2026 10:41:59 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] loop: Remove the "bool global" function argument
To: Nilay Shroff <nilay@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 Haris Iqbal <haris.iqbal@linux.dev>
References: <cover.1785440858.git.bvanassche@acm.org>
 <d5142cf35b04e88939c4aed2debf6f3716d540ae.1785440858.git.bvanassche@acm.org>
 <f3d93315-c7cc-4200-b6c7-5b75ad02290d@linux.ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f3d93315-c7cc-4200-b6c7-5b75ad02290d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/3/26 6:05 AM, Nilay Shroff wrote:
> Overall this change looks good to me. But I see, lo->lo_lock
> is used to protect lo->lo_backing_file. so shall we annotate
> the lo->lo_backing_file using __guarded_by(&lo_lock)?

I don't think so. It seems to me that the strategy in the loop driver
for serializing accesses to lo->lo_backing_file is too complicated for
lock context annotations. My understanding is as follows:
* lo->lo_mutex serializes configuration and state changes on an
   individual loop device.
* loop_validate_mutex serializes concurrent loop_configure(),
   loop_change_fd(), and loop_clr_fd() calls across all loop devices to
   safely execute loop_validate_file() when loop devices are stacked
   or nested.
* The blk_mq_freeze_queue() call in __loop_change_fd() serializes I/O
   request processing and the code in __loop_change_fd() that is executed
   while the queue is frozen.

Thanks,

Bart.
