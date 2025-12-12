Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4028724D
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765538179; cv=none; b=RwxExqD4p2klbx9DvOMVb9P391bZJUY+Auh0/WjDkVVkIg/aKGPIxPyZ2KZ+uWns8MeM2+akCyNi5IgkGpxuGImv1mA7ScyZKao3G9UuNVV1TT43UqEgvyJqTS71pm7ObLCTZsPh/hn061nRmH3XrYi9jhlVkaH9Aw9KvGGV5hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765538179; c=relaxed/simple;
	bh=iTFxxzCgzgLCCa41qEKV28ldYeSNvS7CyEcsSgsivBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wue07YPslnH6+26y460fCTT91HTKbP7+rPORJ5A0nGBPnCRAnQ3vf5l0fx17gVOgJO9LpKUjbvf+RWJVkogw7JXvUdUcPR1KLC8MBYQB0X2iBj78jfBYfMQqbHiTMAfk1BnMacUsl6A+uMERKmyDzuuqpdbdp/WEbPJxqYw01QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UHvRM1m3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHvRM1m3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765538175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LP/mjTYTKiCiU5cIiY2LJTGJw6nKbULNhGHyX+Hblf0=;
	b=UHvRM1m38dAPMUDF+v3+cFdSbz9pJyQ6EsWGVgHI89jB+OTKDIFKHgBBL2cP1ugw/CI7kX
	24ecJvXQIIkiuHBQFYDPm/Z5sUhS4lpzexY6uXMKLwawTvzbj+2vwM0F9u7eNsWXlfCe9r
	5ZL/MYrixH4dtJoGEOPOJ5GZ7hSVy+0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-SbVy66R7MvWLg0u7XiC-ow-1; Fri,
 12 Dec 2025 06:16:12 -0500
X-MC-Unique: SbVy66R7MvWLg0u7XiC-ow-1
X-Mimecast-MFC-AGG-ID: SbVy66R7MvWLg0u7XiC-ow_1765538171
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95A90195605B;
	Fri, 12 Dec 2025 11:16:11 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B61219560B4;
	Fri, 12 Dec 2025 11:16:07 +0000 (UTC)
Date: Fri, 12 Dec 2025 19:16:03 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] selftests: ublk: add support for user copy to
 kublk
Message-ID: <aTv5cz_B1IdLpI78@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-8-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-8-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Dec 11, 2025 at 10:16:57PM -0700, Caleb Sander Mateos wrote:
> The ublk selftests mock ublk server kublk supports every data copy mode
> except user copy. Add support for user copy to kublk, enabled via the
> --user_copy (-u) command line argument. On writes, issue pread() calls
> to copy the write data into the ublk_io's buffer before dispatching the
> write to the target implementation. On reads, issue pwrite() calls to
> copy read data from the ublk_io's buffer before committing the request.
> Copy in 2 KB chunks to provide some coverage of the offseting logic.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

