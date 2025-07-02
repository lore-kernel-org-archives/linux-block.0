Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFE2746E
	for <linux-block@vger.kernel.org>; Wed,  2 Jul 2025 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423599; cv=none; b=RE8hBWzdEqzqCchdWv5IO6sF3NX4ORMt/y28zdkIyP5Iot/cLyNFJXUk0oDx47Oadaxy+U6R23dCrljxuThwzKSuApLyHz8asTqPhXqeka9DDmg/Oo+gWuDgyGp9A2jtQ6pSiloU7nD6OWca+Pox36RcDdhMk2lj4RaMkj8v6AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423599; c=relaxed/simple;
	bh=kYJRSf3Gn5sMpfF/6A1FwMCKjt3zxN26Pr+Lm2aRllY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/781QfuQFoA0C+LKffMprfTclvWs2DeoINhyWkIm5L+9KO3EitY6yBaFdInY+C3jfAhSXNbSah3xADSotAsrMPUxDtCrWCPYt0XCAMBC4YZKP1GiMRGPAJGKi859t4i1DtBoSCId17NhYjw8EJVc/NKXRE3QTt/kXnjQWTKQgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PXWcSy/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PXWcSy/D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751423595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jbPIEReb3xkWAZWAXZfMhbsS92bXSTORD10Gzf+15sA=;
	b=PXWcSy/DKfrn9HiJH1Dk1lTvAaSNEtYvHx1lzbNcBLUe0OX8M+K5OCyUOu3xHU9x09WTkX
	CfR7R48SIlf3o2kHAtpW4ZLlD5iiiLOcRhuC76oI+cvZn6VMV4nvyhV4iDtCe1p4pRp5vY
	Lr+sOHe3l3a3AUXLuy+a4o0JeRgzTFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-gfpB-GDIMGK_xLIBuMXB0w-1; Tue,
 01 Jul 2025 22:33:12 -0400
X-MC-Unique: gfpB-GDIMGK_xLIBuMXB0w-1
X-Mimecast-MFC-AGG-ID: gfpB-GDIMGK_xLIBuMXB0w_1751423590
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 993F31944A83;
	Wed,  2 Jul 2025 02:33:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D7137195608F;
	Wed,  2 Jul 2025 02:33:00 +0000 (UTC)
Date: Wed, 2 Jul 2025 10:32:54 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>, josef@toxicpanda.com,
	axboe@kernel.dk, hch@infradead.org, hare@suse.de,
	linux-block@vger.kernel.org, nbd@other.debian.org,
	linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, johnny.chenyi@huawei.com,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] nbd: fix false lockdep deadlock warning
Message-ID: <aGSaVhiH2DeTvtdr@fedora>
References: <20250627092348.1527323-1-yukuai1@huaweicloud.com>
 <aF56oVEzTygIOUTN@fedora>
 <c2fbaacc-62a1-4a98-4157-2637b7f242b7@huaweicloud.com>
 <197b6dca-56be-438d-a60f-21011367c5ed@linux.ibm.com>
 <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99b4afce-de05-ddcb-2634-b19214cf4534@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jul 02, 2025 at 09:12:09AM +0800, Yu Kuai wrote:
> Hi,
> 
> 在 2025/07/01 21:28, Nilay Shroff 写道:
> > 
> > 
> > On 6/28/25 6:18 AM, Yu Kuai wrote:
> > > Hi,
> > > 
> > > 在 2025/06/27 19:04, Ming Lei 写道:
> > > > I guess the patch in the following link may be simper, both two take
> > > > similar approach:
> > > > 
> > > > https://lore.kernel.org/linux-block/aFjbavzLAFO0Q7n1@fedora/
> > > 
> > > I this the above approach has concurrent problems if nbd_start_device
> > > concurrent with nbd_start_device:
> > > 
> > > t1:
> > > nbd_start_device
> > > lock
> > > num_connections = 1
> > > unlock
> > >      t2:
> > >      nbd_add_socket
> > >      lock
> > >      config->num_connections++
> > >      unlock
> > >          t3:
> > >          nbd_start_device
> > >          lock
> > >          num_connections = 2
> > >          unlock
> > >          blk_mq_update_nr_hw_queues
> > > 
> > > blk_mq_update_nr_hw_queues
> > > //nr_hw_queues updated to 1 before failure
> > > return -EINVAL
> > > 
> > 
> > In the above case, yes I see that t1 would return -EINVAL (as
> > config->num_connections doesn't match with num_connections)
> > but then t3 would succeed to update nr_hw_queue (as both
> > config->num_connections and num_connections set to 2 this
> > time). Isn't it? If yes, then the above patch (from Ming)
> > seems good.
> 
> Emm, I'm confused, If you agree with the concurrent process, then
> t3 update nr_hw_queues to 2 first and return sucess, later t1 update
> nr_hw_queues back to 1 and return failure.

It should be easy to avoid failure by simple retrying.


Thanks,
Ming

