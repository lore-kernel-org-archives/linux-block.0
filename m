Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226542980B3
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 07:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960064; cv=none; b=MWms1oLIdIe3U5TGC9oJBeUztPIYqfvdD1LUH7geKZeK8yNipp5bBdhYpabV90PXrv47WZFda7BSsKymm4KFFK+ltZ63cPUtKPrV724UY1U3fFEXDceWfui0EprhlREqnynJeCFfKPhZFoq0hoRHlrVQDI4BhMF8zKpNK4sBs2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960064; c=relaxed/simple;
	bh=p8Rs9Nj21Lp0gN7Vr5H1MDd/Yb54AdEXOhLfu3r/RDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3DpcZ0kaQBwsoi7hGpOMWOYcPUvurGicDsQEpN1PfkN83enoPMa15cL1oEVewr6ZF7OeVn67yIr4NkCIsHkB762pJVFbGci3JrUXJ9w0KCENLx/COYeiHJJRvunibdGf3KCjaE7je9XLOaW3Brs0qSBz96cKlPV/lto4SVPmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SaojuR+X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaojuR+X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751960062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yyrOa/0bHa3VwV4PjrNhK+4OqEjCqXn7aozO5QOaBAM=;
	b=SaojuR+X+2MymOIxJ6vvdLxDrQ2YzX5XNSVrhsNW6OtiBXzRp9jR1/BsXJyrStCtoCCn+3
	125CN3m+Ll/0Z416XAg0DgBnT+XwojfJywhT3xbk8I0svVOG58njfj/EBFrgZ9M205cnfv
	n7akL2e0EjSD0SR2hZIzhpY9vnTekIg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-5WTsIdcCNDKNx9rh_kkX_Q-1; Tue,
 08 Jul 2025 03:34:19 -0400
X-MC-Unique: 5WTsIdcCNDKNx9rh_kkX_Q-1
X-Mimecast-MFC-AGG-ID: 5WTsIdcCNDKNx9rh_kkX_Q_1751960057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53E84180136B;
	Tue,  8 Jul 2025 07:34:15 +0000 (UTC)
Received: from fedora (unknown [10.72.116.64])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0428C30001B1;
	Tue,  8 Jul 2025 07:34:06 +0000 (UTC)
Date: Tue, 8 Jul 2025 15:34:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, josef@toxicpanda.com,
	axboe@kernel.dk, hch@infradead.org, hare@suse.de,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
Message-ID: <aGzJ6dssrCmJtG-3@fedora>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
 <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
 <aGSaVhiH2DeTvtdr@fedora>
 <7b09167f-bf8d-4d94-9317-3cfbb4f83cd8@linux.ibm.com>
 <bc3f20c3-21f8-443b-619f-da7569b37aaf@huaweicloud.com>
 <08ce91d9-756a-a8fa-a988-a13ec74d8c1c@huaweicloud.com>
 <91174432-8c70-437f-811f-7c8a6c028f64@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91174432-8c70-437f-811f-7c8a6c028f64@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Tue, Jul 08, 2025 at 10:42:00AM +0530, Nilay Shroff wrote:
> 
> 
> On 7/5/25 6:45 AM, Yu Kuai wrote:
> > Hi,
> > 
> > 在 2025/07/02 15:30, Yu Kuai 写道:
> >> Hi,
> >>
> >> 在 2025/07/02 14:22, Nilay Shroff 写道:
> >>>
> >>>
> >>> On 7/2/25 8:02 AM, Ming Lei wrote:
> >>>> On Wed, Jul 02, 2025 at 09:12:09AM +0800, Yu Kuai wrote:
> >>>>> Hi,
> >>>>>
> >>>>> 在 2025/07/01 21:28, Nilay Shroff 写道:
> >>>>>>
> >>>>>>
> >>>>>> On 6/28/25 6:18 AM, Yu Kuai wrote:
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> 在 2025/06/27 19:04, Ming Lei 写道:
> >>>>>>>> I guess the patch in the following link may be simper, both two take
> >>>>>>>> similar approach:
> >>>>>>>>
> >>>>>>>> https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
> >>>>>>>
> >>>>>>> I this the above approach has concurrent problems if nbd_start_device
> >>>>>>> concurrent with nbd_start_device:
> >>>>>>>
> >>>>>>> t1:
> >>>>>>> nbd_start_device
> >>>>>>> lock
> >>>>>>> num_connections = 1
> >>>>>>> unlock
> >>>>>>>       t2:
> >>>>>>>       nbd_add_socket
> >>>>>>>       lock
> >>>>>>>       config->num_connections++
> >>>>>>>       unlock
> >>>>>>>           t3:
> >>>>>>>           nbd_start_device
> >>>>>>>           lock
> >>>>>>>           num_connections = 2
> >>>>>>>           unlock
> >>>>>>>           blk_mq_update_nr_hw_queues
> >>>>>>>
> >>>>>>> blk_mq_update_nr_hw_queues
> >>>>>>> //nr_hw_queues updated to 1 before failure
> >>>>>>> return -EINVAL
> >>>>>>>
> >>>>>>
> >>>>>> In the above case, yes I see that t1 would return -EINVAL (as
> >>>>>> config->num_connections doesn't match with num_connections)
> >>>>>> but then t3 would succeed to update nr_hw_queue (as both
> >>>>>> config->num_connections and num_connections set to 2 this
> >>>>>> time). Isn't it? If yes, then the above patch (from Ming)
> >>>>>> seems good.
> >>>>>
> >>>>> Emm, I'm confused, If you agree with the concurrent process, then
> >>>>> t3 update nr_hw_queues to 2 first and return sucess, later t1 update
> >>>>> nr_hw_queues back to 1 and return failure.
> >>>>
> >>>> It should be easy to avoid failure by simple retrying.
> >>>>
> >>> Yeah I think retry should be a safe bet here.
> >>>
> >>
> >> I really not sure about the retry, the above is just a scenario that I
> >> think of with a quick review, and there are still many concurrent
> >> scenarios that need to be checked, I'm kind of lost here.
> >>
> >> Except nbd_start_device() and nbd_add_socked(), I'm not confident
> >> other context that is synchronized with config_lock is not broken.
> >> However, I'm ok with the bet.
> >>
> >>> On another note, synchronizing nbd_start_device and nbd_add_socket
> >>> using nbd->task_setup looks more complex and rather we may use
> >>> nbd->pid to synchronize both. We need to move setting of nbd->pid
> >>> before we invoke blk_mq_update_nr_hw_queues in nbd_start_device.
> >>> Then in nbd_add_socket we can evaluate nbd->pid and if it's
> >>> non-NULL then we could assume that either nr_hw_queues update is in
> >>> progress or device has been setup and so return -EBUSY. I think
> >>> anyways updating number of connections once device is configured
> >>> would not be possible, so once nbd_start_device is initiated, we
> >>> shall prevent user adding more connections. If we follow this
> >>> approach then IMO we don't need to add retry discussed above.
> >>
> >> It's ok for me to forbit nbd_add_socked after nbd is configured, there
> >> is nowhere to use the added sock. And if there really are other contexts
> >> need to be synchronized, I think nbd->pid can be used as well.
> >>
> > 
> > Do we have a conclusion now? Feel free to send the retry version, or let
> > me know if I should send a new synchronize version.
> > 
> Personally, I prefer synchronizing nbd_start_device and nbd_add_socket
> using nbd->pid but I do agree retry version would also work. Having
> said that, lets wait for Ming's feedback as well.

IMO simpler fix, especially in concept, is more effective for addressing
this kind of issue, with less chance to introduce regression.

If no one objects, I may send the retry version.


Thanks,
Ming

