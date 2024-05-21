Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864DDDD7
	for <linux-block@vger.kernel.org>; Tue, 21 May 2024 02:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716260309; cv=none; b=fHm61XnTYfZOP+WBujeW0GFpp5TI9ikg9alWnMqnjjtH2gDLuwWRwSG5FwCc9rQ3PgPIw4nTYsOTKzxzsq/bTyT+jYr/h7/hjdinfXqQ/wMpNXxh4sygMdsLgDdf+Rzwo9qU7FOF41Wnu2YwAWC40BVIrMUoGTt6krqWyde3SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716260309; c=relaxed/simple;
	bh=8CAEzE8UwTJrfsu+0ZWuR33SWmuDxMlc70dhFiUwbuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7XRJSJasElsl742fwiaxpzxVCTQaoJzRa2pXkxRNeHbU8PP7MygYLCTPpNRYiu6T4JxKbTtEjNibgXOjS0nI+JHa4SGkpR1mizmyEhS4rkFUsKgXc37h+1a3uxx1335b8jPQibNrSDq82L+W2YsYhNqPtEiBwxrUEZl/Tz81nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i2yF/WBo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2yF/WBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716260307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BIEH28unuZSbFltUlDuF3nm0O0I68xphDIs4SX1Zj3I=;
	b=i2yF/WBoHXh/x5GHyg6MACUbHqv6GHAqOr+agol6r5C6QXtQnQiLqV41O1XqJRYPYeZVBY
	Y/+ohQy/NuzUwowncCCCYOe71bh/qgjNc1d2WNRHipME184Sb4eP0Lm+jM/K3ja3DTrlGJ
	Q7Us/w/zqN+L5AIsUSI9n7yOQmsVbec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-wbc8xyKHMHaFFVGGzLqHQg-1; Mon, 20 May 2024 22:58:23 -0400
X-MC-Unique: wbc8xyKHMHaFFVGGzLqHQg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42917101A525;
	Tue, 21 May 2024 02:58:23 +0000 (UTC)
Received: from fedora (unknown [10.72.116.24])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AAEB62026D68;
	Tue, 21 May 2024 02:58:19 +0000 (UTC)
Date: Tue, 21 May 2024 10:58:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc: linux-block@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
	Kevin Wolf <kwolf@redhat.com>, ming.lei@redhat.com
Subject: Re: [PATCH V3 5/9] io_uring: support SQE group
Message-ID: <ZkwNxxUM7jqzpqgg@fedora>
References: <20240511001214.173711-1-ming.lei@redhat.com>
 <20240511001214.173711-6-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511001214.173711-6-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Sat, May 11, 2024 at 08:12:08AM +0800, Ming Lei wrote:
> SQE group is defined as one chain of SQEs starting with the first SQE that
> has IOSQE_SQE_GROUP set, and ending with the first subsequent SQE that
> doesn't have it set, and it is similar with chain of linked SQEs.
> 
> Not like linked SQEs, each sqe is issued after the previous one is completed.
> All SQEs in one group are submitted in parallel, so there isn't any dependency
> among SQEs in one group.
> 
> The 1st SQE is group leader, and the other SQEs are group member. The whole
> group share single IOSQE_IO_LINK and IOSQE_IO_DRAIN from group leader, and
> the two flags are ignored for group members.
> 
> When the group is in one link chain, this group isn't submitted until the
> previous SQE or group is completed. And the following SQE or group can't
> be started if this group isn't completed. Failure from any group member will
> fail the group leader, then the link chain can be terminated.
> 
> When IOSQE_IO_DRAIN is set for group leader, all requests in this group and
> previous requests submitted are drained. Given IOSQE_IO_DRAIN can be set for
> group leader only, we respect IO_DRAIN by always completing group leader as
> the last one in the group.
> 
> Working together with IOSQE_IO_LINK, SQE group provides flexible way to
> support N:M dependency, such as:
> 
> - group A is chained with group B together
> - group A has N SQEs
> - group B has M SQEs
> 
> then M SQEs in group B depend on N SQEs in group A.
> 
> N:M dependency can support some interesting use cases in efficient way:
> 
> 1) read from multiple files, then write the read data into single file
> 
> 2) read from single file, and write the read data into multiple files
> 
> 3) write same data into multiple files, and read data from multiple files and
> compare if correct data is written
> 
> Also IOSQE_SQE_GROUP takes the last bit in sqe->flags, but we still can
> extend sqe->flags with one uring context flag, such as use __pad3 for
> non-uring_cmd OPs and part of uring_cmd_flags for uring_cmd OP.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

BTW, I wrote one link-grp-cp.c liburing/example which is based on sqe group,
and keep QD not changed, just re-organize IOs in the following ways:

- each group have 4 READ IOs, linked by one single write IO for writing
  the read data in sqe group to destination file

- the 1st 12 groups have (4 + 1) IOs, and the last group have (3 + 1)
  IOs


Run the example for copying two block device(from virtio-blk to
virtio-scsi in my test VM):

1) buffered copy:
- perf is improved by 5%

2) direct IO mode
- perf is improved by 27%


[1] link-grp-cp.c example

https://github.com/ming1/liburing/commits/sqe_group_v2/


[2] one bug fixes(top commit) against V3

https://github.com/ming1/linux/commits/io_uring_sqe_group_v3/



Thanks,
Ming

