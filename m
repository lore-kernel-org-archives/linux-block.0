Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5291CDFD5
	for <linux-block@vger.kernel.org>; Sun, 25 Jan 2026 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769354937; cv=none; b=mzWd5MerM14U+G5Zm1nCRr9vrfrPfAia0n5xw3NIolC81yzO4f7B3UJtuz4CCJf6lE7ykoXOYqExG11OuG6aJ5I6uTh+lEXwxTN9qI03R7kCXVuYwhrq9L4Wsgg+N1QwOMAvPM6lA8wgKmxgL1i92Gg0gBiba/KpGoWhdSlj+sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769354937; c=relaxed/simple;
	bh=6FY1Ub3uSJkRf7Mx9U3HnX00fXeOes1bXeoAZmYZfz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzZNvMmWqilanHgU25M+y8C7SleprlciNxAI1D9iCNdBAdccZED27euzGUyO2wjKVVAfe1qW0a4uvpfNTU9kmFQywJIaOIuqo0tOxNu/HWF/FnmELsLvnxv0ml4XEURDtQaXZrEaCr5H2yJJyN6p2EXCGRaY+25xyj7HEqMrkoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxizvHF5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxizvHF5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769354935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Vl7YCd0Ji3+XuLKgfjcuaMXyBhbOPSxVdzCdbCKe6E=;
	b=ZxizvHF5TDFPxNf1kQgTvMBpnz7P0bxkLHBEeJ2+td2yZjNjaDvA6lgkjV4RPt0t2eeB1K
	EgWP64hjfaurw5rIyU2S8FjrSREub3TcmGEHN7SslHHiOA+CAjNfRJyqgxUBMaHOinjhSO
	es60DLmrPMLKzc7Wr1OBB4EAzucUyRk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-2zYMPMKcNTWNFbfvFPviSA-1; Sun,
 25 Jan 2026 10:28:51 -0500
X-MC-Unique: 2zYMPMKcNTWNFbfvFPviSA-1
X-Mimecast-MFC-AGG-ID: 2zYMPMKcNTWNFbfvFPviSA_1769354930
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0995C1956054;
	Sun, 25 Jan 2026 15:28:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.15])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 797251956095;
	Sun, 25 Jan 2026 15:28:45 +0000 (UTC)
Date: Sun, 25 Jan 2026 23:28:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: io-reorder triggered in
 test_generic_01.sh
Message-ID: <aXY2qdYtfVTSc7jB@fedora>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora>
 <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
 <aXOGrXo3AbXPHA-K@fedora>
 <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Fri, Jan 23, 2026 at 05:00:33PM +0200, Alexander Atanasov wrote:
> 
> 
> > On 23 Jan 2026, at 16:33, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Fri, Jan 23, 2026 at 03:59:31PM +0200, Alexander Atanasov wrote:
> >> On 23 Jan 2026, at 15:33, Ming Lei <ming.lei@redhat.com> wrote:
> >>> 
> >>> On Fri, Jan 23, 2026 at 11:20:36AM +0000, Alexander Atanasov wrote:
> >>>> Create a temp dir for temporary files and use it instead of
> >>>> placing them inside source tree.
> >>> 
> >>> Many temporary files are backing files of file storage target, so far
> >>> the code requires O_DIRECT, or the size could be a bit big.
> >>> 
> >>> In case of ramfs/tmpfs of temp dir, it may cause problem for tests.
> >>> 
> >> 
> >> I am aware of O_DIRECT problem but you can export different TMPDIR that has working O_DIRECT.
> > 
> > Can you share how to export TMPDIR capable of O_DIRECT?
> 
> 
> +export TMPDIR=$(mktemp -d ${TMPDIR:-/tmp}/ublktest-dir.XXXXXX)
> 
> I made the tests to run in own TMPDIR. Which is under already set TMPDIR or
> if TMPDIR is not set it is defaults to  /tmp.
> 
> export TMPDIR=/path/to/odirect/capable
> Before running and tests will run in:
> /path/to/odirect/capable/ublktest-dir.XXXXXX
> 
> 
> > 
> >> 
> >> I use sshfs mount of the build to run the tests and that is a problem sshfs/fuse does not
> >> do O_DIRECT too.
> >> 
> >> I think test_generic_06.sh is the only one that fails due to this(thou I still have to investigate).
> >> 
> >> If O_DIRECT is required by the tests it may be possible to go thru a RAM disk which does support it,
> >> so it works eveerywhere
> >> 
> >> Other option is to preserve working in source tree as it is now, and just add a variable to specify working directory -
> >> UBLK_TMPDIR or something.
> >> 
> >> 
> >> I get a lot of out of order io - between 0 and 10 on average on my test setup:
> >> tools/testing/selftests/ublk/test_generic_01.sh 
> >> Attached 3 probes
> >> io_out_of_order: exp 564688 actual 564648
> >> io_out_of_order: exp 564648 actual 565584
> >> io_out_of_order: exp 565584 actual 564688
> >> io_out_of_order: exp 565592 actual 564688
> >> io_out_of_order: exp 566328 actual 565592
> >> io_out_of_order: exp 882256 actual 882248
> >> io_out_of_order: exp 883032 actual 882912
> >> io_out_of_order: exp 882912 actual 883040
> >> io_out_of_order: exp 883040 actual 883032
> >> 
> >> 
> >> generic_01 : [FAIL]
> >> 
> >> All rq-s are there just reordered , AFAIK blk-mq does not guarantee that requests will be completed in order, what’s the idea to catch this and
> > 
> > If there is just 0 ~ 10, it could be fine. But if all are reorderd,
> > something must be wrong. One improvement could be check if there is too
> > many reorder...
> > 
> > Actually what I am trying to test is to make sure same order is observed
> > from both ublk driver dispatch code path and ublk target io handling code
> > path, because io_uring task work schedule uses llist, which may introduce io
> > reorder.
> 
> There are for sure other places where a reordering can be introduced, so the code should be ready and expecting 
> It. (For my case see bellow) Is preserving the order required for some reason for ublk?
> 
> > 
> > However, that involves ublk kprobe/kfunc trace, which may not be stable,
> > so I simply check the end-to-end IO order. Sometimes blk-mq IO queue/dispatch
> > may re-order IO.
> > 
> > I guess the following change may avoid the re-order, but batch IO case may
> > not be covered:
> > 
> > diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
> > index 21a31cd5491a..5805da4c84c5 100755
> > --- a/tools/testing/selftests/ublk/test_generic_01.sh
> > +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> > @@ -29,14 +29,8 @@ if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
> >        exit "$UBLK_SKIP_CODE"
> > fi
> > 
> > -# run fio over this ublk disk
> > -fio --name=write_seq \
> > -    --filename=/dev/ublkb"${dev_id}" \
> > -    --ioengine=libaio --iodepth=16 \
> > -    --rw=write \
> > -    --size=512M \
> > -    --direct=1 \
> > -    --bs=4k > /dev/null 2>&1
> > +taskset -c 0 dd if=/dev/zero of=/dev/ublkb"${dev_id}" bs=1M count=256 oflag=direct > /dev/null 2>&1
> > +
> > 
> > 
> >> consider it an error? (Latest tree with batch io and batch io fixes on top of if that matters)
> > 
> > Never observe generic_01 failure in my test VM and hardware.
> > 
> > My kernel config is based on Fedora, maybe scheduler config option makes the difference.
> 
> Fedora 43 default config with some debugging options enabled, but no changes in schedulers.
> Test VM storage is on a networked NAS over iSCSI - both boxes VM host and NAS have two NICs,
> I get the errors when I load the network. So I believe the requests really complete out of 
> order due to the network in my case. All tests that have the bpftrace check fail on occasion.

Can you test the following patch and see if re-order still can happen? 


diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 26cf3c7ceeb5..26d5e52ece29 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -13,7 +13,7 @@ if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
-_prep_test "null" "sequential io order"
+_prep_test "null" "ublk dispatch won't reorder IO"
 
 dev_id=$(_add_ublk_dev -t null)
 _check_add_dev $TID $?
@@ -39,9 +39,13 @@ fio --name=write_seq \
 ERR_CODE=$?
 kill "$btrace_pid"
 wait
-if grep -q "io_out_of_order" "$UBLK_TMP"; then
-	cat "$UBLK_TMP"
+
+# Check for out-of-order completions detected by bpftrace
+if grep -q "^out_of_order:" "$UBLK_TMP"; then
+	echo "I/O reordering detected:"
+	grep "^out_of_order:" "$UBLK_TMP"
 	ERR_CODE=255
 fi
+
 _cleanup_test "null"
 _show_result $TID $ERR_CODE
diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
index b2f60a92b118..60ac40e66606 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,23 +2,45 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
+
+	Track request order between block_io_start and block_rq_complete.
+	For each request, record its start sequence number and verify
+	completions happen in the same order.
 */
+
 BEGIN {
-	@last_rw[$1, str($2)] = (uint64)0;
+	@start_seq = (uint64)0;
+	@complete_seq = (uint64)0;
+	@out_of_order = (uint64)0;
+}
+
+tracepoint:block:block_io_start
+{
+	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
+		@start_order[args.sector] = @start_seq;
+		@start_seq = @start_seq + 1;
+	}
 }
+
 tracepoint:block:block_rq_complete
 {
-	$dev = $1;
 	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
-		$last = @last_rw[$dev, str($2)];
-		if ((uint64)args.sector != $last) {
-			printf("io_out_of_order: exp %llu actual %llu\n",
-				args.sector, $last);
+		$expected_order = @start_order[args.sector];
+		if ($expected_order != @complete_seq) {
+			printf("out_of_order: sector %llu started at seq %llu but completed at seq %llu\n",
+				args.sector, $expected_order, @complete_seq);
+			@out_of_order = @out_of_order + 1;
 		}
-		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
+		delete(@start_order[args.sector]);
+		@complete_seq = @complete_seq + 1;
 	}
 }
 
 END {
-	clear(@last_rw);
+	printf("total_start: %llu total_complete: %llu out_of_order: %llu\n",
+		@start_seq, @complete_seq, @out_of_order);
+	clear(@start_order);
+	clear(@start_seq);
+	clear(@complete_seq);
+	clear(@out_of_order);
 }

Thanks,
Ming

