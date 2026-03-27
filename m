Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953A02C032E
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625890; cv=none; b=SJIeFxxXZb15h4ZG4DYIaJGJTmisR/V1sVy2hIZ2SQHvRun17RLKpdYGl+CsJl37iO1DHKIukOJMCDkiqGvzZnlwvI8tjLyiP+zTcEk6IbCAnfPHVEr2DW62OilkLPXIAWfVaiYiIaVBKFdsVoSPUlIrZrGoFs9QukdinWWAly4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625890; c=relaxed/simple;
	bh=RT7FbvsI26c8usvFcZEP7bE1gll8AlQFZlvmPvKcWPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWp67ITLO9MzqgtJpaxviKEKVUNbR6gCmrCG7Iybt2jY65wuFO1BTOhjnOAujS8ARztNVYxhSsilkBTcHuzyy8qGuuzTe5MBUScCO8bCiqqEyzBgu7JsJRnvsDeyENdtlQ5IOktAUTLyN9fM1SOuqRg5HqkxdsLqphqItC4PAWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=f+Fh8g4r; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="f+Fh8g4r"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fj4Xw6jgRzlfc9J;
	Fri, 27 Mar 2026 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774625886; x=1777217887; bh=RT7FbvsI26c8usvFcZEP7bE1
	gll8AlQFZlvmPvKcWPM=; b=f+Fh8g4r1u+oSIujvbknCmkxenhaudrmydQH/x2i
	MsV+URDpPLCvB8/KSgEF3CZAU6aQo6J8STJHSMtLZxYZz+8Z/zG30q4TXfzcRHjn
	/z+Nr/Ka/l3N5rzPEkNce54N6EJ+KM68RW2OcaX9CyFfBN6waZsqE+T+SKytDHVr
	1xSduNraG5eLNCkiGG6kX2ca/dfWI46sgED4ZZ1RrnAMS5yt2rsXva5hAJeqGHkP
	IiN1LftMRc/f0nkjGNuNNfONNU9wHLHaDEQJdWX9RXS4dMbq5vEndFIwy/PPi2P1
	qVYVeIvYD38Yvjtpe13dfT9FaUQGndoA6MKzOH29orFVXA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id g7cLK3ucxOS1; Fri, 27 Mar 2026 15:38:06 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fj4Xt090Jzlh1Rp;
	Fri, 27 Mar 2026 15:38:05 +0000 (UTC)
Message-ID: <ac34040a-bd6c-4511-a71c-f0f0ba3442f6@acm.org>
Date: Fri, 27 Mar 2026 08:38:04 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: refactor blkdev_zone_mgmt_ioctl
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, dlemoal@kernel.org
Cc: linux-block@vger.kernel.org
References: <20260327090032.3722065-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260327090032.3722065-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/26 2:00 AM, Christoph Hellwig wrote:
> Split the zone reset case into a separate helper so that the conditional
> locking goes away.
Thanks!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

