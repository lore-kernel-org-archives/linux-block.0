Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB102EACD
	for <linux-block@vger.kernel.org>; Tue, 17 Sep 2024 05:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726552419; cv=none; b=JPBNiFYOpQMjqRDYJ/o565e4oaYRCDxDQxmC5hpxO8g/N7nQavAonP8O2+yuwZbIkfxViteOBRr6wI1H7jaMZV7sNmzDuPNKWboqd6bb8qIKB9fPsmcp+mO6mJkEU6QlblHkPwItfwfXsTWAO3JB45OAdfX6wLlOJBPNqAN2be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726552419; c=relaxed/simple;
	bh=gy6tfK3aXAgqFmEuv8nqRBsHR4UVtJ+/2nKwh+Pix8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCVigQddF5MJ46/1XN+O42El2MjzcW+qNqp5wSQjMcKBg16CQJ6VEHBwhKTr1wPIZ5sXt9+fJOFoHu75fFyWx7eb7qE37lVl8plMxVqwMmA2vdnjMHxvqFXKTtLYNK1d+f3IOckDhrKeL7BbvWQpEfEZytq/EcaH3fkZp7iuAnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5731227ACB; Tue, 17 Sep 2024 07:53:31 +0200 (CEST)
Date: Tue, 17 Sep 2024 07:53:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Ming Lei <ming.lei@redhat.com>, Jeff Moyer <jmoyer@redhat.com>,
	Jiri Jaburek <jjaburek@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] block: Fix elv_iosched_local_module handling of "none"
 scheduler
Message-ID: <20240917055331.GA2432@lst.de>
References: <20240917053258.128827-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240917053258.128827-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Sep 17, 2024 at 02:32:58PM +0900, Damien Le Moal wrote:
> Commit 734e1a860312 ("block: Prevent deadlocks when switching
> elevators") introduced the function elv_iosched_load_module() to allow
> loading an elevator module outside of elv_iosched_store() with the
> target device queue not frozen, to avoid deadlocks. However, the "none"
> scheduler does not have a module and as a result,
> elv_iosched_load_module() always returns an error when trying to switch
> to this valid scheduler.
> 
> Fix this by checking that the requested scheduler is "none" and doing
> nothing in that case.

The old code before this commit simply ignored the request_module,
just as most callers of it do.  I think that's the right approach
here as well.

