Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC93318EF7
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770901361; cv=none; b=UGxfz8RdagfLoo6UhA6xFhFsTCblH0YW4hQvNSsSyOjbtls4L9fo/F5FyMrk5fJ/HJYsPVg8ZA5xVE7CYj1J7WlxlyL3qOMuVFteaatL+6lY4y+60jqKYqlrreEDVymlhwdVa5MWjZuG/DBKmkRHrHbBYyS6fOYL27kZiv/dvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770901361; c=relaxed/simple;
	bh=nPAulLG18MWB/UxWpIYZL/kSbGji6qgpvlBf/VNVdJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJCOVO0BNDPm2gPaR8L0e8w+7I+G8ZM4E9930aFyB94aDkOKOU66lsp0ogElSzhjdGa1FqhonOY3ZiBqO/9aOIOOdOfK2UQ3LXbbUOIGRXd2vbIOQFb3th26H+oB71Vynpp/scv+iuiR7De1fQtzoK9DJJTB8OISxiVh3FehAek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XOJ/vo39; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XOJ/vo39"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770901359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ltFGZoGV7QrGTTfviVUIlXqOp/J0Al9OJh4yhgkYu+8=;
	b=XOJ/vo39PaoQWrC5ELRcRIyIuDaeTFgAyfJD1aGBz00d0/QP6EyHamUVoxEP4y5rj7e8I1
	aMMgPfRFhkJqYrU3KSAEYQrd+S2656NVaipSrW9A247fdZmBIiGCP9qdiVh25rKHryWzL+
	eNleSrqoDdjwSr5fHiJKHNpBOBqUuH0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-AtE4CMgyN7GYEBGRVBTjCg-1; Thu,
 12 Feb 2026 08:02:36 -0500
X-MC-Unique: AtE4CMgyN7GYEBGRVBTjCg-1
X-Mimecast-MFC-AGG-ID: AtE4CMgyN7GYEBGRVBTjCg_1770901355
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8918D1955BC1;
	Thu, 12 Feb 2026 13:02:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0720630001B9;
	Thu, 12 Feb 2026 13:02:30 +0000 (UTC)
Date: Thu, 12 Feb 2026 21:02:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: ublk invert part scan bit logic
Message-ID: <aY3PYGblTx748m4q@fedora>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora>
 <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Feb 12, 2026 at 05:48:40AM -0700, Jens Axboe wrote:
> On 2/12/26 5:42 AM, Ming Lei wrote:
> > On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:
> >> Hi,
> >>
> >> For ublk, there's this logic in in ublk_ctrl_start_dev():
> >>
> >> /* Skip partition scan if disabled by user */
> >> if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> >> 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >> } else {
> >> 	/* Schedule async partition scan for trusted daemons */
> >> 	if (!ub->unprivileged_daemons)
> >> 		schedule_work(&ub->partition_scan_work);
> >> }
> >>
> >> where the
> >>
> >> clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> >>
> >> seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
> >> UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
> >>
> >> 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > 
> > Yeah, the interface is designed in this way: partition scan is not
> > done during add disk, and allowed since then on. The selftest code
> > is written in same way too.
> > 
> > If GD_SUPPRESS_PART_SCAN isn't cleared, userspace can't probe partitions
> > any more.
> > 
> > However, if you think the interface isn't good, we still can change it
> > before 7.0 release.
> 
> What I mean is, if UBLK_F_NO_AUTO_PART_SCAN is set, should we not
> either leave the disk->state alone, or _set_ GD_SUPPRESS_PART_SCAN?

UBLK_F_NO_AUTO_PART_SCAN means partition scanning isn't done automatically
from add_disk(), but it still allow userspace to send ioctl(BLKRRPART) for
probing partition since disk is added.

If GD_SUPPRESS_PART_SCAN is set, ioctl(BLKRRPART) can't succeed any more.

> I might be confused here, but the current implementation doesn't
> make much sense to me! If it is correct, then a comment to that
> effect would be good imho.

I admit it is a little confusing, will send a patch to document this
behavior if no one objects the UAPI.


Thanks,
Ming

