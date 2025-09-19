Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898581D6DB6
	for <linux-block@vger.kernel.org>; Fri, 19 Sep 2025 04:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758254667; cv=none; b=JdriVNOekclvntYKAhAIinpd/hQlhNb2LCWWpQnxOKOGhR/daDAnuTDrelUv85IdNrHPHAq33p/z39aLTzCIBIaRFMo/VNXAaCv0yBdkG0uosMPbYcxwxIhVFhAV3zT0uhYYZeXD815SSYDpSb/iRU/gJMoVwyo8TtMLmEepRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758254667; c=relaxed/simple;
	bh=NqkZnCizAbX+o9YIAhQw0thbKtUrquiDNFODHQ1hcyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSL2GWzgKfnxS48ecPtyl5HuhNPP/spQlsH3NqwieJ/TVkZmQA+O8vAhBtfx2Wj2UiZv0d5hi5di/nAsw+5N7f/m2l8oe8XhssvLgNWxtLHX1Z+67RwVCekaj2/m1h/EfEIcA/VuNxLhNXM103dGp/8lwecuDhR7IB/8VPh1wCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYlRGU/t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYlRGU/t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758254664;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WJFVTJYb2/ev/ctsj3imyOHvTHcYX61/HGTQGEX5Mzw=;
	b=UYlRGU/tGjMTXs6ozmx3gVPdOqjFMs6SJ8UQVoRNaCPEUl5zB+eFE5BEXqtvzpbWD9Zt1c
	u3LaLOSqne4Hqm/k0I7N2OG86D71xmm2/uBw1vjX5n0xapRH8DHXVv8HON2/NAOIjfb/Ap
	mA7VpbYyLpxb6OsFkVAZSUhXzhCKb8Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-lpOjRzIAOV-ZhHf9oUdMcQ-1; Fri,
 19 Sep 2025 00:04:21 -0400
X-MC-Unique: lpOjRzIAOV-ZhHf9oUdMcQ-1
X-Mimecast-MFC-AGG-ID: lpOjRzIAOV-ZhHf9oUdMcQ_1758254660
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 879681800576;
	Fri, 19 Sep 2025 04:04:19 +0000 (UTC)
Received: from fedora (unknown [10.72.120.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AA9571955F21;
	Fri, 19 Sep 2025 04:04:15 +0000 (UTC)
Date: Fri, 19 Sep 2025 12:04:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] ublk: don't pass q_id to ublk_queue_cmd_buf_size()
Message-ID: <aMzWOWxelzLme6ZV@fedora>
References: <20250918014953.297897-1-csander@purestorage.com>
 <20250918014953.297897-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918014953.297897-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Sep 17, 2025 at 07:49:38PM -0600, Caleb Sander Mateos wrote:
> ublk_queue_cmd_buf_size() only needs the queue depth, which is the same
> for all queues. Get the queue depth from the ublk_device instead so the
> q_id parameter can be dropped.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

