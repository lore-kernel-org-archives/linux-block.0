Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBB315B0E4;
	Wed, 28 Aug 2024 13:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724852848; cv=none; b=CRio66S2/rOF9qG8bRBKSW862g+frdJMw98tbfFVKzvVPZYqAfa8nqPM5u0ztN8n+gEsidZ5u9NPWt3mX4Gmss6kW5Ke17FwMAOS3a5+HK+SsZ5V6YQL9mtZFjWb3mUDDVxstZDq4t2nuQGsMVlx+JkY9a42J30RutkRYk0WNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724852848; c=relaxed/simple;
	bh=PhyhFSq2ssqfE87Z8rulgW9y6ISQIaoU1dXRLUiK4to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHKh+0YYTluEegdGJsc7qpsl4Kkdvn3eBEhkGrArsptwZLzpRE0YGPdGRMcGAGJVSOc4ybIaZeF3vuqe4eJZo8ShTnQpadLK6hPfrzhyYgxPVKFHan0DEBK5AX7JrgFfFVPz8SkVH4Z4xde/+IEbhJeY60GHAcXwn/OhnCoHV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RGvYF1st; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RGvYF1st"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Wv5M226tWz6ClY92;
	Wed, 28 Aug 2024 13:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1724852842; x=1727444843; bh=8HL0xEOnM68xTrIbWEcNqu71
	FrJVlvPt0DHaEvk1u08=; b=RGvYF1stSw9zMiJSUwLphKJmx5HVqKxc8/3gdeW5
	3Y2WlnuQRHHW0w4ZLY6GxmsBzuHHm6rTxq3ZI/tnxD16IHdf86/NOUm/AcAqpKcw
	Yi31YZGYrNC3CDB4BkT8TYytetvEOqYh6pspsX0hIgAxVczqSxbdh500jXu1aDWR
	IbOcGDRM2Y4NfedqIkML08daEezbJr3YECGiLh4HuCLEFHSGYl1/hxwdBUxiIgRJ
	SX9focuhDzdNASpuuy/yffcDd/It6cn1VpiFZOLVyxLOc6t21fW7pTr/Vn60sers
	rv5pUl5LR82bpdnlgOlG50Guv+OSDtdqxxw03lYhAquHZQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id u71Aahn4zS-I; Wed, 28 Aug 2024 13:47:22 +0000 (UTC)
Received: from [172.16.58.82] (modemcable170.180-37-24.static.videotron.ca [24.37.180.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Wv5Lt5znwz6ClbJB;
	Wed, 28 Aug 2024 13:47:18 +0000 (UTC)
Message-ID: <03e92755-2011-4c43-8a1c-f1ad9a1382eb@acm.org>
Date: Wed, 28 Aug 2024 09:47:17 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Allow complete locally if capacities are
 different
To: Christian Loehle <christian.loehle@arm.com>,
 Manish Pandey <quic_mapa@quicinc.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com,
 quic_narepall@quicinc.com, quic_rampraka@quicinc.com, quic_cang@quicinc.com,
 quic_nguyenb@quicinc.com, Qais Yousef <qyousef@layalina.io>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <20240828114958.29422-1-quic_mapa@quicinc.com>
 <c5d0966b-7de3-4eff-9310-d9a31d822dad@acm.org>
 <7661afec-168d-406e-903b-a2dc9adf6408@arm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7661afec-168d-406e-903b-a2dc9adf6408@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/28/24 8:26 AM, Christian Loehle wrote:
> On 8/28/24 13:13, Bart Van Assche wrote:
>> I think that the following is missing from the above description:
>> - Mentioning that this is for an unusual interrupt routing technology
>>  =C2=A0 (SoC sends the interrupt to another CPU core than what has bee=
n
>>  =C2=A0=C2=A0 specified in the smp_affinity mask).
>=20
> FWIW on !mcq that doesn't have to be the case.

Hmm ... is there any x86 architecture that ignores the smp_affinity
mask? I have not yet encountered an x86 system that does not respect
the smp_affinity mask.

Thanks,

Bart.

