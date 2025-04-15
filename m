Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A21DC9AF
	for <linux-block@vger.kernel.org>; Tue, 15 Apr 2025 11:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744715176; cv=none; b=k3/PhyxLvXyZLTh4AfDNLLhIDf7FRKbm9Zb8s+CrULdqkLjBzZsTEHUv1SX1Nv3vt0SBRYQO0ggpFuictjAtPJWuhAcNSAY0aJDCjBeJopHJm98KdI0QOjwYm/a201VEHXc7wcThwODSIQitOjVOiqhdA2EQwclnIkdN7lqxZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744715176; c=relaxed/simple;
	bh=0CfixCiorJe1MurjjiLeKO8BTdv0Nlaza2kNOaNEqOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeM8wuYIUPZ6TQijIO5YFnEQ1n2KByJmLx5B73ud+8dK/Ce5uOk1891mOPidxh+2FsFsAzy5wOi7pag6169aPIsM/Whw5q8xCJOum0AN7/lZOKPYQ9TSVseKOBjT/U0bbHup8NEqnpRnCznoEt5ilIUn0+O5N5VPvLb414iQmZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cx2fiRcl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cx2fiRcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744715173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckG36MYR3jHblBOrdgoUd/jq/vRy3uDeIgMJcgnZcnc=;
	b=cx2fiRcl4Sj7YBhzNaCuSoVrFIXQx709PMQ+ARCzgczmaI1fXV1iDpv5WnIlQtPd6pwDo3
	HCuvWALn7dtjjMu7cdVoOPatCl+J4dcq/1uZYpxceTtwS9gGjOs13MQ/iSH4snURSV2Utx
	Xi4gURDVEdwm+T2/U34by9awm8XssOQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-jpUgRbKYM_aVF17yuNo2gQ-1; Tue,
 15 Apr 2025 07:06:11 -0400
X-MC-Unique: jpUgRbKYM_aVF17yuNo2gQ-1
X-Mimecast-MFC-AGG-ID: jpUgRbKYM_aVF17yuNo2gQ_1744715171
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DAC21180035C;
	Tue, 15 Apr 2025 11:06:10 +0000 (UTC)
Received: from fedora (unknown [10.72.116.70])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20E21180175D;
	Tue, 15 Apr 2025 11:06:07 +0000 (UTC)
Date: Tue, 15 Apr 2025 19:06:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Message-ID: <Z_49m8awtNFsY8pl@fedora>
References: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Tue, Apr 15, 2025 at 08:15:08AM +0000, Yoav Cohen wrote:
> I am seeking advice on whether it is possible to upgrade the ublksrv version without terminating the daemon abruptly. Specifically, I would like the daemon to exit gracefully, ensuring all necessary cleanups are performed.
> In my current implementation, I attempted to cancel all ublk uring SQEs (specifically the COMMIT_AND_FETCH_REQ/FETCH_REQ operations) using the following approach:
> io_uring_prep_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);io_uring_prep_cancel_fd(sqe, cdev_fd, IORING_ASYNC_CANCEL_ALL);

That shouldn't work because COMMIT_AND_FETCH_REQ/FETCH_REQ has been
issued to ublk driver already.

> However, this method does not seem to be effective. In my scenario, I have a single io_uring instance that serves multiple devices and other producers, so simply stopping the polling of CQEs is not a viable solution due to potential race conditions.
> Could you please provide any suggestions or guidance on how to achieve a graceful upgrade of the ublksrv version without causing disruptions?
>  

You can delete all ublk devices handled by this single io_ring instance
first by sending UBLK_CMD_DEL_DEV, then exit ublk server loop if there
isn't any pending uring_cmd & target IO. And the ublk server need to stop
to issue COMMIT_AND_FETCH_REQ after getting uring_cmd with UBLK_IO_RES_ABORT.

I guess you want to send the control command in single pthread too?

If yes, it still can work with coroutine or modern language's .async/await.

This feature is actually in my todo list for libublk-rs, just not started
because of not seeing real requirement.


Thanks,
Ming

