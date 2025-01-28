Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C80199EAF
	for <linux-block@vger.kernel.org>; Tue, 28 Jan 2025 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097313; cv=none; b=REcHRVRCf6J3fphthRn45a2XpyF59E0/A8wI1+0OM3SWEw+SUnij4tDq5UygPRH1rWas1mWJ0nP84sde4QP2vdG9/27iHpaEtCLr/s798VKxKPyV7GyhxydKuvBIrARXuIEtmHO88a2V17PtPVSjjx4RDwyVGpNGQsQ8S1PdbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097313; c=relaxed/simple;
	bh=SqAcUJVDLW5nHNMKisHe8H/jFx2DXWErnNKjZsm/nZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnKCpGg3ogN5JGHRU3wYAOSJ7hEGEGUvuO2O6SIOynCnyGV/L24GJ5Zd+IuBRl5rPf5Rt8AeL2Q7aIinJqlQTAFY3+7dx16ws+Csbpqu1xQxDUi69bT84la1cPM/fHicXawLPriWZuw2wwHFBykdWil4V10D3D9BowKy8KpfE/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa8SSbxr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa8SSbxr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FECC4CEE1;
	Tue, 28 Jan 2025 20:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738097313;
	bh=SqAcUJVDLW5nHNMKisHe8H/jFx2DXWErnNKjZsm/nZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oa8SSbxrjXToESKJD2K/lobE36/5Aofr01R2t1ffnCqR7n46f1LaOYdZft0marKx3
	 8YtEGTN+U8i0JxhcQUz6UNPwPD1BiVwpbKyybnsfVZRIVyXBhF+5e55c0gAX7n0DZT
	 xaqVYLdlgDGGa3zJE4vHx7FsfwAGDAjf69OydQNuxladpnCRVVh7zGiBYveFLjPDyL
	 BXfce3MO1P3ydRenC1YRMyDfOvvH9xrJ3T4QNpi4gVxw9jvlCuKqnHbE/twHDmj22O
	 bcmeTCsAl8lMloLX+g3TgF4vhbPFwjUuVd1VJtUEUg8dFxD6cbsSMrT1pP4Iajt/ou
	 wvDMH0GeAyPdQ==
Date: Tue, 28 Jan 2025 10:48:32 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: sooraj <sooraj20636@gmail.com>, linux-mm@kvack.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH] mm/bdi: fix race between cgwb_create and conflicting
 blkcg associations
Message-ID: <Z5lCoLgRTOwDZxNW@slm.duckdns.org>
References: <20250128075250.11500-1-sooraj20636@gmail.com>
 <20250127165311.f51b98290b548aff1df92a81@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127165311.f51b98290b548aff1df92a81@linux-foundation.org>

Hello,

On Mon, Jan 27, 2025 at 04:53:11PM -0800, Andrew Morton wrote:
> On Tue, 28 Jan 2025 02:52:50 -0500 sooraj <sooraj20636@gmail.com> wrote:
> 
> > Ensure cgwb (cgroup writeback) structures are uniquely associated with a
> > memcg-blkcg pair to prevent inconsistencies when concurrent cgwb_create
> > calls race. This resolves a scenario where two threads creating cgwbs
> > for the same memory cgroup (memcg) but different I/O control groups (blkcg)
> > could insert conflicting entries.
> > 
> > The fix rechecks for existing cgwbs under the cgwb_lock spinlock after
> > initial creation. If a conflicting cgwb (same memcg, different blkcg) is
> > found, it is killed before inserting the new entry. This guarantees a
> > 1:1 relationship between memcg-blkcg pairs and their cgwbs, preserving
> > system invariants.

I'm a bit confused. Radix tree doesn't allow two entries to be inserted on
the same key and the tree is keyed by memcg_id. Wouldn't that automatically
guarantee 1:1 relationship?

Thanks.

-- 
tejun
