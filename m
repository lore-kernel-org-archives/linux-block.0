Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6503E132103
	for <linux-block@vger.kernel.org>; Fri, 30 May 2025 02:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748570741; cv=none; b=EgjxJE2pld36b7wHlp/Gh9yB1K2hV8pNBtBI19YeQQZw8axLqB5UUoeqDKALffCrnhBfXU1DS72S4Nk+OW5IblXn40dcNLEvb2zhZET2qF3eSb5G0xd4Ocn7yHZ/9LNNLZBF8gkiKuuGlRnU0F4fvyAocnMozlcvvM+2ptqiL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748570741; c=relaxed/simple;
	bh=5aqObgmG0Uz2hk5FayQ5YGrx2f47e6fCDc2Ix8gVh4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYmNIleVhu5wLqkjx63v9cNKhhEapWhXvlA/O5tvLEd5BhHRn/5qHD/cTucIHKq9PxEl4RjHJh0pWhak33i/xPs9LQ7rqkWmCOTolVgntyKDtBItuYhhfQnBmWRTnoepGxbYH8vHput9vPfU65/VtVPO45JWTRr6wN+omv1TWKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RKkwg/S4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RKkwg/S4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748570738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywVTKcS7LKE/mWfUseZ77s4QJB9QB/8+Twjpn21G2hg=;
	b=RKkwg/S45rHEacmz+HCBonx5kejPQO0HJE1WMF8CBsondOR7bywtHyhQms5YvhafFahASp
	dreg3HV0abvIJmLqdz5KJGpP8RUBgjte2ECdztSMfZ9LWq6Y9M+ZkVAid/ZsTb3U3qAHUf
	X6fodXITKWxI7y3WBe3V5oedtVPtu6c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-KPtzBjDXON2VseZAJmCFTg-1; Thu,
 29 May 2025 22:05:32 -0400
X-MC-Unique: KPtzBjDXON2VseZAJmCFTg-1
X-Mimecast-MFC-AGG-ID: KPtzBjDXON2VseZAJmCFTg_1748570731
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A9C71800570;
	Fri, 30 May 2025 02:05:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.107])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE439180047F;
	Fri, 30 May 2025 02:05:23 +0000 (UTC)
Date: Fri, 30 May 2025 10:05:18 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v8 1/9] ublk: have a per-io daemon instead of a per-queue
 daemon
Message-ID: <aDkSXliGj_syKKsr@fedora>
References: <20250529-ublk_task_per_io-v8-0-e9d3b119336a@purestorage.com>
 <20250529-ublk_task_per_io-v8-1-e9d3b119336a@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529-ublk_task_per_io-v8-1-e9d3b119336a@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Thu, May 29, 2025 at 05:47:10PM -0600, Uday Shankar wrote:
> Currently, ublk_drv associates to each hardware queue (hctx) a unique
> task (called the queue's ubq_daemon) which is allowed to issue
> COMMIT_AND_FETCH commands against the hctx. If any other task attempts
> to do so, the command fails immediately with EINVAL. When considered
> together with the block layer architecture, the result is that for each
> CPU C on the system, there is a unique ublk server thread which is
> allowed to handle I/O submitted on CPU C. This can lead to suboptimal
> performance under imbalanced load generation. For an extreme example,
> suppose all the load is generated on CPUs mapping to a single ublk
> server thread. Then that thread may be fully utilized and become the
> bottleneck in the system, while other ublk server threads are totally
> idle.
> 
> This issue can also be addressed directly in the ublk server without
> kernel support by having threads dequeue I/Os and pass them around to
> ensure even load. But this solution requires inter-thread communication
> at least twice for each I/O (submission and completion), which is
> generally a bad pattern for performance. The problem gets even worse
> with zero copy, as more inter-thread communication would be required to
> have the buffer register/unregister calls to come from the correct
> thread.
> 
> Therefore, address this issue in ublk_drv by allowing each I/O to have
> its own daemon task. Two I/Os in the same queue are now allowed to be
> serviced by different daemon tasks - this was not possible before.
> Imbalanced load can then be balanced across all ublk server threads by
> having the ublk server threads issue FETCH_REQs in a round-robin manner.
> As a small toy example, consider a system with a single ublk device
> having 2 queues, each of depth 4. A ublk server having 4 threads could
> issue its FETCH_REQs against this device as follows (where each entry is
> the qid,tag pair that the FETCH_REQ targets):
> 
> ublk server thread:	T0	T1	T2	T3
> 			0,0	0,1	0,2	0,3
> 			1,3	1,0	1,1	1,2
> 
> This setup allows for load that is concentrated on one hctx/ublk_queue
> to be spread out across all ublk server threads, alleviating the issue
> described above.
> 
> Add the new UBLK_F_PER_IO_DAEMON feature to ublk_drv, which ublk servers
> can use to essentially test for the presence of this change and tailor
> their behavior accordingly.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

