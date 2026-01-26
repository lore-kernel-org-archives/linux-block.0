Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D7F33B6F5
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436220; cv=none; b=b+YMHbaPjEnwDIgu4MIh/OLM2VzeWKOH3a4+W9vi0UBpDdYsGZvJh3Pm3xrHU0I87EjSF9rGkY/YRXYOhIHGDYwpXD+9qLG1HQnt+yu5v3vHuV0Gv24vKLbU9szqITOA9fbV1cJsZX+tbXBHNZ3tdBdBAmwvIxVhNafoDkbogwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436220; c=relaxed/simple;
	bh=8YC1CtA/xR8I2DaiN++y/fxuhNGdRx4gljMF4wqMGdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1nOav8UvTSvvTjo5MHYVkmeWvplVczN0D5B8mTue0McgGAGsGR326ZB6ntZT5Q3OqouFoKjLDMl3aMokxtwQl+NdBvdHX4u5mo2FS/SzacAWl15ziw7sBgWKjzXf4pt69XtcdQaAHEXaCdGMjfD0Qq27JrVInRxl7CuaNjC+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uuvz3LdS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uuvz3LdS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769436217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BTE8lF8KHMXTDyQ5CHrjUWtCI2HjcBMdXUc40qd2TUw=;
	b=Uuvz3LdS6n4wn7hWE05clu9kBuLi0P2NB8z1FqVcMpY+j6XMH+zZNwi/VjWKz77XMAPVNP
	5XJhiYom7Sm7uJsu4kpdMhu8xKr3KM9BoOl0wCjzhUszZGCsZY/e5THKpySuEAPM94f19k
	746KW0i82kl2peXAtHkX3hCs9ywqp7Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-2vvGAvbAP0u1YUB0l298iA-1; Mon,
 26 Jan 2026 09:03:34 -0500
X-MC-Unique: 2vvGAvbAP0u1YUB0l298iA-1
X-Mimecast-MFC-AGG-ID: 2vvGAvbAP0u1YUB0l298iA_1769436213
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D04019775B0;
	Mon, 26 Jan 2026 14:03:33 +0000 (UTC)
Received: from fedora (unknown [10.72.116.122])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 015FF30001A8;
	Mon, 26 Jan 2026 14:03:29 +0000 (UTC)
Date: Mon, 26 Jan 2026 22:03:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: mark each test start and end time in
 dmesg
Message-ID: <aXd0KdG_k-LDxeDo@fedora>
References: <20260126112544.1811817-2-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126112544.1811817-2-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Mon, Jan 26, 2026 at 11:25:44AM +0000, Alexander Atanasov wrote:
> Log test start and end time in dmesg, so generated log messages
> during the test run can be linked to specific test from the test
> suite.
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/test_common.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index ab1ea5cc904a..5865f1e640ce 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -122,6 +122,7 @@ _prep_test() {
>  	modprobe ublk_drv > /dev/null 2>&1
>  	UBLK_TMP=$(mktemp $TMPDIR/ublk_test_XXXXX)
>  	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
> +	echo "ublk selftest: $TID starting at $(date --iso-8601=sec)" | tee /dev/kmsg
>  }
>  
>  _remove_test_files()
> @@ -166,6 +167,7 @@ _cleanup_test() {
>  	"${UBLK_PROG}" del -a
>  
>  	_remove_files
> +	echo "ublk selftest: $TID done at $(date --iso-8601=sec)" | tee /dev/kmsg
>  }

Also `date "+%F %T"`(which is taken by blktests project) looks more readable, such as:

[root@ktest-40 blktests]# date "+%F %T"
2026-01-26 14:00:51
[root@ktest-40 blktests]# date --iso-8601=sec
2026-01-26T14:01:54+00:00

So would you like to consider it too?



Thanks,
Ming

