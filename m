Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3723D391E54;
	Mon,  5 Oct 2026 21:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234475; cv=none; b=ELPzwhMwr1VWcYc9cJVqIFAzwuPkL1GPsLnY8GrbUCAOd8B7guXBL5KHrfqaO3M/wAF0D6QPJEd3mMjelg7mWoJ6SWpivOxCXIIr/ZG3j9/k5sJFg3Z/tb5XNp93mRgksyz0ej3ONrJRKAcx8VbCSo0hZDqfMKlUwZHkrKzl9Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234475; c=relaxed/simple;
	bh=dq4i77jwsT+0KxBL4PRHrMvUgBFxnDzVUkzdfEKqMq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h3Xpg9sEs8pA8TJoy7wumdhjeB6Qs5mBykqvBe2YXOCgDdTqS5IboTzRd9O+4q+0xAZxEmQ6klD3Wsw+g4LD4edbnQ35jmwTbYQoIqCBFa/kwIWNEDFUl6I1SjvAXKxzZrkvyJwsw3QyyxQfVmP2T2225g+mhfnw4Lb4gO+qS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=XREvpsaQ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="XREvpsaQ"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4hzBmn3sPSzlfvpN;
	Mon,  5 Oct 2026 21:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1791234466; x=1793826467; bh=dq4i77jwsT+0KxBL4PRHrMvU
	gBFxnDzVUkzdfEKqMq8=; b=XREvpsaQPQtzw/FDcmSo16IHxb74YV8gj12H275H
	25k+DwXs5j10/zVkLUjOA22E2kQii0Za/Koz3783Aqqokyi9k0+MV0GGLo0YeEz0
	Dyw3660jcGYAH3laoeFT/kZUNlvBDycdPGPiVGGl3ZP6E0UIREcEALm5u6M6xWUo
	XZZjdnhlvfdx0vUtxmLuFKlQWLK8W2nhmCWu960o9foPT2/Ym4QCrL9ScwwPcEB+
	/Dx7Gw/y8XzhLwvxCdvBBigQhQoAyYkhjYtp1SMDChqI9MOzXWCdcm8JKcopfRGf
	aOsIxQg/ldNRfzOv+dntQ2wzWdsvzll4FENKjant1gONbw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tqKjfMOei0EU; Mon,  5 Oct 2026 21:07:46 +0000 (UTC)
Received: from [IPV6:2a00:79e0:2ed2:d:913:466d:8f79:f68e] (unknown [104.135.182.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4hzBmX24XVzlfvpH;
	Mon,  5 Oct 2026 21:07:39 +0000 (UTC)
Message-ID: <0ca00d02-9abf-4740-9dcc-05a85d88df02@acm.org>
Date: Mon, 5 Oct 2026 14:07:39 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] block: Add post_release() operation
To: Christoph Hellwig <hch@lst.de>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
 linux-block <linux-block@vger.kernel.org>, Al Viro
 <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>,
 Brian Foster <bfoster@redhat.com>, Damien Le Moal <dlemoal@kernel.org>,
 Hillf Danton <hdanton@sina.com>, Markus Elfring <Markus.Elfring@web.de>,
 Ming Lei <tom.leiming@gmail.com>, Qu Wenruo <wqu@suse.com>,
 Tao Cui <cui.tao@linux.dev>, kernel test robot <lkp@intel.com>,
 rust-for-linux@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <69960302-1535-441a-be4e-d652766d65c2@I-love.SAKURA.ne.jp>
 <472c3bcd-45d4-477b-9e81-3c68601dc18f@acm.org> <20261005084521.GA8879@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20261005084521.GA8879@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/5/26 1:45 AM, Christoph Hellwig wrote:
> No, adding magic out of lock extra ops is a no-go, and we've been
> through that before.

Thanks Christoph for having provided feedback. Christoph and Tetsuo,
please help with reviewing the just posted version six of this patch.

Bart.


