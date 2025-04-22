Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC68254AED
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745288202; cv=none; b=quIb8as6jw8ngJKLTbBNMlQEgXHSz+Qpg7A4bhiqzp3rrACQNOAuThCESosN5yXa3b70JJpQ1PwOIE4jabL3p86IeLRRZ3ozpDfkb4sRsHWupX4U8vfMu6bDV2m3Y1rh6T5tcS6ifOZiMMviwrV9pNpAGIO8vQLY6sLIVoY3Wxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745288202; c=relaxed/simple;
	bh=m4SH1HDvHugwMTrd3sTk2tokzTcOFXyDZ2ZZ77+0jfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdDnx5eWAz34DZmwYz44hPB+o9RwSbxeOweG/uINzVM2iBBq/fwpXyqQUwmvtBPfjcHEnjy1blx49Dv41leZxV5Etbn0iFk9DOKsYqkr1pZwBdQwsLrNb5RMEY3GOLIRS+htMNM3zXP+XlCRjxzJSdUsQ4Lu9lqF/czv0oG55D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAaKazv9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAaKazv9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745288199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7gdgW5eS93if/nqlNpCjp3rr+e7Hdfk5SuDUBkR/RYQ=;
	b=cAaKazv9/BOSBZAeDnUG0XUXdJ7lJIUueVKUMPFbNnyLdXE9XPUkFXTU6P77A7C0uMDHO6
	18JW34nHAp//gqvgrRerN7Jmlazn7SmpD7UsVYljx8oaajRj4LGh3MRgVsiORmDImnToAc
	M2PXwLLuWLoBjvWvLSNbfxZ3sgBP1kA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-sTJXc5RTNJG1oQ1umttCFg-1; Mon,
 21 Apr 2025 22:16:35 -0400
X-MC-Unique: sTJXc5RTNJG1oQ1umttCFg-1
X-Mimecast-MFC-AGG-ID: sTJXc5RTNJG1oQ1umttCFg_1745288194
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 114141800264;
	Tue, 22 Apr 2025 02:16:34 +0000 (UTC)
Received: from fedora (unknown [10.72.116.137])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 47F4D195608F;
	Tue, 22 Apr 2025 02:16:29 +0000 (UTC)
Date: Tue, 22 Apr 2025 10:16:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH 1/4] ublk: factor out ublk_commit_and_fetch
Message-ID: <aAb7-Wjj6xgymVve@fedora>
References: <20250421-ublk_constify-v1-0-3371f9e9f73c@purestorage.com>
 <20250421-ublk_constify-v1-1-3371f9e9f73c@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421-ublk_constify-v1-1-3371f9e9f73c@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Apr 21, 2025 at 05:46:40PM -0600, Uday Shankar wrote:
> Move the logic for the UBLK_IO_COMMIT_AND_FETCH_REQ opcode into its own
> function. This also allows us to mark ublk_queue pointers as const for
> that operation, which can help prevent data races since we may allow
> concurrent operation on one ublk_queue in the future. Also open code
> ublk_commit_completion in ublk_commit_and_fetch to reduce the number of
> parameters/avoid a redundant lookup.
> 
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

