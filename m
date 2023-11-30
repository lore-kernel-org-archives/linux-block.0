Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S09AF+O8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F821A3
	for <linux-block@vger.kernel.org>; Wed, 29 Nov 2023 16:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701303396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YQqpuGsZIItErENZLmCBFPntp1ZyTZMptB60KCMJ3Oo=;
	b=S09AF+O8sX6mvWDA4BVVOS3STrxO3UKbp+cDHRmmgItXUpDFmvHmmlaf9eINW81Hqbrykh
	3iM1vAQeouM7L84VDz2elE/TXfp9QWXdFSedd6+KiKUjKhRQCV9ZwnWmyPu9NEbsDxlX5P
	i0Yl8446lcAgss5fD8QO/MSoF1AiGvU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-IKpE6fieOauYI4Awx4BZPw-1; Wed,
 29 Nov 2023 19:16:32 -0500
X-MC-Unique: IKpE6fieOauYI4Awx4BZPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64EE31C05AE1;
	Thu, 30 Nov 2023 00:16:32 +0000 (UTC)
Received: from fedora (unknown [10.72.120.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F3EA5112130A;
	Thu, 30 Nov 2023 00:16:28 +0000 (UTC)
Date: Thu, 30 Nov 2023 08:16:24 +0800
From: Ming Lei <ming.lei@redhat.com>
To: "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc: guazhang@redhat.com, hch@lst.de, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: About 'nvme-pci: fix DMA direction of unmapping integrity data'
Message-ID: <ZWfUWPsJ7AAOzqHR@fedora>
References: <CAKhLTr2PjPnNDccbc8OMy3fSc_U1Dk7GS+UWLUkj0zWwzcp4zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKhLTr2PjPnNDccbc8OMy3fSc_U1Dk7GS+UWLUkj0zWwzcp4zw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On Wed, Nov 29, 2023 at 11:56:50AM -0300, Raphael S. Carvalho wrote:
> I am observing a problem where disk writes are apparently being
> misdirected. File system metadata ends up in file data range for
> example.

Please raise one report in linux-block or linux-nvme if you are asking
for help, and include the following info:

1) kernel release version

2) related drivers or device, nvme or scsi, or dm/md, and how to setup
the device

3) filesystem

4) exact reproduction steps

5) expected result

6) actual result, such as how you conclude that WRITE is misdirected

BTW, is it similar with the following one?

https://bugzilla.kernel.org/show_bug.cgi?id=218158

> 
> I am not completely certain about the problem "nvme-pci: fix DMA
> direction of unmapping integrity data" is trying to fix, could you
> please describe a bit more what the problem is?

dma_unmap_page() should use DMA_TO_DEVICE or DMA_FROM_DEVICE, instead
of block request dir(READ or WRITE), and the issue is actually one
dma-debug warning.

And block request buffer or IO direction isn't supposed to change in its
lifetime, and dma-debug code check if page map & unmap direction is same.

> 
> Can it cause silent data corruption?

No.

Thanks,
Ming

