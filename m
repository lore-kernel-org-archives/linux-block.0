Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301F3E7BCA;
	Tue,  9 Jun 2026 08:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780992007; cv=none; b=tClhYaby42tQbCZeK0OL5vSwyYC+pSsLx8sReW+zQFMxf+5Ri/yCW8lOh4WGStTLJwZ03nV5VNyk0ITpV9M1ACKu0/YKt32jDAkK7fOOpoxMUx4OEuSFAR8DzO0cuhq0pQTuObuLqMCvgno9fugJgPqSjEsZxqngCVJ1JsWgw4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780992007; c=relaxed/simple;
	bh=zpxrJP+rVWZKKz52Xc1rq3XY7rpHMHYsN3z3CIvLE80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oO7NR+f25LPL3B449RoRUL2UIzTylN3O17ufHCdSKQJP+uQdT9dsTY75BJ3lYcu8NHGCEIdprdAoz6gBJv+A/XctIO4EBT5zgBJeQIWuuLnY/6KufQvcopW56x1IDCnv15TEgMGFAHgCG5elCSVJoctoACpK4ENUTzKwgbSWRdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3Oo7FYi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3Oo7FYi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3084C1F00898;
	Tue,  9 Jun 2026 08:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780992006;
	bh=zpxrJP+rVWZKKz52Xc1rq3XY7rpHMHYsN3z3CIvLE80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=A3Oo7FYiAdoKe394wjJgbh7ndnLq3z/JyUvWwwQT4+BHt0xQ8riCISOPO6etDevf6
	 dtiOdJeiHooo2RodiljO3AShXsLTxskg11wTYp/o7OGj5Y/Jdj5EYqRSHLFpGDVUx5
	 umYYq+pgQXIEJv4SxXO39Qcdukbnhba4jJcGgxLU2k1VgCP+fUYaTKh9koYo5hO+uK
	 K0mDVaqtmwjReMxoxTlKzodsktUz+u/5OPl7URRo0u0Pl+xPLS8vVjESJKZvDUo3OF
	 cdLCe2R8FecIm5cEmAD+zv4XK85RtYgPRcQ82j0dy+ER1XZchEPLyk+KCfZxpzXisX
	 v7fVTAUUQqdcg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix arg type in `blk_mq_update_nr_hw_queues`
In-Reply-To: <5353c4b0-fc3b-4fa7-bcd6-c8cc490699ea@acm.org>
References: <20260608-update-hw-nodes-arg-v1-1-19aba440b32e@kernel.org>
 <FOXAofrAzzcIqRTKeSNiGa5f3W0WLfFdudQ09DTURWykttcqFAbE1iXzN8OH5qslsMlcMGxfxRcxIzaiUvLqkg==@protonmail.internalid>
 <5353c4b0-fc3b-4fa7-bcd6-c8cc490699ea@acm.org>
Date: Tue, 09 Jun 2026 09:59:56 +0200
Message-ID: <87qzmggn43.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Bart Van Assche" <bvanassche@acm.org> writes:

> On 6/8/26 1:39 AM, Andreas Hindborg wrote:
>> The type of the argument `nr_hw_queues` in the function
>> `blk_mq_update_nr_hw_queues` is a signed integer. This is wrong,
>> considering the field `nr_hw_queues` of `struct blk_mq_tag_set` is
>> unsigned. Thus, change the type of the parameter to unsigned.
>
> Will there ever be storage devices that support more than 2**31 hardware
> queues? If not,

Probably not.

> I think the word "wrong" in the commit message is too
> strong.

Right, I understand. I can change the wording. I chose it because it
seems wrong to me to use a signed type for a value that logically should
never assume a negative value. If the negative value was used to carry
some kind of information, it would make sense, but that is not the case
here.

> If this patch does not change the behavior of the code for any practical
> use case that would be good to mention.

The patch does not change behavior of the code as long as no overflows
occur, and they are not likely to occur. I will be sure to add that to
the commit message.

I came across this while designing the Rust API for these functions.
Rust is kind of particular about integer types, so it gave me some
checks/casts on the Rust side that really should no be required. I was
thinking we might as well change the type on the C side to unsigned when
the data it carries really should be unsigned.

Best regards,
Andreas Hindborg


