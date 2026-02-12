Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE29D1E5702
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770906174; cv=none; b=k7zkJH9PNfUgwgaLqc8hzkFHx1apsGgbCSp2TrlnsNUsFgNC1qAUr5U+flS3O99NffZiqWKbXgaQi8DxMBsPBZ2LD6+6ZOEzrEuQ7AqK1wUKpWKRBWqLagQlhWaO2wOr2TBASHu824MdUDM2OK8CxdYL/CeWANQq+GRcXEYtxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770906174; c=relaxed/simple;
	bh=wNfa2ftZ7WsZGTvhiItt4+sHdLdFsPahu9en+PGmAIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CmtbgC/+Ce4CZ+3rlbfV/yVOJVPtrllCWTIhMcwVq0hflhrMGvCQi00syBUzA+CQWuxxQrqShPrJJuO5DOlMpIXeA5SWahdgt8ekLmCLnjx7mQeu1P9KwQJb73zhVuhoSwUVUIWMWcl/Y/kw2s/+xZFvUexaL14QDFXyJ1FV4hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dbv5wWWG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dbv5wWWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770906172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ptFhSm65DCfj49xFpwwKLztH7AFNqHdJc1L/FQijGkI=;
	b=dbv5wWWGnaUrUbSEZe/aSB5wCtaqsnsODAD8tdHfnsAMPYmiSfyvQIuRIjwAfq4R+/z538
	4gxvKhYi7FvpZquYPDWC2P7BKGaoNkJxfoRRSzTwYvOXvfEz2ziA3I9FXa0Sxj2tvfEooz
	RbRLgbpP/UTaleca2PtJ+ZJq0CFly7I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-WfzRq2ZpME-c-kDlWc_HWw-1; Thu,
 12 Feb 2026 09:22:49 -0500
X-MC-Unique: WfzRq2ZpME-c-kDlWc_HWw-1
X-Mimecast-MFC-AGG-ID: WfzRq2ZpME-c-kDlWc_HWw_1770906168
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1AEF180025B;
	Thu, 12 Feb 2026 14:22:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.145])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D983D19560BB;
	Thu, 12 Feb 2026 14:22:44 +0000 (UTC)
Date: Thu, 12 Feb 2026 22:22:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: ublk invert part scan bit logic
Message-ID: <aY3iLwf8G3jKUIbw@fedora>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
 <aY3KpLbAOchXxXyi@fedora>
 <dfc5a8d3-45d3-4fe2-aa0b-b9571b5fb883@kernel.dk>
 <aY3PYGblTx748m4q@fedora>
 <e63cd486-cdf0-4c90-85a5-b2f15699e96d@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63cd486-cdf0-4c90-85a5-b2f15699e96d@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Feb 12, 2026 at 03:04:53PM +0100, Hannes Reinecke wrote:
> On 2/12/26 14:02, Ming Lei wrote:
> > On Thu, Feb 12, 2026 at 05:48:40AM -0700, Jens Axboe wrote:
> > > On 2/12/26 5:42 AM, Ming Lei wrote:
> > > > On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:
> > > > > Hi,
> > > > > 
> > > > > For ublk, there's this logic in in ublk_ctrl_start_dev():
> > > > > 
> > > > > /* Skip partition scan if disabled by user */
> > > > > if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> > > > > 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > > > > } else {
> > > > > 	/* Schedule async partition scan for trusted daemons */
> > > > > 	if (!ub->unprivileged_daemons)
> > > > > 		schedule_work(&ub->partition_scan_work);
> > > > > }
> > > > > 
> > > > > where the
> > > > > 
> > > > > clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > > > > 
> > > > > seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
> > > > > UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
> > > > > 
> > > > > 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")
> > > > 
> > > > Yeah, the interface is designed in this way: partition scan is not
> > > > done during add disk, and allowed since then on. The selftest code
> > > > is written in same way too.
> > > > 
> > > > If GD_SUPPRESS_PART_SCAN isn't cleared, userspace can't probe partitions
> > > > any more.
> > > > 
> > > > However, if you think the interface isn't good, we still can change it
> > > > before 7.0 release.
> > > 
> > > What I mean is, if UBLK_F_NO_AUTO_PART_SCAN is set, should we not
> > > either leave the disk->state alone, or _set_ GD_SUPPRESS_PART_SCAN?
> > 
> > UBLK_F_NO_AUTO_PART_SCAN means partition scanning isn't done automatically
> > from add_disk(), but it still allow userspace to send ioctl(BLKRRPART) for
> > probing partition since disk is added.
> > 
> > If GD_SUPPRESS_PART_SCAN is set, ioctl(BLKRRPART) can't succeed any more.
> > 
> > > I might be confused here, but the current implementation doesn't
> > > make much sense to me! If it is correct, then a comment to that
> > > effect would be good imho.
> > 
> > I admit it is a little confusing, will send a patch to document this
> > behavior if no one objects the UAPI.
> > 
> Is there a specific reason to continue to allow BLKRRPART if the
> UBLK_F_NO_AUTO_PART_SCAN is set? Wouldn't is be better to have a

No, I just want to allow future ioctl(BLKRRPART).

> simple 'UBLK_F_NO_PART_SCAN', which directly maps to GD_SUPPRESS_PART_SCAN?
> Would we lose something substantial in that case?

If there is, we may add new feature flag for it.

> 
> I actually would _like_ to be able to suppress partition scan
> completely for ublk devices...

Fine, we can change UBLK_F_NO_AUTO_PART_SCAN to align with GD_SUPPRESS_PART_SCAN.



Thanks,
Ming

