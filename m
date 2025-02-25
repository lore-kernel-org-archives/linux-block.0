Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B5D263C9E
	for <linux-block@vger.kernel.org>; Tue, 25 Feb 2025 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473541; cv=none; b=rCksVHJAYS88R4PkeH+bqY24LY7E0Cls6bviiz/w5wbY7G7WnIPW+w+1oaXzimCga+tYVVTxd7Vxo1PxVq7Q4fnt6wVx50/uRwN2gxiaim3IdZHomd3jwJVfeBi1lTBDLsvUs91kR0tzEz3CqNMQuCrK9Z9IMl6mr17YUK85//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473541; c=relaxed/simple;
	bh=6AVs8XJ4mc7ZUXZHOTy1gk0PXYPAPQJ8+VMRBLSisyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tr5wrMFHRtEsAneE49p4zQnng21+rj5oPP1Qqzwfjy4Q7KFbmuyyHZRollfOQnwRUnlf2HiY88eGnRcKRGecn5OxwiXzr8/9nwggAvJTSa0RWs4h8b2+5J+Eyryhd5ZBLdw9GgqGJDKvP3+SMDYHtcmfYqxUdP46TPzxK9cy5ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y72encgB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y72encgB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740473538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFoRbSMoXQTA+56zYXSjGU4fdlX3cjng4F4BmGZ4tVU=;
	b=Y72encgBp/QYSnDCydiKvMsAwbUiTt7sRpgQZpjKrv5G+VWIhSOrR1o+/lAim0mviI9YzW
	t8aPodv1I6nhYvhSE5pnhbIQpYwCzmTgF3YjAhM8Liw5XWWVz1zE57IzeWyEbidAC6cKoN
	iS0g0BiNOxtfbby2Mqe8pJC4TokQNOg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-ISLvie4EM0CteLPIqyGCBw-1; Tue,
 25 Feb 2025 03:52:14 -0500
X-MC-Unique: ISLvie4EM0CteLPIqyGCBw-1
X-Mimecast-MFC-AGG-ID: ISLvie4EM0CteLPIqyGCBw_1740473533
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 00DB81979057;
	Tue, 25 Feb 2025 08:52:13 +0000 (UTC)
Received: from fedora (unknown [10.72.120.31])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0FCD19560B9;
	Tue, 25 Feb 2025 08:52:06 +0000 (UTC)
Date: Tue, 25 Feb 2025 16:52:00 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@meta.com>
Cc: asml.silence@gmail.com, axboe@kernel.dk, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, bernd@bsbernd.com,
	csander@purestorage.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 04/11] io_uring/nvme: pass issue_flags to
 io_uring_cmd_import_fixed()
Message-ID: <Z72EsOV5J5sDm8IZ@fedora>
References: <20250224213116.3509093-1-kbusch@meta.com>
 <20250224213116.3509093-5-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224213116.3509093-5-kbusch@meta.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Feb 24, 2025 at 01:31:09PM -0800, Keith Busch wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> io_uring_cmd_import_fixed() will need to know the io_uring execution
> state in following commits, for now just pass issue_flags into it
> without actually using.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

