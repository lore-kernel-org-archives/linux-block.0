Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20403383337
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 17:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692144; cv=none; b=cxQOZVmdRu5iX06/5svXFur6ROKS0YKARqU27Vriok7G5iOxCOKsa6w/iMlokphv9yULP8cj97/zhPFYngN+afm4yUn+nqRB6uO5jPFlaB9oOApuc+CvVttCLB+5F6lB5JqRGH+jG+dk+kgFG17vVytCx50gZqwyD3/9IUhwCsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692144; c=relaxed/simple;
	bh=pOBN1uKrb74ZwLb66TPfiKh4FkoLRc/sbMcEijRkZMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sqS/WIqQx6ufF1mnmbvipCVnD4RMO+dskTjjM8x6uzbdIIBJ9IVIqwRxLjhKS4PonEnl+6W+FT9UnRTVGqAKQhstj8JVz6o6WJEI4wkNFMqRDwR9GU+TomzsmUsqTRHmj5hKYsMoFdrxx83av65+pvxnlC6a3v2jxp7Kn3bb4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=bhvKeXHT; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="bhvKeXHT"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gG0Kt2MGMzlfl6N;
	Wed, 13 May 2026 17:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778692128; x=1781284129; bh=1wsR2raVmUwXaEMf9Q4FWpvW
	1TpAJ/NF8YTeVDPFX94=; b=bhvKeXHTxCsKhlemYlbPnmBqu/tmDyb0C4+bK+4Y
	kF+yaVJVV4xFWAHJQFzwOnvBMu1urEePH4VbRbS4rfe2tP8ndBgUkODpNNmhiTvI
	fcDqqxjsM9gCwgXxJITuy23p0VlY7eATCgeTf5C/opoWUMKhZ/ZDUMS3/V9QGoIL
	8rXToqUZVlAnQdqRWM/bBDv38GdEScMxNTCJKoNSoyr/4JsCoJR6rlUeobIEQRRY
	pLwjrkemT2JKei2fMNXycvDBiZS2R9eMOYr7sQyHIYk9n6ctJ5MOuppkLfgMdDK0
	K3UwayabzwHi+vAH5P6WxoEQftLfFDNjehfVx5k7E1v8og==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NbrJK5cLVndN; Wed, 13 May 2026 17:08:48 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gG0Kq39Q9zlfl89;
	Wed, 13 May 2026 17:08:47 +0000 (UTC)
Message-ID: <10bc69b1-762f-40a1-94b0-9ce6580b17e1@acm.org>
Date: Wed, 13 May 2026 10:08:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/3] check: add --cmd-trace option
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>, John Meneghini <jmeneghi@redhat.com>
References: <20260513112326.584256-1-shinichiro.kawasaki@wdc.com>
 <20260513112326.584256-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260513112326.584256-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/13/26 4:23 AM, Shin'ichiro Kawasaki wrote:
> diff --git a/check b/check
> index c166fae..a68049b 100755
> --- a/check
> +++ b/check
> @@ -458,7 +458,17 @@ _call_test() {
>   
>   		TIMEFORMAT="%Rs"
>   		pushd . >/dev/null || return
> +		if ((CMD_TRACE)); then
> +			exec 8>"${seqres}.cmdtrace"
> +			export BASH_XTRACEFD=8
> +			set -x
> +		fi

Hmm ... my experience is that set -x breaks most tests.

Thanks,

Bart.
