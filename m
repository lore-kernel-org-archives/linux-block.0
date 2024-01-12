Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886624A10
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imkLuf1S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705022022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=lR/IMzHbiub1hn91+j6HNrtl4uAT2OL+J7H2o1L2b/o=;
	b=imkLuf1SVDJD6Llhyvalxj3ei6ZI0owJA0PHwzC0R+RNexCpFOdzEDmwBx+aRm7BcDjXrh
	Ii/9t/ai008t32FH56lp1zoHoRoaRR6145//mEAtc3SNDRMM96+QhJGB4wKkX4ycW5eDbt
	wSwMf4KD94EkiCG/R1UE7JBmL2uE4RQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-w5G-OFUDN8epxwQCkl19wg-1; Thu, 11 Jan 2024 20:13:37 -0500
X-MC-Unique: w5G-OFUDN8epxwQCkl19wg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 582E685A58F;
	Fri, 12 Jan 2024 01:13:37 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24A692166B31;
	Fri, 12 Jan 2024 01:13:32 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:13:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: ming.lei@redhat.com, Yi Zhang <yi.zhang@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len]
Message-ID: <ZaCSOH7L+Nm6PvcN@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

----- Forwarded message from Ming Lei <ming.lei@redhat.com> -----

Add linux-nvme

Date: Fri, 12 Jan 2024 09:08:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: ming.lei@redhat.com, Yi Zhang <yi.zhang@redhat.com>, John Meneghini <jmeneghi@redhat.com>
Subject: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len

Hello Damien and Guys,

Yi reported that the following failure:

Oct 18 15:24:15 localhost kernel: nvme nvme4: invalid zone size:196608 for namespace:1
Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, opened
Oct 18 15:24:33 localhost smartd[2303]: Device: /dev/nvme4, NETAPPX4022S173A4T0NTZ, S/N:S66NNE0T800169, FW:MVP40B7B, 4.09 TB

Looks current blk-zoned requires zone->len to be power_of_2() since
commit:

6c6b35491422 ("block: set the zone size in blk_revalidate_disk_zones atomically")

And the original power_of_2() requirement is from the following commit
for ZBC and ZAC.

d9dd73087a8b ("block: Enhance blk_revalidate_disk_zones()")

Meantime block layer does support non-power_of_2 chunk sectors limit.

The question is if there is such hard requirement for ZNS, and I can't see
any such words in NVMe Zoned Namespace Command Set Specification.

So is it one NVMe firmware issue? or blk-zoned problem with too strict(power_of_2)
requirement on zone->len?


Thanks,
Ming


----- End forwarded message -----

