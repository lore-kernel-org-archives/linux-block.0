Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200E31A9FA0
	for <linux-block@vger.kernel.org>; Tue, 27 Jan 2026 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769478700; cv=none; b=cwzOM6LaAsG6ZaFwcZXqS+KkmmHdrL5ibnUeIoVlTQge4kG5nOzazzKibSO3ijR78ItQF4b2uFuFXmtSuKCihpAvzGUjrYHYlEyrU5KII/ejFlI8R7kNNzvfhN0r++v2Pg44OffnId0HfqQ6CWeeK/OgR+ykdB9TbPsuZ7Oap1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769478700; c=relaxed/simple;
	bh=eyxTN9IgKIaq9t95i3EEnZbMLuQMbex3eZrZpejXSP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddma3+L6/ZQSDER+AcaOz+T60i0eIfW6fcA/wTeeUpr9DS72kmmv/NvmYJsRuhuLqE+YdykJ1ZOaZ5F80rpLagNqmX32MQWxmImiuKUDbmTE1vhfwB384uZSWLCqsGaKPBAnte+24yiVBzhFCj5UrHlzTU4PE9g0Sxm3sdizVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Thjuy8+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Thjuy8+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769478698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q1yZrGBdqZtV6cDnvCMjWe1ZioMevOKQ+zKOgMVricM=;
	b=Thjuy8+08xZrHNzG7hmHO63Bxlghcy0xREUoLM7y9Kp7RtDqh46Nyrs0cMs/lzJMBB+/rv
	YRFwVKeM0SYR2fh+l9LDk/aIJJX87enwSuL/PVQ+pH/nANJYfICDADz02/h3NM/22IH39p
	YbH2Z3yS9RfV/ItlaAsC8EKg55wkOIQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-HWfFDvdcNT6__wkd3hFlxw-1; Mon,
 26 Jan 2026 20:51:33 -0500
X-MC-Unique: HWfFDvdcNT6__wkd3hFlxw-1
X-Mimecast-MFC-AGG-ID: HWfFDvdcNT6__wkd3hFlxw_1769478692
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A20E1195608F;
	Tue, 27 Jan 2026 01:51:32 +0000 (UTC)
Received: from fedora (unknown [10.72.116.167])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0D2A1956095;
	Tue, 27 Jan 2026 01:51:28 +0000 (UTC)
Date: Tue, 27 Jan 2026 09:51:23 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: ublk: mark each test start and end time in
 dmesg
Message-ID: <aXgaG606iOpF1ODS@fedora>
References: <20260126143158.1830011-1-alex@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126143158.1830011-1-alex@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 26, 2026 at 02:31:57PM +0000, Alexander Atanasov wrote:
> Log test start and end time in dmesg, so generated log messages
> during the test run can be linked to specific test from the test
> suite.
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/test_common.sh | 2 ++
>  1 file changed, 2 insertions(+)
> 
> v1->v2:
>   - rebase to latest block tree
>   - include base-commit 
> 
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index 7ff6ce79d62c..e554e89e6e67 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -121,6 +121,7 @@ _prep_test() {
>  	modprobe ublk_drv > /dev/null 2>&1
>  	UBLK_TMP=$(mktemp ublk_test_XXXXX)
>  	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
> +	echo "ublk selftest: $TID starting at $(date --iso-8601=sec)" | tee /dev/kmsg
>  }
>  
>  _remove_test_files()
> @@ -165,6 +166,7 @@ _cleanup_test() {
>  	"${UBLK_PROG}" del -a
>  
>  	_remove_files
> +	echo "ublk selftest: $TID done at $(date --iso-8601=sec)" | tee /dev/kmsg

As we talked, it could be more readable to follow blktests's date format of
 `date "+%F %T"`, please do it in V3.


Thanks,
Ming

