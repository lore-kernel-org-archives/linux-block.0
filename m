Received: from outbound.pv.icloud.com (p-west1-cluster6-host4-snip4-10.eps.apple.com [57.103.67.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49C19F42F
	for <linux-block@vger.kernel.org>; Wed, 21 May 2025 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849663; cv=none; b=uP62YzixJ+Ztd0vG2ooUYot3Xph3+iUmDO8n4WKWbd59IZ8JKHRjsURPq+kSjrcSR0KuEo2LkksvxVn7pLrCkGQbHnYI1xdI0ZFsNkH0kyJW8sDKPA+h+losisjf/IRZShnfcAlBS3hBgOulWKVS2ZWuVioasxerG+S2RV81n2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849663; c=relaxed/simple;
	bh=BkI/MtM2ux1hiNId2JLBQER9HhxxNybNHSPS8v/u+Bo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Z38yL7J1/kCk28/y5UHl35v9Rz2jbhBL+VvrLw/bCZXSbUtMKT/iVNM5o/hih8bEJpQBFbJRZ6dqalkJWjoWUHfYdc39z+WL/ze6E9gJAIqhs42Fa24ELZ9urmeAYNIci0YrGpUroZdl7qLQ9gFoVv3kK8Kt2jIWHQzvcpx+Huk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com; spf=pass smtp.mailfrom=ai-sast.com; dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b=Ocj2QuM7; arc=none smtp.client-ip=57.103.67.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ai-sast.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ai-sast.com header.i=@ai-sast.com header.b="Ocj2QuM7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ai-sast.com; s=sig1;
	bh=BkI/MtM2ux1hiNId2JLBQER9HhxxNybNHSPS8v/u+Bo=;
	h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
	b=Ocj2QuM70JLOhlh9zhfz/INEW8DlJNHTR4Ls10vU41Y7iLt7swfFDThrejahehMGL
	 6CMBtjEH1wOYYkBw5e5LNOGyyht4LdMSI7I/EyBw7Wz1HZ9lpDrpbP7KgVAqVJW4GV
	 y+TlXrPrko0ljGleZHN6Bsfa/j+IGu8feEA9wPFexShyJkgtZYllMVFJQq/r6SMS5f
	 JIdKfvMNJ+DvCzwOzW4yQTM5KH+pH0mdC7//Is7I65PyYwP3jSWggE9zthlFDRXo4U
	 d14WnMptkQweWpMQVJ5B/kLVQ11ki2MJKwI3EcbBP1As3X+k6oUJNxM3QaODQz2oL9
	 kF0eRis9snF5A==
Received: from outbound.pv.icloud.com (localhost [127.0.0.1])
	by outbound.pv.icloud.com (Postfix) with ESMTPS id 1344C1800226;
	Wed, 21 May 2025 17:47:37 +0000 (UTC)
Received: from smtpclient.apple (pv-asmtp-me-k8s.p00.prod.me.com [17.56.9.36])
	by outbound.pv.icloud.com (Postfix) with ESMTPSA id 72849180020C;
	Wed, 21 May 2025 17:47:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] pktcdvd: fix missing bio_alloc_clone NULL check in
 pkt_make_request_read
From: yechey@ai-sast.com
In-Reply-To: <aC37oAvMagTbRoPt@infradead.org>
Date: Thu, 22 May 2025 01:47:23 +0800
Cc: linux-block@vger.kernel.org,
 axboe@kernel.dk
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AD0D024-C122-4F2A-90A0-9992F827F86D@ai-sast.com>
References: <20250521123019.25282-1-yechey@ai-sast.com>
 <aC37oAvMagTbRoPt@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Proofpoint-GUID: GYFQn_KI7G5Tjc5DLLLcjN-VwQYMXSFW
X-Proofpoint-ORIG-GUID: GYFQn_KI7G5Tjc5DLLLcjN-VwQYMXSFW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_06,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 clxscore=1030
 mlxlogscore=861 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2503310001 definitions=main-2505210176

Hi Christoph,

Thank you for your feedback.

While `bio_alloc_clone()` is called with `GFP_NOIO`, there are still
cases where such allocations can fail under memory pressure, =
particularly
on constrained systems or during heavy I/O.

I've noticed that some drivers, such as `dm-zoned`, perform a similar =
NULL
check after `bio_alloc_clone()` and handle allocation failures =
gracefully
by calling `bio_io_error()`. This suggests that the possibility of =
failure
is taken into account in other parts of the kernel.

Given that, I thought it would be prudent to include a NULL check here =
as
well, to avoid any risk of dereferencing a NULL pointer=E2=80=94even if =
the
probability is low.

Please let me know if you think this makes sense, or if I might have
missed something.

Best regards,
Chey

> On 22 May 2025, at 12:13=E2=80=AFAM, Christoph Hellwig =
<hch@infradead.org> wrote:
>=20
> On Wed, May 21, 2025 at 08:30:19PM +0800, Ye Chey wrote:
>> The bio_alloc_clone() call in pkt_make_request_read() lacks NULL =
check,
>> which could lead to NULL pointer dereference. Add NULL check and =
handle
>> allocation failure by calling bio_io_error().
>=20
> Please explain in detail how this could ever lead to a path in
> bio_alloc_clone that could return NULL and how you came to that
> conclusion.

