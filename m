Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FF21FE45A
	for <linux-block@vger.kernel.org>; Sun, 28 Dec 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766964523; cv=none; b=C2iQhz59b/vsi72OvuOJ2C+XqqXp9KCOVgGuonblAVAfibFsq6s1V/GFVkDOc+rMn3+qli+6rWymhaDAaTgOz9TWkEpq3HrZjHlO9YcpISrNXy7XBDvYArqj0/h+reLoOZB5hlZCOAOraBLRKzLIecWjlzc127Bif/NfdaTtjxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766964523; c=relaxed/simple;
	bh=vwZLS4U7XTXVrnDZu1W0lK8LiSnibUhQfOgxwRR7IO4=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=YRNEs/s/lEs8FuJbGhjsYNIImie0HMFpA6kDA2wy0Lwu9fDGO5LAlRxxF6ykE5CjneTPAixzXgKMoByaSNF2CXHm7UhsFohrwtB3+ajanwd7F/egAHo5pmLf0pB4YxUmdOqvgnR7NwnmRSE4huHNkO6DfQLjXqAgqnk4rgN6dfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=lqqHOTZC; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="lqqHOTZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=dnoyfsskxndarinzen4qxlc5p4.protonmail; t=1766964512; x=1767223712;
	bh=vwZLS4U7XTXVrnDZu1W0lK8LiSnibUhQfOgxwRR7IO4=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=lqqHOTZCpnsPf4Xe61gM9x3Pw8miSP+MYkwPCJBOpMJ4WKewyhn0oe702SxmQYpLV
	 0DMyASxYMBWHMxsag+aV7/DmPb187ZINUMJdtksaCQi/w7ZHdvJncQxAly9SrJiZXX
	 tyUlB1DNQkUbN0MkWgrtnq59AUGrtVjYw+HXFLu6QFKeCDMvMoYC3SUI529lLr3tmW
	 YB+Q3myPn4b6/+Az1nj1RJuS6NFYJMhcd1/R56s3qbZkkvErzvNRpT+cjpK6A7xu6l
	 aqCPlNjJnRxauNVhRMSWNdmyaRcgabkm8cUV0ZuXJr8GRQXVSj3v4baF0oK/ClxZRk
	 uftXpquDo68wQ==
Date: Sun, 28 Dec 2025 23:28:27 +0000
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Cork <c0rk3d@proton.me>
Subject: blk-core: use refcount_inc_not_zero in blk_get_queue
Message-ID: <GDEKCj_yoRVrQXF0_aiX1bjtPDZTT9L4WUt5hnbO1C_kbeckz9J_6Kj_vsQ3wsx1qogOxNIge1sT1CvTA-QKleCFJYJ02RBvvcAvUB2AfrY=@proton.me>
Feedback-ID: 121452778:user:proton
X-Pm-Message-ID: cf69fe4cd28d4fcb40e600461c28700b5852fa3b
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

=C2=A0 blk_get_queue() has a TOCTOU race between checking blk_queue_dying()=
 and calling refcount_inc(). A concurrent blk_put_queue() can drop the refc=
ount to zero between these two operations.

=C2=A0 While RCU and VFS synchronization likely prevent exploitation in pra=
ctice, this pattern violates the refcount API contract which requires calle=
rs of refcount_inc() to already hold a reference.

=C2=A0 Replace with refcount_inc_not_zero() for correct atomic semantics:

=C2=A0 =C2=A0 bool blk_get_queue(struct request_queue *q)
=C2=A0 =C2=A0 {
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (unlikely(blk_queue_dying(q)))
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;
=C2=A0 - =C2=A0 =C2=A0 refcount_inc(&q->refs);
=C2=A0 - =C2=A0 =C2=A0 return true;
=C2=A0 + =C2=A0 =C2=A0 return refcount_inc_not_zero(&q->refs);
=C2=A0 =C2=A0 }

Cheers!
