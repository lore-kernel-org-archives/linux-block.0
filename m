Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCD9165F13
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748621092; cv=none; b=BGXAlSmTANpKGhA/dCvthYD4pMOgYWSFGUh0MH1BrBM0ZRoFB/FxWrHxUwIeQlQGVZ/7D8ElDTL5Zq/C+fjpvIVrFDX5iBeNBZVhCtXlLBOL07dWpgb9JE0x/IvwdHt5tPjK2GyoNTxD02SZlY/67nKaBmHCiC2xWkgiq2Qr8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748621092; c=relaxed/simple;
	bh=pCxjfZF7Uhf4csaKQoUi4Xpq3/4T2fFwKxt87j8V2OM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=TMhe4vbQ/44n/q8939rc4hRRjUEzcu9jvcD7aQEtN38rHoaG/ZKyyvzAtArGbKPp0CqohnH4Xdmn2EjbNPBcEjl3xH7Lo1RAT1dgBHrnsB1aDH6G89cXcH8eK96H0T7NwAiWC0+LDVauHo2gciZx1rqTBVTtQocwC/eIz/24i9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RJMSZbZq; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RJMSZbZq"
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4b87Nd68SQzlxh6X;
	Fri, 30 May 2025 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:content-language:references:from:from:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1748621088; x=1751213089; bh=pCxjfZF7Uhf4csaKQoUi4Xpq
	3/4T2fFwKxt87j8V2OM=; b=RJMSZbZqztMAL7cQmgoc2oSKrllo6PCW3/xBcNIx
	Cf8KRjKowfISRl0jEoIijCCQasp4zYIEa+5aSLRp34faaVtHSxP7j3f5uOGY132Y
	69vXACdwTgZpmE4aJV3WD5gMfmCiBElHcZx5bOvlKz7sJWb7c3dYTn97RC1QdgmE
	9oB40nKFUwee0npOyY6lnZpCAgh7Lx/o33nDqT+S3C6kXo8QHjZBkeaBY53ahpiy
	yqSoClV1axpnhdrjFU9KxV5V6QJIiBuNpBX83fIZn7rj8fl/QxAiHUlswDeogNY8
	hG8Yj0bvCfGP0xbMqvP0sunxZdu8qlpiItgpNpwbBDXa8g==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id WGwLm4QdIpYT; Fri, 30 May 2025 16:04:48 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4b87Nb3mbRzlyhH9;
	Fri, 30 May 2025 16:04:46 +0000 (UTC)
Message-ID: <12e64bdd-5160-4e04-ab8f-9b8859ae64c1@acm.org>
Date: Fri, 30 May 2025 09:04:45 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests RFC 1/2] check: allow strict error-checking by
 "set -e" in each test case
From: Bart Van Assche <bvanassche@acm.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
References: <20250530075425.2045768-1-shinichiro.kawasaki@wdc.com>
 <20250530075425.2045768-2-shinichiro.kawasaki@wdc.com>
 <0d4dec4a-7a47-459b-876e-d9e3c4d24f55@acm.org>
Content-Language: en-US
In-Reply-To: <0d4dec4a-7a47-459b-876e-d9e3c4d24f55@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 5/30/25 8:56 AM, Bart Van Assche wrote:
> On 5/30/25 12:54 AM, Shin'ichiro Kawasaki wrote:
>> @@ -695,9 +695,9 @@ _check() {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [[ $group !=3D=
 "$prev_group" ]]; then
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 prev_group=3D"$group"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if [[ ${#tests[@]} -gt 0 ]]; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if ! ( _run_group "${tests[@]}" ); then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=3D1
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fi
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ( _run_group "${tests[@]}" )
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 # shellcheck disable=3DSC2181
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (($? !=3D 0)) && ret=3D1
>=20
> Is the above change necessary? This command shows that the exclamation
> mark does not affect subshells:
>=20
> $ bash -c '!(set -e; false; echo set -e has been ignored)'
> $

(replying to my own email)

Please ignore the above comment since another email from you shows that
the exclamation mark affects called functions even if these are called
from a subshell.

Thanks,

Bart.
