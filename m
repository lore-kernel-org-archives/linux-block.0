Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223731F8BD6
	for <linux-block@vger.kernel.org>; Tue,  2 Sep 2025 02:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756780303; cv=none; b=XG+4TZK2qi41uqp0beVajCNt2fnMhlTVCeKBspe1qEKfsA1Hze6dz5rIAGH/ifDDb+L64RxjGZSqAmd64La8yFL687BkUEyJCHLiDQJYJgDZn1Ljx0I6OS6Ljs1pgmmIYXQ7VMiyxXpxsEf0OcNxtXSWKfMnEQz/d9FdzoSHUHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756780303; c=relaxed/simple;
	bh=7ApC/acdwadMqj0NCJITjFFJBG57saxendR1ww3jhq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USd/oxhsWn6ORmXz3xaVP5CVE4kJ+2s4bPgXbTwhIaXN/pPEbMaoUHMwb+LNyvOhsx48Lxj1K1nAygbSbuokUNTYfEl+bqCYfv7qO00aby8IOiU4RIuoBmvsKG+nHM6MpP2+4/PHK9iEdWNHTDn7tUeJ3VsT+I5S44/B2HFneYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPN3uNQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPN3uNQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756780300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=njm65XEI3r6LnTykyxWauJUuVmjmoM9IX37ukLvXumI=;
	b=ZPN3uNQf8PN8jcs4FCppdkqhCM4FwOQWLLTEsGxRCn7nYJ75WaD9WjRRO0QFck12fpMJ+/
	vQR3SOhaFrbB4pDQuaIB+sX+aeZNfX2JMh7DdOyKxyj6UB9PR5G6wNXf/ayzYbEBprUWJR
	HwAxyqdmklz5nC75Jf4S+l8EH6iXvCs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-aFmXmTyZO92hZ-WrvtEzxA-1; Mon,
 01 Sep 2025 22:31:39 -0400
X-MC-Unique: aFmXmTyZO92hZ-WrvtEzxA-1
X-Mimecast-MFC-AGG-ID: aFmXmTyZO92hZ-WrvtEzxA_1756780298
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F198C180036E;
	Tue,  2 Sep 2025 02:31:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.121])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1749D30001A2;
	Tue,  2 Sep 2025 02:31:33 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:31:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: inline __ublk_ch_uring_cmd()
Message-ID: <aLZXAExxsZAuZyeZ@fedora>
References: <20250808153251.282107-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808153251.282107-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Aug 08, 2025 at 09:32:50AM -0600, Caleb Sander Mateos wrote:
> ublk_ch_uring_cmd_local() is a thin wrapper around __ublk_ch_uring_cmd()
> that copies the ublksrv_io_cmd from user-mapped memory to the stack
> using READ_ONCE(). This ublksrv_io_cmd is passed by pointer to
> __ublk_ch_uring_cmd() and __ublk_ch_uring_cmd() is a large function
> unlikely to be inlined, so __ublk_ch_uring_cmd() will have to load the
> ublksrv_io_cmd fields back from the stack. Inline __ublk_ch_uring_cmd()
> into ublk_ch_uring_cmd_local() and load the ublksrv_io_cmd fields into
> local variables with READ_ONCE(). This allows the compiler to delay
> loading the fields until they are needed and choose whether to store
> them in registers or on the stack.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Looks good,

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

