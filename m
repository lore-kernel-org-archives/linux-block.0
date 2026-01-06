Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908127E05A
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767708636; cv=none; b=N1WDmh0Epu5AHZM17KgT970/CFHHr9OuqNvqQoH+lzOTY07lFQHP2hhN09UYnnp8LDoMnU4R8CiBrpB7rjvj8A5jloqORCnna0Awp34lF4BUSu77js2uaaA3CXqlqbUnYKZwnbdCIkxRQE4RiJNX8vUc1Dn2Jbf38TsB62KEuGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767708636; c=relaxed/simple;
	bh=515A1Ze/d8n3Ha+aRtuXZTlbFyrHeWURMG0vanVFztM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avVFWzGQM55F8/txg+g/WLfgVvQAxGSL0yyl/dh0mnOiYtHwgmBqsLa2tgaqv02I2cpvGlSc5+CkPT2jOo3o4FNQs3z0yS8D9wbMlun/XA6u5GcPUSaBLN+BDI4wvk2jAmCgV02vf+0QJGCDPWnBi3aXOND8mHYNlz2YKl8X8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UpFIiCXu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UpFIiCXu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767708633;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1g+ZO/94q1ivwdez+O4FZrlvIVly9LXqKXHuSbHbO44=;
	b=UpFIiCXuLjfbCOB9Dvmasvf9pfZYQTL/tiCoWfkftAHFSkyp+uGfdGT5D5slbcm9952MmF
	+elj9AonArvBvMoHhszw28tAw0M5RRRklI8DGSkFsQH1E4xWk0Eh4IJDmP/HjmieXimuwf
	3rV4OVnOD3bIuUbJ1CHDRxyAGqWZkSo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-5ThPj8GQMmGWrLNkwpFDlg-1; Tue,
 06 Jan 2026 09:10:28 -0500
X-MC-Unique: 5ThPj8GQMmGWrLNkwpFDlg-1
X-Mimecast-MFC-AGG-ID: 5ThPj8GQMmGWrLNkwpFDlg_1767708626
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6FAC5195608D;
	Tue,  6 Jan 2026 14:10:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.130])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11D0B19560AB;
	Tue,  6 Jan 2026 14:10:20 +0000 (UTC)
Date: Tue, 6 Jan 2026 22:10:15 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v3 19/19] selftests: ublk: add end-to-end integrity test
Message-ID: <aV0Xx2vWmL5Iuls4@fedora>
References: <20260106005752.3784925-1-csander@purestorage.com>
 <20260106005752.3784925-20-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106005752.3784925-20-csander@purestorage.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, Jan 05, 2026 at 05:57:51PM -0700, Caleb Sander Mateos wrote:
> Add test case loop_08 to verify the ublk integrity data flow. It uses
> the kublk loop target to create a ublk device with integrity on top of
> backing data and integrity files. It then writes to the whole device
> with fio configured to generate integrity data. Then it reads back the
> whole device with fio configured to verify the integrity data.
> It also verifies that injected guard, reftag, and apptag corruptions are
> correctly detected.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  tools/testing/selftests/ublk/Makefile        |   1 +
>  tools/testing/selftests/ublk/test_loop_08.sh | 111 +++++++++++++++++++
>  2 files changed, 112 insertions(+)
>  create mode 100755 tools/testing/selftests/ublk/test_loop_08.sh
> 
> diff --git a/tools/testing/selftests/ublk/Makefile b/tools/testing/selftests/ublk/Makefile
> index bfd68ae64142..ab745443fd58 100644
> --- a/tools/testing/selftests/ublk/Makefile
> +++ b/tools/testing/selftests/ublk/Makefile
> @@ -33,10 +33,11 @@ TEST_PROGS += test_loop_02.sh
>  TEST_PROGS += test_loop_03.sh
>  TEST_PROGS += test_loop_04.sh
>  TEST_PROGS += test_loop_05.sh
>  TEST_PROGS += test_loop_06.sh
>  TEST_PROGS += test_loop_07.sh
> +TEST_PROGS += test_loop_08.sh
>  TEST_PROGS += test_stripe_01.sh
>  TEST_PROGS += test_stripe_02.sh
>  TEST_PROGS += test_stripe_03.sh
>  TEST_PROGS += test_stripe_04.sh
>  TEST_PROGS += test_stripe_05.sh
> diff --git a/tools/testing/selftests/ublk/test_loop_08.sh b/tools/testing/selftests/ublk/test_loop_08.sh
> new file mode 100755
> index 000000000000..ca289cfb2ad4
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_loop_08.sh
> @@ -0,0 +1,111 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +if ! _have_program fio; then
> +	exit $UBLK_SKIP_CODE
> +fi
> +
> +fio_version=$(fio --version)
> +if [[ "$fio_version" =~ fio-[0-9]+\.[0-9]+$ ]]; then
> +	echo "Requires development fio version with https://github.com/axboe/fio/pull/1992"
> +	exit $UBLK_SKIP_CODE
> +fi
> +
> +TID=loop_08
> +
> +_prep_test "loop" "end-to-end integrity"
> +
> +_create_backfile 0 256M
> +_create_backfile 1 32M # 256M * (64 integrity bytes / 512 data bytes)
> +integrity_params="--integrity_capable --integrity_reftag
> +                  --metadata_size 64 --pi_offset 56 --csum_type t10dif"
> +dev_id=$(_add_ublk_dev -t loop -u $integrity_params "${UBLK_BACKFILES[@]}")

I tried above setting:

./kublk add -t loop --integrity_capable --integrity_reftag --metadata_size 64 --pi_offset 56 --csum_type t10dif --foreground -u /dev/sdb /dev/sdc
dev id 1: nr_hw_queues 2 queue_depth 128 block size 512 dev_capacity 8388608
	max rq size 1048576 daemon pid 38295 flags 0x160c2 state LIVE
	queue 0: affinity(0 )
	queue 1: affinity(8 )

However, IO error is always triggered:

[ 9202.316382] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.317171] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.319478] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.319983] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.326332] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.326974] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.327570] ldm_validate_partition_table(): Disk read failed.
[ 9202.336539] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.337228] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.339247] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.339779] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.344306] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.344948] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.347067] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.347558] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.348100] Dev ublkb1: unable to read RDB block 0
[ 9202.350159] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.350642] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.354977] ublkb1: ref tag error at location 0 (rcvd 128)
[ 9202.355539] Buffer I/O error on dev ublkb1, logical block 0, async page read
[ 9202.356280]  ublkb1: unable to read partition table



Thanks,
Ming

