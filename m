Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A7618DB1E
	for <linux-block@vger.kernel.org>; Fri,  5 Dec 2025 03:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764905625; cv=none; b=Yxpe2UFYL+9dFZAfZZlZGGubsFKgWJdyHim0ZmqxZ+4UWjviDDJopmMoCHb9yYlOt/fdDe7kT6MIZpfPC/9RnntzcT6ws7I5WcKnu2aWHQbxxdjFHAffb7PS6b7gFbXk8qXjZw4UXwBcOiz+6GW+U7gPlAU7tyeuu7RXBZtg9+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764905625; c=relaxed/simple;
	bh=GebIMPBTH8p1wTvkv66f1hvcevmsyynSOKo3Soe+X74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IVnW093ho6ZtfJzLz/8FfmEPXSPAzU5Kpem+o1qTNponngTmN8SuF02SiPJAMafQ2fikJEFGs2JpdueoWdSnY64PlB2f/00Se2+VmAZzgZV+Iucg9zBBD4BwsSUkXOSvE5Gf2H/6KmYv6dp232ELJyxKRnE5nM0U+vq0Rw9g6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hs/26YHm; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hs/26YHm"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dMxml1vBYz1XLyhF;
	Fri,  5 Dec 2025 03:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1764905622; x=1767497623; bh=hHLADSCi7nArYeRMMk8ZjSOE
	qGV9ncj9OuKuadsf6Zw=; b=hs/26YHmhUQ/MCVx5G2GrtnJKERS0VfbY0mq59+y
	iPwpoBGtCotpF1bUiJzF2oeABENAgw468adV/EvV0tkJKHwvN67ZD4kSC6hpXh2s
	TkeZlsZFRr1Hrin/CLIYND0jCmYWYxm3CZ+cj38gp2ak2akbBHZYz0FaFlPzZzd8
	D9+tnS3p5a2XeE5soTiaYVr+MN/FQBm5XfBXkxWP4d+k8tJXf6UyIKVJOw3snqM9
	YAIkaoXtkYjZEksqCpJodbGvN1eQ8Mrcd7VpaYo+GKWusYWeFjwmYDLE/BuTlp5e
	Zmy5cUh0xElws5BmyMZsxKgSauLhGTF40eHnOeiQ42D7tA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id mCOvkr8-0lNN; Fri,  5 Dec 2025 03:33:42 +0000 (UTC)
Received: from [10.22.10.72] (syn-098-153-230-237.biz.spectrum.com [98.153.230.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dMxmh0wjTz1XM0pg;
	Fri,  5 Dec 2025 03:33:39 +0000 (UTC)
Message-ID: <08b497a7-4b05-4282-809f-bf9e2d6f1e22@acm.org>
Date: Thu, 4 Dec 2025 17:33:36 -1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] scsi/004: Remove reliance on deprecated
 /proc/scsi/scsi_debug
To: Li Zhijian <lizhijian@fujitsu.com>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, Hannes Reinecke <hare@suse.de>
References: <20251205031053.624317-1-lizhijian@fujitsu.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251205031053.624317-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/25 5:10 PM, Li Zhijian wrote:
> diff --git a/tests/scsi/004 b/tests/scsi/004
> index 7d0af54..72c9663 100755
> --- a/tests/scsi/004
> +++ b/tests/scsi/004
> @@ -39,9 +39,9 @@ test() {
>   	# stop injection
>   	echo 0 > /sys/bus/pseudo/drivers/scsi_debug/opts
>   	# dd closing SCSI disk causes implicit TUR also being delayed once
> -	while grep -q -F "in_use_bm BUSY:" "/proc/scsi/scsi_debug/${SCSI_DEBUG_HOSTS[0]}"; do
> -		sleep 1
> -	done
> +	# Remove the SCSI host to ensure all the pending I/O has finished.
> +	host_cnt=$(cat /sys/bus/pseudo/drivers/scsi_debug/add_host)
> +	echo -"$host_cnt" > /sys/bus/pseudo/drivers/scsi_debug/add_host
>   	echo 1 > /sys/bus/pseudo/drivers/scsi_debug/ndelay
>   	_exit_scsi_debug

Although this change looks fine to me, it probably is more complicated
than needed. Writing a negative number into the scsi_debug add_host
attribute that is larger than the number of hosts works fine so the
following should be sufficient:

echo -9999 > /sys/bus/pseudo/drivers/scsi_debug/add_host

Thanks,

Bart.
