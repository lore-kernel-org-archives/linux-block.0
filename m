Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED816A956
	for <linux-block@vger.kernel.org>; Thu, 29 Jan 2026 08:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674921; cv=none; b=uO4XLBoHcF/yvvBDXXolgN2pEL3IYBt32Qy/512S4/lNo/UUvtZQgu6uY4MWeiEc9U66HZfNeszD1W28T3LVoLFJOXbpZ6pwOqEoH7s5putmv9I79INhqhmjFARo0w0jgoH2FkXOT2h8zraYKfE868a+TbfEyzn01k/5D+CxiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674921; c=relaxed/simple;
	bh=eB4TnzMxrO4cX6tz7m47qcyKK/60d6ivEpCr0yKXFK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR/aHWNLLS1mLwdO0VafUG3SVTfFhc6ukPg7qpfzHi3DMI+1fEUfGyf0y6z+54/63pyamuDSUrp2zNxsTjVNtrYTv4eYgXocSTCItV8lcTq38kFV/84ZclixCxIwggmdhLi1mvOEccP6hehUdcPmATPbIhvRHOjwlzQNyhznnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUqfhpLr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUqfhpLr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769674918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUilyuw8LfdXlHS2LJn/PeiP5yz2o+GH6XWV8wAxZ9s=;
	b=VUqfhpLrtG+mgEBpox4Zl9Tq+6OytoVcqHkP5mxNd9feJU/PuWVBNnKQacMre7W8pAMCZK
	GZmhpyH7BSRko1ng/W9nYF36WRFjEe23Zakn0VzereuvilzzAfkOMW3krKiHA7+8HCHvS1
	Mcl5+o0VtltTo0Kr3v/nyNKYXktO/AQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-zlJnqMuBP6OV76VJ2HUAhQ-1; Thu,
 29 Jan 2026 03:21:57 -0500
X-MC-Unique: zlJnqMuBP6OV76VJ2HUAhQ-1
X-Mimecast-MFC-AGG-ID: zlJnqMuBP6OV76VJ2HUAhQ_1769674916
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E39481800357;
	Thu, 29 Jan 2026 08:21:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.182])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A25D118002A6;
	Thu, 29 Jan 2026 08:21:51 +0000 (UTC)
Date: Thu, 29 Jan 2026 16:21:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>,
	Yoav Cohen <yoav@nvidia.com>
Subject: Re: [PATCH 2/5] ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag
Message-ID: <aXsYmhdCLBSN704-@fedora>
References: <20260129031501.3403688-1-ming.lei@redhat.com>
 <20260129031501.3403688-3-ming.lei@redhat.com>
 <CADUfDZoYtEjVjqQDnHXQynZUp3NJv+bgWuFJuvOUS_hJcOy3qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZoYtEjVjqQDnHXQynZUp3NJv+bgWuFJuvOUS_hJcOy3qg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Jan 28, 2026 at 08:44:58PM -0800, Caleb Sander Mateos wrote:
> On Wed, Jan 28, 2026 at 7:15 PM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > Add a new feature flag UBLK_F_NO_AUTO_PART_SCAN to allow users to suppress
> > automatic partition scanning when starting a ublk device.
> >
> > This is useful for some cases in which use don't want to scan
> > partitions.
> >
> > Users still can manually trigger partition scanning later when appropriate
> > using standard tools (e.g., partprobe, blockdev --rereadpt).
> >
> > Reported-by: Yoav Cohen <yoav@nvidia.com>
> > Link: https://lore.kernel.org/linux-block/DM4PR12MB63280C5637917C071C2F0D65A9A8A@DM4PR12MB6328.namprd12.prod.outlook.com/
> > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > ---
> >  drivers/block/ublk_drv.c      | 7 ++++++-
> >  include/uapi/linux/ublk_cmd.h | 3 +++
> >  2 files changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> > index 94470a2ec05e..0b98ab0f8257 100644
> > --- a/drivers/block/ublk_drv.c
> > +++ b/drivers/block/ublk_drv.c
> > @@ -80,7 +80,8 @@
> >                 | UBLK_F_BUF_REG_OFF_DAEMON \
> >                 | (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) ? UBLK_F_INTEGRITY : 0) \
> >                 | UBLK_F_SAFE_STOP_DEV \
> > -               | UBLK_F_BATCH_IO)
> > +               | UBLK_F_BATCH_IO \
> > +               | UBLK_F_NO_AUTO_PART_SCAN)
> >
> >  #define UBLK_F_ALL_RECOVERY_FLAGS (UBLK_F_USER_RECOVERY \
> >                 | UBLK_F_USER_RECOVERY_REISSUE \
> > @@ -2364,6 +2365,10 @@ static void ublk_partition_scan_work(struct work_struct *work)
> >                                              &disk->state)))
> >                 goto out;
> >
> > +       /* Skip partition scan if disabled by user */
> > +       if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN)
> > +               goto out;
> 
> Seems like it's not necessary to schedule ublk_partition_scan_work()
> in this case? Could just clear_bit(GD_SUPPRESS_PART_SCAN,
> &disk->state) in ublk_ctrl_start_dev()?

OK, we can do it by saving one time of wq schedule.

> Is it actually necessary to clear GD_SUPPRESS_PART_SCAN at all? Does
> that flag block partprobe too?

Yes, the flag is totally controlled by user side.


Thanks, 
Ming

