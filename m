Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782B833987D
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435362; cv=none; b=QB40JAcavbjaPdeAcTGuxqsEucrxfOE0ZruGuluzQxrbAqk467ply8ZU8RMTF1v4K6Q3jc3+HY1Ao3hBnQgr4+MLeCaKRTkky2ILoWmSeEtOjQOCM7EX5zxwyfoWAHOoMU+FTVtYwx6pLKSKhDMDGla8Bu24ZOaU8Xi3+QgRhTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435362; c=relaxed/simple;
	bh=BF8dOLWxJGuUF7dclkYRviGBiNWDYMT7uI8kuXn8zac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4Yz8w4S+Bpgq/PuraXSlSEwcJ0lzsmuuSxE8EmwSdlZ/Q6ehvYUk1dGs5CdO2vqfynFCM/B4wufE6vRXIT/LcHxAc4PyBsRiXy0tkoBZzQuQEE/P8ZFnXJ1K+8Ac7OJpg9MWdbNOEob0RP++OuEMBpyVCtvkZviFAZesPqhdek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FiNS/K6B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FiNS/K6B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769435360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X7t7ie5pipo7SSO+eULx65tGVU5QHabXsShIrXhp1Co=;
	b=FiNS/K6BmvZa+bOxKXduz//Y8Xyksk/vT0tMOqrSro7dgCj/syuhDdgUFMCMmk/a94Rold
	wS5fHOQVcQdzm3aAA6OChf22xmRsxEvCmaEkNmhmxm+mxCC5PxIc1+JkwOZ2c/zD7w5hjp
	UmuSuHt180uncGDnZNW1y8xkjKFv/h4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-MgOuZya3Npaxdb4uQZcCtg-1; Mon,
 26 Jan 2026 08:49:17 -0500
X-MC-Unique: MgOuZya3Npaxdb4uQZcCtg-1
X-Mimecast-MFC-AGG-ID: MgOuZya3Npaxdb4uQZcCtg_1769435356
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2F8A519775A4;
	Mon, 26 Jan 2026 13:49:16 +0000 (UTC)
Received: from fedora (unknown [10.72.116.122])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B0EC619560B4;
	Mon, 26 Jan 2026 13:49:11 +0000 (UTC)
Date: Mon, 26 Jan 2026 21:49:06 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: mark each test start and end time in
 dmesg
Message-ID: <aXdw0hCiXhxSBPfE@fedora>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

This patch is one nice improvement!

But it can't be applied cleanly on block/for-7.0/block, can you base it
against for-7.0/block branch of block tree?

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.0/block

```
[root@ktest-40 linux]# git am raw.16
Applying: selftests: ublk: mark each test start and end time in dmesg
error: patch failed: tools/testing/selftests/ublk/test_common.sh:122
error: tools/testing/selftests/ublk/test_common.sh: patch does not apply
Patch failed at 0001 selftests: ublk: mark each test start and end time in dmesg
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"
```


Thanks,
Ming

