Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C20EA6
	for <linux-block@vger.kernel.org>; Fri, 12 Jan 2024 01:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NHsgO9qt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705021737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=sDCb95jFyxMrcuhzrRucjLKEjA/5V27UJDAqMaRXmXw=;
	b=NHsgO9qtEC3xx7SJHvMaox4yaYyBpFxWC0X4e3/74J2Gz+r1HLW82+VDmbE5FZ+Eve/DHL
	HsuPZNCnQZ5ohbbfkuYCUnzKlKbnXEMu2gBRrBzwWkV7rjDDOc8bJ+C/buZpe9YyPWzl5m
	bHTM08nMlgLJHUOmp3C9+PB88SnL5rw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-wVzfvpbwNjiZRQsy1J4ggA-1; Thu,
 11 Jan 2024 20:08:55 -0500
X-MC-Unique: wVzfvpbwNjiZRQsy1J4ggA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8972D1C06EC1;
	Fri, 12 Jan 2024 01:08:55 +0000 (UTC)
Received: from fedora (unknown [10.72.116.36])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A4DE2166B31;
	Fri, 12 Jan 2024 01:08:51 +0000 (UTC)
Date: Fri, 12 Jan 2024 09:08:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: ming.lei@redhat.com, Yi Zhang <yi.zhang@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>
Subject: [Report] blk-zoned/ZNS: non_power_of_2 of zone->len
Message-ID: <ZaCRHzTjj8i0AJwE@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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

