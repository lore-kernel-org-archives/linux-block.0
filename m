Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86234321A
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788150; cv=none; b=pka722QBGmzUFT5VVz5xjNseSbLvTQ30dKmnzo1iKWkf7yCsW0fcMIFgSEZCIi7mQOWwh8n6JWkDxOxi5SpmGYUFxDdvYoM4Vbx767iMJWpA+glpYx7gUYaf7IyXqP1k6TmuK/LQA/wYZm//DdfESL85B1Y2d473+BSmZDmBk5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788150; c=relaxed/simple;
	bh=vemaNb9PX2bl5/GL/wA6/rAPx47OHCRjqTk+m3EA9m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xcm0TMhdaU3XVs1RmhOHEa+sSl0ju3+wAfdjdwxATV4RpuTOXEK+JXjt2Ax1GvJLDqYf8e/6CqmUGqPzpSLneWzfoi4z6W1dtkCYJ900lMXim29d5wR/W0zwhD42SMlyiUuRqqav0JrGaTyWN1gLmaSJRrJBg/xyJUvEK0FsoKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TBTzzYeb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBTzzYeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769788148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VDPEdzOpe82L2X5zZrpHHC+ARlFtDRmYGQmS5Pfmouo=;
	b=TBTzzYebfTjB+WPo3f/87uLYTVs5Qh3ciHuB8nrV1s4ntNViNhvsf+WWm2pKeyi5weP3ak
	dTIKNfobeArAx5KDqBRTXDfN8zMdoHsowB8OexjeK6HHG42oDvYfaDkP0zm34+WVDFilwx
	hBvL7258wcKtISodw4TFVfK9Bx1rIQo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-t8Zt0CR9NVmP-MbXZPDD7Q-1; Fri,
 30 Jan 2026 10:49:04 -0500
X-MC-Unique: t8Zt0CR9NVmP-MbXZPDD7Q-1
X-Mimecast-MFC-AGG-ID: t8Zt0CR9NVmP-MbXZPDD7Q_1769788143
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D93E718E7C2D;
	Fri, 30 Jan 2026 15:48:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 821233008DDF;
	Fri, 30 Jan 2026 15:48:44 +0000 (UTC)
Date: Fri, 30 Jan 2026 23:48:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] ublk: don't write to struct ublksrv_ctrl_cmd
Message-ID: <aXzS1iOjZAVEcZ8k@fedora>
References: <20260129224618.975401-1-csander@purestorage.com>
 <20260129224618.975401-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129224618.975401-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Jan 29, 2026 at 03:46:15PM -0700, Caleb Sander Mateos wrote:
> ublk_ctrl_uring_cmd_permission() writes to struct ublksrv_ctrl_cmd's
> addr and len fields, which is racy because ublksrv_ctrl_cmd is part of
> the io_uring_sqe, which may lie in userspace-mapped memory. Store the
> values of addr in len in local variables instead to avoid the race.
> 
> Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

The simpler approach is to define local `header` variable and copy data to
it.

Given it is introduced in v6.19-rc1, backport should be easy, so this patch
looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

