Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB73BB57
	for <linux-block@vger.kernel.org>; Tue,  3 Feb 2026 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770088469; cv=none; b=DisbhfLufvCV2M+vAhFY/KlmuGU3Hi+QdK0O5UaRMAkMY09rnuTk4mRGtTxUSF26wKW5LEKtG4brX6t3IkjWgItYC2KcNImM0ICf5ksPv8ySo3aARs0qp0Tx5Dd/S5iqL/dZSUqfMCMzTzbB6Qy/Vjnv88Bn6O1aLJzoQJDsKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770088469; c=relaxed/simple;
	bh=uuEj6Cw94yK3SHlyFK+k+KM5MROXPbSCDahO7Y4K928=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiNBmSndPHcIuifxLI1hLcxtYBxSPY3BKhRRPVQCDh7L4HdF1/sZJzHVy5w4Y2mri6Tv7m9khylLOo5gWH8zcdi7f9ZJySz63CmwxVLnayShEXylNJNZQDnOU7Qva4j90OqNh5mD1/Ztf2lmMOQJJ6NPeDa2YIMpcNb8lOwljBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VP65uCWq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VP65uCWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770088467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bhbcDfd6GKLuKNUd6g7wVJ0vSapI862aCf53bUJiWfY=;
	b=VP65uCWqPOU30RJIse0kiUFMQcXue7NH0AYHqpprHaCjQjs7Z1uEtjadYnC8dc2UtrMwBB
	BOKuggp+q1OKmCvHSFzWaTy2Qnk2CNAW/35wFgF0sSMclUyfaIH98yh4NMtogvCulEcssj
	IPWO+0eiuZlrvczRQkkG7ku0q4f+csE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-ZsMK_n_wM4-_HK4DbdKufw-1; Mon,
 02 Feb 2026 22:14:24 -0500
X-MC-Unique: ZsMK_n_wM4-_HK4DbdKufw-1
X-Mimecast-MFC-AGG-ID: ZsMK_n_wM4-_HK4DbdKufw_1770088463
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10047195608F;
	Tue,  3 Feb 2026 03:14:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.35])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 362251800285;
	Tue,  3 Feb 2026 03:14:18 +0000 (UTC)
Date: Tue, 3 Feb 2026 11:14:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Hannes Reinecke <hare@suse.de>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
Message-ID: <aYFoBafih46bLK0T@fedora>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Hi Hannes,

On Sun, Feb 01, 2026 at 06:06:52PM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> We are currently working on implementing cross-controller resets for
> NVMe, which requires to send a command to the target which then should
> terminate all commands on a given controller.

Can you provide a little background why this reset is required? And for
solve which problem?

> While we could easily terminate the controller, the specification
> also requires us to terminate all outstanding commands.
> Which then recurses into my all-time favourite topic on how to
> abort outstanding commands from the fs/bio layer.

nvme_quiesce_io_queues() & nvme_cancel_tagset() may do it, or do you have
other new requirement not covered by the two helpers?


Thanks, 
Ming

