Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF922417E0
	for <linux-block@vger.kernel.org>; Fri,  7 Feb 2025 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738895972; cv=none; b=RdIh4G/urnedDNzhNZDahilqbmjhyElzNR9GtVEGOpPb6RDurDzVVsSzOJOlpjzd8YhWQQw0hQ16plx8I3z+fC8DOQR3i8Khv9OdwnheE03XH5mpiOhuJ4TK/KCr5D3We9zpHldNM0/8aXZHVjryhIHrCsnuHpBvXKbNKUoaQxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738895972; c=relaxed/simple;
	bh=JvWA+gZnFGD2Wx2vPDVpWjjmg4vdJ41Wksr+oWa4f9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8iWyHzF+pBab6dGVwzKCXXWVWe3WMJ9WXShZuCCOENa0Pg/o0aeFk4JGUjD1/ijEWVn5UImAUSUxSProJrb4KEpsAa9+q2ic3debm96PlN7S2S8r6fNbOcQK702HSNLSOrkBjHjDMnWXcuvKRUyPHSTT3DQPGJhXSABkQh6V6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HIDPHUGW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HIDPHUGW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738895968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D+JWHUT7Z1fxT+zobpObJB9SyncARUjxWk08EF0gQHs=;
	b=HIDPHUGWj3HWR/loHPxuuJq/H2ThMhB2qYGp+xqKQEjLIvia9pSZgW2HJTKuYEan/zeTMs
	Wyv/6dAfD3FCLcTrhiVE5pMghxy/eS7M2T3Bjia+FCpmUQguMzUMiI1wosxoozshLFYzJj
	qo9N5yYH//Av5KqwJ+MbjfmJvmWKsIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-572-Vr_6rdGRPUasFcAkfSDETA-1; Thu,
 06 Feb 2025 21:39:25 -0500
X-MC-Unique: Vr_6rdGRPUasFcAkfSDETA-1
X-Mimecast-MFC-AGG-ID: Vr_6rdGRPUasFcAkfSDETA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 87F931956094;
	Fri,  7 Feb 2025 02:39:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.126])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 001DF19560AE;
	Fri,  7 Feb 2025 02:39:21 +0000 (UTC)
Date: Fri, 7 Feb 2025 10:39:16 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Rick Koch <mr.rickkoch@gmail.com>
Cc: linux-block@vger.kernel.org
Subject: Re: Kernel Oops in __blk_mq_all_tag_iter() using Raxda CM5
Message-ID: <Z6VyVEIP-228PiPb@fedora>
References: <CANa58eceasto+EzkRKp+10vLfUfi_O8gkc9mtu0PR01=o7-ACQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANa58eceasto+EzkRKp+10vLfUfi_O8gkc9mtu0PR01=o7-ACQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Feb 06, 2025 at 10:29:34AM -0500, Rick Koch wrote:
> Hello linux-block,
> 
> I am seeing a kernel Oops in early booting up of a Radxa CM5 board running
> Armbian
> on a 6.12.7 kernel.
> 
> I had reported a very similar Oops back on 2024-10-11 (Oct 11, 2024)
> 
> https://lore.kernel.org/all/CANa58ee6EeT9V7Q=epoZdqYw3sLh1CZGNWqJ0UcKMp6eRfcd+Q@mail.gmail.com/T/
> 
> Which you had provided me with a patch that fixed the issue and has not
> occurred again.
> 
> Here is the current Oops I am experiencing, maybe 1 out of every 10 boots.
> It does lockup after this, requiring me to re-power/boot the board.
> 
> Starting kernel ...
> 
> [    1.582430] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> [    1.582984] Modules linked in:
> [    1.583256] CPU: 6 UID: 0 PID: 46 Comm: cpuhp/6 Not tainted
> 6.12.7-edge-rockchip64 #7
> [    1.583942] Hardware name: Saturn SDR, Radxa CM5, 8inch LCD/Touch panel
> (DT)
> [    1.584557] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
> BTYPE=--)
> [    1.585167] pc : __blk_mq_all_tag_iter+0x3c/0x274
> [    1.585584] lr : blk_mq_all_tag_iter+0x14/0x20

Can you share where '__blk_mq_all_tag_iter+0x3c' points to?

Also running kernel with KASAN enabled often provides more helpful hint.



Thanks,
Ming

