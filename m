Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2420DD48
	for <linux-block@vger.kernel.org>; Fri,  7 Mar 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340858; cv=none; b=khUdVPFQ8ZpdAMyhA6vt2HxQGb682UykdhUhfIg1L/LxUP/WmT+GJ3CbEvEWFT/xN0V2J3FCLEbBXhKHHq/BKmuoo/Wl6PSIWNAfLU8/fvRWlSm/xs5jkKI0SsmwBFXdShZ0XDEDLKjNFzgK8bfA/Wb6a64SL2uK8mKpik1BRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340858; c=relaxed/simple;
	bh=erMGJmtXEJJrGTZnuRDuDpgv8iwPaiRcLgpLlI9OswI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwxG1hGDtXpNAgUoHKNjhap68jeZXo0wKjnK3Zppp4y66NAHowNenGt3W9XVnkQBKaKbp6WYZCXxkRvfhoKq5iw4blfusNAB9V/GWrNStBmAzDO2aR0+HxbD1srno3bunhGirNEc7AFeTRFhvDvnNhxr0aUeD7uHs92Vc6do0s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XYUNcddC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYUNcddC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741340854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fENBFIri74cayVNvUVVQ3Lg4CNoRB1cMbPLqKDA5HLQ=;
	b=XYUNcddCaMcpQb+XmHx7A19R3JRJMGR/R94SF2Jixj0jw1cWZI5rhEZCrvsHhWWOWkaeZ4
	QJo404uEcbohw7d+im42uikMbXjSN+RmtLfQFqCpiWX1BkEHq+DvBSmWjBZ5bIokk1I8eP
	DVi4od0rck8c9g1brB8zb1g7Vq/k3wA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-100-5LYzeCx7MBujD5y09DpZTQ-1; Fri,
 07 Mar 2025 04:47:28 -0500
X-MC-Unique: 5LYzeCx7MBujD5y09DpZTQ-1
X-Mimecast-MFC-AGG-ID: 5LYzeCx7MBujD5y09DpZTQ_1741340847
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8B4D019560B3;
	Fri,  7 Mar 2025 09:47:26 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DB18F1801747;
	Fri,  7 Mar 2025 09:47:21 +0000 (UTC)
Date: Fri, 7 Mar 2025 17:47:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
	yukuai3@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH RFC 1/2] tests/throtl: add a new test 007
Message-ID: <Z8rAo8aCwi-OWADq@fedora>
References: <20250307080318.3860858-1-yukuai1@huaweicloud.com>
 <20250307080318.3860858-2-yukuai1@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307080318.3860858-2-yukuai1@huaweicloud.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Mar 07, 2025 at 04:03:17PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Add test for IO merge over iops limit.
> 
> Noted this test will fail for now, kernel solution is in development.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  tests/throtl/007     | 65 ++++++++++++++++++++++++++++++++++++++++++++
>  tests/throtl/007.out |  4 +++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/throtl/007
>  create mode 100644 tests/throtl/007.out
> 
> diff --git a/tests/throtl/007 b/tests/throtl/007
> new file mode 100755
> index 0000000..597f879
> --- /dev/null
> +++ b/tests/throtl/007
> @@ -0,0 +1,65 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Yu Kuai
> +#
> +# Test iops limit over io merge
> +
> +. tests/throtl/rc
> +
> +DESCRIPTION="basic functionality"
> +QUICK=1
> +
> +requires() {
> +	_have_program taskset
> +	_have_program fio
> +}
> +
> +# every 16 0.5k IO will merge into one 8k IO, ideally runtime is 1s,
> +# however it's about 1.3s in practice
> +__fio() {
> +	taskset -c 0 \
> +	fio -filename=/dev/$THROTL_DEV \
> +	-name=test \
> +	-size=1600k \
> +	-rw=write \
> +	-bs=512 \
> +	-iodepth=32 \
> +	-iodepth_low=16 \
> +	-iodepth_batch=16 \
> +	-numjobs=1 \
> +	-direct=1 \
> +	-ioengine=io_uring &> /dev/null
> +}
> +
> +test_io() {
> +	start_time=$(date +%s.%N)
> +
> +	{
> +		echo "$BASHPID" > "$CGROUP2_DIR/$THROTL_DIR/cgroup.procs"
> +		__fio
> +	} &
> +
> +	wait $!
> +	end_time=$(date +%s.%N)
> +	elapsed=$(echo "$end_time - $start_time" | bc)
> +	printf "%.0f\n" "$elapsed"
> +}
> +
> +test() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# iolatency is 10ms, iops is at most 200/s
> +	if ! _set_up_throtl irqmode=2 completion_nsec=10000000 hw_queue_depth=2; then
> +		return 1;
> +	fi
> +
> +	test_io
> +
> +	# 300 means 50% error range, no IO should be throttled
> +	_throtl_set_limits wiops=300
> +	test_io
> +	_throtl_remove_limits
> +
> +	_clean_up_throtl
> +	echo "Test complete"
> +}
> diff --git a/tests/throtl/007.out b/tests/throtl/007.out
> new file mode 100644
> index 0000000..0d568ef
> --- /dev/null
> +++ b/tests/throtl/007.out
> @@ -0,0 +1,4 @@
> +Running throtl/007
> +1
> +1
> +Test complete

I'd suggest to check if actual iops matches with the iops limit directly,
and it isn't intuitive to compare time taken in test wrt. iops throttle.

Thanks,
Ming

