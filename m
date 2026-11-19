Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=128.30.2.78
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795058964;
	b=G/vOI6/x3llEYrnPC7z+/NPqjtPDXawNlNRLy3OaomE5b6GILLCKeWMuP6zW2dNHCJgv
	 tud44IBwPyRlzPcG7DZBX9KCwbiksJwoOpdlctja8qe0iAnN6bSn3TGL+WXSHJWql0YEN
	 CYSvTXsZDVQPR0hPbxMXNSQvzSoXJ/+724t4X56MSDQS0Q4Z3dP2VxlPxZmVVvcDcYkvt
	 4cHo4qpatGYZonGU1DgCtpgEK5CyoChq+KAUasMfMyy/zT6/8Zhn1YRwYa08ZCLD3DLX/
	 RCylKDNq4THAEqx0zI8Jx0zVqdLH1+2UR2Dkr5AS4Ab6YqzrlGeC3U7jV7LbpeeSyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795058964;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=YO823eDLJQHWN5O46rkPXSW+9PcURe41/AAnelQaq7k=;
	b=lcM9fsYcSr9Wp9wEdP8/8n3f2MJt3aHmyDL/p1xgTCc8hSBrdQgHRXkMtEqhFywqL5BU
	 X47UaDnxXXsuZfkRcmYRtPajTJkUAwj9hTfkF+7d+AO1KeRQR/3gVsX0zNR4ohiFEzA2q
	 hrnNfPlJT7lfFZ46FKfpvfU+HXkMxsxqFztnTNL/5RMUc5nVl7PgCbfYfc1jybzQ7dQCS
	 2bxaNbMZsdS2Q2rFhuNdZxUwvfRSLg6MXcJq7TCeB9iOZs2BLYXUiea7cF3aTA3iSmBbu
	 MJg/WUeVYsTvZ6/sx5tbEB8rbBzUrYJ5OIPb5AsWZ+0ai/GwhYeKudSyKUjEOxBo2xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=csail.mit.edu;
	spf=pass smtp.mailfrom=csail.mit.edu;
	dkim=pass header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=wuqDbME1;
	arc=none smtp.remote-ip=128.30.2.78
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF531606A320;
	Thu, 19 Nov 2026 03:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF531606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.a=rsa-sha256 header.s=test20231205 header.b=wuqDbME1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YO823eDLJQHWN5O46rkPXSW+9PcURe41/AAnelQaq7k=; t=1795058963; x=1795922963; 
	b=wuqDbME1s8LJpzb9tkX1pS5ixyD7UgUhXxIBNfazENz5/qLLfhRNwwRUlLG3OWdyVTRdL6OWKsz
	dMrWF2KQ3fF0y9lI+9F0BO5KOZAOZyK0zzccVGmCejFrmZJUPfP0LpQeqZc7dLiVifUQaNfClguIi
	4hrRT48MMjYS/zS3nBAanckHOUwa9VH2OCgXhMKdQMWE5pw86PnrKhYsxzstdAXYCS6bNFE6KOhcH
	KeN1eUmLHy4kOQTvkEz28fdg/VyCf3g+538jT85XBfEM/izBSHPo6vqx5EvPkG6/qAqHLPo5zsuh3
	E6dHBmMpRqcKS89VE+UOv3Ck+714uDI8vFAg==;
Received: from [49.207.212.66] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1xTspp-001dIL-0i;
	Wed, 18 Nov 2026 22:29:17 -0500
Date: Thu, 19 Nov 2026 08:59:08 +0530
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Keith Busch <kbusch@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Jens Axboe <axboe@kernel.dk>, Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] block: Fix NULL pointer dereference in
 blk_mq_complete_request_remote
Message-ID: <av5tBNfe4TWqywzS@csail.mit.edu>
References: <20261119-fix-blk-mq-null-ptr-deref-v1-1-9bcbcfcfaff8@csail.mit.edu>
 <av4QS4NK1qL1QPCt@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <av4b9EN8n9t0jjeC@kbusch-mbp>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <av4b9EN8n9t0jjeC@kbusch-mbp>

On Wed, Nov 18, 2026 at 02:43:16PM -0700, Keith Busch wrote:
> On Wed, Nov 18, 2026 at 03:53:31PM -0500, Hamza Mahfooz wrote:
> > On Thu, Nov 19, 2026 at 12:58:44AM +0530, Srivatsa S. Bhat (Microsoft) wrote:
> > > Add NULL pointer validation in blk_mq_complete_request_remote() to
> > > prevent kernel crashes when block drivers pass freed request structures.
> > > 
> > 
> > This looks a lot like a driver bug, so it's probably best to hunt that
> > down instead of trying to work around it here.
> 
> It would be better to go another level lower and fix the broken
> hardware. The "bug" is describing device behavior too far outside
> protocol to be usable.

Ah, I see. It was actually a firmware bug and it was root-caused and
fixed already, and that's why I'm not able to reproduce the crash
anymore (as it is not that straight-forward for me to revert back to
the buggy firmware environment).

Thank you Hamza and Keith for the feedback - I can now see where the
pushback is coming from. My bad, I should've been clearer about the
firmware fix -- without that clarification about the firmware bug being
fixed, I can totally see why this sounds like adding a workaround in
the kernel instead. I did add a note in the patch notes saying I'm not
able to repro the crash anymore, but I should've been clearer as to
*why* that's the case and not leave it as a mystery :-)

My motivation for this patch was to reduce the severity of the impact,
should a similar underlying hardware/firmware bug occur in the future
for any other platform. Instead of causing a kernel panic and bringing
down the entire system, I was hoping that the NULL check could help
isolate it down to just failed I/O operations (along with a warning to
help with investigation).

But the sashiko review also seems to be hinting that such a NULL check
is insufficient and won't be race-free, even if we wanted to go down
that route of isolating the fault than panicking the kernel. (I had
also noted down my own question and uncertainty about the rq->state
management in the patch notes).

So, my takeaway from this discussion is that this is probably best
left as is in the kernel, since it complicates blk-mq recovery (a
simple NULL check being insufficient), and instead rely on the
firmware/hardware working correctly for this scenario.

Thank you!

Regards,
Srivatsa
