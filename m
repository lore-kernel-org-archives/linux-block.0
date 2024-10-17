Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125FB111AD
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179787; cv=none; b=EYha6aoyRKKJw3uH9yBbEHz1BH1i5vADeJmgV7JtA8MfDdjcFkZvRFSOgk4io0a/PYEqtgjzkuYMsvT5UBCTgSp6j+1E3v3tJK2ANaPDmPYPkeO42pLRNnjXSFb4nnzaMMETyOrH3XcR/IYGGD4k+8So1h0GiWTsjKeU7VuSpEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179787; c=relaxed/simple;
	bh=poYUPwywsKpOeIi53rfn8CRh/RiYY8sxvAT15x3saiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YN5AjDWavMal3//+kXUmwM+iX1AWOyM32hvUEj0jEYNSxIDKrQ7o6GwHgluE+87S3Ch1zEAAGb0AUIj6P5a9BfrslmFOOms8kT380sDXpRyCKLQvrX/YyuNhqo/OWUA4YyKEppgaRGfVtI2HXI5ppjDEYv6ENChixysMG3RojVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IkU+Fxen; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IkU+Fxen"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729179785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lUy+NHCY90HFmiHuL5kBvzZvtUN1CcRm3oIFWnmLPRo=;
	b=IkU+FxenORjn3xsWE+cOtfnI3NeS9VUcvxOi6z4PnPHHlPDXCQdXiNFp8kj0gaM9ZVM/bn
	hAL844Rck9Yld6moh0xLOpxAUdArhdG0FqI2fX2oUjz6BFIq0rJUT3pJc7xcZlaTYvOyHp
	CGBsV5ySYjmFnzlypPba9H3dfShddBA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-K7FxqgiwN4SnUhSC_t5xfw-1; Thu,
 17 Oct 2024 11:43:03 -0400
X-MC-Unique: K7FxqgiwN4SnUhSC_t5xfw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1361B197703D;
	Thu, 17 Oct 2024 15:43:02 +0000 (UTC)
Received: from fedora (unknown [10.72.116.14])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00C731956086;
	Thu, 17 Oct 2024 15:42:55 +0000 (UTC)
Date: Thu, 17 Oct 2024 23:42:50 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
	josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
	vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
	Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] nbd: fix partial sending
Message-ID: <ZxEwelJ__pzSMDPo@fedora>
References: <20241017113614.2964389-1-ming.lei@redhat.com>
 <354b464e-4ae0-460b-b6d1-8ae208345bfa@acm.org>
 <140c4437-fea2-482b-a43f-4ffe6c35e3d2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <140c4437-fea2-482b-a43f-4ffe6c35e3d2@kernel.dk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Thu, Oct 17, 2024 at 09:22:22AM -0600, Jens Axboe wrote:
> On 10/17/24 9:13 AM, Bart Van Assche wrote:
> > On 10/17/24 4:36 AM, Ming Lei wrote:
> >> +static blk_status_t nbd_send_pending_cmd(struct nbd_device *nbd,
> >> +        struct nbd_cmd *cmd)
> >> +{
> >> +    struct request *req = blk_mq_rq_from_pdu(cmd);
> >> +    unsigned long deadline = READ_ONCE(req->deadline);
> >> +    unsigned int wait_ms = 2;
> >> +    blk_status_t res;
> >> +
> >> +    WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
> >> +
> >> +    while (true) {
> >> +        res = nbd_send_cmd(nbd, cmd, cmd->index);
> >> +        if (res != BLK_STS_RESOURCE)
> >> +            return res;
> >> +        if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline)
> >> +            break;
> >> +        msleep(wait_ms);
> >> +        wait_ms *= 2;
> >> +    }
> > 
> > I think that there are better solutions to wait until more data
> > can be sent, e.g. by using the kernel equivalent of the C library
> > function select().
> 
> It's vfs_poll() - but I don't think that'd be worth it here, the nbd
> driver sets BLK_MQ_F_BLOCKING anyway. Using a poll trigger for this
> would be a lot more complicated, and need quite a bit of support code.

Agree.

It is one unlikely event and not worth vfs_poll() here.

And the retry with exponential backoff wait should work just fine.


Thanks,
Ming

