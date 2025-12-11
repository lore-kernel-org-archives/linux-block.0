Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D7725A33F
	for <linux-block@vger.kernel.org>; Thu, 11 Dec 2025 09:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765444005; cv=none; b=pnVqeCRhrLNdErGzByQfOl9y8FSytL86RqE5eUaI0+2HLfA5zXNCLg1H+nAu6c/7XeAizgX+/ElHh92ojqdWT5gHsBiIUa5PDyOU4prMhOcYSEO0fAEtzwKDp3/NkaE9LeqMFOL11Ygi7mBqIUl/8sBx6C4CYGX5X+kPHtEPy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765444005; c=relaxed/simple;
	bh=teAzMo5yQuqSl4hPQUy/EgXCiT7icaIDEZ4Uh5eiJqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEHbcJ2mtwcYit4au37TdHIqrNxC41oXo/iXa6D0LzG8rL33KIRTr6mDDX6PAkbHE64AZNgEDzjBcQFsvstaJ/40cujAYhzgqvQFQ/yJlpAEg2h6Oum0uD6aFXrws5QMRrkT6x2CFW/2qxdhY+eroL4MbGHOgZAoJPgrp7u05P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjM40/Zo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjM40/Zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765444003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jg19wiGYY6vsBkwCpi5AtQH0+YPAc6y1x1cHHwsb4I0=;
	b=MjM40/ZozbdMNy+SRlfhyNXXI9awvOT3CZJwQ2RYv+OQo9kD4CpMwwcl3oW6ceUzGszkOC
	IZtbfSUBSve79GIdI36ls329nAzlU9TQwnqx6K+Q2GptpcRGammWC4jSlJVopBrXPO++iu
	2PZFWOgmJpF3hZtESPVG9ooX2zn2D5A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-83-E2klMEXfNi6AA-nUHbkUWA-1; Thu,
 11 Dec 2025 04:06:39 -0500
X-MC-Unique: E2klMEXfNi6AA-nUHbkUWA-1
X-Mimecast-MFC-AGG-ID: E2klMEXfNi6AA-nUHbkUWA_1765443998
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 223E318002C9;
	Thu, 11 Dec 2025 09:06:38 +0000 (UTC)
Received: from fedora (unknown [10.72.116.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFBB6180044F;
	Thu, 11 Dec 2025 09:06:33 +0000 (UTC)
Date: Thu, 11 Dec 2025 17:06:28 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON tests
 in stress_04
Message-ID: <aTqJlLbAiup38hTI@fedora>
References: <20251211051603.1154841-1-csander@purestorage.com>
 <20251211051603.1154841-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251211051603.1154841-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Wed, Dec 10, 2025 at 10:15:59PM -0700, Caleb Sander Mateos wrote:
> stress_04 is described as "run IO and kill ublk server(zero copy)" but
> the --per_io_tasks tests cases don't use zero copy. Plus, one of the
> test cases is duplicated. Add --auto_zc to these test cases and
> --auto_zc_fallback to one of the duplicated ones. This matches the test
> cases in stress_03.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/test_stress_04.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_stress_04.sh b/tools/testing/selftests/ublk/test_stress_04.sh
> index 3f901db4d09d..965befcee830 100755
> --- a/tools/testing/selftests/ublk/test_stress_04.sh
> +++ b/tools/testing/selftests/ublk/test_stress_04.sh
> @@ -38,14 +38,14 @@ if _have_feature "AUTO_BUF_REG"; then
>  	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --no_ublk_fixed_fd "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
>  	ublk_io_and_kill_daemon 8G -t null -q 4 -z --auto_zc --auto_zc_fallback &
>  fi
>  
>  if _have_feature "PER_IO_DAEMON"; then
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> -	ublk_io_and_kill_daemon 256M -t loop -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> -	ublk_io_and_kill_daemon 256M -t stripe -q 4 --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> -	ublk_io_and_kill_daemon 8G -t null -q 4 --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --nthreads 8 --per_io_tasks &
> +	ublk_io_and_kill_daemon 256M -t loop -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[0]}" &
> +	ublk_io_and_kill_daemon 256M -t stripe -q 4 --auto_zc --nthreads 8 --per_io_tasks "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
> +	ublk_io_and_kill_daemon 8G -t null -q 4 --auto_zc --auto_zc_fallback --nthreads 8 --per_io_tasks &

I'd rather to fix the test description, the original motivation is to cover
more data copy parameters(--z, --auto_zc, plain copy) in same stress test.


Thanks,
Ming

