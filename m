Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A091DFE12
	for <linux-block@vger.kernel.org>; Fri,  7 Nov 2025 00:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474260; cv=none; b=bjyTc5369e0RLUX8IJljlY8GRlc+dSmRm+6aVDvUifWil0Ttxuk6xwIZHMawId894F1odyr3hv21tQxFLNKf/NRyNk0WnCk7J+swbhsqki4bDiEmUZA1QvT4wPHehDxosJC13pg9z1p/YcmLLf24UClDUvbeUWEyFgT5G5UJdJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474260; c=relaxed/simple;
	bh=YwGnfZV13ZP8Ogk95cKBeclXjRlSTKAjTiLl25kTRFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbTGJbBPPyPnxtfjuHUH13Ydi4btF1yMK3QQHMYvlHEtJ8sJ+GQJz9P6Oplpr3foYaWKdpVbU1yvrh58t424P7k5uiyySH3tWpqh53T0gn7jtoao8Y/MFBgS1KbbUYE4PIaMepTR5jF9pqtWX0HvMWWg1KEdr7At5ylU3nI2+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOxiRMeF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOxiRMeF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762474257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CmkS/EwwmVv+zOfOfidDYpacGfbtN7LhsV4QegBVAFw=;
	b=SOxiRMeFrz34plcT4u5pguFvze2CZyM0Jcc0/ME743ZzqZMVqWJXtKEOasqPwAUs3xgKJH
	ORmJFDNBtTyIJSnu7VAM4ZfzYzIG7m5BA4mzXwBVHQN45aq0pQrLsilOhndKttxrswKZrp
	LqIFzXFBZ/P0zb4YO4OtmWLCyECLGFE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-wFoTcsUIPsu0t6itzAX8GQ-1; Thu,
 06 Nov 2025 19:10:52 -0500
X-MC-Unique: wFoTcsUIPsu0t6itzAX8GQ-1
X-Mimecast-MFC-AGG-ID: wFoTcsUIPsu0t6itzAX8GQ_1762474251
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C56718007F2;
	Fri,  7 Nov 2025 00:10:51 +0000 (UTC)
Received: from fedora (unknown [10.72.120.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64D8519560A7;
	Fri,  7 Nov 2025 00:10:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 08:10:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ublk: use rq_for_each_segment() for user copy
Message-ID: <aQ05AQOlm4pDnELt@fedora>
References: <20251106171647.2590074-1-csander@purestorage.com>
 <20251106171647.2590074-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106171647.2590074-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Nov 06, 2025 at 10:16:47AM -0700, Caleb Sander Mateos wrote:
> ublk_advance_io_iter() and ublk_copy_io_pages() currently open-code the
> iteration over the request's bvecs. Switch to the rq_for_each_segment()
> macro provided by blk-mq to avoid reaching into the bio internals and
> simplify the code.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Nice cleanup:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

