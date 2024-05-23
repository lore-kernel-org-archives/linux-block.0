Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A17BD9
	for <linux-block@vger.kernel.org>; Thu, 23 May 2024 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716483225; cv=none; b=nf0vvNtVVAQr2m7yiFfgT1V7t/SrmyebCzidLlwe2bN0oxlcOUVfmQQCdLQDKo4MJitRs1jOOfwk/r5c/ypPkKK53pEWkpv8ejEWZFB7K0UgBwTBCp0TWPmY7oVCTPDYoOU3YasjWjKbxi2Ow5z1yo5Xtf6wqQn6OYi3Xgm5Lxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716483225; c=relaxed/simple;
	bh=FXXc/WPUqVzWvmXyeKoySolFM1EnHkj9Q1p2+dRNWWE=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=f+wcTfi28F+m41GSOKLuUrpZRITeVdwPI49akBwhbWqNrU3P8UyO2pS0P8KZZUoPHtQkRMXHz6U1qnsaLe8gikBrEKq1d/l+izqt2fWY019jv6tvnpz9fdDcD7ICN/PxUTCfA6meiVspKjF2Csi3+I/QsEaQVJ8XXr5ABMhXvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SDOi0bkC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SDOi0bkC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716483222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=D/p2RkQytKJi3MuPGrjVqdXhBuYp+ylwZe8ZbpZTahc=;
	b=SDOi0bkCUKJ4pzKN/BJqTnu57jl+x8zeq3S79LWq6Sxxe+4vXrYMrE1Pa90nFH5dXmazrs
	zT1lwr3K3GewNg7+Bom7nhIrAUBtXqtilFniKNXvy0scr1j9kFzv8r6pBf4LM29CuLJIQu
	RHoQsVer0DESWVZCT992dFKWrpD039E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-uz8F4asBM92bX_NY5AMwIA-1; Thu, 23 May 2024 12:53:38 -0400
X-MC-Unique: uz8F4asBM92bX_NY5AMwIA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37C66101A52C;
	Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2168C40C6EB7;
	Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id 0E31530C1C33; Thu, 23 May 2024 16:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id 0D4943FB52;
	Thu, 23 May 2024 18:53:38 +0200 (CEST)
Date: Thu, 23 May 2024 18:53:38 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, 
    Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
    Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>, 
    Anuj gupta <anuj1072538@gmail.com>
cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev, 
    linux-nvme@lists.infradead.org
Subject: [PATCH 0/2 v3] dm-crypt support for per-sector NVMe metadata
Message-ID: <a1d8771a-70ad-9eed-476c-af696d2f9ac2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi

Here I'm resending the dm-crypt support for per-sector NVMe metadata. I 
made some changes to the first patch as suggested by Jens Axboe.

The first patch fixes a bug when splitting a bio with attached metadata.
The second patch enables dm-crypt to use NVMe metadata for authenticated 
encryption. dm-crypt can run directly on NVMe without using dm-integrity.

These patches increase write throughput twice, because there is no write 
to the dm-integrity journal.

An example how to use it (so far, there is no support in the userspace
cryptsetup tool):

# nvme format /dev/nvme1 -n 1 -lbaf=4
# dmsetup create cr --table '0 1048576 crypt
capi:authenc(hmac(sha256),cbc(aes))-essiv:sha256
01b11af6b55f76424fd53fb66667c301466b2eeaf0f39fd36d26e7fc4f52ade2de4228e996f5ae2fe817ce178e77079d28e4baaebffbcd3e16ae4f36ef217298
0 /dev/nvme1n1 0 2 integrity:32:aead sector_size:4096'

Mikulas

