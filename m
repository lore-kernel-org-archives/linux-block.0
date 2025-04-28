Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0474A21
	for <linux-block@vger.kernel.org>; Mon, 28 Apr 2025 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841124; cv=none; b=VHpifVyg2Fn4WZzm+XbEn5n1fOVFiwMiWghiGb7l3PkAt+1cdpm0u9GiSAm1gffxO8CfWH7vXDuym8vA5Xpmzt82LXYsxxNelQnxxT2M3FT4VCKFOKKFG4QIf0xfZTyNEyDtCg3M0Fs34vBlQf9DTc46QABVY5awRT/wqrEzDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841124; c=relaxed/simple;
	bh=2Tez4/WzB6NeQFEpf9w4LApO1G0GKt8LY/BRZBgITvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DioIJ8NyOYbtkuwkA780C/AwfguMp5uSzYS1xB6PtecCCxw9xkqafhcfltb4WK7u9dr4lKR11F88c7j45a2g5BkPPaFZiiS9HGsPmyUrLFksRDJ3fde83c+R2GIdvX4ETgRz8OaxSdNrG5hkDZuLgU3UL4kFWeYjt7Gujk54ESU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OflX3Ikr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OflX3Ikr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745841121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNj1l5QmBMhuRA1gTzIZuuu2VnXQsropjVB2lzik7ow=;
	b=OflX3Ikr+9CE0mVMD7nTCFnVF6fTYICG3U0RhU6s0wcetWbo3/QoYO004vl5xCNO/IrAPZ
	Zid76XGH6MOrIYp/jvJgCmKo8dbaJMwuzppIBMwPrPccdcJkKFXH74AR5Zs34u4z/FyznQ
	9t9HaJwvTYq1rZXAndcQlwxX4+Baa6k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-136-AZ16a193MFKPVNIrSz6j-w-1; Mon,
 28 Apr 2025 07:51:58 -0400
X-MC-Unique: AZ16a193MFKPVNIrSz6j-w-1
X-Mimecast-MFC-AGG-ID: AZ16a193MFKPVNIrSz6j-w_1745841116
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A77F180036D;
	Mon, 28 Apr 2025 11:51:56 +0000 (UTC)
Received: from fedora (unknown [10.72.116.66])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FB3819560A3;
	Mon, 28 Apr 2025 11:51:52 +0000 (UTC)
Date: Mon, 28 Apr 2025 19:51:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH V3 10/20] block: move blk_unregister_queue() &
 device_del() after freeze wait
Message-ID: <aA9r06XTsrtiMxb3@fedora>
References: <20250424152148.1066220-1-ming.lei@redhat.com>
 <20250424152148.1066220-11-ming.lei@redhat.com>
 <20250425143441.GE11082@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425143441.GE11082@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Apr 25, 2025 at 04:34:41PM +0200, Christoph Hellwig wrote:
> On Thu, Apr 24, 2025 at 11:21:33PM +0800, Ming Lei wrote:
> > Move blk_unregister_queue() & device_del() after freeze wait, and prepare
> > for unifying elevator switch.
> > 
> > This way is just fine, since bdev has been unhashed at the beginning of
> > del_gendisk(), both blk_unregister_queue() & device_del() are dealing
> > with kobject & debugfs thing only.
> 
> Can you please add a reference to the previous attempt here and that
> it was backed out again and why we think it's fine this time around?

Turns out this patch isn't necessary, we can avoid the small race easily
between elevator switch and del_gendisk().

Will drop this patch in V4.


Thanks,
Ming

