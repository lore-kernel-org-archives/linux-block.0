Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E57627B4EB
	for <linux-block@vger.kernel.org>; Tue, 27 May 2025 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748361234; cv=none; b=jCc29IMmq9arxzUzSdFMwlJ+H31EdNwLbSfYduQZk5St4vNIWp+vNEZi2f0aklDHvcSRGh8Uy2/zwghN6j9kUEGz5bZxo2ez5eIitEp137aeXw+77qHZfmrbbEcLc9cdsY90bkQ9S/P4pscDlhs6xre33IvyAuOvCiT8voxELPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748361234; c=relaxed/simple;
	bh=sYnbHMNRPawubY/d56Yx3EzeY9wok+TDMSfHqlwtQag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BA8arE1kNpt65IYKvYhyFuHePrR+CaK58ZxTkyHXFWkOd15pk3fOkF/rWyJcqnqKnFZLhfBj55emTJ3oMzYF1WWCC3mdGa4P+i6Us3pYOhObJi3zO40RBdikX/eLqZK4myEPqdSk3fpSq1LnINDl2oTlLgkX2aHehTpc9bsS9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KPcZ1Cm3; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KPcZ1Cm3"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4b6HHG2R6zzm0ySQ;
	Tue, 27 May 2025 15:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748361225; x=1750953226; bh=m95tE0lbkXUNHz4eywKMcZ8v
	iQZv/vT0rTyrSozrDC4=; b=KPcZ1Cm3R+T4By82KWT4C0JxXB0aGvA/C0bffh5L
	SAcZ0hUL16EnA/UIGmY3YIm3PLqdl2Gk0UXzX2EyTcjOHLr+Or/MJLr5lM2weC7C
	3drTqQAjsFzi0/eUhW82MT5Re6hdBpHOxrIXSyxpNyrkJqjTJMMW2/1sINB6q6Sp
	Rw79+vzkYl2Brbe/EDuPVsym3e91L+2W+42k1zMDMLYZh8EJD2OvhFEvTAJBqZcp
	Q5QPJdSkbvYI2N3iZoEIgQYkNbwLgKAXi0eDCZJq7rBspAqmn+Ys4hi5rkUy2J3k
	dsyxryP92LG/FTiO3QHuDzAHfLRm5xCHgpqTRcvIojJCrw==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id abJYoBlqP0fe; Tue, 27 May 2025 15:53:45 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4b6HHB5X8nzm0jvl;
	Tue, 27 May 2025 15:53:41 +0000 (UTC)
Message-ID: <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
Date: Tue, 27 May 2025 08:53:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, hch <hch@lst.de>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/26/25 1:25 AM, Shinichiro Kawasaki wrote:
> On May 23, 2025 / 09:49, Bart Van Assche wrote:
>> [ ... ]
>> +. common/null_blk
> 
> Nit: this line can be removed since tests/zbd/rc sources common/null_blk.
> 
>> +requires() {
>> +	_have_driver dm-crypt
>> +	_have_fio
>> +	_have_module null_blk
> 
> Nit: the line above can be removed since group_requires() zbd/rc checks it.

I prefer to make such dependencies explicit. Relying on indirect
dependencies is considered a bad practice in multiple coding style
guides since it makes it almost impossible to remove dependencies
from dependencies, e.g. removing "_have_module null_blk" from
"zbd/rc".

>> +test() {
>> +	set -e
> 
> Is this required? When I comment out this line and the "set +e" below,
> still I was able to recreate the deadlock.

I want the entire test to fail if a single command fails. Debugging
shell scripts is much harder if a script continues after having
encountered an unexpected error.

I plan to address the other comments.

Thanks,

Bart.

