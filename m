Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECD34321A
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788593; cv=none; b=kZFkGNNu6HMfWNcs8VnFHVDjsvpzUQpJEUBen3+87v9TCktHsSSjTQq3DNDGZP7Yf2NC6M0In+eMSWSd6CwSfGF3trti35i488sNDiZcPkUWvQm3LMX4UYJoyhdrBOqj1+f9OLDB3eOaqQ5NRz+t3LEaqj62yqDvErz/ppkUzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788593; c=relaxed/simple;
	bh=RXkn4ZsFPzGQmL8O+tCLJ2YPArF77qTmOaROZpCEnzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvaXS84O+szdwSK8Jbj/KTg9Fl5By1awVQxpQZNhTIpTRwK+naBYPQQd0htZ6qdpNYQUO28q12bgRlaBsdAqKiCr80n7Dv+b3kfhSsVx+J9EBL+sQbzuBlVWKuka+YnZFi4/VB0uMps0mzMQ9NHTbLb1Ah3yM5eDYpXhpOmuFLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioWKk5Dz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioWKk5Dz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769788591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wjvSBEo/Xm98ouRNd7s72ZOuIUzyU2IkxRJVaOufyr0=;
	b=ioWKk5Dz7mzkavA9A4oevbjKLbnuumWNIF6ZajQP51XRZ0JjPM8QEU6T98xhhZTAxlrPY6
	U0snpHTXr1b+OQr3PSl/cioXX+pU5GI4pk4PUrVvEc5eZtaZEZjSdj8GKl7oDPGhC5CFTc
	FqKBjKNcTRnG5f5vzLB7CTFZLfAzeEc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690--DNgjNCqPjmpcFwF2OlpUg-1; Fri,
 30 Jan 2026 10:56:28 -0500
X-MC-Unique: -DNgjNCqPjmpcFwF2OlpUg-1
X-Mimecast-MFC-AGG-ID: -DNgjNCqPjmpcFwF2OlpUg_1769788587
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D36F41956088;
	Fri, 30 Jan 2026 15:56:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C2B01956056;
	Fri, 30 Jan 2026 15:56:22 +0000 (UTC)
Date: Fri, 30 Jan 2026 23:56:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
Message-ID: <aXzUoRgvbE0izVVP@fedora>
References: <20260129224618.975401-1-csander@purestorage.com>
 <20260129224618.975401-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129224618.975401-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Jan 29, 2026 at 03:46:16PM -0700, Caleb Sander Mateos wrote:
> struct ublksrv_ctrl_cmd is part of the io_uring_sqe, which may lie in
> userspace-mapped memory. It's racy to access its fields with normal
> loads, as userspace may write to them concurrently. Use READ_ONCE() for
> all the ublksrv_ctrl_cmd field accesses to avoid the race.
> 
> Fixes: 87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK issue")
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 77 +++++++++++++++++++---------------------
>  1 file changed, 37 insertions(+), 40 deletions(-)

I'd suggest to define local `struct ublksrv_ctrl_cmd` variable in
ublk_ctrl_uring_cmd() for avoiding READ_ONCE:

- it is slow control cod path

- READ_ONCE is supposed to be used for fast path and be carefully

- it is sync command

Defining one local data can be simpler to avoid the issue, and more
reliable.


Thanks,
Ming

