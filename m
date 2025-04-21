Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA021184
	for <linux-block@vger.kernel.org>; Mon, 21 Apr 2025 02:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745203929; cv=none; b=UYRg7ww3oOXfk/tTViXa+80EZKboVc4nFw+GHKNn7CAUkjlkYH2bUy2NGfMMJzsVdhZIJxvvor9ExUNC5hszcAGGo9Zv3Zc8GOwh8s++5e6cNEH1LxDm7qE0+XcGEIAeSRlWQb4b+wFWLWtdSJgxYQpd224X0aCeDbKV2uQXLjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745203929; c=relaxed/simple;
	bh=Oclm9dmXWhIcgSHwh1RuruOhxVe1JUzmy9uE33V89u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbC3flbueioUEHJqWRoTeda4SVLSryBTNWXQ4hFKw3kV/AW97ptdobr0KF3rEhmjc2rOmejHH62qZKjAcrJGEWfDug3QuxfChAg5hbiqlfwRRISo49gw/vAT/FmdkM6BVlQyAEKu/u6jnth0aWTPxdRPvEQUEpYQFEmJJlXZ/C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y9Iw/9Yn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y9Iw/9Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745203926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YI1Pypu2FW7l3S7IiGzxy1fl9eACeynpKO3foEAvve4=;
	b=Y9Iw/9Yng0Vas7C2UG/G82iC98tPpKZAkOpQNzOf+mkQkCH8za1w7eawjZ0olljP7tPW7v
	Qr81OrfPuAWew9ygfdS5CEuJgS3jrosle4VsXk92EWERGn1h24L32onQPh77HYHXleJBVI
	sZNh4lAnYM7Hl1/cZrnEkr2YJt3A+Vc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-YlK2rDJ5MmS9yXBXAa10Xw-1; Sun,
 20 Apr 2025 22:52:05 -0400
X-MC-Unique: YlK2rDJ5MmS9yXBXAa10Xw-1
X-Mimecast-MFC-AGG-ID: YlK2rDJ5MmS9yXBXAa10Xw_1745203924
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1D3F418001EA;
	Mon, 21 Apr 2025 02:52:04 +0000 (UTC)
Received: from fedora (unknown [10.72.116.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95CB219560A3;
	Mon, 21 Apr 2025 02:52:00 +0000 (UTC)
Date: Mon, 21 Apr 2025 10:51:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>, csander@purestorage.com
Subject: Re: [PATCH v4]: ublk: Add UBLK_U_CMD_UPDATE_SIZE
Message-ID: <aAWyy9qFlURHabHM@fedora>
References: <918750ec-42e8-46d4-bbfb-e01d3dce6ed0@nvidia.com>
 <aAGQLYDOFY5PyUMJ@fedora>
 <26675f4e-07c5-4a76-ba98-463c5bd0406c@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26675f4e-07c5-4a76-ba98-463c5bd0406c@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Sun, Apr 20, 2025 at 11:06:17AM +0300, Jared Holzman wrote:
> 
> 
> On 18/04/2025 2:35, Ming Lei wrote:
> > On Wed, Apr 16, 2025 at 01:07:47PM +0300, Jared Holzman wrote:
> > > Currently ublk only allows the size of the ublkb block device to be
> > > set via UBLK_CMD_SET_PARAMS before UBLK_CMD_START_DEV is triggered.
> > > 
> > > This does not provide support for extendable user-space block devices
> > > without having to stop and restart the underlying ublkb block device
> > > causing IO interruption.
> > > 
> > > This patch adds a new ublk command UBLK_U_CMD_UPDATE_SIZE to allow the
> > > ublk block device to be resized on-the-fly.
> > > 
> > > Feature flag UBLK_F_UPDATE_SIZE is also added to indicate support for this
> > > command.
> > > 
> > > Signed-off-by: Omri Mann <omri@nvidia.com>
> > > ---
> > >   drivers/block/ublk_drv.c      | 18 +++++++++++++++++-
> > >   include/uapi/linux/ublk_cmd.h |  7 +++++++
> > >   2 files changed, 24 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > > index cdb1543fa4a9..128f094efbad 100644
> > > --- a/drivers/block/ublk_drv.c
> > > +++ b/drivers/block/ublk_drv.c
> > > @@ -64,7 +64,8 @@
> > >           | UBLK_F_CMD_IOCTL_ENCODE \
> > >           | UBLK_F_USER_COPY \
> > >           | UBLK_F_ZONED \
> > > -        | UBLK_F_USER_RECOVERY_FAIL_IO)
> > > +        | UBLK_F_USER_RECOVERY_FAIL_IO \
> > > +        | UBLK_F_UPDATE_SIZE)
> > > 
> > >   #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> > >           | UBLK_F_USER_RECOVERY_REISSUE \
> > > @@ -3067,6 +3068,16 @@ static int ublk_ctrl_get_features(const struct
> > > ublksrv_ctrl_cmd *header)
> > 
> > I try to apply this patch downloaded from both lore or patchwork, and 'git
> > am' always complains the patch is broken:
> 
> I think this is because of my workflow. I cannot send email outside of our
> network using git send-mail so I've been copy-pasting the patch into
> Thunderbird.

oops, copy-paste usually breaks patch style, probably `xclip` can help you
if copy-paste can't be avoided.

You probably need to find one email client to support importing patch plain
text from file or sending patch directly, such as mutt/msmtp,...

Thanks,
Ming

