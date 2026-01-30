Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471C73009C1
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769760205; cv=none; b=VTskdu1YUTg07QSQfxqUqwcT+/i92W8EeRTjgw0RFI8dVvotvGnTw/lrdsmeWz+J+vP+XxzL8Pv+3zklNiM1SpBIGdMj3YW9EXhwI7EjX8RPbBmBOZzEcTxQb9NVgRbqfI5UT3thP/hUomzKEUmvPBN8DY/ntlqLuwk98fpfvOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769760205; c=relaxed/simple;
	bh=0vvxTNZtE9blyRKG0QmjEm3MA7AMELs2r+SaJOTZApY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XP1SC9afOVmnDL7IASHanGMKmwGYJkzM29+F7X56JzcWX+1OPA6PxMf99Z2W8OamvbmhXlTwuLuVydiEwtd5HXlTUs1nQVCL3WXGLe/wy6YrG9xy9JYWfNfWB/69YtIV4Igyqpnql4zpiPFa3mWkLn5IgX1NnoE1xyWrnHKYyNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OSFyat/p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OSFyat/p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769760203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DDnkjCbXpYisumYmIRFHtNeXXpB5IUbbsMXbRBwy7X8=;
	b=OSFyat/pnx7c1PF80Xk6+v4OXKYDsCGZxdMb99NTtJJgqcGFG2CevTebF1pmyGB5feQaQt
	cJl6BBCzEAQ6tkTFrbWuA7Q8lbIM7OuEjNss/A+0CozOI4wokyG8Mzdrc/RC1D0xeBdKzO
	WyJcd01aGY/wviSEW9nkhGj3IAqjPpo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-lvTeQqykMEab-ZUErJU9zg-1; Fri,
 30 Jan 2026 03:03:20 -0500
X-MC-Unique: lvTeQqykMEab-ZUErJU9zg-1
X-Mimecast-MFC-AGG-ID: lvTeQqykMEab-ZUErJU9zg_1769760199
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F38E19560B2;
	Fri, 30 Jan 2026 08:03:19 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FEEB19560A2;
	Fri, 30 Jan 2026 08:03:14 +0000 (UTC)
Date: Fri, 30 Jan 2026 16:03:09 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ublk: Validate SQE128 flag before accessing the cmd
Message-ID: <aXxlvbLeqpscOFI9@fedora>
References: <20260129224618.975401-1-csander@purestorage.com>
 <20260129224618.975401-2-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129224618.975401-2-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jan 29, 2026 at 03:46:14PM -0700, Caleb Sander Mateos wrote:
> From: Govindarajulu Varadarajan <govind.varadar@gmail.com>
> 
> ublk_ctrl_cmd_dump() accesses (header *)sqe->cmd before
> IO_URING_F_SQE128 flag check. This could cause out of boundary memory
> access.
> 
> Move the SQE128 flag check earlier in ublk_ctrl_uring_cmd() to return
> -EINVAL immediately if the flag is not set.
> 
> Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
> Signed-off-by: Govindarajulu Varadarajan <govind.varadar@gmail.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

