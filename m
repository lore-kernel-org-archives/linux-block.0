Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C61990BE;
	Fri, 14 Jun 2024 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382991; cv=none; b=OZYuFJqYbshiq091IfUh/3MB+KlCpWmUIPelbMIGfjs5SjeR1Oeg3nbasblzD2FlwLDN8Bc6tbvQAYKbDgNmWvDifcTqNB0cM+LgHESEN5IED3hCHP7d4yVcQM9OhJ1AwKtPV5q0c6rKcKbbLCczZ5jAET3oB4+bEXJ21y1Wc4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382991; c=relaxed/simple;
	bh=662xbSRYJldsCMHXwrtqu3fQzLDt8igxit9UX9ONmsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr8oMKtiw6aV/u9QKzfxGdeU72sBK+UzGs4BLVe4Fp6OaW9cpTPdEwTZK0Lzh0WShEnVh3V3rREZ+qnl0gWxTUdctVgOL7ipNHn4Te4Z+F1JNh6MFkdubSF+2SaPmM+B0f7/NzP/YshH4YVXMA3MTCPr3ZKPXyabAHHR1IVEDL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J/J+GimC; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J/J+GimC"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4W14fh73SpzlgMVX;
	Fri, 14 Jun 2024 16:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718382987; x=1720974988; bh=TorCP2Kg6bmk1qmL0hdVj1QW
	YrFfd3WeFiJwrvgWJmY=; b=J/J+GimCWj2BYQyltGL3WnE0v5P3ZWCfJ+PCFSSI
	Gb1qDVR9z0Lczps7ANQSwinnshUrc1PsmqFyV2nIZX58Nc/udBXZVq1P0CKHaDSS
	qGhLuNesGtX7tbKJfc4LmmRppOBHaJZQenhE5O8E5OALxchaefyowTxf/UUzZWKv
	9yJfP2qhRZe1eOphVDfcyccS7BJ4UatEcMCbyQ1kCvZHii+kv5RqUoalUcSfWUdz
	XCZVchGGBjKBjcuCFpGwzgA3TlpHP7+v1jKiAV1+baiPi3Zh7esPegs3vdwww/xU
	idDKdjMC9h4R5Alb1LXhTEKsiaBOhqRcNmmYsn3b0Uv4hw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 97vX90FEDnf4; Fri, 14 Jun 2024 16:36:27 +0000 (UTC)
Received: from [100.96.154.26] (unknown [104.132.0.90])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4W14ff0jbkzlgMVV;
	Fri, 14 Jun 2024 16:36:25 +0000 (UTC)
Message-ID: <95fdfb79-3f8c-4067-b8f7-7c301b3bf511@acm.org>
Date: Fri, 14 Jun 2024 09:36:25 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: Drop locking annotation for limits_lock
To: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk,
 paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 jiapeng.chong@linux.alibaba.com, hch@lst.de
References: <20240614090345.655716-1-john.g.garry@oracle.com>
 <20240614090345.655716-3-john.g.garry@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240614090345.655716-3-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/14/24 2:03 AM, John Garry wrote:
> Currently compiling block/blk-settings.c with C=1 gives the following
> warning:
> block/blk-settings.c:262:9: warning: context imbalance in 'queue_limits_commit_update' - wrong count at exit
> 
> request_queue.limits_lock is a mutex. Sparse locking annotation for
> mutexes are currently not supported - see [0] - so drop that locking
> annotation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

