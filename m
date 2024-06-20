Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A974A1B29B6
	for <linux-block@vger.kernel.org>; Thu, 20 Jun 2024 16:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902348; cv=none; b=QlIp2TDtQ4waoaVK5gSImsQsrvUt2PihSE8l9a06yxHjkCeMHJFIEXEepSmK81R68ukccDFvmBhN3XxDL0CbtrFnYtvMzpHvYKSG2zkcd+TdjddjQbE4GTtHlg7sjc+/i2gbHIkmTcTXadhLkGADLW6+vAsGWbaQugChh6T+SKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902348; c=relaxed/simple;
	bh=IBnp0mdtl7oiBsGVq7Y5sFj0U18SH6MJj+qv1auMXiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jOl6gL9BhB9I4km67Q/Mr8v/VV5tgzpS3YHYedbLQ8y+/Wj19iA5e5SkMnuLZhJZtKxdQrH+ZIuJHqb7Lq9bzKEoIA05ibXQBeMDoMC10VWh8i1K1nkww4TlEc8i3vc7yiLL1NUarRrEonIj/7OLKHqOIqW00clfP6f94PzOESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=thxBXJsS; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="thxBXJsS"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W4mkD36bdz6Cnk9Y;
	Thu, 20 Jun 2024 16:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1718902339; x=1721494340; bh=z0XmAyG8x9QIfbm1e82GouJC
	5DW8mogzHNByoXyWNS4=; b=thxBXJsSihqHqUm/y0vH3oTi/3E6C7JWU6mkvNpW
	I6RUDakQOihQBX66rWiNS6aCCQDZ9d14Wh1w8FSqJ4FGsdMXENlrzDK7w0a9w2DW
	kGwEdBevELujkWsZ2GM8iW9ND/bvSEyH+dQZDt3jbd1XZR0ajnxj3pgbyd4Mtfcf
	hoLXePzzhnUD9FQDnfcUHxHrJtdOcdwqls8R2+USyETdxpd8t6hnj4e1N5ECNiD4
	SfIuLj+05fgo/rGjw/7JQ5GCfHbp+Ne1tddOjKo2M5cqExDLTd2KDfrj7DLWP1Gu
	62CQQRXTpYIG2kPdawe4q2lPVhRq3dfOftVKqQBjMvz9hQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id bLIXWTjTrn26; Thu, 20 Jun 2024 16:52:19 +0000 (UTC)
Received: from [100.125.76.199] (unknown [104.132.0.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W4mkB5ZcYz6Cnk9X;
	Thu, 20 Jun 2024 16:52:18 +0000 (UTC)
Message-ID: <4c98300f-bc0d-4267-acd4-6365de65713e@acm.org>
Date: Thu, 20 Jun 2024 09:52:16 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.6 kernel block: blk_mq_freeze_queue_wait in suspend path but
 userspace task held the queue->q_usage_counter in 'TASK_FROZEN' state
To: Kassey Li <quic_yingangl@quicinc.com>, linux-block@vger.kernel.org
References: <6fb677a4-b655-4395-9dd1-450217fec69d@quicinc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6fb677a4-b655-4395-9dd1-450217fec69d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 6/19/24 11:53 PM, Kassey Li wrote:
> hello, linux block team:

Please repost this message on the linux-scsi mailing list. I think this
is a UFSHCD driver issue rather than a block layer issue.

> userspace task A=C2=A0 ['TASK_FROZEN']
>=20
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c527f10>] __switch_to+0x1e8
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c5287ec>] __schedule+0x6cc
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c528c28>] schedule+0x78
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c532bbc>] schedule_timeout+0x50
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c529e48>] do_wait_for_common+0x10c
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c529238>] wait_for_completion+0x48
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0b4def4c>] __flush_work+0xcc
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0b4dee70>] flush_work+0x14
>  =C2=A0=C2=A0=C2=A0 [<ffffffdc0c091aec>] ufshcd_hold+0xc0

Is ufshcd_hold() executing flush_work(&hba->clk_gating.ungate_work)?
If so, why does the ungate work not complete?

Thanks,

Bart.
