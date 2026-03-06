Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534F233CEBB
	for <linux-block@vger.kernel.org>; Fri,  6 Mar 2026 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772767054; cv=none; b=got3u3KP6ubL9KQBauCjnJLUhSenyqim6pPbkfYaKMFfRyHpB5tXvgVSAFi25bLEtkcsBv7gkM/L2FDIdmTt5e6E/HeG4LndAwuzk9/pEh1MP8PrCFeHpHktRQs4i1WyqvmuMuC9ovwFqyeqZSAfYKHp5zjkKZWWAHLf1lOCOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772767054; c=relaxed/simple;
	bh=Kwz+EBx2BAGOykkCJo/ZT700Gffm0roD+9YWlt+YudM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8S7dCOjpPkoFil68B7Bngc4tv/sCedXYxcZ0bfHHhk22XFaWWcAUMjqJZsCsYAH1XzrdDw7zr6V3B0aZn9QdM8c2newUzIAeDV7l9X2sN03lNRSFSf4JALxY7NBsevX3CA+0hV6SIKHR90+L7OJf+wu22MnZN40/mwE3q8eQoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JaUt9Geq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaUt9Geq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772767052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TVPDcQKfIjg1KiD+Q4Cc9N52PUKSErwuPqzr2O/KUKQ=;
	b=JaUt9GeqfJVDcvclhXqtAkOUU7OGPYoPWZCcPZ0jvitqHU9CHAFv5fPiMxVwZnNWNxDBDd
	tsZGmfiALCIdLCu6KIHv17WXlcpOkqjx/dsXZGSUVlQrqsrkm7nz5gd/sC5QTsUYakXSvI
	oe8UNwkxz6CUVtW/CSW/HI3F8oS2Swk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-_IEtg4TkP_Gbich3qNbZUQ-1; Thu,
 05 Mar 2026 22:17:28 -0500
X-MC-Unique: _IEtg4TkP_Gbich3qNbZUQ-1
X-Mimecast-MFC-AGG-ID: _IEtg4TkP_Gbich3qNbZUQ_1772767047
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 355AA1800344;
	Fri,  6 Mar 2026 03:17:27 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 486BC1800361;
	Fri,  6 Mar 2026 03:17:22 +0000 (UTC)
Date: Fri, 6 Mar 2026 11:17:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Mehul Rao <mehulrao@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ublk: fix NULL pointer dereference in
 ublk_ctrl_set_size()
Message-ID: <aapHPc07uU_dBwKG@fedora>
References: <20260305193146.304526-1-mehulrao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305193146.304526-1-mehulrao@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, Mar 05, 2026 at 02:31:46PM -0500, Mehul Rao wrote:
> ublk_ctrl_set_size() unconditionally dereferences ub->ub_disk via
> set_capacity_and_notify() without checking if it is NULL.
> 
> ub->ub_disk is NULL before UBLK_CMD_START_DEV completes (it is only
> assigned in ublk_ctrl_start_dev()) and after UBLK_CMD_STOP_DEV runs
> (ublk_detach_disk() sets it to NULL). Since the UBLK_CMD_UPDATE_SIZE
> handler performs no state validation, a user can trigger a NULL pointer
> dereference by sending UPDATE_SIZE to a device that has been added but
> not yet started, or one that has been stopped.
> 
> Fix this by checking ub->ub_disk under ub->mutex before dereferencing
> it, and returning -ENODEV if the disk is not available.
> 
> Fixes: 98b995660bff ("ublk: Add UBLK_U_CMD_UPDATE_SIZE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mehul Rao <mehulrao@gmail.com>

Looks fine given ublk_detach_disk() is called with ub->mutex grabbed:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

