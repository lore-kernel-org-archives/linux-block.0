Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F716175D50
	for <linux-block@vger.kernel.org>; Thu, 24 Oct 2024 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751570; cv=none; b=PnLIBKW/xQ6ZmyWcCtydqzJt8vzK5+/AZSas0oRK5Ww5Wtpr8ngTTDB1b4njDLV+jJohGoeri0ZX7dnI0MWdCHWyG+jK8iOZx8zbZvQ6jGewTJK1dgcQFC7AnQhJodMTol0MB8dPChpnujFVp2zht6ZM+yG53VrF7C/Og+ZhErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751570; c=relaxed/simple;
	bh=+UPCXQBkWNTDiXfeMiQlhW8zB4gJG3TTUSrx8pIfxiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2yZ78GzGvjHAKTb+s31E8ZW9NCSNrgzXmlBBAosSwj1rmBdYbpjjFdwvx/p4sViOQ3nEQ6hMxGRI0fkVZumJkSBKZdyvLLXVnLzPmjvE9Dx+AL6FUftUnJUi1PJYOohBK2Nu1QBM/ckPsuz+eEL32zwBkUBHDIGM6GdJY+eJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MJEVfiBj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MJEVfiBj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729751567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YPOQaP9fLsohm+bZdFISaQhDYYb3guJlfd4tvlkGmE=;
	b=MJEVfiBjlBix0hHYGbT6X0n1gEvlUfVLZqEoTf5ZKmQ2lWbhZZabqGw9TtUpFDNeGHxQcM
	Yp5EQN92PjwW6CbULZOa9RM3AjAQBGKYyIs1i6sHi9LvPWG5s29QCGIDKaIOPD5ai/uN1n
	7v9ICgoYaB3Rt3+n1i3BANuJLTwiUWw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-Nb3Pj152Mk6E4qJjtxXwGw-1; Thu,
 24 Oct 2024 02:32:43 -0400
X-MC-Unique: Nb3Pj152Mk6E4qJjtxXwGw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5434B19560AF;
	Thu, 24 Oct 2024 06:32:42 +0000 (UTC)
Received: from fedora (unknown [10.72.116.150])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00012300018D;
	Thu, 24 Oct 2024 06:32:37 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:32:32 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-block@vger.kernel.org
Subject: Re: [PATCH V7 5/7] io_uring: support leased group buffer with
 REQ_F_GROUP_KBUF
Message-ID: <ZxnqAMkrUowONyu7@fedora>
References: <20241012085330.2540955-1-ming.lei@redhat.com>
 <20241012085330.2540955-6-ming.lei@redhat.com>
 <ZxnlmNGYWz+AikvV@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxnlmNGYWz+AikvV@dev-ushankar.dev.purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Thu, Oct 24, 2024 at 12:13:44AM -0600, Uday Shankar wrote:
> On Sat, Oct 12, 2024 at 04:53:25PM +0800, Ming Lei wrote:
> > +int io_import_group_kbuf(struct io_kiocb *req, unsigned long buf_off,
> > +		unsigned int len, int dir, struct iov_iter *iter)
> > +{
> > +	struct io_kiocb *lead = req->grp_link;
> 
> This works since grp_link and grp_leader are in a union together, but
> this should really be req->grp_leader, right?

Yeah, will fix it in V8.

Thanks, 
Ming

