Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AFD2F4321
	for <linux-block@vger.kernel.org>; Thu, 12 Jun 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749719725; cv=none; b=Pbe6svEVjDPsz4j4w3ZoufJ/iXGqS5Yw7KfMwRl1ALN7EkbL5tHp6nUj9OaqDjSPNXjlSTS4GT1th7jq92u9wh5I/TBxiFky1SIlhgPoPB7uuPD6KQYIzzsFE33kzooni7/yU2NUFGOvgF2QU1UlRTVW+EJE2zlKeOFWGptyWws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749719725; c=relaxed/simple;
	bh=z4rgWb483Ejeal2uTAb+GxAgPrXO88mQqxqt+839oNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJXC5M0eldgbZRJWXNmy3w51AELHow7CdqHqkwEaUUA+V7cMsyJ95Hays5Heo9d9KhN6SMyOO8Q3ZED/VedmDKIenhGFCxoKQ/+X1rdf4dczP7mJs6S1+iRNmBOiuE0XO1/kNyIyDAk+/djq9l1wDtR4zssr1X6wkHFASa+sX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxEN2ty+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxEN2ty+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749719722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oB5kKrQszqFfN2d56va2aa2yQHxZtAWM5mZO8C2ij8w=;
	b=CxEN2ty+TqqvKUxUY4/n98HxaF0hi45obM8FjW5c5vDKahrxuQdURJV5bKC7xIbPsSIw/U
	C/beaY51IqzmvNPsoc6BDx0xcZVzyZLqY0mKalwclTyF0Z1bWP+rMXnt74fFNmFQqeVzY3
	PuvlMcJ9PAVfvXLuiuLbG5+svPL+eNc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-nXnSBYl-NLaElXaLknJCIw-1; Thu,
 12 Jun 2025 05:15:19 -0400
X-MC-Unique: nXnSBYl-NLaElXaLknJCIw-1
X-Mimecast-MFC-AGG-ID: nXnSBYl-NLaElXaLknJCIw_1749719718
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1AE4619560BD;
	Thu, 12 Jun 2025 09:15:18 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD4A19560B2;
	Thu, 12 Jun 2025 09:15:13 +0000 (UTC)
Date: Thu, 12 Jun 2025 17:15:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 2/3] ublk: add feature UBLK_F_QUIESCE
Message-ID: <aEqanYVjHgVOjcwR@fedora>
References: <20250522163523.406289-1-ming.lei@redhat.com>
 <20250522163523.406289-3-ming.lei@redhat.com>
 <DM4PR12MB6328039487A411B3AF0C678BA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEK6uZBU1qeJLmXe@fedora>
 <DM4PR12MB6328BB31153930B5D0F3A3C7A968A@DM4PR12MB6328.namprd12.prod.outlook.com>
 <aEWfWynspv75UJlZ@fedora>
 <DM4PR12MB63280BC70C29A91E973E8080A974A@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB63280BC70C29A91E973E8080A974A@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Thu, Jun 12, 2025 at 08:17:49AM +0000, Yoav Cohen wrote:
> Hi Ming,
> 
> Thank you very much, I managed to integrate the feature to our application and it seems to work perfectly fine during our update tests.
> Just a double check: when UBLK_F_USER_RECOVERY & UBLK_F_USER_RECOVERY_REISSUE
> and QUIECE_DEV was called - does any IO that will be completed using COMMIT_AND_FETCH with a failure (i.e result=-EIO) will be retry after the recovery stage?
> 

UBLK_F_USER_RECOVERY_REISSUE supposes all inflight IOs are failed, so
these IOs will be re-delivered to ublk server after recovering to LIVE.

So you needn't to complete the IOs with -EIO for retrying them during
recovery, in short:

- if ublk server handles inflight IOs, complete them by sending COMMIT_AND_FETCH
with result before closing '/dev/ublkcN', and these IOs will not be re-issued
by driver after recovery

- otherwise, just ignore & discard inflight IOs, they all will be
re-issued by driver after recovery via UBLK_F_USER_RECOVERY_REISSUE.


Thanks,
Ming

