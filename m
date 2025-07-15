Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AA2459FA
	for <linux-block@vger.kernel.org>; Tue, 15 Jul 2025 22:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619101; cv=none; b=VdSR2yAV/ekPp9qK/5OucTWIU9vP93VjnEgcJl/iT25rsm5ZNNqlc/EEhVrzJen5YSVzqOZ0rpex9Xu9sR5QrU1OaSONK2lzslz77YA0+oReZlK0/xvzbYObfn8V07efTwsxIhl0ZlGnzE9/Fy3mrSXN74tC8zxMpjlY+H/v4/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619101; c=relaxed/simple;
	bh=m0EXv/giwwP0LsGLNE2kAtNFVh4aq00jvuG7BH6iKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6lhK5v1FsWzcyGXz5f3KlX/xhq5ZiMJKmxQromzjAKmIHmqPBinuDNggsRd9sizwYK8wv23O9p49jJzKu4pDji5Kdjiir1dP/Do1Y6qcweoZkoreXr5oMi5XE+fKiKK4MtIQz92dMgBYkeWi+Wb1a2SZz0TbDnoo4bBhQ+x3n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftvChQR/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftvChQR/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752619097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWauv4FuNsiIruk4vJlAJ3hxfktkhyn2XBOo/YagwlQ=;
	b=ftvChQR/oI8AK3CGhtPd9P/2/V4ukwKF1jpauJ7ZA40u0gUGv4z6FqVTtZZP0476YFDPQZ
	pgX8r3fa8k/6D1nJqK+j67ZVtq9LJbxoJUhkzA0O5tNXs2HbnnDQj018Q7q9meNcZKRTeV
	qxWhiHVe94TXcbtyY7EGGXd9oEYlPbY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-68-4DzBAuIhPbqeWUggQAPjSw-1; Tue,
 15 Jul 2025 18:38:14 -0400
X-MC-Unique: 4DzBAuIhPbqeWUggQAPjSw-1
X-Mimecast-MFC-AGG-ID: 4DzBAuIhPbqeWUggQAPjSw_1752619093
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CB2391956096;
	Tue, 15 Jul 2025 22:38:12 +0000 (UTC)
Received: from fedora (unknown [10.72.116.8])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91D07180045B;
	Tue, 15 Jul 2025 22:38:09 +0000 (UTC)
Date: Wed, 16 Jul 2025 06:38:04 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove unused req argument from ublk_sub_req_ref()
Message-ID: <aHbYTI2g7RTmqBSO@fedora>
References: <20250715154244.1626810-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715154244.1626810-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, Jul 15, 2025 at 09:42:43AM -0600, Caleb Sander Mateos wrote:
> Since commit b749965edda8 ("ublk: remove ublk_commit_and_fetch()"),
> ublk_sub_req_ref() no longer uses its struct request *req argument.
> So drop the argument from ublk_sub_req_ref(), and from
> ublk_need_complete_req(), which only passes it to ublk_sub_req_ref().
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks, 
Ming

