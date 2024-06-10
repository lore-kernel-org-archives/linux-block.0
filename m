Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7744182B5;
	Mon, 10 Jun 2024 19:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718046910; cv=none; b=mXmgKWPU94QXnlF6aWl+pvwtF73lqyBTyEaegD2iPJMCWFBdzYGCibRHcc2MQZZFx1JX0+4ddWFyCY5HH51zLgKKNZUw+U+OakBkSG9CksyAAzSUF62r5UdRtQaM1S6CeQzZlb8JpNRBiaG2JmU7dsawlaG2w2/igfRKi1jlw7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718046910; c=relaxed/simple;
	bh=L7ZozjW/CAUgCkBG7Y7oL8z6so9aqPVMLj+1HaGaLFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paOfI0sQBfaWOpVZvzeaCQYBkAPXdjraIqrpjQYmlxCjIW2gfpOBcSrWbPacX8bIVgR/z+VI9B6ix1cOKZtLPhFPhZxxOhSV/yvR8ZWiaO+UBEp1ohtyC2YgXPPYnmZT79PVPdHw/PxqO0u1eyWSmnO96/xVlTimScRqUkmtCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC2wDHIu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC2wDHIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEA8C2BBFC;
	Mon, 10 Jun 2024 19:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718046910;
	bh=L7ZozjW/CAUgCkBG7Y7oL8z6so9aqPVMLj+1HaGaLFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aC2wDHIus0HXZO/CjsYD8+ikV+1Z/HZo7oKJy1yjj5PKXzrYk3ti49hNPhRELCyVi
	 4R/BH/sCRX/vfBS/qInp505tZQQhp9P8Dar0hZFrs9pJrmf7Cg/Bzi56EPiqJATsoo
	 qxw1cWZPSUNkQrrZQArXmZLyQLoFWsqGCKaouLP5sQLQBp/OsCUBu/dUD1SfGlCnuM
	 n9vXMRQ8h+NJ34+BZo9427kh5b9WYNTEZ+G5sT7DWlL8w5kQtgpQsYl9vnHVQ+FR0m
	 QlUT8nWVjRwSTT5LA2Bx6SAPqo1s+yDuTz8Y5bld4P3ndS3Y6xh64kblf0362SqK3x
	 dMMLKT0rMXBOQ==
Date: Mon, 10 Jun 2024 13:15:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>

On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
> 
> 
> On 10/06/2024 21:53, Keith Busch wrote:
> > On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> > > Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> > My mistake. The namespace remove list appears to be getting corrupted
> > because I'm using the wrong APIs to replace a "list_move_tail". This is
> > fixing the issue on my end:
> > 
> > ---
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 7c9f91314d366..c667290de5133 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> >   	mutex_lock(&ctrl->namespaces_lock);
> >   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > -		if (ns->head->ns_id > nsid)
> > -			list_splice_init_rcu(&ns->list, &rm_list,
> > -					     synchronize_rcu);
> > +		if (ns->head->ns_id > nsid) {
> > +			list_del_rcu(&ns->list);
> > +			list_add_tail_rcu(&ns->list, &rm_list);
> > +		}
> >   	}
> >   	mutex_unlock(&ctrl->namespaces_lock);
> >   	synchronize_srcu(&ctrl->srcu);
> > --
> 
> Can we add a reproducer for this in blktests? I'm assuming that we can
> easily trigger this
> with adding/removing nvmet namespaces?

I'm testing this with Namespace Manamgent commands, which nvmet doesn't
support. You can recreate the issue by detaching the last namespace.
