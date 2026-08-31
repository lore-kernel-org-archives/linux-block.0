Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48159446C1B;
	Mon, 31 Aug 2026 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788193516; cv=none; b=gRdjpXd4W4azsUhmYjjM+is8pqrtYkHCl53ZfmN1SRPVmEjwGlucmkd0YnGKiB/DZgb1a3tXEDAL28mjg/KPheQOfDvuz0RvUf3IVEm6Fwmz79gL9dE04dc2JrO8PLmnKhZvn7Hpw0b9EpmxSJjP3TgOnJNKFQQxDiygJK9LQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788193516; c=relaxed/simple;
	bh=KL7wyZApefg2gUrFzUIjVaSBIZ9vGIATCPoEDUeFQRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oov8stUtU0PTyb8lDMZ6HcY7HuKp6llVyRO+xM2zz383ZkfoEBFpH1qYGmhb9c7jlmgeg4mMskz3W2bfcqz86xU3K05N1I85OzmGC+Dv59NQpezH1Uyczs4d7fs8ZajUffyUl0VtbB2yX4SY+W3s2X8BCpg4jk0+NwfAmb4H6tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=FomE3cW3; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="FomE3cW3"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hYZ8p5Px4zlfvps;
	Mon, 31 Aug 2026 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1788193511; x=1790785512; bh=HffM1Q2/SdT9wBbZV7bnbP7h
	WGk+stTJkeMhWMNSB18=; b=FomE3cW3h6jvfNLNrArFg3I4yeAi7ypzMhpxBUua
	0+AqcAMrPeh+mR1sZQrQ/+MSE9pym28gYrNVIGRcFQ3kj73cvs81BTP2agj4utrJ
	c4dAKLttoLA8vquzZDIAX8DK3m2gNY8IUso2nc00uo5w3oWZyBaofteGqhpRJwCw
	uNj5/EynoFrsV1JS5hOeIFVJX4CFzXGyRp6oyIuU32W+s7nCjeTnIJ7BB5bl6chw
	SziYWhd8xyayihEqyJfdvKqKvxiteE/qhpWI57fMP0oF0upWZGVHlc+3coHHbwyx
	2+EXYAgpKyaCx1k3vm+0zqwdDsTHQio0Ig886azft9CfpQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gJXlNlSMmhAY; Mon, 31 Aug 2026 16:25:11 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:a104:ffdc:9983:687c] (unknown [104.135.182.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hYZ8k1cWrzlfvpM;
	Mon, 31 Aug 2026 16:25:09 +0000 (UTC)
Message-ID: <b6af880e-66df-484d-b776-8ca72aac3b1a@acm.org>
Date: Mon, 31 Aug 2026 09:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loop: defer the queue limits clear to a workqueue
To: Tao Cui <cui.tao@linux.dev>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tao Cui <cuitao@kylinos.cn>
References: <20260828072004.273519-1-cui.tao@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260828072004.273519-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/26 12:20 AM, Tao Cui wrote:
> The code already has an XXX comment saying this should move to a
> workqueue.  Do that: schedule a work item on the system workqueue,
> where it is safe to freeze the queue and update the limits using
> queue_limits_commit_update_frozen().
The patch description explains why queue freezing is necessary but
does not add queue freeze and unfreeze calls. Is that perhaps an
oversight?

Thanks,

Bart.
