Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442C29A9ED
	for <linux-block@vger.kernel.org>; Mon,  7 Jul 2025 14:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751897922; cv=none; b=KlGLZamXQoDFXmT5lk/jj9DNsrVyvZ2T/IMf7EZGstRVEzfFJ1TPPne1EVff8VmF23uOILMCNBFZgRVBNToJNPNN3y/7UbaGJgUVwclgEyVezn71nRQTXqYselrj0eiCp4T+gyGiM0/lRlZPrzhpXBUcDq9FNPWbY+yXrsb0ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751897922; c=relaxed/simple;
	bh=vc/3+CgThDGMIVO83uKF9zpezircqbtNPggYoNL6JTo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FKHX4oTsxJkYDJfeCzwm568La9b1Lr+VuPcZzwRp+9lqIyZmZ64pz5CA29nxE3pW9TVkBVRgnxbfRzGn8R4JG8TKpCtwveTpQ4WjoH6Pu5FtJMD63PPQ7NCou1xsWlb2JB+1JnJ3xTtzpRqAMMsFf9ha6dRVSIb2/r6Uvl/CHfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A872468C7B; Mon,  7 Jul 2025 16:18:34 +0200 (CEST)
Date: Mon, 7 Jul 2025 16:18:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>,
	Keith Busch <kbusch@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Subject: What should we do about the nvme atomics mess?
Message-ID: <20250707141834.GA30198@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)

Hi all,

I'm a bit lost on what to do about the sad state of NVMe atomic writes.

As a short reminder the main issues are:

 1) there is no flag on a command to request atomic (aka non-torn)
    behavior, instead writes adhering to the atomicy requirements will
    never be torn, and writes not adhering them can be torn any time.
    This differs from SCSI where atomic writes have to be be explicitly
    requested and fail when they can't be satisfied
 2) the original way to indicate the main atomicy limit is the AWUPF
    field, which is in Identify Controller, but specified in logical
    blocks which only exist at a namespace layer.  This a) lead to
    various problems because the limit is a mess when namespace have
    different logical block sizes, and it b) also causes additional
    issues because NVMe allows it to be different for different
    controllers in the same subsystem.

Commit 8695f060a029 added some sanity checks to deal with issue 2b,
but we kept running into more issues with it.  Partially because
the check wasn't quite correct, but also because we've gotten
reports of controllers that change the AWUPF value when reformatting
namespaces to deal with issue 2a.

And I'm a bit lost on what to do here.

We could:

 I.	 revert the check and the subsequent fixup.  If you really want
         to use the nvme atomics you already better pray a lot anyway
	 due to issue 1)
 II.	 limit the check to multi-controller subsystems
 III.	 don't allow atomics on controllers that only report AWUPF and
 	 limit support to controllers that support that more sanely
	 defined NAWUPF

I guess for 6.16 we are limited to I. to bring us back to the previous
state, but I have a really bad gut feeling about it given the really
bad spec language and a lot of low quality NVMe implementations we're
seeing these days.
 not the 
