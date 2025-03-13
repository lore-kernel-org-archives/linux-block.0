Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE1381A3
	for <linux-block@vger.kernel.org>; Thu, 13 Mar 2025 07:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852468; cv=none; b=kL7NKe+Kkt1gDZYeKfZ8t/BMnCcA/hXz5EnymRCUhScq6TROS5kIjRo8OfOMpUoi+zXZTg/6Y6S8lNcYDGv/2U6qxCq5PE6sCx2BeWbrmwAYoVP5X8mupWKsBpkw8BzJBbo40bU7z87PFiZBm1z7H87Rls0jEev7AzEfu73/Q7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852468; c=relaxed/simple;
	bh=bTW76qJ0WfK/jCI7vOMbguSglWE7r1xgW628o66kkLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXVFnCkW7dV2mv/wfIoAqy7hi/4U+cGMIxnDe9b4lySEIlOK++bJ7o+S51bfzMdun0OrIdLzPlJyTURMv0Gt8H9qmoqvivq5vr9GyzKfidXRUaah9q6KM5TKRL2agOBvpmBshFXb3XUl5pEHBvFbA22/Wo0f4NTh3H4uK+qI7Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F44268C4E; Thu, 13 Mar 2025 08:54:21 +0100 (CET)
Date: Thu, 13 Mar 2025 08:54:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-block@vger.kernel.org, ming.lei@redhat.com, dlemoal@kernel.org,
	hare@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: Re: [PATCH] block: protect debugfs attributes using
 q->elevator_lock
Message-ID: <20250313075421.GA12286@lst.de>
References: <20250312102903.3584358-1-nilay@linux.ibm.com> <20250312141251.GA13250@lst.de> <9e5fd5f1-1564-4a99-aeb4-6d8d9d765db7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e5fd5f1-1564-4a99-aeb4-6d8d9d765db7@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Mar 12, 2025 at 08:49:33PM +0530, Nilay Shroff wrote:
> > really want this read system call interrupted by random signals, do
> > we?  I guess this should be mutex_lock_killable.
> > 
> > (and the same for the existing methods this is copy and pasted from).
> > 
> I thought we wanted to interrupt using SIGINT (CTRL+C) in case user opens 
> this file using cat. Maybe that's more convenient than sending SIGKILL. 
> And yes I used mutex_lock_interruptible because for other attributes we are 
> already using it. But if mutex_lock_killable is preferred then I'd change it
> for all methods.

Let's leave it alone for this series.  While I think it's the wrong
choice it's been there for a long time, so we might as well not change
it now for unrelated reasons.

