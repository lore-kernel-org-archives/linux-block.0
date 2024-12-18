Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40214658C
	for <linux-block@vger.kernel.org>; Wed, 18 Dec 2024 05:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734498258; cv=none; b=YgccrJ6ZVehbdrYo/oCm0tGRBv3k/ITDNDe45uhPjb5/Xy33vqlFRnTdwEccyuafopDoOhlAVunTiqIoXWj1YggbPsdjRIZbxWbzi/XbPnHjbSE8lWUDZWcgeJln+zP56z6HHkLMEr3WTFSBviKvRgfm/vlj6/zpfFWmBx3sBss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734498258; c=relaxed/simple;
	bh=kC01mZ4L52bc7lnGnqNOpqjPlXsJRbczG1gbElfsO24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUHiQq+att12JwHOXs5Pjg8YoW3Ew4wafOUid7Be2o3t6cpVJjRHuYfC8eTU0pwdqkLi5Jj5n6KXLGkuQR8MzfhQBHYW0QfqrK0Wps3x3zVDQk+QUSQdKQXZwnn9WhMibQW0Gsl3rGz/kNc8zu88S+zZyGPakn0eXMphdgDIUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LQd+LATv; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LQd+LATv"
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4YChRh16Qlzlff0D;
	Wed, 18 Dec 2024 05:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1734498253; x=1737090254; bh=GWAEocCU4rt9mAPtnGOULqAJ
	7dcQhXPREYf+isHmKqc=; b=LQd+LATvyJo7P2cvcrQ5JK+0Yab+N0dC6TI7BFG/
	OfgxodweSMmoST3zu5AMmcdP1VojVuYP5gkPsN910xY6OEVj1l5nRAB+lybfOnnJ
	U9wE3nzSlcOXhcLQ+MyCdhEHn7Bca7N88Lw3soGJSCxcIenNlJ2d2llBWngAk2ni
	4WWtke3MKvYnYf3jYHggvaJk9p8LZS9rvKDYOwWflvFCgAdVPWLaaaMXWL62el6k
	wYWnAl4LNoEYX93ThITLc9HRBQbxr+aJHfdzyYB9qiovSC4sC3n6McPdMOY/cSxC
	V/dbGyURuuZfXRzaW9P6vjBWN0uCnycI7zxBgpHwZOVRQA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WYDBVa-IkaQr; Wed, 18 Dec 2024 05:04:13 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4YChRZ58Rqzlffkv;
	Wed, 18 Dec 2024 05:04:09 +0000 (UTC)
Message-ID: <329599c5-580d-4fe5-97f2-4e4e5d5d9d7b@acm.org>
Date: Tue, 17 Dec 2024 21:04:08 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 2/2] throtl: fix the race between submitting IO
 and setting cgroup.procs
To: Yu Kuai <yukuai1@huaweicloud.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, yi.zhang@redhat.com,
 "yukuai (C)" <yukuai3@huawei.com>
References: <20241217131440.1980151-1-nilay@linux.ibm.com>
 <20241217131440.1980151-3-nilay@linux.ibm.com>
 <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d2b28360-259a-8938-47eb-b14b5b4df754@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 12/17/24 6:24 PM, Yu Kuai wrote:
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 sleep 0.1
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 while ! cat $CGROUP2_DIR/$THROTL_DIR/cgroup.procs | grep=20
> $pid; do
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 0.1
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _throtl_issue_io "$rw" "$bs" "$count"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } &

If this approach is used, please add the options -q (quiet) and -w
(match whole words only) to the grep command.

Thanks,

Bart.

