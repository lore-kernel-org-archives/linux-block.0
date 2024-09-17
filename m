Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9E443150
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 12:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576446; cv=none; b=ZRTCXa+N+fIUz649ou8nXzpEcB2NjWqAac3Zhjkwpw+BLUfEM9v+prItOmmX2dU9vCtZ4hr9KS7A+TPkzWoBf0uoE89K0OgWoWaG3YjTsxVF5NE6mR2W1OASV2/WMFfMdCD5prHcIL4FHYOZIBave2HtZlpBgiysj0CDuNWx9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576446; c=relaxed/simple;
	bh=GwW53sXbjtLIT9Gbh34JwUOnACvyw7jyQS3PEkRNhcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PO5JtBnzIutCSV2S3Z+76PkZd8XyALSBgRDhF2JMyUCpgcl42Rs3JfhvwOuDBVr6sOK1myXWxsWowSR8QtFuwjLywVUUQeVqhCieB0/S9kzUJAOOj2Z0huoXpJEdN9ncXQ/IZ97SyENfb0vwHx6F7VgSm/NlovM9S0XTvBQpxaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EzbwkAsD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EzbwkAsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726576443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v98mJLLbcKiwFwyAyjVul8WkqY9q0rgMVp45uk9ZP5s=;
	b=EzbwkAsD0UN2qBtaoU6j0e6t7YLDPM5G2jid8S6xIQEg8SBHIF88Q3vrr9zWytkeSpTInY
	DQVrVzcCJiPoKIO+1k4I9Jw1jl2/2c0LSBgWkxI5xbLaz/la9BSqUbiIbysmaYJS77ZiAW
	TFaysZRl0U+iKVMZdh8CBrKg/mKO4/Y=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-fvjuN64rO-CRJVlYsyMnTA-1; Tue, 17 Sep 2024 08:34:02 -0400
X-MC-Unique: fvjuN64rO-CRJVlYsyMnTA-1
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-49bd58a2444so1424694137.2
        for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726576442; x=1727181242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v98mJLLbcKiwFwyAyjVul8WkqY9q0rgMVp45uk9ZP5s=;
        b=WRfRDlxtGL+a3GAe1y2lQkRCSo9//FWLPwO1hvXn2uD5L5s97KLuuC/1ePZL/TmhGq
         f5iz4/XcSe22ML0WSt8tbMLlixVzt7J3nnFKN8cL5j+8NYo+wEmkMyxTU3akmaIyL5d0
         gku/Y3Y53KB9SCiGef5C0L/j6Ac+gYRAYc04oM8qOvLuZrJhvTlpDe+LWy4PLPRAGbyq
         BuwAMwhayGooVUmrJK/HB6X5W7OFoORfWPbQqL/UGWpBJDtslk5LOlusFP8yTs5ZN1GR
         RpovXJaXBbHMOPAbk9xujf/d4a10ftxcecNIZ2fNqiC96ytg1ENCW4/ZPhNqHwsSuGED
         WljQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvXS6dCnd2rK7ZWn0NJfAa2aqPKmKfwAtp1flIdwdSPtqyXot8awPLk3rRvw/wssEfnOM0fPyQOZAMWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Io1j0tbXyiPPQW9enkfe0kz84sliQh9IlFE3MFoRn7kFStZu
	0BDipt8an0M5xRoRdJgin2o8jaID+2Sb0DNLKchUTnPD4eqwXzoIRn4NKcJwyXvrwNVuSaPlaL3
	NpmzcsPYL1cSbU64ncUgJvnFn+/2aQeKeebCzRG395fE/F67BnVMU8GXJm83YqjrGqWjn6nzKSZ
	/fwA8c2DRvQpQ/+VvT+5Epp5B1Q6HmOjjLXLc=
X-Received: by 2002:a05:6102:3a0f:b0:48f:8ead:7b7 with SMTP id ada2fe7eead31-49d4f6b8cfemr9452073137.21.1726576441785;
        Tue, 17 Sep 2024 05:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHA0vTtlOysis/HDemAr9gOTbXQdWHbBtcckR98WNovfiBYFHTQp/ubdNiWuaOubARujqB576ArElU/YElc3Ac=
X-Received: by 2002:a05:6102:3a0f:b0:48f:8ead:7b7 with SMTP id
 ada2fe7eead31-49d4f6b8cfemr9452052137.21.1726576441511; Tue, 17 Sep 2024
 05:34:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240917053258.128827-1-dlemoal@kernel.org> <20240917055331.GA2432@lst.de>
In-Reply-To: <20240917055331.GA2432@lst.de>
From: Ming Lei <ming.lei@redhat.com>
Date: Tue, 17 Sep 2024 20:33:50 +0800
Message-ID: <CAFj5m9JZe5g07YNVh6BL8ZixabRTrhx-AELxTxFNm9STM7gNzA@mail.gmail.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none" scheduler
To: Christoph Hellwig <hch@lst.de>
Cc: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	"Richard W . M . Jones" <rjones@redhat.com>, Jeff Moyer <jmoyer@redhat.com>, 
	Jiri Jaburek <jjaburek@redhat.com>, Bart Van Assche <bvanassche@acm.org>, Hannes Reinecke <hare@suse.de>, 
	Chaitanya Kulkarni <kch@nvidia.com>, "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 17, 2024 at 1:53=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Tue, Sep 17, 2024 at 02:32:58PM +0900, Damien Le Moal wrote:
> > Commit 734e1a860312 ("block: Prevent deadlocks when switching
> > elevators") introduced the function elv_iosched_load_module() to allow
> > loading an elevator module outside of elv_iosched_store() with the
> > target device queue not frozen, to avoid deadlocks. However, the "none"
> > scheduler does not have a module and as a result,
> > elv_iosched_load_module() always returns an error when trying to switch
> > to this valid scheduler.
> >
> > Fix this by checking that the requested scheduler is "none" and doing
> > nothing in that case.
>
> The old code before this commit simply ignored the request_module,
> just as most callers of it do.  I think that's the right approach
> here as well.

freeze queue is actually easy to cause deadlock, and old code is to not
do it everywhere.

Probably it may be more reliable to replace 'load_module' with 'no_freeze',
and not to freeze queue in case that 'no_freeze' is set in queue_attr_store=
().

queue_wb_lat_store() need no_freeze too since there is GFP_KERNEL
allocation involved.

Thanks,

