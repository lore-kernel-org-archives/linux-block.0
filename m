Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168D31815D
	for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769351163; cv=none; b=bm/1ji7A26LB6dptMmBmYeNcL6dpc/7VdFdz2PwwUeAT6hw3WonXdTgc3/8wUz+Ou7B5WsKkArSiRnlCYtMZXP86kXfA8GgcSaVmNhSh3XHoxzkXNcPAv7PjO92IIeLhQmQBPUIZK95dJnnpfrTItObaAyh0QhVNz+F9WqfPNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769351163; c=relaxed/simple;
	bh=JzxMMuwZjGS4yWvf7Yb7zEMJyauI7cBHGYR3tx83SSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aW7RchLjqotzv2nrhDoATstMTN06AtcxGx6zlYkIriKSWU4FJkH55y01Wdn/wd1CzGgsPwrwSG8bB6zp1b1S7jNymAYwkC1p9VPdfzXsNzH4Mk02IlRXgzdO7uVpUIgOBeXli7FkaeyD2zTrTUzXSxlQrK1kTENde2l9NiHCsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBtf9RhC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBtf9RhC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769351161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DwYLs07QAVxXf9Pa8PnBOgcRVeKGE+NJdcnmkfRwBwc=;
	b=PBtf9RhCYIDMGGhS2Duplsy+2EstUJ6wKG1/srRPr/S+JG87c9kfm7x/QljGfAJRS3Dehp
	bimBkzJIam/0VoV8lE/tj8djS7d5KwbdQiE2KDV1LoKeqC91pLFth0+XN9qpMhedalFba0
	MMFjxGU//pxp3i6TC8Tf/xobZdRyoQg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-7KEnwvP9PiejeIbQAIKOwg-1; Sun,
 25 Jan 2026 09:25:59 -0500
X-MC-Unique: 7KEnwvP9PiejeIbQAIKOwg-1
X-Mimecast-MFC-AGG-ID: 7KEnwvP9PiejeIbQAIKOwg_1769351158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01D29195608F;
	Sun, 25 Jan 2026 14:25:58 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 222A91955F66;
	Sun, 25 Jan 2026 14:25:52 +0000 (UTC)
Date: Sun, 25 Jan 2026 22:25:47 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: ublk: add missing gitignore for
 metadata_size binary
Message-ID: <aXYn66eXcs-I1Bin@fedora>
References: <20260125085747.1631424-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125085747.1631424-1-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Sun, Jan 25, 2026 at 08:57:46AM +0000, Alexander Atanasov wrote:
> A new utility metadata_size was added in
> commit 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
> but it was not added to .gitignore. Fix that by adding it there.
> 
> While at it sort all entries alphabetically and add a SPDX license header.
> 
> Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
> Fixes: 261b67f4e347 ("selftests: ublk: add utility to get block device metadata size")
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/.gitignore | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> v1->v2:
>  - add SPDX license header
>  - sort alphabetically as suggested by Caleb Sander Mateos
> 
> It is also Reviewed-by: Ming Lei <ming.lei@redhat.com> but it needs an Ack from him,
> as he is the original author of the file, for the license header.
> 
> 
> diff --git a/tools/testing/selftests/ublk/.gitignore b/tools/testing/selftests/ublk/.gitignore
> index 8b2871ea7751..e17bd28f27e0 100644
> --- a/tools/testing/selftests/ublk/.gitignore
> +++ b/tools/testing/selftests/ublk/.gitignore
> @@ -1,3 +1,5 @@
> -kublk
> -/tools
> +# SPDX-License-Identifier: GPL-2.0
>  *-verify.state
> +/tools
> +kublk
> +metadata_size

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

