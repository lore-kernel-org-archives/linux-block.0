Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4581F524F
	for <linux-block@vger.kernel.org>; Sun, 27 Apr 2025 13:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745759645; cv=none; b=q9HeEQnUrm3kMKeqtKImQHdYY+eBjowLlicUKstw6MQMp2X2xg8FDi2WwiRUd8VLzX6jh32fQ8tFGwA+fBmOb1g5d5Es5agSq4piVehFMo/064ETpo43eGJS7CBhvqdcjc7YwOZQbtZaGB099tjH3VOol7xcO4cKewaV0uSswKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745759645; c=relaxed/simple;
	bh=wU5G/ORd7jg7YqY8ZVW0sjM/fQEAp7t1iOVZNN7dnHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcFge75sMcuu9c5ECfACElCEa7tFyQNDi39gUHS2TVNaC/xB9pvWar3zISuiASYlNH+LYqQOIQhj1D8OgyJBA01LBGDowqAhmc+whdd1qHYaHrXvQksFEtIuAuICkD+b7OrkwPd/m8eKOnhKdIbVftFGa/0tbUoBruLC+vsLhs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DBo2pN2Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DBo2pN2Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745759642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KB57MTnRwOC/Yn6FUIY4COt0ItfQNeHUwh5m3vAZJSw=;
	b=DBo2pN2YHJPBEWZY+KRTPhvtcLum+MWuOd1a40DLt+YUEZoGrKETuc7HNnjUN6Yw9nIL2G
	3wcu/aIPppdh4lhdtYn57LisrFFOMQ43h6QGxc0/Qver6U4s90dx9KIS7pVJTraBoT8Jfc
	0HXKo//EIRTUSO7n/W5LitqUQ8fCBmM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-347-qgdJ5Y3EP6SUV_UFDnPo5w-1; Sun,
 27 Apr 2025 09:13:58 -0400
X-MC-Unique: qgdJ5Y3EP6SUV_UFDnPo5w-1
X-Mimecast-MFC-AGG-ID: qgdJ5Y3EP6SUV_UFDnPo5w_1745759637
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 45CEE1800446;
	Sun, 27 Apr 2025 13:13:57 +0000 (UTC)
Received: from fedora (unknown [10.72.116.119])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A580E1956094;
	Sun, 27 Apr 2025 13:13:53 +0000 (UTC)
Date: Sun, 27 Apr 2025 21:13:48 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Uday Shankar <ushankar@purestorage.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] ublk: check UBLK_IO_FLAG_OWNED_BY_SRV in
 ublk_abort_queue()
Message-ID: <aA4tjJdyzYtmi0s3@fedora>
References: <20250427045803.772972-1-csander@purestorage.com>
 <20250427045803.772972-8-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427045803.772972-8-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Sat, Apr 26, 2025 at 10:58:02PM -0600, Caleb Sander Mateos wrote:
> ublk_abort_queue() currently checks whether the UBLK_IO_FLAG_ACTIVE flag
> is cleared to tell whether to abort each ublk_io in the queue. But it's
> possible for a ublk_io to not be ACTIVE but also not have a request in
> flight, such as when no fetch request has yet been submitted for a tag
> or when a fetch request is cancelled. So ublk_abort_queue() must
> additionally check for an inflight request.
> 
> Simplify this code by checking for UBLK_IO_FLAG_OWNED_BY_SRV instead,
> which indicates precisely whether a request is currently inflight.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

