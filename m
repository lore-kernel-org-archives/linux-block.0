Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082129B799
	for <linux-block@vger.kernel.org>; Mon,  6 Apr 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483704; cv=none; b=dlMOdkF0HeDZKM2H4Y9BYWHE2XTNS5UCQUXUXGzTAK7VzNwoF6KYg2eu0Aa3bbZ66P5n0xAlgNgLh8rYYaFtmQxdctDmbPBgtCZkUkDW+m+YSg7Z627eFdEi5E5Qn8Bplc/XwtuWzuLlxM2diolwgK/3tgJKx+JDATWFJJlK0gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483704; c=relaxed/simple;
	bh=BlRGju0yDXLuxYqu9D0tI0GAFc5m3BHwc58s8REtt/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IozEWmoh8Vksx9mYj63p+X1XjT/0hEB7PuSNFyiqRGFlwpUWiRW3hTojsBwrQMOnHk49hu37UHskhdMmSjqKNHgDeHUXXFoVw0F9rba6rDMX+P39JEsjh2eulKE4gcLmnrePcu8jpsdoKScKdunpb/aoPgAJgPuKOzPexWWULfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0U/DpiuF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0U/DpiuF"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fq9jF6srtz1XM6JY;
	Mon,  6 Apr 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775483487; x=1778075488; bh=ObmWQNl1Jw9ZeRz04b39hyGa
	qMc41n7MGMvGzD0D0Dc=; b=0U/DpiuF8VhPpv7ozz514H40quRlMlusz/948eHv
	lapFb5JuVD/EZdt74ssxG5Or/BIkF1A7OOpCh7CU5KaHt/kY8P7PnNogtC7SNq4X
	BI1zl4W/LfJzDu7SRmOypl0rXoZYCuTaXuH0345caB9hopt5Y1Bowg7lZhh/Icsh
	R67zjBkRobEM8MuMGy5DmZ9lYBhlRV8HJJdnbqR2sFnI9ra1QC7YiV07kf9JTB4j
	aYrtZ1OJDLaSerx4KWqMzkHvCxJqOeAfXqHOtbAZ1XTe9lV+Nt/1agnbOc7X/swZ
	6+VB6Z0bpVC9HqKS78AQ3mmyWgi2d1JJC/aG1babuHyNaA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lr1eyx5azbe0; Mon,  6 Apr 2026 13:51:27 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fq9j94Cyfz1XM6Jh;
	Mon,  6 Apr 2026 13:51:25 +0000 (UTC)
Message-ID: <020e64e2-8a2c-4e91-ac4e-21801fe5216f@acm.org>
Date: Mon, 6 Apr 2026 06:51:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] src/dio-offsets.c: Fix err() usage
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Damien Le Moal <dlemoal@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>
References: <20260326173632.3259254-1-bvanassche@acm.org>
 <adDM7QhRRlnntRB5@shinmob>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <adDM7QhRRlnntRB5@shinmob>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/26 1:35 AM, Shinichiro Kawasaki wrote:
> One thing I found is that one more err(EIO,...) is left in __compare() after
> applying the patch. Should we convert it also into err_errno()? If so, I will
> fold-in the hunk below.
> 
> diff --git a/src/dio-offsets.c b/src/dio-offsets.c
> index 9fc7b92..c40ce68 100644
> --- a/src/dio-offsets.c
> +++ b/src/dio-offsets.c
> @@ -131,7 +131,7 @@ static void __compare(void *a, void *b, size_t size, const char *test)
>   {
>   	if (!memcmp(a, b, size))
>   		return;
> -	err(EIO, "%s: data corruption", test);
> +	err_errno(EIO, "%s: data corruption", test);
>   }
>   #define compare(a, b, size) __compare(a, b, size, __func__)

Folding in this change sounds good to me.

Thanks,

Bart.
