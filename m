Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8734028D
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 21:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660211; cv=none; b=QAMqY77IrGsGci2e1lM8aEpQNJYlwXk2/+GmXfyrrnP521bd4BcYVVGTvZ5C1duI+FGlt2kPGf1N5GjMOyj+0DYaR3Lt2Fv4+QcYXzU/QQz0MBdkf/glZ0b+OAfn3WJ3mnimzax6xSA2XXwWhYCNNo2HS2nmEpw1/FPZgj7paJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660211; c=relaxed/simple;
	bh=k3aWtajrjYWzf7/KAN+qnCfnArA/Zw2yIIXklu9Ywrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rv2JNxBppSjaVba/NJDZFGOBlC7MTihcjIbc9WZe6JQWmHICTyhuadwroFsHUNdY5bAzzUU6l0Ks5tqcNnRy4Sdl25w0uMnmeeW/UeuYJPjRO6AT3EUrG05JRx90ikkkVZdvyQiGIBSZbCJjRtaTfvfr6dJNnK5P9nCHxYCzuww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=WQLcgAdn; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="WQLcgAdn"
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fR5bP4YHYzlfdds;
	Wed,  4 Mar 2026 21:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1772660205; x=1775252206; bh=msX6wyhmYe8vU4bu3UmEt08X
	FRaB0KUpSbe4Kq/mKTI=; b=WQLcgAdnglVlZFNCsfLXoj3NIjBNd/nIWrbzv4aQ
	CMpXIiZyj24RZ5/6obVjnRAxesJyP+ThqogSjYq9zpIDvZ6pyQNlYrxTsBuCWYRh
	FW7EG5T5rNpdI0OoLPI960VjcXWhgQzxe8XLw3mJ7H3srmRx/TSj07DePuMLwJCf
	REb89NGToHWAw3JbMAD+LnEn+IpjCm92E7QfprslRf18uH8lXyPBMKd/fHRvzcKC
	cWdTUhRxAajfTRcUHNfZ7/xu20BsaJnqAcd+0fx0NP5oHHnYfTm2vzi61RUfXcdq
	3HfsuTCw9U9RJBvQJ/7QF/voaQZXfdugCXHu9XhxHeZVyg==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id gYNL4187YYRM; Wed,  4 Mar 2026 21:36:45 +0000 (UTC)
Received: from [192.168.132.187] (unknown [12.150.89.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fR5bG5hTyzlfddt;
	Wed,  4 Mar 2026 21:36:42 +0000 (UTC)
Message-ID: <4510c313-9019-4901-8711-42400070f4fc@acm.org>
Date: Wed, 4 Mar 2026 15:36:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] ublk: Fix the lock context annotations
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, Marco Elver <elver@google.com>,
 linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-12-bvanassche@acm.org>
 <CADUfDZon_tUuZzH3we4NdPg_MB-LQsMWbeRrLAiqzBbSM9hG-g@mail.gmail.com>
 <c658a073-ec42-40df-a03e-c34cb5c3f545@acm.org>
 <CADUfDZrYu42KbiBNoXtuHUKAuXFxovydLRvNrXAEw9hL6puXiw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CADUfDZrYu42KbiBNoXtuHUKAuXFxovydLRvNrXAEw9hL6puXiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/4/26 3:03 PM, Caleb Sander Mateos wrote:
> On Wed, Mar 4, 2026 at 12:55=E2=80=AFPM Bart Van Assche <bvanassche@acm=
.org> wrote:
>> @@ -3581,6 +3584,7 @@ static void ublk_batch_revert_prep_cmd(struct
>> ublk_batch_io_iter *iter,
>>    static int ublk_batch_prep_io(struct ublk_queue *ubq,
>>                                 const struct ublk_batch_io_data *data,
>>                                 const struct ublk_elem_header *elem)
>> +       __must_hold(&data->ub->mutex)
>>    {
>>           struct ublk_io *io =3D &ubq->ios[elem->tag];
>>           const struct ublk_batch_io *uc =3D &data->header;
>=20
> Sure, these annotations all look correct. But it's not clear to me how
> you're deciding which functions need an annotation. Is clang just
> unable to see that ub->mutex is held here because the function is
> called indirectly through a function pointer?
Clang performs more strict checking of lock context annotations than
sparse. If a function is annotated with __must_hold(), sparse only uses
the information from that annotation while checking the implementation
of that function. Clang not only checks the implementation but also
checks the caller(s).

Thanks,

Bart.
