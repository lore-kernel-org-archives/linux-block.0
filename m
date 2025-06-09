Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3983D11185
	for <linux-block@vger.kernel.org>; Mon,  9 Jun 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749452501; cv=none; b=QaoNuMwyRQpudmjgfdQzuTJovRmbgGJv8VgTQKDV5Z4UZ6P2lUAuKUsvnuMbYxRcFRQ3DCkhY5QTHppwudYmetDWJnW9E6h/YnsTMSyTkGpPuQH11wtckAEyd/Lg9VxVElZNc87Zyf8tSYs7h05PEpbqhg8lFYTyBS0Da46nKhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749452501; c=relaxed/simple;
	bh=24j1izB3G1Vz4OnlgD09xWSrwYWMs2psdazEFrf7e7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rbvx/DD3aqbmXjoT6+kQA0IYVa1QBaahhSt7LEZXNjbeIqYPpQZT0PXEws6cjwSvQH/URBR4Z7/e6sKUSzCH8EQLZa/x1x/Etz8mmz+z7LGbxCGQxptsFD0E5iGmfFIZ2WzZGa/tYsGqhBcd8OHy3/Xv6DKLJl1cGXEnwxYCwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FHuCZCz+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FHuCZCz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749452495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3faoYg91RG4eJNblg1x+pVAqidVJobrRs7saRse3ztU=;
	b=FHuCZCz+KqUylmEdBC9AGEiyr8N0JyBOPMNXiIUuzN0g/q3cdT0+QomZFMEKgj9XD2kF2G
	aiZYsQjALoZ7KQqs8wcPnQPtoqKujBd8LN/ugMgql8QGFPtGA5gthR0KsLLDLxCSeqr0hH
	64uMmLYsZR69PQn0jTLMJ3gr/PBW2h4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-H19SLwScNBCK6SyhQRbr0Q-1; Mon,
 09 Jun 2025 03:01:31 -0400
X-MC-Unique: H19SLwScNBCK6SyhQRbr0Q-1
X-Mimecast-MFC-AGG-ID: H19SLwScNBCK6SyhQRbr0Q_1749452490
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 463B91956089;
	Mon,  9 Jun 2025 07:01:30 +0000 (UTC)
Received: from fedora (unknown [10.72.116.58])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 787C81956087;
	Mon,  9 Jun 2025 07:01:27 +0000 (UTC)
Date: Mon, 9 Jun 2025 15:01:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Uday Shankar <ushankar@purestorage.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/8] ublk: handle UBLK_IO_FETCH_REQ first
Message-ID: <aEaGwp0zYJnIMAFC@fedora>
References: <20250606214011.2576398-1-csander@purestorage.com>
 <20250606214011.2576398-3-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606214011.2576398-3-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Fri, Jun 06, 2025 at 03:40:05PM -0600, Caleb Sander Mateos wrote:
> Check for UBLK_IO_FETCH_REQ first in __ublk_ch_uring_cmd() and return
> early. This allows removing the allowances for NULL io->task and
> UBLK_IO_FLAG_OWNED_BY_SRV unset that only apply to FETCH.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

thanks.
Ming

