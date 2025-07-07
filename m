Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF5C265282
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 18:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913339; cv=none; b=NiNtmtybsWBD+xsaPD0hhPY3fANbhGi7UIIPWgX1Fr5/9GJM1x3OGa9EpwMdTEQatXN5uClFg2vAc74bZTqgW/TODdgj7EGMRPpEslAAHapmdNULeJbsoJY6NwWRac5CyvvELVcLgY1fbizii1zILG8CuG9otav5o/GyRbrX9Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913339; c=relaxed/simple;
	bh=rPuLYwYlh0zw9E24LygyF8vZuNtQm7rdIa2EPjJ98Jc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L6yEOZxn6NQRC9rUxfWoYwAwRk5pZ3rKcKsIjMtkEjm7ea9Xg01ykmD/qxMOTV6DB7PA0zeiMfUlK0zHyKqvrLwlz6VQsKmafkHUCUZWOUOXckGZMt1llbYo4V569VqhlKOmjaa3WdZN794qDyH85PKvusib+J1b9HTu2U5xY3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=p2RNoKSb; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="p2RNoKSb"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4bbXx519BhzlgqyR;
	Mon,  7 Jul 2025 18:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1751913336; x=1754505337; bh=uho3eGsTHyAARNa07IiIoTqt
	qZe1gmlnofi/CWdDoHc=; b=p2RNoKSbjgqYz067vqjz3gA3uo5b1/T/8kFwAV39
	uUyD3tZuvLLYXjUTNtwMD57WwXgtzAKvZNmrF3XDBn1+mMdhT+e5YHe38Y2hX0tB
	dsDNK7J24Iziba/ums6F6CQC9PQRWWG7bMFsDhEXdkLs/3Ovy0GQ8TJrJs9fQLeR
	vYH5SUanwY8hM5Bw64OBD8JRybGxfoAfc9aSqLQy17e9mwldaIhxShU6vZc11GHu
	uls/t+FwSNn6Y8E8AHYyVt2N7n1V3AWzEdUQPsU9J+w4Lm6g2En48Fld5OoSTAx/
	aIAo+M9oPCGCOHG9iYjBOZ+4pAgxOiQe9qiHLy0sIYnVkA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JpPgy0SXnlUZ; Mon,  7 Jul 2025 18:35:36 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4bbXx23M00zlgqVY;
	Mon,  7 Jul 2025 18:35:33 +0000 (UTC)
Message-ID: <918963a5-a349-433a-80a8-6d06c609f20e@acm.org>
Date: Mon, 7 Jul 2025 11:35:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Fix a deadlock related to modifying queue attributes
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20250702182430.3764163-1-bvanassche@acm.org>
 <20250703090906.GG4757@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250703090906.GG4757@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 2:09 AM, Christoph Hellwig wrote:
> I'm still very doubtful on this whole approach, and I think you are
> ignoring the root cause, which is dm-multipath keeping a q_usage_count
> reference for an unbounded time.  It is only supposed to be held over
> I/O, and I/O is expected to time out.

No. Since queue_if_no_path was introduced, it can queue I/O
indefinitely. The oldest reference I could find to the queue_if_no_path
implementation is from 20 years ago:

Author: Alasdair G. Kergon <agk@redhat.com>
Date:   Wed Mar 9 17:19:15 2005 -0800

     [PATCH] device-mapper: multipath

     The core device-mapper multipath and path-selector code.
     [ ... ]
     As a last resort there is an option to 'queue_if_no_path' which 
queues I/O if
     all paths have failed e.g.  temporarily during a firmware update or 
if the
     userspace daemon is slow reinstating paths.

> You'll probably get much farther by changing dm-multipath to not hold
> a q_usage_count reference for something not actually under I/O.

Please make yourself familiar with how the dm-mpath driver works. The
default behavior for the dm-mpath driver is to operate in request based
mode (DM_TYPE_REQUEST_BASED). Hence, a request is allocated before the
dm-mpath driver sees any I/O. Hence, q_usage_counter is increased before
the dm-mpath driver sees any I/O. Hence, what has been suggested cannot
be implemented.

Bart.
