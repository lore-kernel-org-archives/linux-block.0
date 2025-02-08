Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F72192B63
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 06:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738994614; cv=none; b=ccA0iwismyRvMI94m1HOmLlvXx9vrFL2vNLoHBGdES9O3dbNtjGft55D+/mSVWJcqZRe/FN/Xm+4mj07iE12k6BVuoruCUk+/j6TyQwV5tTV/UfS560zdEAVHxXCPASaBvzLAYDe2l6U04C4Z4yQIokyo3alX0QB6JJ+ZvPXbJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738994614; c=relaxed/simple;
	bh=pt1lbtIgr7gikrI67QWG8Z6Tb6L65EAFl9bnCU1j0HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBRvVrj8N1wQN+uwwiqDv6ZMcR9sYvHGJUfz8tG8HBP+DHWhBhvxKi3/aPCITWNhkWEb2uIeB2KL0OpwSPY2q0C9KGQp4hL270a3/Eft2M3K+WvT9jKxQGNs6m3iqSARXzaOw1o/bEhbPAXTXrREbDG2ZjYNwrvkoY45+IZim4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g7bN+elj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g7bN+elj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738994611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c6OS6U9D+hOy1jy/OSO1Sfa8rSRiwGjPfmP5Xx+YlE0=;
	b=g7bN+eljkVpAp7Ai6bXrcE10IucWcoqtdQRVV10dccZ/JW+BZgGHrWZ5XqsVw1W/3GR+2k
	f1kwRaM8RqoT5jeO727v18Tht8Bu9d/Vh5SitoSD8ZG0qYizZu8/WGZfLSEEVNdlAfF004
	rJQ8l+tX7EGTD+ejn7HrMLl8gZS9LM8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-L8xDllmeMN6NahUZGmbiRg-1; Sat,
 08 Feb 2025 01:03:29 -0500
X-MC-Unique: L8xDllmeMN6NahUZGmbiRg-1
X-Mimecast-MFC-AGG-ID: L8xDllmeMN6NahUZGmbiRg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0FE02180056F;
	Sat,  8 Feb 2025 06:03:29 +0000 (UTC)
Received: from fedora (unknown [10.72.116.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C4A1955BCB;
	Sat,  8 Feb 2025 06:03:25 +0000 (UTC)
Date: Sat, 8 Feb 2025 14:03:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Broomfield <mattysweeps@google.com>
Cc: linux-block@vger.kernel.org
Subject: Re: ublk: expose ublk device info in sysfs or support ioctls on
 ublk-control
Message-ID: <Z6bzpx5jxH3F8ebP@fedora>
References: <CALEiSPxGXy5faNFiiPt_tOF=K2cS=02RVdjw1JGuokNV7JPHJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALEiSPxGXy5faNFiiPt_tOF=K2cS=02RVdjw1JGuokNV7JPHJw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Feb 07, 2025 at 11:50:33AM -0800, Matthew Broomfield wrote:
> Hi all,
> 
> It would be great if there was a sysfs file which exposed "struct
> ublksrv_ctrl_dev_info" so programs written in languages without
> io_uring libraries (such as python) could easily read this information
> for management, testing, or record keeping. Ideally if possible this
> could be something like "/sys/block/ublkbX/ublk_info". Is this
> possible?

It is doable, but depends if it is necessary.

The device info can be stored in FS by ublk server, and the file
lifetime can be aligned with the ublk device, then python tool
can read it from FS directly.

> 
> Alternatively, the "/dev/ublk-control" file could support ioctls which
> mimic the io_uring cmds such as UBLK_CMD_GET_DEV_INFO,
> UBLK_CMD_ADD_DEV, etc. This would be more powerful as the block device
> lifecycle management program could be completely independent of both
> io_uring and the program which handles the block IO. However I'm
> skeptical it's worth it in the long run to create a ioctl -> io_uring
> adapter. (As opposed to languages natively supporting io_uring)

I'd suggest to not add ioctl, uring_cmd is async, which can help to
setup ublk device in completely async way, and I remember that someone
has asked if lots of ublk device can be created in single pthread
context.


Thanks,
Ming

