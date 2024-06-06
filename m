Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2F6190697
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717678200; cv=none; b=MCNEnwNLTfIYCbM+V9zM85pQnGjIxKwMMZBSF0RcEsfnWBf2YEk43ZaQQLbwx09KaghSBM98/6F0UwInNNXN3/CttX1e0V4dD/FlJeVgGaJktbDYLHXY2YC+h3RC6V7rOZKwTsWF0sRpIVI8xv+5OTl4gNr9ye0kACQsnzO0ScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717678200; c=relaxed/simple;
	bh=6s3t/kNPu834Gbf2bRMSjLM5gpFGM/d/GKFM6NqrtnU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=cUOVJK+R1oz/6wik1Lhws5ouM6WpZwnzfCPBUBN1vHmUhglHxGGCjWeLvjhhFhCHXFwJrXT2EJIWZtaGbQnop0bsKAwh8YE1+u3C9rCTLqQA/vXiv3FzDt2WGdtJuX6I78FYukhgprOaGBXr3UE14YE3vIdDDyi8N1EflVQM04A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BOd6HMKs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOd6HMKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717678197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=LXouFU8ZPSjf7r8Q47PI+pQjbdcpaUiDOdpCY1yPI+I=;
	b=BOd6HMKsF8k755W/h50oxTqbD073mC/ulI2P8Z+C0DwoMG73EH8z9Libklm4v1U6QQQB34
	/qIoH74evxUQkbAWu4Vo00tcrDJ5MewvTUtn03mpSCnid/RV4Pnguj36Y1dJzAFt/YnkLq
	erXE/SLZcz0rbVmQvRuDqMSKtArM9oE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-3s01uroIOKmMWMyXQ2v7hQ-1; Thu, 06 Jun 2024 08:49:52 -0400
X-MC-Unique: 3s01uroIOKmMWMyXQ2v7hQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B95A4185B920;
	Thu,  6 Jun 2024 12:49:51 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A934220229B8;
	Thu,  6 Jun 2024 12:49:51 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 8435130C1C37; Thu,  6 Jun 2024 12:49:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 7B97D3FB52;
	Thu,  6 Jun 2024 14:49:51 +0200 (CEST)
Date: Thu, 6 Jun 2024 14:49:51 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>, Zdenek Kabelac <zkabelac@redhat.com>
cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
    Hans Holmberg <hans.holmberg@wdc.com>, 
    Dennis Maisenbacher <dennis.maisenbacher@wdc.com>, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>, 
    linux-block@vger.kernel.org
Subject: disk removal slowdown due to rcu_barrier
Message-ID: <b3c96411-dea-16ed-85fc-a33f842594@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hi

The patch dd291d77cc90eb6a86e9860ba8e6e38eebd57d12 (block: Introduce zone 
write plugging) causes a performance regression when removing block 
devices.

The kernel 6.9 removes a DM block device in 73ms. The kernel 6.10-rc in 
103ms.

That patch adds a rcu_barrier() call to the disk-removal code path and it 
causes the slowdown. We get this stacktrace when we attempt to remove 
large amount of DM devices. Note that the removed devices aren't zoned at 
all.

[<0>] rcu_barrier+0x208/0x320
[<0>] disk_free_zone_resources+0x102/0x160
[<0>] disk_release+0x72/0xe0
[<0>] device_release+0x34/0x90
[<0>] kobject_put+0x8b/0x1d0
[<0>] cleanup_mapped_device+0xd8/0x160
[<0>] __dm_destroy+0x12a/0x1d0
[<0>] dm_hash_remove_all+0x77/0x1a0
[<0>] remove_all+0x23/0x40
[<0>] ctl_ioctl+0x1dc/0x530
[<0>] dm_ctl_ioctl+0xe/0x20
[<0>] __x64_sys_ioctl+0x94/0xd0
[<0>] do_syscall_64+0x82/0x160
[<0>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

Mikulas

