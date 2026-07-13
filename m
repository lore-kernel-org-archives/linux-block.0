Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A233438BD
	for <linux-block@vger.kernel.org>; Mon, 13 Jul 2026 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962831; cv=none; b=Eo1jpZF+5QXSWlWDyrqOHLV6Ib+jyRLVhHbbW2LpWJs92VRBctsBjzmqVoVlfHnx0YMxfW1KinlPYvhUjU3J8TEWSS46seVEzbinzzmHlD/jzV3oTcdMEHE9yZ7WtM5oDp7h1cM309aVAb1jnUTV78hy/FK41CHE2fKFxsXxxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962831; c=relaxed/simple;
	bh=5K6gfjt/6fDUJRQVpKaKe2Aa95UW3dW2wH/fO/u4ZK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b6Qtr9LeMSzZMXRuAOCOeDYjuhJGaMDYMNC35dyVirkdP2pBcDb5k05ebhF7Ncvcg8jm6L7hFVyXtDZowXl8OuGg6A1BOJgB0VU/IX+eLd9S3spfW2CQfLRRVJEQdeOMaEFMftt4C5pZAPa0odv1QaVZdWwm7y/gBrC/o02aTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=tmYZSYhV; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="tmYZSYhV"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gzTYT5cyHzlfgPY;
	Mon, 13 Jul 2026 17:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1783962828; x=1786554829; bh=5K6gfjt/6fDUJRQVpKaKe2Aa
	95UW3dW2wH/fO/u4ZK0=; b=tmYZSYhVF5tcT0Ypy2tVDuAIJNzd3bSa7jvqu2sF
	FyDyZcky+qPjp4Y4ArmElXZ/VPJVMM3UgP+UHlXqz13UkyRZhPEIjeiWWtVJuzXa
	2pBzIAvcR0GOdmpOx8/glI5vDf+9TCF+TJ4sMQ+jGA9cEbdKwIt+U2BAAwZnvD5n
	k0bq4bJRZA5T+nje5D3mxrdAUGdoQ6axwdv5LvqL91F/q0wewnVO6xFD09d8UFIg
	QYvHaFG6Us5vt46fTOYi01blBUuGHq4SWNJZKuQ7SxPT3zYYT9f5jhvV/e1qOY1Q
	cFvkmwwbFPw7zrcEUEzBVSPjkwUfeNRT4hZgzOGceyXnGA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id sANBuWLaxW_s; Mon, 13 Jul 2026 17:13:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gzTYR5dlPzlfvq7;
	Mon, 13 Jul 2026 17:13:47 +0000 (UTC)
Message-ID: <ef7dcd20-991d-49dd-ace5-ee8360ef4f2f@acm.org>
Date: Mon, 13 Jul 2026 10:13:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/4] misc fixes
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260713003906.21153-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/12/26 5:39 PM, Shin'ichiro Kawasaki wrote:
> These are miscellaneous fixes. They do not affect test results, but worth
> fixing.

For the series:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

