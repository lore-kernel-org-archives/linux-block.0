Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA92DAFBD
	for <linux-block@vger.kernel.org>; Wed, 10 Jun 2026 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110129; cv=none; b=lNGy69ypzHNijTl2z4+EMOCcZeF91qvaFy4+VnblIrK+SfZDtOssmBD/bmHjWh5pgJnzmtoLH/6wXJp7deAcHuVRcCs3zMmdn/kE7DJs8UILHclaGHx9VGKGM4ZXAcLQi8Q0nzMbicKWQw91b1J6lxOhfKCrDQpVF+JACOx10wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110129; c=relaxed/simple;
	bh=6Qf45X1OZLfUNLERcqWZ0/tbCTDRoXD/PJv7gQnabts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Agwo0DQhRPayhL5kt3hbJdb+j9Z0zXHmiI4WTT76XBMRH+A7zw+XfaUeJoYuRHiVa2mxm5EeYdoU1R9gD5QDkPhkFwK8pZw/3vHV6IFHCy+HtHEyBlnSluw4/OUkX7l4low/AHWRV/ZLTlitaxLi/OOiB5OW7V3EncTGv2v+LNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=QZ5MG8DI; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="QZ5MG8DI"
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gbBYq3rVDz1XLyhV;
	Wed, 10 Jun 2026 16:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1781110124; x=1783702125; bh=KdSKeOm/Ka7P52X/KB7UnKxt
	vzBEOUVUcBN/x25X2oE=; b=QZ5MG8DIMOMkHCGihCgseG9FQ4AqIDhsk1DiB1WC
	yQnPfwjQi8cFdqNd20Abbn1WLnNGtXAFHmSAmPGt60stdsZX7Yj48dBXAeRrHAGp
	OP310GKj62Dcr06Oi4fR7gBvw1bDeQHJbA+/hr7zbAZ/UC4/vD0PqKvwSVjSCgQc
	ypZbIXND5ra8o+EqHO773iFytIfYKNdjlb7MuCEWRIRVTZovl7uorqO3Z5oYi7Vd
	m7b7W3Grk4eHgY1zRanFBInyH7IVtyMu50WuAfuIwj3nnksNob3DSeTBXuMUPPKk
	IPR69QRZjaOuvk7Je/1yf1dDdyjD+yQxIgqBbMxExF5YVA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id OW1Obzu2e3rt; Wed, 10 Jun 2026 16:48:44 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gbBYk4Hc2z1XLyhT;
	Wed, 10 Jun 2026 16:48:42 +0000 (UTC)
Message-ID: <8d85af7d-5751-48b2-82c9-4720010db8f9@acm.org>
Date: Wed, 10 Jun 2026 09:48:41 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/27] drbd: Split drbd_nl_get_connections_dumpit()
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Marco Elver <elver@google.com>, Philipp Reisner
 <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <cover.1781042470.git.bvanassche@acm.org>
 <167a1fe9f633fe1d1a0d89a50f10c3185d9ddddd.1781042470.git.bvanassche@acm.org>
 <aij0fuVz_Bxi6NXi@infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aij0fuVz_Bxi6NXi@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/26 10:22 PM, Christoph Hellwig wrote:
> On Tue, Jun 09, 2026 at 03:04:56PM -0700, Bart Van Assche wrote:
>> +static int drbd_nl_put_dump_connections_result(
>> +	struct sk_buff *skb, struct netlink_callback *cb,
>> +	struct drbd_resource *resource, struct drbd_connection *connection,
>> +	enum drbd_ret_code retcode)
> 
> Weird indenation here.  The usual style is either lining up after the
> opening brace or two tabs.

This formatting comes from git clang-format. Anyway, I will fix the
formatting.

Thanks,

Bart.


