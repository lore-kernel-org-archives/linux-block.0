Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A3B652
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 02:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203423; cv=none; b=LrTrVpbVeUs+quSiCFYS8mL8F08kyEjh6BYlraU4ORmG5MH7HHC4ySVTBSsrbO0T+Goal9ZnM3Qw6dVo3HYZhIgKIVQHxYr2BlF/bIlu/80cgJMz4HCgby5cIq1TidK/T1rYSR2jceVI5n8LT9G2dJL6Jn18VqsgX8OviFT+6UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203423; c=relaxed/simple;
	bh=In0TgZWdjobO06X+6Ca59UCerldO8QKLHBS0UcAOvHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEbVM/iwEq3PsyOwZ0dwN0OUc/7x34fvaCDjbNBGZIL+1SBqJjOW2XfHETBgz5QEEcwaXQhjpQt92uqY1b2yxez00ln2tj3RuNttmpGKPLSBS11+FgQzj+WDuaOC+kb7d+8QYHI1cYobQXcmNVHNBiWrzJOLyHe5S7ZETFVUVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE3EJQkM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE3EJQkM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2L/wtxlkH2lkJo+AcH/YHxqs0ANqUne/vfFYH13GNg=;
	b=LE3EJQkMS7ia0RcdPHl+CuHmhcQ67i44el7ArA5hyEGH2dGchmRkYX6lKXCl0X95h+g1lB
	/aTFlmIX+O8es/AjleoO13UHdTQDiek0rQ2mQ3y8bX5xa6ogLRJvb/yFt6P5XGAVU4PwCQ
	S9y14wUGMNPtDGmEJhTCtKgFtCUEcjg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-Mwz9dLu1OzimqV9gTRYdYQ-1; Sun,
 20 Apr 2025 22:43:35 -0400
X-MC-Unique: Mwz9dLu1OzimqV9gTRYdYQ-1
X-Mimecast-MFC-AGG-ID: Mwz9dLu1OzimqV9gTRYdYQ_1745203414
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9AA6F1956087;
	Mon, 21 Apr 2025 02:43:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3D0291801778;
	Mon, 21 Apr 2025 02:43:30 +0000 (UTC)
Date: Mon, 21 Apr 2025 10:43:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Uday Shankar <ushankar@purestorage.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: ublk: Graceful Upgrade of ublk server application
Message-ID: <aAWwzm3IdpL8odQf@fedora>
References: <DM4PR12MB63282BE4C94D28AA2E1CACA0A9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_49m8awtNFsY8pl@fedora>
 <DM4PR12MB63285A6617D8A9B9F22B912BA9B22@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z/7/LTSxqLH7JgAl@dev-ushankar.dev.purestorage.com>
 <Z_8KO5uJfkB-SKvT@fedora>
 <DM4PR12MB632890760804D06B3CBC357AA9BD2@DM4PR12MB6328.namprd12.prod.outlook.com>
 <Z_90hHRXe7R3fQuk@fedora>
 <DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB632807AB7CDCE77D1E5AB7D0A9B92@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Yoav,

On Sun, Apr 20, 2025 at 08:57:23AM +0000, Yoav Cohen wrote:
> Hi Ming,
> 
> Thank you very much!
> The above seems to match our requirements.
> Just to be sure, Do you want me to Implement it and issue a patch or do you plan add it to your plan?

It is great if you'd like to implement the feature, and please add one
selftest case(add quiesce command & one test case) together with the
driver change.

Otherwise, I can add it to my todo list.

Thanks,
Ming

> 
> Thanks
> 
> ________________________________________
> From: Ming Lei <ming.lei@redhat.com>
> Sent: Wednesday, April 16, 2025 12:12 PM
> To: Yoav Cohen
> Cc: Uday Shankar; linux-block@vger.kernel.org; axboe@kernel.dk
> Subject: Re: ublk: Graceful Upgrade of ublk server application
> 
> External email: Use caution opening links or attachments
> 
> 
> On Wed, Apr 16, 2025 at 08:16:44AM +0000, Yoav Cohen wrote:
> > Hi,
> >
> > The use case is as you say to replace the binary (update) without making the bdev to disappear.
> > Currently I don't even use the user_copy(to avoid the 1 more system call) so the io buffer is also part of the sqe which is prevent me from free it from userspace perspective.
> > So yes, even ABORT_URING_CMD by given tag can be enough.
> > What do you think?
> 
> I think the requirement is reasonable, which could be one QUIESCE_DEV command:
> 
> - only usable for UBLK_F_USER_RECOVERY
> 
> - need ublk server cooperation for handling inflight IO command
> 
> - fallback to normal cancel code path in case that io_uring is exiting
> 
> The implementation shouldn't be hard:
> 
> - mark ubq->canceling as ture
>         - freeze request queue
>         - mark ubq->canceling as true
>         - unfreeze request queue
> 
> - canceling all uring_cmd with UBLK_IO_RES_ABORT (*)
>         - now there can't be new ublk IO request coming, and ublk server won't
>         send new uring_cmd too,
> 
>         - the gatekeeper code of __ublk_ch_uring_cmd() should be reliable to prevent
>         any new uring_cmd from malicious application, maybe need audit & refactoring
>         a bit
> 
>         - need ublk server to handle UBLK_IO_RES_ABORT correctly: release all
>           kinds resource, close ublk char device...
> 
> - wait until ublk char device is released by checking UB_STATE_OPEN
> 
> - now ublk state becomes UBLK_S_DEV_QUIESCED or UBLK_S_DEV_FAIL_IO,
> and userspace can replace the binary and recover device with new
> application via UBLK_CMD_START_USER_RECOVERY & UBLK_CMD_END_USER_RECOVERY
> 
> Please let us know if the above works for your requirement.
> 
> Thanks,
> Ming
> 

-- 
Ming

