Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211793587D3
	for <linux-block@vger.kernel.org>; Thu, 12 Feb 2026 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770900154; cv=none; b=piVebae+/S+IOhh9SdSuFH3yOmAY0i12tewaNBHUBuqVBmqUtqfn/3wJ+9zil1jf1Plo3GO8zq/+655RD6JRGE4honjcLax+mxgJHL4suYL16/9MPstKdwus0L5ir3OB9M/P8Gkul1wplX/9dH1LumymiUR43W8jnvT4CVyIJG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770900154; c=relaxed/simple;
	bh=UtykMG9qyzHiupp0EH2JXb2wpvwSlCxkegRnryZ4THc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bb9eZjEbrrHzXYPBkYhcRAvhFeZ0bBxcRF6TGUrhy/8oM9zzb6/3ngH52c5/0F//1ZVaZd80ZDBzmgbCx+1crNLJkYzTxBNnpy9skp11Wu0XdLucQ/5kYqfDOdQozjdBM1kuQDEvjK8V4Yh+hSaTaVz/niF3DqgR8GU5N12dlnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M52vdG2x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M52vdG2x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770900151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f712IpmRjgeyKMzsNkPA++2JxuBB2X23UauaHg6YmkE=;
	b=M52vdG2xIsenYklLWcokqEGjkzVoZJdZKufNx90H3fZuXGv1MXxnOi8whX1p5SMo9rAvZk
	dpMHp5wJY5L0ll2FVGdfagxV3lscQZn1aXEuSbvWKE75QneqLRPYL2F5YCYbRCc/WGlztC
	jamTC7L88Hs+dSwwUCQTpPxfhure+WY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-6Gz6Ga0SMZ-aGulvyIA1oA-1; Thu,
 12 Feb 2026 07:42:27 -0500
X-MC-Unique: 6Gz6Ga0SMZ-aGulvyIA1oA-1
X-Mimecast-MFC-AGG-ID: 6Gz6Ga0SMZ-aGulvyIA1oA_1770900147
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 90CF01955D80;
	Thu, 12 Feb 2026 12:42:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.145])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 317C51956095;
	Thu, 12 Feb 2026 12:42:23 +0000 (UTC)
Date: Thu, 12 Feb 2026 20:42:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: ublk invert part scan bit logic
Message-ID: <aY3KpLbAOchXxXyi@fedora>
References: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0535f4dd-ada3-414a-84c6-7abc232aa670@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Thu, Feb 12, 2026 at 04:05:27AM -0700, Jens Axboe wrote:
> Hi,
> 
> For ublk, there's this logic in in ublk_ctrl_start_dev():
> 
> /* Skip partition scan if disabled by user */
> if (ub->dev_info.flags & UBLK_F_NO_AUTO_PART_SCAN) {
> 	clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> } else {
> 	/* Schedule async partition scan for trusted daemons */
> 	if (!ub->unprivileged_daemons)
> 		schedule_work(&ub->partition_scan_work);
> }
> 
> where the
> 
> clear_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> 
> seems reversed? Why is GD_SUPPRESS_PART_SCAN being cleared if
> UBLK_F_NO_AUTO_PART_SCAN is set? Added in:
> 
> 8443e2087e70 ("ublk: add UBLK_F_NO_AUTO_PART_SCAN feature flag")

Yeah, the interface is designed in this way: partition scan is not
done during add disk, and allowed since then on. The selftest code
is written in same way too.

If GD_SUPPRESS_PART_SCAN isn't cleared, userspace can't probe partitions
any more.

However, if you think the interface isn't good, we still can change it
before 7.0 release.


Thanks
Ming

