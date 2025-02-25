Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD122222D9
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524220; cv=none; b=IQWc/FPILkdbrtaLKCcRfwjsNt59S3+A6AIDmixrqaFPF0lFrcI2c1bE6avxJd19qbxKI9qTyFxx8uVYT/7Eg8aCMDB7IHsMyspYbFzV1cLoFDy+os23RmViZVStmaXXca/vjSZ+scB3BxZh63HxoEb4WLZHe6JR0RpM6CM4XGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524220; c=relaxed/simple;
	bh=GMPzrLo8gcPNCb+c1FxvtRjNMUFwtEy138bRJue0iJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLK15FdErky+EyGD0qF9nchx7Ya0SLhkt972A2dQW+tvll3jO9HAoNFDayqOBiP0mctgkfeZNB8i2i8kgNuJ8nOpJq+wq00sk/fw9zWXph6E7GE2MVD2h87iw4CAbdHK/svsQoW760yKPuRJaOsRWIBVO5pUTmxxPRbWeh7yZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtYwDlaQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtYwDlaQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740524217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1MIExbY5lASb2t4DcFKWsWFPWydwcu/0GgTo18o9k4g=;
	b=AtYwDlaQ+oOfFIWBdpyRBOMHOU8/Jl9StX5oS4kUc+QqdOnDs4N4Josm5x7zUyh/yx23g8
	QT2GSjvQI7O8Tgijgr2Xy6i32EQ0dWGLAMg9DfCosbamNJtGd7IVsYTr/QFjYeFWro84UD
	zJw5DzZ3YxvDkX8tD8DiT6jq5sXHxak=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-gxNZfSALOQ-X3pKRAckKrQ-1; Tue,
 25 Feb 2025 17:56:53 -0500
X-MC-Unique: gxNZfSALOQ-X3pKRAckKrQ-1
X-Mimecast-MFC-AGG-ID: gxNZfSALOQ-X3pKRAckKrQ_1740524212
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5EE180034E;
	Tue, 25 Feb 2025 22:56:52 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B6D5C300018D;
	Tue, 25 Feb 2025 22:56:46 +0000 (UTC)
Date: Wed, 26 Feb 2025 06:56:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, asml.silence@gmail.com, axboe@kernel.dk,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	bernd@bsbernd.com, csander@purestorage.com
Subject: Re: [PATCHv5 09/11] ublk: zc register/unregister bvec
Message-ID: <Z75KqctKnQCyyRiR@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-10-kbusch@meta.com>
 <Z72itckfQq5p6xC2@fedora>
 <Z73xUhaRezPMy_Dz@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z73xUhaRezPMy_Dz@kbusch-mbp>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Feb 25, 2025 at 09:35:30AM -0700, Keith Busch wrote:
> On Tue, Feb 25, 2025 at 07:00:05PM +0800, Ming Lei wrote:
> > On Mon, Feb 24, 2025 at 01:31:14PM -0800, Keith Busch wrote:
> > >  static inline bool ublk_dev_is_user_copy(const struct ublk_device *ub)
> > >  {
> > > -	return ub->dev_info.flags & UBLK_F_USER_COPY;
> > > +	return ub->dev_info.flags & (UBLK_F_USER_COPY | UBLK_F_SUPPORT_ZERO_COPY);
> > >  }
> > 
> > I'd suggest to set UBLK_F_USER_COPY explicitly either from userspace or
> > kernel side.
> > 
> > One reason is that UBLK_F_UNPRIVILEGED_DEV mode can't work for both.
> 
> In my reference implementation using ublksrv, I had the userspace
> explicitly setting F_USER_COPY automatically if zero copy was requested.
> Is that what you mean? Or do you need the kernel side to set both flags
> if zero copy is requested too?

Then the driver side has to validate the setting, and fail ZERO_COPY if
F_USER_COPY isn't set.

> 
> I actually have a newer diff for ublksrv making use of the SQE links.
> I'll send that out with the next update since it looks like there will
> need to be at least one more version.
> 
> Relevant part from the cover letter,
> https://lore.kernel.org/io-uring/20250203154517.937623-1-kbusch@meta.com/

OK, I will try to cook a ublk selftest in kernel tree so that the
cross-subsystem change can be covered a bit easier.



Thanks,
Ming

