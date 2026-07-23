Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BB2368D6F;
	Thu, 23 Jul 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828318; cv=none; b=hCaVquWmidm8xRuZ+03NshdAcSqrRAFYZYFVMBgNdfQKn8sUDeQYtOrvp/3hJuyVzo2H8LvO4JBQ0qtLNpCC4xTVG2YuWbDS/ustmbTnZ+ZxuWSPH3+45vb0BKhAX5yYgHK8LrYOoHuwMtOMRX/3onqZA93APYb6FDJIlVLCmBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828318; c=relaxed/simple;
	bh=eWI+G4fD2ZdiktrUHuIE+WQJNxpnJbYhSsRZdSbikLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvFAh5MkZiPFvlJP8yHmt/I7zCZpFCdU08QE6BcFxqmDNH6LgLdRdI3ZYdawBr6UBrtxJiZxXvvTJ8AG0ujXWtvJcvURE56VeqdCswszCqCQO6xreCHG7UfDsH94AmswpjiYy36U9cYOcNxC6eeYGfo3Uh3sBA8kGL8G6MqShTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Dc+cLRQz; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Dc+cLRQz"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4h5ddT0VTFzlfq9R;
	Thu, 23 Jul 2026 17:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1784828314; x=1787420315; bh=gvLGMOIY5UuDgQBU72WpsXk1
	8dZZlxeUgXW+M9PEJ6k=; b=Dc+cLRQz61iVnz5A8yYKrpB5xMHZ40np0ynws/3s
	IAh2A3+ehteg6Bo3SKQjaGslnZItQhZmkgC2J+Q71/xqs0yPJ6hyAAh7R60DovIK
	WbZFzn6Ieh6dPIawJGxHIT0bwBkVnDAnYeVMXyDwnnQd6mmRActzxWrlobHncBA7
	ecN9tWWDn9Pf/klXDhtJdRFvb4Eti85pkWO4UYe27X2MNSfQYAZWeau7nYzcnXDw
	lj+4yLrH1t2MOrlj/AMTzSnIYEadNbwzm6eckt+1GsEbujjM63mvZs6nATDajQMS
	FT/h9dWJEJodMqlf5QZf+0KKEyneV6rE2Pr6d8lhFCFhLA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lJf_m1-86BEo; Thu, 23 Jul 2026 17:38:34 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4h5ddQ0GxKzlfqKv;
	Thu, 23 Jul 2026 17:38:33 +0000 (UTC)
Message-ID: <af98cabf-89a6-41b0-9929-ec3e24783503@acm.org>
Date: Thu, 23 Jul 2026 10:38:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogUmU6IOWbnuWkjTogUmU6IFtQQVRDSCB2MV0gYmxv?=
 =?UTF-8?Q?ck/mq-deadline=3A_hold_elevator=5Flock_in_debugfs_next=5Frq_show?=
To: =?UTF-8?B?5YiY5Zac6ZGr?= <liuxixin@kylinos.cn>,
 linux-block <linux-block@vger.kernel.org>
Cc: axboe <axboe@kernel.dk>, linux-kernel <linux-kernel@vger.kernel.org>
References: <4vwol95qmudj-4vww18fcfi2w@nsmail8.2--kylin--1>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4vwol95qmudj-4vww18fcfi2w@nsmail8.2--kylin--1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 7/22/26 7:37 PM, =E5=88=98=E5=96=9C=E9=91=AB wrote:
> That approach did not take effect, so I switched to the current patch.
>=20
> I have verified the current patch, and the KASAN crash is gone with it.

The following is missing from your patch:
- An explanation why q->elevator_lock is locked instead of dd->lock. I
   think that you are misunderstanding the purpose of these locks.
- An explanation why locking q->elevator_lock from inside a debugfs
   attribute neither triggers lock inversion nor a deadlock.
- An explanation why the dd and per_prio assignments happen with the
   lock held. This seems unnecessary to me because neither
    e->elevator_data nor the address of dd->per_prio[] are modified while
   the mq-deadline debugfs attributes exist. Did I perhaps overlook
   something?

Bart.
