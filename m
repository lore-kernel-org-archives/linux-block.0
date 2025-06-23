Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6D6442C
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651362; cv=none; b=HU73kkJvXNZ/Pi+WQymUKV7BW5bsshUoTa+W5nCK4R9UgzR3yA7BR+Crl1oc5VymuzPti6VnwaHFdyiepkXTJqSvvt8cQEyYK0idCnmW1ANNv0CpML3IYx6DvtPuLeU4qAWP8R28TeClHoX7E7gez8hYomHpCNFydlmHRt2rLms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651362; c=relaxed/simple;
	bh=a3Xh+Gbzbc6EFlC9zJai9Y+prJRIoMEowqMnCM5K/wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmpHF+ZXYcIUptFUosnIy5wSw20LPsQ1CsuxAyqfgXX8liCghDd8Rz9Lo03qLg/N6bmI0NmLFQvyazNnGHH8+09USmYOhQRNB8uAwaAXU6FPoUYV6wmfMvp6PAxDLWUEQ/Dnd3KeZ5jMNeTzsJcJV4SefL+wDF9DiMZ5076CTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MXF6r27Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXF6r27Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750651359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FwTdDa7+zOPfvJA4M4KhEnaQ5IkSI7g91Kvc5pb6pEk=;
	b=MXF6r27QzKdgsnG34wInhyreaySnzTl3sMGwGgLPhB3JdDXw2Dfh6UEoN+EByXNZ9Y/kPq
	m64yblTrHUmgNAYZ2G7bKUXbMNO+/fTbDDTuPitUUmdoGXF3sPU7VE3fiWFPlHWskxi4lx
	z3rKq8W92MrKZ4OaFZg7bo47yzz5CTo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-UsU3UsrSM0adT42XZp27Yg-1; Mon,
 23 Jun 2025 00:02:37 -0400
X-MC-Unique: UsU3UsrSM0adT42XZp27Yg-1
X-Mimecast-MFC-AGG-ID: UsU3UsrSM0adT42XZp27Yg_1750651356
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 613EE1956089
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 04:02:36 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01A77180045C;
	Mon, 23 Jun 2025 04:02:33 +0000 (UTC)
Date: Mon, 23 Jun 2025 12:02:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Changhui Zhong <czhong@redhat.com>
Cc: Linux Block Devices <linux-block@vger.kernel.org>
Subject: Re: [bug report] BUG: kernel NULL pointer dereference, address:
 0000000000000001
Message-ID: <aFjR1M2RwGn8y9Rs@fedora>
References: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGVVp+VN9QcpHUz_0nasFf5q9i1gi8H8j-G-6mkBoqa3TyjRHA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Hi Changhui,

On Mon, Jun 23, 2025 at 10:58:24AM +0800, Changhui Zhong wrote:
> Hello,
> 
> the following kernel panic was triggered by ubdsrv  generic/002,
> please help check and let me know if you need any info/test, thanks.
> 
> commit HEAD:
> 
> commit 2589cd05008205ee29f5f66f24a684732ee2e3a3
> Merge: 98d0347fe8fb e1c75831f682
> Author: Jens Axboe <axboe@kernel.dk>
> Date:   Wed Jun 18 05:11:50 2025 -0600
> 
>     Merge branch 'io_uring-6.16' into for-next
> 
>     * io_uring-6.16:
>       io_uring: fix potential page leak in io_sqe_buffer_register()
>       io_uring/sqpoll: don't put task_struct on tctx setup failure
>       io_uring: remove duplicate io_uring_alloc_task_context() definition

The above branch has been merged to v6.16-rc3, can you reproduce it with -rc3?

I tried to duplicate in my test VM, not succeed with -rc3.

...

> [ 7044.064528] BUG: kernel NULL pointer dereference, address: 0000000000000001
> [ 7044.071507] #PF: supervisor read access in kernel mode
> [ 7044.076653] #PF: error_code(0x0000) - not-present page
> [ 7044.081801] PGD 462c42067 P4D 462c42067 PUD 462c43067 PMD 0
> [ 7044.087488] Oops: Oops: 0000 [#1] SMP NOPTI
> [ 7044.091685] CPU: 13 UID: 0 PID: 367 Comm: kworker/13:1H Not tainted
> 6.16.0-rc2+ #1 PREEMPT(voluntary)
> [ 7044.100991] Hardware name: Dell Inc. PowerEdge R640/0X45NX, BIOS
> 2.22.2 09/12/2024
> [ 7044.108565] Workqueue: kblockd blk_mq_requeue_work
> [ 7044.113374] RIP: 0010:__io_req_task_work_add+0x18/0x1f0

Can you share where the above line points to source line if it can be
reproduced in -rc3?

gdb> l *(__io_req_task_work_add+0x18)


Thanks,
Ming

