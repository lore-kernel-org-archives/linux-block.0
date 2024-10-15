Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E601F667C
	for <linux-block@vger.kernel.org>; Tue, 15 Oct 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729010432; cv=none; b=ZpOMMWK7urAQn6YFgW4cng7cgZFHCgQOm/9jO9K93/Yp0L6ruxmuN5Bwfoh6aper33JeELze57ypIj7kCOUfifmJTpN8Hw53fQDuCtmZ2EvRo+fUJq+1XhMhXgV68jPRWYIztrGUq3GhB+NAYZiVk4lN3D+EA15tHQn2RbgjuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729010432; c=relaxed/simple;
	bh=MyZKFDFuFDT94CRYOaGJVPQTP8cEe/PxKy6fhYjQgPc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bLj20teoKddO9+UzPL8fs1A5Uq7qyWuXcyAKRo0kfSv6KbB3jkQosO5wfJcFg3DfGuFyqw/FtRx8ytd0qex6fcqfVw+5l0GR/AXNSE1lToycjBwk4Rl0GKr2IbL1KqGs0K6num5DBWfMutMcin8NupOP8wBuecYGmEVPHp14hdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lk+k/GiS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk+k/GiS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729010429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=7oscf9BVAWrQH8Kbeje1+MmNXbyezAEFS+Y4FMKb9WE=;
	b=Lk+k/GiSUBhrTCt8i98ylcCBeMgpw8IFRsTMm6xVJ3KnBMie3k99ALi+iYIVL05q7NvTAc
	OM9F2d6znhp2PzgXQHxrQ8JShmjkk0irKPLd1eYiJSa7iBBDr+bML4ihb45FzvBDiNxvHe
	ZRw46I7t0d8LKYlonUT5R9cRe89pQA0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-NcINg_TWOkqJf8x1EGBPFQ-1; Tue,
 15 Oct 2024 12:40:26 -0400
X-MC-Unique: NcINg_TWOkqJf8x1EGBPFQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 444AF19560B4;
	Tue, 15 Oct 2024 16:40:24 +0000 (UTC)
Received: from fedora (unknown [10.72.116.3])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813AF1956056;
	Tue, 15 Oct 2024 16:40:20 +0000 (UTC)
Date: Wed, 16 Oct 2024 00:40:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [Regression] b1a000d3b8ec ("block: relax direct io memory alignment")
Message-ID: <Zw6a7SlNGMlsHJ19@fedora>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="riDcSl3aQ1468jZ6"
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--riDcSl3aQ1468jZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Guys,

Turns out host controller's DMA alignment is often too relax, so two DMA
buffers may cross same cache line easily, and trigger the warning of
"cacheline tracking EEXIST, overlapping mappings aren't supported".

The attached test code can trigger the warning immediately with CONFIG_DMA_API_DEBUG
enabled when reading from one scsi disk which queue DMA alignment is 3.

Thanks,
Ming

--riDcSl3aQ1468jZ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dma.c"

#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <libaio.h>
#include <errno.h>
#include <unistd.h>

int main(int argc, char *argv[])
{
	const char *outputfile=argv[1];
	io_context_t ctx;
	int output_fd;
	const int nr = 4;
	struct iocb _io[nr];
	struct iocb *io[16] = {
		&_io[0],
		&_io[1],
		&_io[2],
		&_io[3],
	};
	struct io_event e[nr];
	struct timespec timeout;
	int ret;
	char *content;
	unsigned size = 2*1024 * 1024;

	posix_memalign((void **)&content, 4096, nr * size + 512);

	memset(&ctx,0,sizeof(ctx));
	if(io_setup(10, &ctx) != 0) {
		printf("io_setup error\n");
		return -1;
	}

	if((output_fd = open(outputfile, O_DIRECT, 0644)) < 0) {
		perror("open error");
		io_destroy(ctx);
		return -1;
	}
	io_prep_pread(io[0], output_fd, content + 4, size, 0);
	io_prep_pread(io[1], output_fd, content + size, size, size * 2);
	io_prep_pread(io[2], output_fd, content + size * 2, size, size * 4);
	io_prep_pread(io[3], output_fd, content + size * 3, size, size * 8);

	ret = io_submit(ctx, nr, io);
	if(ret != nr) {
		io_destroy(ctx);
		printf("io_submit error %d\n", ret);
		return -1;
	}

	while(1) {
		timeout.tv_sec=0;
	        timeout.tv_nsec=500000000;
	        if (io_getevents(ctx, nr, nr, e, &timeout) == nr) {
	            close(output_fd);
	            break;
	        }
	        printf("haven't done\n");
	        sleep(1);
	}
	io_destroy(ctx);
	return 0;
}


--riDcSl3aQ1468jZ6--

