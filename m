Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E7D25D1E7
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 02:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288244; cv=none; b=h4NqldJEdmTdbnDlRL1AHc3c/iXUz9+wNhWHc6kLuTUNxSwUW0balBkCL1c/iuj4e9W2iYYqs9oWoW3KnhucZhAbU1BQuH6NhRY3pRM2bqQRnkU45gwvvAA7z/1KcegNA1CiAqII0RCyM3jFyNFqs8JzdaPFep+tHq1gxi7Bf18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288244; c=relaxed/simple;
	bh=ZZHqkKq+49cIqgAl6qN3d5wawWQS8Uabq7s40p983kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1fIBBJufkcm56DrFkg+Xana3YPV5MnXN12CFGHghbaooCNIB+pfANAMo/ig6cFy9IQEKAhB0iXwl2LkkaWloXhCAi1tIZPR1GkVigIHBarcmlD+EmAuLgejgcjS/DMR4RYdzEvvrxMOu+EEPyoFAu3r2tpiwW5PLTWCdo6XLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEkOpeXB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEkOpeXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745288240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPTnMwL4/AxLUZBgsDv5fiQPI73zQZ0VZKJSDjiN8Nk=;
	b=bEkOpeXBWbyMEaEEbnjYUwsr/q44MwUAqSmRZ8MG6+jmahW810F/uYvHXhb1nsaVkcgEw3
	ioRYTioSSrVGsqqpo4fuoFbPeLpNXRbggT7oklhf1IPgtljGtCWkyV3mnILb5Jwh9MW0mf
	B6Cadxdd8Ziic4339f5UjX2wNhg1iDA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-XTG-6jzWMSWJA0fWr1fcAA-1; Mon,
 21 Apr 2025 22:17:15 -0400
X-MC-Unique: XTG-6jzWMSWJA0fWr1fcAA-1
X-Mimecast-MFC-AGG-ID: XTG-6jzWMSWJA0fWr1fcAA_1745288234
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3A43180087F;
	Tue, 22 Apr 2025 02:17:14 +0000 (UTC)
Received: from fedora (unknown [10.72.116.137])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D1A5180045C;
	Tue, 22 Apr 2025 02:17:10 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:17:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 3/4] ublk: factor out ublk_get_data
Message-ID: <aAb8IgxW85Ncxv74@fedora>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
 <20250421-ublk_constify-v1-3-3371f9e9f73c@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-ublk_constify-v1-3-3371f9e9f73c@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Apr 21, 2025 at 05:46:42PM -0600, Uday Shankar wrote:
> Move all the logic for the UBLK_IO_NEED_GET_DATA opcode into its own
> function. This also allows us to mark ublk_queue pointers as const for
> that operation, which can help prevent data races since we may allow
> concurrent operation on one ublk_queue in the future.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

