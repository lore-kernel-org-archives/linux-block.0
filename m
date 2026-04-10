Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639F78F29
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838885; cv=none; b=kaZo3t59JX31jbCgekAZYK7TA/8MQubdixQIR6gHJfb4MXYpjGjm9PsIs4bSD4mgXqCIAQraqSZpuKb/g3goChCy8yfHOyDuHNmIL2Je8/1mf4/UNMcRHdzN8MDEHc2cAmh15OjwA7K8EMtJ///p8T1NcfQXOAVzIoOcIb5q+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838885; c=relaxed/simple;
	bh=2nr5UrcVKbbFdH8NWjxF0UIk3Kx9jYVv4kaERQ2aJx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHq4qSaevbhBxD2WuNGGEkatugwfVfwz+cKHnsbs6UrP8yJ6F3GtdU8XLFRcttd/FEv8LVeLx2G5k1OKKO9g2z5Ze0yo+PFH3JoStlasxV30aYII+j7xx//T8um07Ez4C1MZy3OwwNcpXhi2ZD+tMpB2BtKOTwGDPi2gq78tFBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=t2XJQXaU; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="t2XJQXaU"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fsj7d2BD9z1XM0p8;
	Fri, 10 Apr 2026 16:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775838875; x=1778430876; bh=mtCgvzlqAHlo3snWBvYxDiCo
	zntz6PR2HD600nRdBPI=; b=t2XJQXaURz2kfCI+zGJBBrnK2FOtCbcUS35RlFpF
	4hgLvRvdlVFIlI4fqVcUQO+Saix4gDwyrF7xnOYGQ7hcVZsQdZEmK8BiVCaQSFw3
	43Jv+nw7pvjGGIVKGvg7+oBCUR1vjszvIqSUZpG3zR84drlCaWjf2OWH5scfOsQp
	q1Y533oQ25wlAgcdYSd06fp02ucG8j3gRUAp+Tc/p2NwLOM59xEdGyggjbHzUyhY
	JBjIzU6P7sVQ49adq8KJIkn43xHsyTC+0pYSJRTt4KrcjqKV0rNDuFULkzYn5M4N
	+CzUtGTV8MJ2mgwzAZcPBuQwGpywFSojlkTgQVTQyUjQmw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Lot4fYDA9EPN; Fri, 10 Apr 2026 16:34:35 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fsj7Z2KNbz1XM2FN;
	Fri, 10 Apr 2026 16:34:33 +0000 (UTC)
Message-ID: <9a297b35-639c-417f-bf22-a20742a9adcd@acm.org>
Date: Fri, 10 Apr 2026 09:34:32 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/1] common/scsi_debug: use _patient_rmmod() to
 unload scsi_debug
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>
References: <20260410053016.4013504-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260410053016.4013504-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/26 10:30 PM, Shin'ichiro Kawasaki wrote:
> -	modprobe -qr scsi_debug >&/dev/null
> +	_patient_rmmod scsi_debug >&/dev/null

The output of none of the other _patient_rmmod calls is redirected to
/dev/null. I propose to leave out the output redirection because of 
consistency.

Thanks,

Bart.
