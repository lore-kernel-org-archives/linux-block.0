Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A961A9FA0
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757294959; cv=none; b=O/G1h1L9z9oJbwOQ+Jm+SUS8zNeM+RlcuvsMshbWadH9wLzRK8PcAl5GtLQoCEZVJkHf69SqDSCqFx1ZgHRjODLmGtgID+17QekVIwdhQ5XV6kTAer5mJ0G2yPThs0vpfI8W8DhedaLVE5pKta8s/7WHd06wp+z1rMK8dcelDnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757294959; c=relaxed/simple;
	bh=ltKsrL8XuvFDcFv3IZBGLefyei/XNUgJcxT5XWlu7/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSV++BL32g9zFR8AivcEMcPOzXp6ZkS7DBFPFycraIfbnk8LSdWfMCsaJRwbMJQoopY8w5K6QE9SW/wzrE1GmKpiQfXtqM0SCVAmq6O2z08AOtPda5BfR1Yvd9E3809QY3B7tEAIa+g5tK6Y8ffC9mT9S+Wc+kT0NpMoBAz1Sy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPVVUnnJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPVVUnnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757294954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8jvDWZPSNp6TtCQnfkgzTNaiEAdcRYOJN/AA4nNQaVk=;
	b=bPVVUnnJsc0QOF8RN18pOFt5GQhxYUJnLOkclMU129D8vUoewtbuZI4SimAlk1sBIM7hwo
	p0Xmk5N8TbyXI0bql589jAxsElEctZedLWdvZJvfTtmrg5CL/85DUCToCdtqwkavgwvMGn
	K5NEYkuqdKJO4iWlxr6JxV2qRYkTtnU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-341-J1B9W5jtOb6V_vO4HswOrA-1; Sun,
 07 Sep 2025 21:29:11 -0400
X-MC-Unique: J1B9W5jtOb6V_vO4HswOrA-1
X-Mimecast-MFC-AGG-ID: J1B9W5jtOb6V_vO4HswOrA_1757294950
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B77A41956087;
	Mon,  8 Sep 2025 01:29:09 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0C471800446;
	Mon,  8 Sep 2025 01:29:05 +0000 (UTC)
Date: Mon, 8 Sep 2025 09:28:59 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Hannes Reinecke <hare@suse.de>, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH V2 0/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators
Message-ID: <aL4xW_wRG2MZFA3U@fedora>
References: <20250830021825.2859325-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830021825.2859325-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Sat, Aug 30, 2025 at 10:18:18AM +0800, Ming Lei wrote:
> Hello Jens,
> 
> Replace the spinlock in blk_mq_find_and_get_req() with an SRCU read lock
> around the tag iterators.
> 
> Avoids scsi_host_busy() lockup during scsi host blocked in case of big cpu
> cores & deep queue depth.
> 
> Also the big tags lock isn't needed when reading disk sysfs attribute
> 'inflight' any more.
> 
> Take the following approach:
> 
> - clearing rq reference in tags->rqs[] and deferring freeing scheduler requests
> in SRCU callback
> 
> - replace tags->lock with srcu read lock in tags iterator.
> 
> V2:
> 	- rebase on for-6.18/block
> 	- add review tags

Hello Jens,

Ping...

Thanks,
Ming

