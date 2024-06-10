Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140B72230F;
	Mon, 10 Jun 2024 19:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048036; cv=none; b=idC6r3zJdekcf7SNZbp5qhAiP/KfIcUUMRAtSPmMkVvWQU05+Fjl6XDJx4EnYMMQcr2lWQkRj4v3/mdkSb9Grh1abibmbajMLPlA+Sq/Npj0TMA+glsgloljslXMu3XQWUdExuXg7ykCC+kbTqpccybRpVjVkCGw7OUKcu09B+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048036; c=relaxed/simple;
	bh=Qk5Vp5/sI/Gldp06bVN/w//AsSVkw1JHkdQm2GlWS3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaAOAV7FyirTcKvqlJvu3ms57Fq4yNZOTLz+tcTQxYISH2UMrVbE8qbyKx3Fik0E3QXedKjZhu8BDS7NuqKvkEjiPXgc97j5II7bRH5g97n7mdZghYql8rjY/Hl30WNwhH8woqBHZhKYFvtmOuU3wxSlsDpCYwZaB1FCDMosOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRkBnj3q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRkBnj3q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A64C2BBFC;
	Mon, 10 Jun 2024 19:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718048035;
	bh=Qk5Vp5/sI/Gldp06bVN/w//AsSVkw1JHkdQm2GlWS3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRkBnj3qKLzKtc+3T5Oij/zRoN3CPoJC7GS5nVXb/86MZithcRd6sMyUvqmLiuTQq
	 pfdjVpplwIOj0hgPBKTLQwNVOUhWufQo/Nz3EGhkIw2Ap9qq7/2KJiSQtwlmrZav/R
	 Y4Fjx471dGhT/sWZ1ydiRA/gIiheH19aiatm3VQ7oCBB0M1L2INCSzXPTB6ja5tGj1
	 /vpAeA0tVtZw+i9nFLeqRhVi/DxX43c6938Ok5M3vcZPiMG8cGI3+PxKTyXelp9dry
	 MTyJEFng7Av4ucas1DQkJXLVpsQchgXgwgVtzS9X1c5qBRcisVuz5DZ6Lrs75vPqhd
	 TI7lq1JrELaNA==
Date: Mon, 10 Jun 2024 13:33:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
Subject: Re: Kernel OOPS while creating a NVMe Namespace
Message-ID: <ZmdVIfnqtweVt9ZN@kbusch-mbp.dhcp.thefacebook.com>
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
 <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
 <ZmdQuz8vJZMj41Kn@kbusch-mbp.dhcp.thefacebook.com>
 <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bccf1e1f-bc45-4052-9504-d852f9ae4e6c@grimberg.me>

On Mon, Jun 10, 2024 at 10:17:42PM +0300, Sagi Grimberg wrote:
> On 10/06/2024 22:15, Keith Busch wrote:
> > On Mon, Jun 10, 2024 at 10:05:00PM +0300, Sagi Grimberg wrote:
> > > 
> > > On 10/06/2024 21:53, Keith Busch wrote:
> > > > On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
> > > > > Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> > > > My mistake. The namespace remove list appears to be getting corrupted
> > > > because I'm using the wrong APIs to replace a "list_move_tail". This is
> > > > fixing the issue on my end:
> > > > 
> > > > ---
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 7c9f91314d366..c667290de5133 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
> > > >    	mutex_lock(&ctrl->namespaces_lock);
> > > >    	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> > > > -		if (ns->head->ns_id > nsid)
> > > > -			list_splice_init_rcu(&ns->list, &rm_list,
> > > > -					     synchronize_rcu);
> > > > +		if (ns->head->ns_id > nsid) {
> > > > +			list_del_rcu(&ns->list);
> > > > +			list_add_tail_rcu(&ns->list, &rm_list);
> > > > +		}
> > > >    	}
> > > >    	mutex_unlock(&ctrl->namespaces_lock);
> > > >    	synchronize_srcu(&ctrl->srcu);
> > > > --
> > > Can we add a reproducer for this in blktests? I'm assuming that we can
> > > easily trigger this
> > > with adding/removing nvmet namespaces?
> > I'm testing this with Namespace Manamgent commands, which nvmet doesn't
> > support. You can recreate the issue by detaching the last namespace.
> > 
> 
> I think the same will happen in a test that creates two namespaces and then
> echo 0 > ns/enable.

Looks like nvme/016 tess this. It's reporting as "passed" on my end, but
I don't think it's actually testing the driver as intended. Still
messing with it.
