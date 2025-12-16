Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009E319852
	for <linux-block@vger.kernel.org>; Tue, 16 Dec 2025 08:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765875404; cv=none; b=QXc+Wl8GBsH8CAKlPF/TL17zjXkk3dnMRjIOwmVOd8IcAOrkeSidSEHs28coMAyH3703XaNeZatZ1C20TzwpQ49detXhLxS3Q5UwTKN0tBC9yleOExLudiKhPrKw8DUxTt+rtGzyU8dYNxDeho+M4ad/xivFI7CelpXP/+SPlVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765875404; c=relaxed/simple;
	bh=3Y7Kx2jec/82gnCVM4HJzm1bsk/5lhL0iSkCisR5y7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcE0meaoqceS8v1+U3FzzPo46qgee/kDdA9XwxNcu57xzgtfpwFSzLKQXv4DR2ASNp2MLo2PwkdYQP7nw8kEYGdw9UKGaKBCXldwlsbJDuh3QcqnOwb6PS9JfRPm/3hbcVwCoKpgao5KF/ubJhlDSmQBg32shJGgjBQczvSU8RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LktvlV+X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LktvlV+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765875401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41WhHli5771EDQmkQX9uWeh8VZF/Cr1dC6n2VK5SiwU=;
	b=LktvlV+XnaCkvAKTO0uIyeA8CF9dsNyZeXV1O6uYyTd97+3JmK+3p2DtKBXvCwbG3tMsik
	U8kvYxvLLhW2rLj9FF8hhXz0PySsxceSNnwnr8TsvlbiayVLTC7UU+nweaoot5DWvCrdpT
	Gw5cb/Lt4NvbNHk//zFHABME8BW+Lcs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-SOeH8UScON-N92M2PcmhJw-1; Tue,
 16 Dec 2025 03:56:38 -0500
X-MC-Unique: SOeH8UScON-N92M2PcmhJw-1
X-Mimecast-MFC-AGG-ID: SOeH8UScON-N92M2PcmhJw_1765875397
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD17718005AE;
	Tue, 16 Dec 2025 08:56:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 213B719560A7;
	Tue, 16 Dec 2025 08:56:32 +0000 (UTC)
Date: Tue, 16 Dec 2025 16:56:27 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH V2] ublk: fix deadlock when reading partition table
Message-ID: <aUEeu9luJ9ZNvJzA@fedora>
References: <20251212143415.485359-1-ming.lei@redhat.com>
 <8dd3c141-3e92-44f3-91e2-2bf4827b36a4@kernel.dk>
 <aTzPUzyZ21lVOk1L@fedora>
 <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93163617-11bb-4700-aca9-940c0df7429f@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sat, Dec 13, 2025 at 11:41:52PM -0700, Jens Axboe wrote:
> On 12/12/25 7:28 PM, Ming Lei wrote:
> > On Fri, Dec 12, 2025 at 12:49:49PM -0700, Jens Axboe wrote:
> >> On 12/12/25 7:34 AM, Ming Lei wrote:
> >>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> >>> index df9831783a13..38f138f248e6 100644
> >>> --- a/drivers/block/ublk_drv.c
> >>> +++ b/drivers/block/ublk_drv.c
> >>> @@ -1080,12 +1080,20 @@ static inline struct ublk_uring_cmd_pdu *ublk_get_uring_cmd_pdu(
> >>>  	return io_uring_cmd_to_pdu(ioucmd, struct ublk_uring_cmd_pdu);
> >>>  }
> >>>  
> >>> +static void ublk_end_request(struct request *req, blk_status_t error)
> >>> +{
> >>> +	local_bh_disable();
> >>> +	blk_mq_end_request(req, error);
> >>> +	local_bh_enable();
> >>> +}
> >>
> >> This is really almost too ugly to live, as a work-around for what just
> >> happens to be in __fput_deferred()... Surely we can come up with
> >> something better here? Heck even a PF_ flag would be better than this,
> >> imho.
> > 
> > task flag will switch to release all files opened by current from wq context,
> > and there may be chance to cause regression, especially this fix needs to
> > backport to stable.
> 
> I don't mean in general for the task, just across the completion. It'd
> cause the exact same punts to async puts as the current patch.

Technically it is very similar with the posted path, just task flag way touches
core code, especially there are only 4bits left.

> 
> > So I'd suggest to take it for safe stable purpose.
> 
> I'm really having a hard time with it - and I have to defend it once I
> send it further upstream. And I can tell you who's going to hate it, the
> guy that pulls from me. We might get lucky that he doesn't look at it.
> But the underlying issue here is that the patch is one nasty bandaid,
> not that Linus would yell at it, with good reason imho.

Understood.

IMHO, even this patch is a workaround and looks ugly, but it has enough
benefits too:

- driver only change and won't touch core code
- it is for handling abnormal userspace behavior(close(disk_fd) before
  completing block IO)
- correct & safe because it is always fine to complete IO request from irq
  context
- easy to backport

> 
> At the same time, I don't really have other good suggestions. Let me
> ponder it a bit, about to get on a flight anyway and -rc1 has been cut
> at this point regardless.
> 
> Obviously this isn't a ublk induced issue, it's all down to the lock
> grabbing that happens there. Maybe bdev_release() could do a deferred
> put if a trylock of ->open_mutex fails?

There is risk to break application since some cases need to drain
bdev_release before returning to userspace.

The issue for ublk is actually triggered by something abnormal: submit AIO
& close(ublk disk) in client application, then fput() is called when the
submitted AIO is done, it will cause deferred fput handler to wq for any block
IO completed from irq handler.


Thanks,
Ming

