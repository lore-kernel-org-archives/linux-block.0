Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F41D432F
	for <linux-block@vger.kernel.org>; Tue, 26 Nov 2024 14:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732629983; cv=none; b=k3DYpteMmeAEDe9RnqgH5HkC04+n7rW6erF2fjIjWeEwkRHsierki1kaQst0cIkCfyc4xoj4sHot6fu4oYgHJ1LMU3LjV+3+SX4Zf9aC3B5SaCsUdTHm1Uu7p8707wXjBWuZIsvp3OJmFZux4qg39ued3B4QpjlU1bCmHucOGkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732629983; c=relaxed/simple;
	bh=nJPqcGlmhXt+lEqV0jIz7WymRiBlx5Wqn+tu58LF7CA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KU5KrvFr3J3yA42KndPY7Wz5kp2EWP2diRJvD3h+3uTUBEOjFiYpdhhKqN0JiYKHSK2fwpl5D6iVLm5k+GRc0ksosj3EU2m7R5N5gr2JmhvKBBKD/mPzeXqZpDgCoCViPAXL6nvwd+P+t4zdqpjudPCPEBm5TTH54roEcaJxfXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=DMJnzHgR; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="DMJnzHgR"
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XyPWH1LkWz6CmQtQ;
	Tue, 26 Nov 2024 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732629976; x=1735221977; bh=nKnAVO3xid0jOVICSX12SUd4
	BFeSrFzAvuvx7x13B0E=; b=DMJnzHgRPA+HaFjJT0p3aPdjQC5K2CU7tIdcjXkr
	u3jwFElqN+63k4OPcpQPMhwz6v3+mtQgUQlMJ8CF4RNK9rhE0bYxiTH5ZH2IjkNk
	Fdw09pLZ54RDaLHXbeEBV4aPUfjKA424FQ4xhzktau5Z7WUbi2+QfyGpAiOVC/pe
	984XHp3YbLAVKcsWhTqOrf9OlZTFAb1FkXnT2fn2p9hiEOlxGBrEtFslze/lipBR
	qekjKKmFYmcyfsE6igDrMKyS3+1yv16oHxFf/OCIKIY5NxTyQXc5Mhqe5nvhgS4q
	VCm++XK75iHiRO1m3T1ULX9WcWJ9WNKdQ1kGU4fnBfllFg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 5l4ElaTkNf96; Tue, 26 Nov 2024 14:06:16 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XyPW91JXQz6CmQwT;
	Tue, 26 Nov 2024 14:06:12 +0000 (UTC)
Message-ID: <285a140f-4ed0-4e79-9da8-2f82d60c5a8a@acm.org>
Date: Tue, 26 Nov 2024 06:06:09 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mq-deadline: don't call req_get_ioprio from the I/O
 completion handler
To: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc: linux-block@vger.kernel.org, Chris Bainbridge
 <chris.bainbridge@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>
References: <20241126102136.619067-1-hch@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241126102136.619067-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/26/24 2:21 AM, Christoph Hellwig wrote:
> req_get_ioprio looks at req->bio to find the I/O priority, which is not
> set when completing bios that the driver fully iterated through.
> 
> Stash away the dd_per_prio in the elevator private data instead of looking
> it up again to optimize the code a bit while fixing the regression from
> removing the per-request ioprio value.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
