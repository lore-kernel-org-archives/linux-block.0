Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89D681724
	for <linux-block@vger.kernel.org>; Fri,  6 Jun 2025 10:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749204376; cv=none; b=W2LEIKdpFU4kKaS6kWFwP3bCa0x6bNUGmsAIB4hsfEayyEvEPWaznKAntm2BTGRlH7lu963a69GICfLT5Mz/eCjLGsQJB/3E85mKj13XDdwDhgGlt9eoaRkiPrVlUq3FlD/YGnkB2QS/GvhkN2LKaSxIdUAvwjzxteuAb25UeEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749204376; c=relaxed/simple;
	bh=Ko9gn0WyBW7B9w+8269mkJhOE8WktafJk/quBdD1t98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLd60f3nsAHtZ3DxIqsc3+Pblr+x8IXhqJK/hp09967SGwGy9bib43LrvEZgaaPrOSiyaCX4eLXCSp437xE3pDcb8+QMIB8p7EFjkly+xaxnkGBBuWXdQu2Bz14cPpEMpNa/NKY8IdBx6nUQYGB1dhVr4XVBoREAcwwjdXn2T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gnBNlhOe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gnBNlhOe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749204373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=13IDmuGIYmqe3lLFBrR7XVdezQ46MFwukH1u7DHYpAg=;
	b=gnBNlhOeFJUMySGKa2WDFLEpcFbfpvjqNd5ae3ObibYD278ongXml6UUFSuZBMF5iTOXTM
	y5CgwA+aIiu/bSBy7Vr1KtRvzXBQ+gxYNipvFvW3wjIObV2ruEq2mWuM2PAhwy2Yf7GMLq
	meWrAs/HCfHsJYmcg51W1KpkYJRQwk4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-qiacxrf-P9yhADmIaVNDag-1; Fri,
 06 Jun 2025 06:06:10 -0400
X-MC-Unique: qiacxrf-P9yhADmIaVNDag-1
X-Mimecast-MFC-AGG-ID: qiacxrf-P9yhADmIaVNDag_1749204369
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C2B71800BF3;
	Fri,  6 Jun 2025 10:06:09 +0000 (UTC)
Received: from fedora (unknown [10.72.116.163])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AFEC719560B2;
	Fri,  6 Jun 2025 10:06:06 +0000 (UTC)
Date: Fri, 6 Jun 2025 18:06:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yoav Cohen <yoav@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Jared Holzman <jholzman@nvidia.com>
Subject: Re: ublk: Adding Latency Measurement Support to UBLK
Message-ID: <aEK9iSmuAJrulQDs@fedora>
References: <DM4PR12MB632854130D3793D4DF7A892DA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM4PR12MB632854130D3793D4DF7A892DA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jun 05, 2025 at 12:52:49PM +0000, Yoav Cohen wrote:
> Dear Ming,
> 
> We would like to propose adding support to the ublk server for measuring latency at each stage of the I/O path. Currently, we are missing key information from the ublk driver—for example, the exact time a completion queue entry (CQE) was issued for an I/O operation, or when an I/O reached the ublk driver.
> 
> After reviewing the code, it seems this information is not currently accessible. One possible approach could be to extend the ublksrv_io_desc structure when a specific flag is passed during the creation of the ublk device (or by some other mechanism).
> 
> We are very interested in contributing this feature but would appreciate your thoughts and feedback before proceeding.

One idea is to add some trace points which can be attached reliably by
ebpf program, then you can run any analysis on the collected data from
ebpf program.

Please see the block layer's example:

trace_block_rq_issue()
trace_block_rq_complete()
...


Thanks,
Ming

