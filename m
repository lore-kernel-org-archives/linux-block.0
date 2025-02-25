Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7C25A2DB
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 09:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475630; cv=none; b=WW7dCFp2DBWvxsSGjSgRTC84VWTVCeJV2LPJefh6/xo3/ulivC1e3E3oZD5OJg+sjgL+u5YYvwUe4bu2/KW6tu2svvLStoF5qKf88L8bRb0oukKEbwaexx6Q3AgmWRsdbyohN/cKBzWkXk/HNfFwd58BqV2TzfoZY/UjEP69AUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475630; c=relaxed/simple;
	bh=XN/p3m0lX2csaqrXUMm+P2+iHiKg8TChDcg+BJ9vE6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1bhsGgnqd4uMX5GfKElpp2/DVTvtXLwNAcOg/HTFdHSPbgVMbvk6dxGqfIL/d5nsa19tdQv1c87zPdgeRCqfrQdmuLqCiV+uEWOk53qSeyHwZrXPjzEd6zmP2xxSp2pqCfNlr7J+LsIzQ9n3ywwUl9MSjk06VII5CX6+qUuPPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AzlEoAA4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AzlEoAA4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740475627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RydiVPnRA4hbY63akY5afPHXOwrCNksTaXNBuU/ZtAs=;
	b=AzlEoAA4zFelPS4DjSUyvqdOOKyFIbQnVca8BOlFew4eQ2ggq7hCoJWdqWfEnJuKccUIMu
	kH8QfeClMH0iel8HtWOdlKA1xDQ6TgcvTwjyVjRm90i2ndJVSg87+JCq6zYyO3VxUkqntX
	gXWzAorAAu2rWjdm1jGWe8BBTHlP2bg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-qORxS5UjNJ-m402KgZjOiA-1; Tue,
 25 Feb 2025 04:27:00 -0500
X-MC-Unique: qORxS5UjNJ-m402KgZjOiA-1
X-Mimecast-MFC-AGG-ID: qORxS5UjNJ-m402KgZjOiA_1740475619
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2877B180087C;
	Tue, 25 Feb 2025 09:26:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A1522180087F;
	Tue, 25 Feb 2025 09:26:53 +0000 (UTC)
Date: Tue, 25 Feb 2025 17:26:46 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 06/11] io_uring/rw: move fixed buffer import to issue
 path
Message-ID: <Z72M1pOz43_HYI-6@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-7-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-7-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Mon, Feb 24, 2025 at 01:31:11PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Registered buffers may depend on a linked command, which makes the prep
> path too early to import. Move to the issue path when the node is
> actually needed like all the other users of fixed buffers.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Ming Lei <ming.lei@redhat.com>



Thanks,
Ming

