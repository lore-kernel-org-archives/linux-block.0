Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66D283C9D
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561647; cv=none; b=bnhmIoSu01CUmqENh2F7kj5yLiKSot4fQ1LNBAG0wubmgCTQSNkw3YKQRlHPcpUZNQyCyyn96qLiOoseXBNo5+XiQhHUkuKRDL2uAJPQ3QLyt2/lJC8vCnyqxRCa9qI1o3bnmEjq00+C/FFl/GWzdz8H/rEhjHoQcV5HoGU8Lio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561647; c=relaxed/simple;
	bh=DVROGPV+cSRdvmeQ6gUv1LsxvjcOX+qP7J5cjG3Bk6I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJPjb8mjsIEyofPYLOpYGi9Pjc+Oi1jAKHJ/M8Zk2DfX9tHHPVyFB4xjqxEJgBOwhTutSVZEcZF1Ys3PBbiazUj8hebhZykOTGT2fZRXqlCQ3BAHIIvDSdJFq68s1oRMeXZsH4Ys6b35wXlv0j0Oqc/5JBEcs8ZO97UrtqsqVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NwOoVEpn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NwOoVEpn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fhcnL4012zlfc9G;
	Thu, 26 Mar 2026 21:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774561635; x=1777153636; bh=Q1qTa8qaBEJcl53re+C+UF++
	/Fy0WTURsjvIM3D//Y8=; b=NwOoVEpnW+9TUvkT6zarZvoja8YQFSPxexIJWaxu
	xaNOTFeQPFwnFWxH68ZLFG/C+0qGC01pwtUnGQDn0YhplQxMfmdoPgPi0BVREkyM
	x2zIVvQkIahN7hTiRKJ4A1vyvnxLkYcmQ1jbDMReP45B5HIatCr7ga3LQKYtt3B3
	Sxz3NF/dtbfafW0snkU8i3lv+DEfAxCR1grscScA3yHzTdRQFDGpAlcuf//hcg/f
	Nph0SOqmLhEmkeDwZ72zVQApke4TxceYQ7+QQm4gRj6npbmhYOpCaJ+y2nsJGiV+
	ITffBjYK7Qx0KjbIoJNGTow5cqekGCoO6D72sgsRURRwYg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oRoZzHrwpC3A; Thu, 26 Mar 2026 21:47:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fhcnF0ZGxzlfftf;
	Thu, 26 Mar 2026 21:47:12 +0000 (UTC)
Message-ID: <fe778bf7-74dc-49c6-9267-fd41ad9e592c@acm.org>
Date: Thu, 26 Mar 2026 14:47:12 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: Balance RCU calls in drbd_adm_dump_devices()
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260326214054.284593-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260326214054.284593-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/26/26 2:40 PM, Bart Van Assche wrote:
> Make drbd_adm_dump_devices() call rcu_read_lock() before
> rcu_read_unlock() is called. This has been detected by the Clang
> thread-safety analyzer.

(replying to my own email)

Since it is the third time this patch is posted, the changelog is as
follows:

Changes compared to v2:
  - Added Christoph Hellwig's Reviewed-by tag.
  - Extracted this patch from a larger series.

Changes compared to v1:
  - Added Christoph B=C3=B6hmwalder's Tested-by tag.

Bart.
