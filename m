Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FF23ABB9
	for <linux-block@vger.kernel.org>; Sat,  4 Apr 2026 13:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775309328; cv=none; b=QCVL2OoxfK/Pc6t/1wSRKumyS7xNjDNaBUNddwdIn1WEJYjdx+ZTyjy3eNLZM6O9I5BssdIwwtWDNQaO2oU2tu3T1rTCG1dGg9Lr493NJR3ZQ3KppeFf9ssNua0vCMNHe7LeLtjj+XA6cLbVKRINEn9RoFcq7ThCQqbfZZ7+L9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775309328; c=relaxed/simple;
	bh=+Pg3y9uCZpZwx2gMNTmmSPXqOnhDGRer4BDuYSckX40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tj2Zb583+65cb7gzfgHMhpIeC8feYX1HcSy0b+hZ6c7kqcj2noxH2U8sVI7DBPxc/yig6n7hAhB7mGvnvZB/zrldPmphMe+Eo0hLzJlh3/iFDr6cZIbQBSKr8AcLTur9Q3ZGnCQ0o/0+Tz3iu2oYRWci9go0F5UTXvpzOfnw1rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRPlx414; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRPlx414"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775309325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rdgC9jmqU4elE5AoYVsNX/RMZxLg84P9OhHhc0kBzaE=;
	b=MRPlx414Szraqa0bvSW44GuDEpUX0NjgzWdArZagMDU40uA+xPRISBTVyREVoaaptVL8ox
	bN5KqDhLUdHB0j3RyPwydFVSC+dfY3gNYLtSlzQFiLWfHwy0fksRLq7/xd5LF6raHKrdei
	xXLFyVL9MeWtaFAG0hEoTLiiLYjhM2Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-rcW2SBgVM7GnIrMIQKFahA-1; Sat,
 04 Apr 2026 09:28:42 -0400
X-MC-Unique: rcW2SBgVM7GnIrMIQKFahA-1
X-Mimecast-MFC-AGG-ID: rcW2SBgVM7GnIrMIQKFahA_1775309321
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39E7E1800283;
	Sat,  4 Apr 2026 13:28:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536931955D84;
	Sat,  4 Apr 2026 13:28:33 +0000 (UTC)
Date: Sat, 4 Apr 2026 21:28:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] ublk: reset per-IO canceled flag on each fetch
Message-ID: <adER-jg0JfkE4I8n@fedora>
References: <20260403-cancel-v1-0-86e5a6b3d3af@purestorage.com>
 <20260403-cancel-v1-1-86e5a6b3d3af@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403-cancel-v1-1-86e5a6b3d3af@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Apr 03, 2026 at 09:23:55PM -0600, Uday Shankar wrote:
> If a ublk server starts recovering devices but dies before issuing fetch
> commands for all IOs, cancellation of the fetch commands that were
> successfully issued may never complete. This is because the per-IO
> canceled flag can remain set even after the fetch for that IO has been
> submitted - the per-IO canceled flags for all IOs in a queue are reset
> together only once all IOs for that queue have been fetched. So if a
> nonempty proper subset of the IOs for a queue are fetched when the ublk
> server dies, the IOs in that subset will never successfully be canceled,
> as their canceled flags remain set, and this prevents ublk_cancel_cmd
> from actually calling io_uring_cmd_done on the commands, despite the
> fact that they are outstanding.
> 
> Fix this by resetting the per-IO cancel flags immediately when each IO
> is fetched instead of waiting for all IOs for the queue (which may never
> happen).
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Fixes: 728cbac5fe21 ("ublk: move device reset into ublk_ch_release()")

Reviewed-by: Ming Lei <ming.lei@redhat.com>


thanks,
Ming

