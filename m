Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F773195F0
	for <linux-block@vger.kernel.org>; Fri, 12 Dec 2025 10:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537018; cv=none; b=ueuGcW9OLHPH3NvGbeDHhuvV2x/9toaqCjG/2TAxhQCWSP0stDTpI6Urr6hchLc6OFLuFvp97fwNr/ZTjwApBwaSNZkpVP7JJhmc3MT/XE1QiChx6kPtdQTz+VVRcENIzfcscUqObd3CI/NpkdYIjwx5y/5AsMoDYf1CGy9gMgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537018; c=relaxed/simple;
	bh=ibQJsHwkc+7Pma/2fkkv0U4dadiyxgGSoLTWPaqXEkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VrmtfKTEAOJbv+Xbfp7QvUIHHv/rr4t8t0G8EudTddr64N44ypdE5f1kB6U415l6Iw3mcUG0JNocOTLzSYHTMWjaTOo6jXv/xkRcE0fkx2rmyjIRpl0lIoieYVIifpFNAEFJpjKqCCkdcMu9oDmwHX8FAqZ6ZyIwjqoUntacbeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UO8F+Mhy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UO8F+Mhy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765537014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OERi9wgee/xA9tebuxmJovKCJLd5or7+bUVPWM9Skcw=;
	b=UO8F+Mhy95ab6Ut5n/GTOXJVm5m7l5CQo3UJZNA6DIbHH7jU3bdgeecWXTR5VG3cgMeK0F
	nwwgMVkY11apTK+2QvVD+CLjpKruZbzB9IWkGxIWjA7LHzcSEYAUjPYT7VjJVtLgUldANB
	Khs+fA4kjf2cjQHQc1x2H97qsx00jMo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-debKW8RjMeK9Se_joa4MHw-1; Fri,
 12 Dec 2025 05:56:51 -0500
X-MC-Unique: debKW8RjMeK9Se_joa4MHw-1
X-Mimecast-MFC-AGG-ID: debKW8RjMeK9Se_joa4MHw_1765537010
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E20BC18002C1;
	Fri, 12 Dec 2025 10:56:49 +0000 (UTC)
Received: from fedora (unknown [10.72.116.48])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 95FCB180049F;
	Fri, 12 Dec 2025 10:56:46 +0000 (UTC)
Date: Fri, 12 Dec 2025 18:56:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] selftests: ublk: use auto_zc for PER_IO_DAEMON
 tests in stress_04
Message-ID: <aTv06QEJIYyJKCVQ@fedora>
References: <20251212051658.1618543-1-csander@purestorage.com>
 <20251212051658.1618543-5-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212051658.1618543-5-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Thu, Dec 11, 2025 at 10:16:54PM -0700, Caleb Sander Mateos wrote:
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

The last line needs `-z`, otherwise the following warning is dumped:

```
# selftests: ublk: test_stress_04.sh
# main: auto_zc_fallback is set but neither F_AUTO_BUF_REG nor F_SUPPORT_ZERO_COPY is enabled
# stress_04 : [FAIL]
```


Thanks,
Ming

