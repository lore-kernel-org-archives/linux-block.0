Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CB011185
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452578; cv=none; b=PvPCAAI9KwRQ0EAx0oDTbHpdI35GZgGeUcD1KwdkFEu9ttV8jQ0Odma+lQBBlGcMDlp5F+kRbfGunZcDGVVkBEGxyLPd+Sqc5oVqru3JxiJPZqlqVR5oolnMtWt0/otlxzC0bwnHgahhkKm7NTE8H+TAbGe0vUZ3f5MLb7J021w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452578; c=relaxed/simple;
	bh=p9d8s+VXQT5tyf7SYHf1N5KsIokJGrAlS05nv1Nt8dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkMF0Nd96iki54G4m73YEv4k4HAc3XoLl2R3UL9dDiEHJNMjE9cZMrmNEnLFP9TzlfWlS8jvo9BXMw5ovOcB+yZC7BXrORpPmycKpkYAE8hitObVbGL0JZ3GQZNa1l437b/PIkE6ldh0d1RFmQpLxqLae0hnI8Q/Anstqm2w+a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PEYqpGIw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEYqpGIw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749452575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CxWfSrLq3h1e2EySudPhaiwzv5xcxAVTtPeAS1idXXk=;
	b=PEYqpGIwirIgrtt9/AKfizMn68TZU0GlvlEM7IoqNhURmSjljGrGrhkGHvGT0nw+qFxwKt
	lbqP2JM8isPiTWmj5buvUZVaqgTnudFRdfbWikk14EDOMPUtM/KFv+T/NEbXAvTTLx6Lpk
	WzRU2U5I9Cctaa3nmf/h4g/4FT+8bwQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-BdO20ROSP72o0CWAau5xDQ-1; Mon,
 09 Jun 2025 03:02:49 -0400
X-MC-Unique: BdO20ROSP72o0CWAau5xDQ-1
X-Mimecast-MFC-AGG-ID: BdO20ROSP72o0CWAau5xDQ_1749452568
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EF18180028E;
	Mon,  9 Jun 2025 07:02:47 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 827FF1956087;
	Mon,  9 Jun 2025 07:02:44 +0000 (UTC)
Date: Mon, 9 Jun 2025 15:02:39 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/8] ublk: remove task variable from __ublk_ch_uring_cmd()
Message-ID: <aEaHD6BjnNdGj6pq@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-4-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-4-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 06, 2025 at 03:40:06PM -0600, Caleb Sander Mateos wrote:
> The variable is computed from a simple expression and used once, so just
> replace it with the expression.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks,
Ming

