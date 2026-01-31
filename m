Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297171624D5
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 02:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827454; cv=none; b=pkzQxbT7POvQG4jc5b+2J8IX/R9jATmu/I2y2856gdxltG2AEUduYOdadsi8ZyeyXcjg+DWaUW+O2can7A5msscpDFxarEsFXKOGP0evg0NDHhOlHcTw/KLcUGvs3AVrdqLf28yKfrbs5KrLKBz7VRMZGkwaEIBSVBWafCE9TcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827454; c=relaxed/simple;
	bh=KPSGOaZo8+1urCucU0Pbeo5EDp/kEcFVYTowjZWae1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeGzTWpiSyWFuvPnM4px1VMxjlPZm8pYoXomOAuy5ZaU/TI1h6xk/xQ+puQqLIiiibcnf230uORQN7GFC5Oh52l9EYP5f95aI3xryv5Ux633tXM0ZLMln0SWcQbapC34cyrxDc9Hvk1Y+4+W4+lnfw2CWvgOzl2fbBEM7Z9DvB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1b3YeL6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1b3YeL6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769827452;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ3lefmtEesvzm96GY6JmNHPC/oMz7yIlbk/rOcdXfM=;
	b=E1b3YeL6wey7PnMeBWBKS6PpwHxnkIREMG9Qxsnk75Au3SA7xUFm1UEY6BlJ57n4TmXfya
	C9YWy+71og8LbnxHaxaEfh9CtYlfGanXdpDmUIe53od64ABjCP4Etjs1gynvONz7Nrm9nP
	niT+FDrefoA+ZXmb+AmEbhNlZ15Rpag=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-yIYm1dsCPGKnjBaP6ytx_A-1; Fri,
 30 Jan 2026 21:44:09 -0500
X-MC-Unique: yIYm1dsCPGKnjBaP6ytx_A-1
X-Mimecast-MFC-AGG-ID: yIYm1dsCPGKnjBaP6ytx_A_1769827448
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7CBBC1956080;
	Sat, 31 Jan 2026 02:44:08 +0000 (UTC)
Received: from fedora (unknown [10.72.116.21])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC4DE1956056;
	Sat, 31 Jan 2026 02:44:04 +0000 (UTC)
Date: Sat, 31 Jan 2026 10:43:58 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Alexander Atanasov <alex@zazolabs.com>
Subject: Re: [PATCH V2 9/9] selftests: ublk: move test temp files into a sub
 directory
Message-ID: <aX1sbrLk-Vv-7rSh@fedora>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
 <20260129162001.3532311-10-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129162001.3532311-10-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Alexander,

On Fri, Jan 30, 2026 at 12:19:58AM +0800, Ming Lei wrote:
> From: Alexander Atanasov <alex@zazolabs.com>
> 
> Create and use a temporary directory for the files created during
> test runs. If TMPDIR environment variable is set use it as a base
> for the temporary directory path.
> TMPDIR=/mnt/scratch make run_tests
> and
> TMPDIR=/mnt/scratch ./test_generic_01.sh
> will place test directory under /mnt/scratch
> 
> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
> ---
>  tools/testing/selftests/ublk/test_common.sh | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
> index dd4eff97610a..21ba51fcc7d7 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -48,7 +48,7 @@ _create_backfile() {
>  	old_file="${UBLK_BACKFILES[$index]}"
>  	[ -f "$old_file" ] && rm -f "$old_file"
>  
> -	new_file=$(mktemp ublk_file_"${new_size}"_XXXXX)
> +	new_file=$(mktemp ${UBLK_TEST_DIR}/ublk_file_"${new_size}"_XXXXX)
>  	truncate -s "${new_size}" "${new_file}"
>  	UBLK_BACKFILES["$index"]="$new_file"
>  }
> @@ -65,7 +65,7 @@ _remove_files() {
>  _create_tmp_dir() {
>  	local my_file;
>  
> -	my_file=$(mktemp -d ublk_dir_XXXXX)
> +	my_file=$(mktemp -d ${UBLK_TEST_DIR}/ublk_dir_XXXXX)
>  	echo "$my_file"
>  }
>  
> @@ -124,7 +124,9 @@ _prep_test() {
>  	local type=$1
>  	shift 1
>  	modprobe ublk_drv > /dev/null 2>&1
> -	UBLK_TMP=$(mktemp ublk_test_XXXXX)
> +	TDIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
> +	export UBLK_TEST_DIR=${TDIR}
> +	UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
>  	[ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
>  	echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
>  }
> @@ -171,6 +173,7 @@ _cleanup_test() {
>  	"${UBLK_PROG}" del -a
>  
>  	_remove_files
> +	rmdir ${UBLK_TEST_DIR}
>  	echo "ublk selftest: $TID done at $(date '+%F %T')" | tee /dev/kmsg
>  }
>  
> @@ -405,6 +408,8 @@ UBLK_PROG=$(_ublk_test_top_dir)/kublk
>  UBLK_TEST_QUIET=1
>  UBLK_TEST_SHOW_RESULT=1
>  UBLK_BACKFILES=()
> +UBLK_TEST_DIR=${TMPDIR:-.}
>  export UBLK_PROG
>  export UBLK_TEST_QUIET
>  export UBLK_TEST_SHOW_RESULT
> +export UBLK_TEST_DIR

I feel this patch can be simplified in the following way, what do you think
of the change?

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index 21ba51fcc7d7..1ee7a898e6bf 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -48,7 +48,7 @@ _create_backfile() {
        old_file="${UBLK_BACKFILES[$index]}"
        [ -f "$old_file" ] && rm -f "$old_file"
 
-       new_file=$(mktemp ${UBLK_TEST_DIR}/ublk_file_"${new_size}"_XXXXX)
+       new_file=$(mktemp ${TDIR}/ublk_file_"${new_size}"_XXXXX)
        truncate -s "${new_size}" "${new_file}"
        UBLK_BACKFILES["$index"]="$new_file"
 }
@@ -65,7 +65,7 @@ _remove_files() {
 _create_tmp_dir() {
        local my_file;
 
-       my_file=$(mktemp -d ${UBLK_TEST_DIR}/ublk_dir_XXXXX)
+       my_file=$(mktemp -d ${TDIR}/ublk_dir_XXXXX)
        echo "$my_file"
 }
 
@@ -125,8 +125,7 @@ _prep_test() {
        shift 1
        modprobe ublk_drv > /dev/null 2>&1
        TDIR=$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
-       export UBLK_TEST_DIR=${TDIR}
-       UBLK_TMP=$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
+       UBLK_TMP=$(mktemp ${TDIR}/ublk_test_XXXXX)
        [ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
        echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee /dev/kmsg
 }
@@ -173,7 +172,7 @@ _cleanup_test() {
        "${UBLK_PROG}" del -a
 
        _remove_files
-       rmdir ${UBLK_TEST_DIR}
+       rmdir ${TDIR}
        echo "ublk selftest: $TID done at $(date '+%F %T')" | tee /dev/kmsg
 }
 
@@ -408,8 +407,6 @@ UBLK_PROG=$(_ublk_test_top_dir)/kublk
 UBLK_TEST_QUIET=1
 UBLK_TEST_SHOW_RESULT=1
 UBLK_BACKFILES=()
-UBLK_TEST_DIR=${TMPDIR:-.}
 export UBLK_PROG
 export UBLK_TEST_QUIET
 export UBLK_TEST_SHOW_RESULT
-export UBLK_TEST_DIR




Thanks,
Ming

