Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDF3274FD5
	for <linux-block@vger.kernel.org>; Sat, 20 Sep 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758358480; cv=none; b=Paxypp25mqBOxJxIljM10cBjtRr9/X+/wnZYe/SydvoKV+tLqlP2ojD9z5mn+lG0TOoNLc3zIea1v/Cpx6sM7sZWRd2BlZZiv1jJ/0RvrcjnT5hDvGONDz4V2vejeFeAT+UBIpnZjZC1m5VeJrnIpg17B1T8ZWCeZ650is7agU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758358480; c=relaxed/simple;
	bh=4UjIHIMHVJP1B4x5ZHWcDInkdoATf6MI1a6CRrW0cB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxGO5q4zqMDBXhpt0MvfKL7nesbI+aSD97sXLN9ewGLsokbYzoUoFOJoN6VBXuuJmQymg7Q3Ib6P80MSpnXmNbmnCFaRDiASoZBcT2FNJHOwaKsdsppVNDruj4VLVjRjdl6TbzJJWgaVFNAJnIq23G1xMKpUzfDqYhkVt8CUSeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VHq7EOIs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VHq7EOIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758358477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+hHE4sdSr/iIbdI83gq3looRFTCEYUJKvUfL6ikBG0M=;
	b=VHq7EOIsnW6TmeRr6YAYr4HtMxjLPXptL+MJbsvQeYqBigBkytF28gkbOGnUtR8kItW5G6
	N8/tHNjsuzeXe39PiETAZNbvCZsOtE02cQ0QeGyWVE7KtrThpuFojlKzp2OHvACXxzK/5X
	LMhY5f9gCfAQCCh4hph3jcMpzdwAGV4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-xYtaVor1N26wk0DSFmji0w-1; Sat,
 20 Sep 2025 04:54:33 -0400
X-MC-Unique: xYtaVor1N26wk0DSFmji0w-1
X-Mimecast-MFC-AGG-ID: xYtaVor1N26wk0DSFmji0w_1758358472
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C3E719560AE;
	Sat, 20 Sep 2025 08:54:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 736F818004A3;
	Sat, 20 Sep 2025 08:54:27 +0000 (UTC)
Date: Sat, 20 Sep 2025 16:54:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/17] ublk: add helpers to check ublk_device flags
Message-ID: <aM5rvjGN68iwIixV@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Wed, Sep 17, 2025 at 07:49:40PM -0600, Caleb Sander Mateos wrote:
> Introduce ublk_device analogues of the ublk_queue flag helpers:
> - ublk_support_zero_copy() -> ublk_dev_support_user_copy()
> - ublk_support_auto_buf_reg() -> ublk_dev_support_auto_buf_reg()
> - ublk_support_user_copy() -> ublk_dev_support_user_copy()
> - ublk_need_map_io() -> ublk_dev_need_map_io()
> - ublk_need_req_ref() -> ublk_dev_need_req_ref()
> - ublk_need_get_data() -> ublk_dev_need_get_data()
> 
> These will be used in subsequent changes to avoid accessing the
> ublk_queue just for the flags, and instead use the ublk_device.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

