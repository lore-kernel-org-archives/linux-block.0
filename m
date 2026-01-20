Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43642EECF
	for <linux-block@vger.kernel.org>; Tue, 20 Jan 2026 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916552; cv=none; b=uqcKTp4gIS/l3n/eUyo5631Vv6SW3JXcp57hWE/tVKDP74kw8wBcRfel0bBSXp/adkwcHCsN5VXg/7b5z2ubIOUaQwKpZEIkQ1RUz1CcFVD4CRkxQrEPL5ebk186sCp0gbYkKiG9W3+pE4+t5iGRbNJ0Lth91gW5ua1kIm0283I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916552; c=relaxed/simple;
	bh=Bvq1OiLJX+XuOddzADa3EtQmWj3/0bcBAuQyXDw38VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FE3qz15JVQrgyRI3hhbMZWu2KqGfEnhpdmbgt3rgX79patneOnrSfPZjL90MbXu6Vi+YB4ILfMgc5wwGS8Ba88euaE7KHQDyd5VWMqmiDmQB5RikMBYTcIxgTrN3+gueHzVg3gODyWuDs+KNQ8i9Ma0NorYJm5PHhmMkHVSWNbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=48vWhJBo; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="48vWhJBo"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dwT5x4KLLzlh1Wl;
	Tue, 20 Jan 2026 13:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768916548; x=1771508549; bh=rj0/q+F0OOTTSQFT1eQb2qCk
	APNM4Sz31Z6SI7Safbo=; b=48vWhJBoRw/JJGx3OqwyNPgK3Mxv0zS8jHLGCKv+
	y9CfKKpbpllkvwJ0hVabYpeFs21bcnBe2ACI+ryl4etvFFWmiYWfujnR+1gEoLzD
	pXlZM61dDCT94iz60At3zamXfzpuovi42H1Oo+rCAk/FPGNDDDTRGt7vbbHiuBWz
	7gwGG/OkoZ9ggZ1jxS8DVSdN2NRgh0niUVNsqpMM95XbGogoenCAPUL+Tqs/BScr
	40RK2sgSj4FEyzOJCVa7J+fiEMFSb3/JEenE8EuniL36Ia3H96Rmw3J0a4+4n1d+
	KCh3YWyRkrlKFoWZ5C0epORqT2BwI24bO5syH1HrNQVLGQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ib6r9kwi6Ldb; Tue, 20 Jan 2026 13:42:28 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dwT5t74cgzlhH07;
	Tue, 20 Jan 2026 13:42:26 +0000 (UTC)
Message-ID: <06e8517a-1b30-4aef-9ec7-80b56a430fd6@acm.org>
Date: Tue, 20 Jan 2026 05:42:25 -0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Annotate the queue limits functions
To: Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
 <20260114192803.4171847-2-bvanassche@acm.org> <20260115062613.GA9542@lst.de>
 <1eeca326-9403-4483-8b03-36621e79db81@oracle.com>
 <33fe1cf9-a779-427b-bf74-1eee4434517c@acm.org> <20260119084143.GA5509@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260119084143.GA5509@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 1/19/26 12:41 AM, Christoph Hellwig wrote:
> On Thu, Jan 15, 2026 at 08:53:32AM -0800, Bart Van Assche wrote:
>> On 1/15/26 1:11 AM, John Garry wrote:
>>> On 15/01/2026 06:26, Christoph Hellwig wrote:
>>>> This is missing a commit log.=C2=A0 And not really telling what kind
>>>> of annotation you're adding.
>>>
>>> And we removed these previously - see c3042a5403ef2.
>>>
>>> Does sparse now handle mutexes?
>>
>> sparse is dead.
>=20
> It's not.  And even if it was we still need it.
Is there perhaps a new official sparse git repository? What I wrote
applies to the following repository:
https://github.com/lucvoo/sparse.git. After some searching, I found a
repository with more recent changes:
git://git.kernel.org/pub/scm/devel/sparse/sparse.git

There are 7 commits in the latter repository that are not in Luc Voo's
repository. Not much, but better than nothing.

And I found this email from September 2025: "Re: Sparse maintainership"
(https://lore.kernel.org/all/CACePvbU=3DfAf6nNih5r-epJwU8qpiJ4TmkU6yQg8O1=
hrJKznDRA@mail.gmail.com/)

Thanks,

Bart.
