Received: from sg-1-102.ptr.blmpb.com (sg-1-102.ptr.blmpb.com [118.26.132.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D633B6D9
	for <linux-block@vger.kernel.org>; Fri, 21 Nov 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763713090; cv=none; b=Sp145CtkokASMydSba/uYZwDy8XMZa70STXXJCq8+GQo4aH0fLKMlQOio/i9hOGTsrP+eiiaUqq46lrQYu1GSqVdVyk5dYIdJu8LE29fuk3UsbvDRQQMswMKotwRw/gXYlhjL6NHgHajK3RmRcdcV/eIb3Q7vbFSu4H+HJCYe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763713090; c=relaxed/simple;
	bh=PH7pBCDlSwnut2+YV421LQPBN3TCyx6xDVGb6dWlZfs=;
	h=To:From:Mime-Version:In-Reply-To:Content-Type:Date:Message-Id:Cc:
	 Subject:References; b=Ko4KZ+3T8uLKmvUxbnYn+1PEonVRv5mOmiStTv8h4vWjhHMds+73xmVti5cdd53n+L0OYCio5T/GLAC/izaCgpOMHJD6xLDQ72+BJb2BWr4DgDUtLOa+UOmS1ubuTdowHgWLk/ryo3WVzx0FJlcpGc8PDf5M1auY+CdUapjVCjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N6LLDT2L; arc=none smtp.client-ip=118.26.132.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N6LLDT2L"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763713079; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=PH7pBCDlSwnut2+YV421LQPBN3TCyx6xDVGb6dWlZfs=;
 b=N6LLDT2LuVq2AISCxWDxzCXduyAEIUabCzYrNxke7EiMztBCS4R2bR3ud5plAvZl1hzDLG
 TwJe+vlBrH4GUff9KJcovaerGFlMWhMKNcaJyLz4zzPZewiJI5N1znRWCaG1ikh7XuiInM
 RJuqcqE39ZzHkm/P4wtieslCW0/q6731248eH5xh0HwD6QQIqt5/H8fMCnhj6RcUnETxkd
 es73/g2IysrNlAIDCmUnbFnaNjP8eG1nDwCTDhRs8IyBRl/CgiAN1BLNdSjqa0JLctPCwh
 vKgSBtI8mqh8SLkA9Ct2fo37486Ycqzdr7dMNHtwQoEKdZumSesFwZ3pl9Ib2A==
To: "Bart Van Assche" <bvanassche@acm.org>
From: "changfengnan" <changfengnan@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+169202035+b059d8+vger.kernel.org+changfengnan@bytedance.com>
In-Reply-To: <3abda215-67f5-44d8-a2a1-5562c42c0f71@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Nov 2025 16:17:55 +0800
Message-Id: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.7a8aa9c6.39da.4362.953a.fa91f529e498@bytedance.com>
Cc: "Fengnan Chang" <fengnanchang@gmail.com>, <axboe@kernel.dk>, 
	<linux-block@vger.kernel.org>, <ming.lei@redhat.com>, <hare@suse.de>, 
	<hch@lst.de>, <yukuai3@huawei.com>
Subject: Re: [PATCH 1/2] blk-mq: use array manage hctx map instead of xarray
References: <20251120031626.92425-1-fengnanchang@gmail.com> <20251120031626.92425-2-fengnanchang@gmail.com>
	<3abda215-67f5-44d8-a2a1-5562c42c0f71@acm.org>


> From: "Bart Van Assche"<bvanassche@acm.org>
> Date:=C2=A0 Fri, Nov 21, 2025, 00:41
> Subject:=C2=A0 Re: [PATCH 1/2] blk-mq: use array manage hctx map instead =
of xarray
> To: "Fengnan Chang"<fengnanchang@gmail.com>, <axboe@kernel.dk>, <linux-bl=
ock@vger.kernel.org>, <ming.lei@redhat.com>, <hare@suse.de>, <hch@lst.de>, =
<yukuai3@huawei.com>
> Cc: "Fengnan Chang"<changfengnan@bytedance.com>
> On 11/19/25 7:16 PM, Fengnan Chang wrote:

> > use-after-free on q->queue_hw_ctx can be fixed by use rcu to avoid in

> > next patch, same as Yu Kuai did in [1],

>=C2=A0
> Does this mean that this patch triggers a use-after-free? If so, please

> include the fix for the use-after-free in this patch.

No, this won't tigger use-after-free,=C2=A0 just potentially risky.=C2=A0
"The uaf problem hasn't been repoduced yet without hacking the kernel."

>=C2=A0
> Thanks,

>=C2=A0
> Bart.
>=C2=A0
