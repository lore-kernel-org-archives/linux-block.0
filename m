Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6284620298D
	for <linux-block@vger.kernel.org>; Mon, 23 Jun 2025 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750665770; cv=none; b=IxUXginBZfwHE+x9qodHvCTENJA2mhPvhmOjrmRNK2PyRYWOiVTPeSXEVvh+1HXKUUyqMnWOQekYVp/YcEZxWKhRYuYIR6Tvg6r7p/eGxCo690YAQwXU+UObGHIs2Yoxy1lFyuvp2XwOPOXHgBsR3XNypFvYjIwXUWnqxikY6VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750665770; c=relaxed/simple;
	bh=FL9vAAwQPQQWDibzZcTeejk6+wTwLdVxnONhFfIiNyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM5li78J/MrXpbm7EGbdFiEuWMM9kXWHx9WC/HtO0XAGWeGLk6vjA4lNI9luGNt6G+s48TJyBmKjZ3Oowk3GhSnJUSCDGT7YssfJFLiIJL+Ur6rgMkiCIRXYAa9npveAvyM6GYcitwzZG7p1WBOT7OgH+KTs9V1wtHgU4tJOqBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HnHWOD72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HnHWOD72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750665768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vjqmSHAr7Yje9MhTxotdlI6FDUaDoQnGvx95g4AfMiQ=;
	b=HnHWOD72E+5gsVW9xhhOB8NhWJtRmRkE6ejeziW9g2LU6ZRSGYAEmvKLWXO5W+0hZdzxK/
	lbBf74P47ylr6dnJli6qYPpF2RBwEmTkLNRbkF9BvPrmmCn5uIdRBitwcdKLCHH19YsBDh
	g5t+0gXqvlhkNaMk1RCni6F3L7LYh2k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-NfJ6zZfkMZC14-KfWW0N6Q-1; Mon,
 23 Jun 2025 04:02:42 -0400
X-MC-Unique: NfJ6zZfkMZC14-KfWW0N6Q-1
X-Mimecast-MFC-AGG-ID: NfJ6zZfkMZC14-KfWW0N6Q_1750665761
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4D7A218001D1;
	Mon, 23 Jun 2025 08:02:41 +0000 (UTC)
Received: from fedora (unknown [10.72.116.65])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 859C219560B4;
	Mon, 23 Jun 2025 08:02:38 +0000 (UTC)
Date: Mon, 23 Jun 2025 16:02:33 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 02/14] ublk: remove struct ublk_rq_data
Message-ID: <aFkKGXbsBRDdrMjj@fedora>
References: <20250620151008.3976463-1-csander@purestorage.com>
 <20250620151008.3976463-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620151008.3976463-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Fri, Jun 20, 2025 at 09:09:56AM -0600, Caleb Sander Mateos wrote:
> __ublk_check_and_get_req() attempts to atomically look up the struct
> request for a ublk I/O and take a reference on it. However, the request
> can be freed between the lookup on the tagset in blk_mq_tag_to_rq() and
> the increment of its reference count in ublk_get_req_ref(), for example
> if an elevator switch happens concurrently.
> 
> Fix the potential use after free by moving the reference count from
> ublk_rq_data to ublk_io. Move the fields buf_index and buf_ctx_handle
> too to reduce the number of cache lines touched when dispatching and
> completing a ublk I/O, allowing ublk_rq_data to be removed entirely.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 62fe99cef94a ("ublk: add read()/write() support for ublk char device")

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

