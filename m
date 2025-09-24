Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813342E62C6
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758714438; cv=none; b=p1jS3AvJFLcZUTUg5NPRpmhYCa5NYmgWbdgApBzyhao4NFsW4pVFaiiH/cN1HDTios1vSQ6dSSHwu4z08iYwAMtEXxtOSeCTrDMOYm3QzEPaWydbopi+ced/6f2/iCbeH39FLxoSabhKi3ZXqYr3ClHa3LfFH/QgnM6ivOWLyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758714438; c=relaxed/simple;
	bh=CpcTn/LkkmKOCPxdKBtvW/X03DJ7EbwCgKqtNEMFm9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UibPYRmCqBGCOJaOr5GrCXsX3FO5q2fDv1kIPZQlpbsfaKOJkidbyyIiISYWNDMF+3Zt8w+uV7qqL6h59613mLagCTQucwfz5rW2CtuZbFIwSMWM2auR1xGJEsTaiALhuPKs6oOGOAijO9eXtpYpY1AdxBnKjp8nvlDfRHm+Od0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e+6ipAwb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e+6ipAwb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758714432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U49N+r+zxSJi1zFY3gjdcUdjVBkpVbT2zJacgwMW37A=;
	b=e+6ipAwbXevl1R7CFvAlQ9I2t9yE7rvh7I/Z7Ya+z5wUMAXzc9vl/8LLE1pzeyHdZBUfZ7
	cbPLL0AjwXZH+bCZzlNohgFFKy5SAqCoa+Td3iYaQI2OhTp3bGHh9PcQiy2QJImLfK2R2g
	0uU96fWn/UTSb5Dfl4bnhbcZ2BBfKA8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-ZHnt4TrjPOS_6u8ZCD-IDA-1; Wed,
 24 Sep 2025 07:47:09 -0400
X-MC-Unique: ZHnt4TrjPOS_6u8ZCD-IDA-1
X-Mimecast-MFC-AGG-ID: ZHnt4TrjPOS_6u8ZCD-IDA_1758714428
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C06AA1955D58;
	Wed, 24 Sep 2025 11:47:07 +0000 (UTC)
Received: from fedora (unknown [10.72.120.20])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4512819560B8;
	Wed, 24 Sep 2025 11:47:02 +0000 (UTC)
Date: Wed, 24 Sep 2025 19:46:57 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: remove redundant zone op check in ublk_setup_iod()
Message-ID: <aNPaMVxUR-Q4haGX@fedora>
References: <20250923155249.2891305-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923155249.2891305-1-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Tue, Sep 23, 2025 at 09:52:48AM -0600, Caleb Sander Mateos wrote:
> ublk_setup_iod() checks first whether the request is a zoned operation
> issued to a device without zoned support and returns BLK_STS_IOERR if
> so. However, such a request would already hit the default case in the
> subsequent switch statement and fail the ublk_queue_is_zoned() check,
> which also results in a return of BLK_STS_IOERR. So remove the redundant
> early check for unsupported zone ops.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

