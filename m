Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E851FBBFF
	for <linux-block@vger.kernel.org>; Mon, 13 Jan 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736780711; cv=none; b=eKBODSPzGRon2XXIjazkCY5BXsmxNJsqzjF/0TXH9fZvGU1u8H3MGOL9C3qOmRPXzwQ3abRK/LbawGGY56ypJD3m3xowowLdf02x1LzXZ0fUePPUfyQEXseE4mCTcIe+rZyhLNdP9JG8lC/1CTBpypJxVcNpOfCa9+TGYJJ1dPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736780711; c=relaxed/simple;
	bh=gF7akPQck8VqayQLn+XL9KZU4z03sp0uXtv01Rqya00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+wsyiKyeC0lChCoFAVkeIoYCBEZ7HC5nWPU6zc830shNRnqUi7OeJwcVLGBheCJSzmbS4MKPv0JqFpD7lyGSOW2+nTkOtnImbDAYCBW+Px06FZJnHMNobV2s2UDGqHRhiPwQ99/LG6FrvNOSDBT1PC8fSKEod7uMLmn++DUrdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TDmpsz2a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TDmpsz2a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736780709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D0VIsHVJkTNcm+Rri4tUndPShw+MRzPuSqi6HfumbSs=;
	b=TDmpsz2amtm5ujiTJKlUrptakTF1G+1lzga/RMCbrawZazgwkXAI9pOcpoSeceB/rKrVjG
	Z0dgvBo5b+huKMUUSOfkIMSFAqspOB0OEQbvNH5FX2AoEtzo2S3VZcdToImCfkscxq/+tx
	LOEZlkpaeN1V+cEbqHoNklnjtEqeXeQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-e2lTjiuHN6WOpkmoiNdlvw-1; Mon,
 13 Jan 2025 10:05:05 -0500
X-MC-Unique: e2lTjiuHN6WOpkmoiNdlvw-1
X-Mimecast-MFC-AGG-ID: e2lTjiuHN6WOpkmoiNdlvw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A79611955BD2;
	Mon, 13 Jan 2025 15:05:03 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 791C81956056;
	Mon, 13 Jan 2025 15:04:56 +0000 (UTC)
Date: Mon, 13 Jan 2025 23:04:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.edu.cn>
Subject: Re: [PATCH] loop: move vfs_fsync() out of loop_update_dio()
Message-ID: <Z4Urk9NvFqcVhgoS@fedora>
References: <20250113120644.811886-1-ming.lei@redhat.com>
 <Z4UaKmN551grXYMn@infradead.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UaKmN551grXYMn@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 13, 2025 at 05:50:34AM -0800, Christoph Hellwig wrote:
> NAK for the same reason as v1.  It's not needed because there is no
> deadlock, just a false positive due to missing annotations of lock

Yes, but annotation should be the last straw.

> instances, and we need to fsync with a frozen queue to ensure there
> is no outstanding I/O.

loop_configure() is on unbound loop, so there isn't outstanding I/O.

loop_change_fd() is switching to this new file, so no outstanding I/O
on this new file before unfreeze.

The other two can only switch to buffered IO, which needn't the fsync.

So can you point out anything is wrong?

And this way is sort of simplification.


Thanks,
Ming

