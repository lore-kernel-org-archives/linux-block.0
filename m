Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADE622DA0C
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671892; cv=none; b=bdW7Me38N7zBG5W28OtKL/WrJhy8O/JcG38UDcv7vh7iwGFbQ1mqTv0j9D1/6N3Ak2MqZCJj3P9KH4Rw3EJk1H4H6KXq5dOVgAKa6/NK14j4oWX3pKAoFZcZ3l4G9E9D6g5n1k5qu79A+aZebrIOqLyu+KnFyIYLC61zRRfnh58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671892; c=relaxed/simple;
	bh=yB3fyP09icgtsZmmFe1LuvJ2w3RjzqffNuIlJ/IG/hA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwyC314o0DvUqTGakhR/46y5+kL+AE3/x3SJHnx216p51pDcpq6gDAdKXLnzgzKvKo1N4HqkCdBLMfnaZwoyLi0Vu+dDOq+2YmIfN926/d+fockFyEE888Vd85TuqMr/17gfXgdrGc6kTTBU3Vx/aYpwoi1PeBhr6EosJWiQVnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dDrjWwz9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDrjWwz9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750671889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P/a4J33vzQwSP8FhNhro3+kvteeihK4Srm0QvldA7I4=;
	b=dDrjWwz99bzpLgpVwKm/967hWcP+wQ84XqhbOOoGRGFEBVMlIW6MXu8g6G5oSUgCpCnctT
	j/xC5n6FA8IrgTJBZ27y/7K0vY4jyNddZcJiT9pHhsIRByH4wUFSkkly7YCdX27O+ZX7/J
	N9zdp9g+2ljIJL8LFIY2Mr1Tb71FzRk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-5wjC3UW6PQKFhjjdiMePeg-1; Mon,
 23 Jun 2025 05:44:45 -0400
X-MC-Unique: 5wjC3UW6PQKFhjjdiMePeg-1
X-Mimecast-MFC-AGG-ID: 5wjC3UW6PQKFhjjdiMePeg_1750671884
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F5B61800268;
	Mon, 23 Jun 2025 09:44:44 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5977A180045B;
	Mon, 23 Jun 2025 09:44:40 +0000 (UTC)
Date: Mon, 23 Jun 2025 17:44:35 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 11/14] ublk: optimize UBLK_IO_REGISTER_IO_BUF on
 daemon task
Message-ID: <aFkiA5dwExDx_At3@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-12-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-12-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jun 20, 2025 at 09:10:05AM -0600, Caleb Sander Mateos wrote:
> ublk_register_io_buf() performs an expensive atomic refcount increment,
> as well as a lot of pointer chasing to look up the struct request.
> 
> Create a separate ublk_daemon_register_io_buf() for the daemon task to
> call. Initialize ublk_io's reference count to a large number, introduce
> a field task_registered_buffers to count the buffers registered on the
> daemon task, and atomically subtract the large number minus
> task_registered_buffers in ublk_commit_and_fetch().
> 
> Also obtain the struct request directly from ublk_io's req field instead
> of looking it up on the tagset.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

