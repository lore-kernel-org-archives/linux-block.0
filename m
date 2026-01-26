Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB6170814
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769390877; cv=none; b=d/knRNAoowwVAUBL5cfPf0pv+T2/xqb7AhjGYNUXd1JqBLqtA8dMiP437Lv5kp31lWw1b9vGo/lV7ccz0QilWRGvMmW74VpDQx2mIRhf8BV+1zaKHjylEtx5w5hUHe9l5corl60S1R/eX58aRGhy0kMneL7GTl3PuViakT1v/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769390877; c=relaxed/simple;
	bh=MaQ16MFjCF86robio2aChV2W+uQIjvg7Y1R2ERTVQ/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLB1/Kx3oHgY2Y/Kw8wNW+S54iJ9Vit3befswXlBcgHOEO9qq/qrH9b4zaWeMzddWEboZaow4nIxkYhzMJvTOCN7vzGb0oOwKGh2Z457ceRp+0LYOwTbBSMAzntKlvYWryvusoQDY7L8WaOg3TRRVXKHI1jKYyfQgi/di60aUqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMonZoqo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMonZoqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769390874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0/3PjVwTlclzpJ/pn4iW/a3eYF5SY1NpLn8jCSWnQgk=;
	b=XMonZoqoDIukvjJ2YlQJq3qVdytobMCAfgQrZo9R2sAoBFsB1MAUmEzE9UYLmeYW7+fVMm
	TyDIECVLw2cb8LbV1mXbmibJMz8pXZSotB/8orsx4ekxZROHgmUKv6HKWUF9n5vod7kJcD
	+K38DDUOcuCBnS44D7WirKAqr8/AQTg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-dsOPYKVNNDe3B-Pe4R-OmA-1; Sun,
 25 Jan 2026 20:27:49 -0500
X-MC-Unique: dsOPYKVNNDe3B-Pe4R-OmA-1
X-Mimecast-MFC-AGG-ID: dsOPYKVNNDe3B-Pe4R-OmA_1769390868
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 122A8180057E;
	Mon, 26 Jan 2026 01:27:48 +0000 (UTC)
Received: from fedora (unknown [10.72.116.88])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C9DF30001A7;
	Mon, 26 Jan 2026 01:27:44 +0000 (UTC)
Date: Mon, 26 Jan 2026 09:27:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: alex+zkern@zazolabs.com
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: io-reorder triggered in
 test_generic_01.sh
Message-ID: <aXbDCtZ8fvljMEsC@fedora>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora>
 <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
 <aXOGrXo3AbXPHA-K@fedora>
 <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
 <aXY2qdYtfVTSc7jB@fedora>
 <c517e1ca-0e2b-4143-b0f6-07a3d0c3abcf@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c517e1ca-0e2b-4143-b0f6-07a3d0c3abcf@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Sun, Jan 25, 2026 at 08:35:20PM +0200, Alexander Atanasov wrote:
> On 25.01.26 17:28, Ming Lei wrote:
> > On Fri, Jan 23, 2026 at 05:00:33PM +0200, Alexander Atanasov wrote:
> > > 
> > > 
> 
> [snip]
> 
> > Can you test the following patch and see if re-order still can happen?
> > 
> > 
> > diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
> > index 26cf3c7ceeb5..26d5e52ece29 100755
> > --- a/tools/testing/selftests/ublk/test_generic_01.sh
> > +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> > @@ -13,7 +13,7 @@ if ! _have_program fio; then
> >   	exit "$UBLK_SKIP_CODE"
> >   fi
> > -_prep_test "null" "sequential io order"
> > +_prep_test "null" "ublk dispatch won't reorder IO"
> >   dev_id=$(_add_ublk_dev -t null)
> >   _check_add_dev $TID $?
> > @@ -39,9 +39,13 @@ fio --name=write_seq \
> >   ERR_CODE=$?
> >   kill "$btrace_pid"
> >   wait
> > -if grep -q "io_out_of_order" "$UBLK_TMP"; then
> > -	cat "$UBLK_TMP"
> > +
> > +# Check for out-of-order completions detected by bpftrace
> > +if grep -q "^out_of_order:" "$UBLK_TMP"; then
> > +	echo "I/O reordering detected:"
> > +	grep "^out_of_order:" "$UBLK_TMP"
> >   	ERR_CODE=255
> >   fi
> > +
> >   _cleanup_test "null"
> >   _show_result $TID $ERR_CODE
> > diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
> > index b2f60a92b118..60ac40e66606 100644
> > --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> > +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> > @@ -2,23 +2,45 @@
> >   	$1: 	dev_t
> >   	$2: 	RWBS
> >   	$3:     strlen($2)
> > +
> > +	Track request order between block_io_start and block_rq_complete.
> > +	For each request, record its start sequence number and verify
> > +	completions happen in the same order.
> >   */
> > +
> >   BEGIN {
> > -	@last_rw[$1, str($2)] = (uint64)0;
> > +	@start_seq = (uint64)0;
> > +	@complete_seq = (uint64)0;
> > +	@out_of_order = (uint64)0;
> > +}
> > +
> > +tracepoint:block:block_io_start
> > +{
> > +	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
> > +		@start_order[args.sector] = @start_seq;
> > +		@start_seq = @start_seq + 1;
> > +	}
> >   }
> > +
> >   tracepoint:block:block_rq_complete
> >   {
> > -	$dev = $1;
> >   	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
> > -		$last = @last_rw[$dev, str($2)];
> > -		if ((uint64)args.sector != $last) {
> > -			printf("io_out_of_order: exp %llu actual %llu\n",
> > -				args.sector, $last);
> > +		$expected_order = @start_order[args.sector];
> > +		if ($expected_order != @complete_seq) {
> > +			printf("out_of_order: sector %llu started at seq %llu but completed at seq %llu\n",
> > +				args.sector, $expected_order, @complete_seq);
> > +			@out_of_order = @out_of_order + 1;
> >   		}
> > -		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
> > +		delete(@start_order[args.sector]);
> > +		@complete_seq = @complete_seq + 1;
> >   	}
> >   }
> >   END {
> > -	clear(@last_rw);
> > +	printf("total_start: %llu total_complete: %llu out_of_order: %llu\n",
> > +		@start_seq, @complete_seq, @out_of_order);
> > +	clear(@start_order);
> > +	clear(@start_seq);
> > +	clear(@complete_seq);
> > +	clear(@out_of_order);
> >   }
> 
> 
> First run after reboot always fails:
> 
> ./test_generic_01.sh
> ublk selftest: generic_01 starting at 2026-01-25T19:08:47+02:00
> I/O reordering detected:
> out_of_order: sector 112040 started at seq 88 but completed at seq 0
> out_of_order: sector 112048 started at seq 89 but completed at seq 1
> out_of_order: sector 112056 started at seq 90 but completed at seq 2
> out_of_order: sector 112064 started at seq 91 but completed at seq 3
> out_of_order: sector 112072 started at seq 92 but completed at seq 4
> out_of_order: sector 112080 started at seq 93 but completed at seq 5
> out_of_order: sector 112088 started at seq 94 but completed at seq 6
> out_of_order: sector 112096 started at seq 95 but completed at seq 7
> out_of_order: sector 112104 started at seq 96 but completed at seq 8
> out_of_order: sector 112112 started at seq 97 but completed at seq 9
> out_of_order: sector 112120 started at seq 98 but completed at seq 10
> out_of_order: sector 112128 started at seq 99 but completed at seq 11

In the 1st bpf attachment, fio may be started between attaching
block_start_req and block_complete_req. Maybe the following patch can
solve it:


diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 26cf3c7ceeb5..15cea9e55e1c 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -13,7 +13,7 @@ if ! _have_program fio; then
 	exit "$UBLK_SKIP_CODE"
 fi
 
-_prep_test "null" "sequential io order"
+_prep_test "null" "ublk dispatch won't reorder IO"
 
 dev_id=$(_add_ublk_dev -t null)
 _check_add_dev $TID $?
@@ -21,15 +21,20 @@ _check_add_dev $TID $?
 dev_t=$(_get_disk_dev_t "$dev_id")
 bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
 btrace_pid=$!
-sleep 2
 
-if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
+# Wait for bpftrace probes to be attached (BEGIN block prints BPFTRACE_READY)
+for _ in $(seq 100); do
+	grep -q "BPFTRACE_READY" "$UBLK_TMP" 2>/dev/null && break
+	sleep 0.1
+done
+
+if ! kill -0 "$btrace_pid" 2>/dev/null; then
 	_cleanup_test "null"
 	exit "$UBLK_SKIP_CODE"
 fi
 
-# run fio over this ublk disk
-fio --name=write_seq \
+# run fio over this ublk disk (pinned to CPU 0)
+taskset -c 0 fio --name=write_seq \
     --filename=/dev/ublkb"${dev_id}" \
     --ioengine=libaio --iodepth=16 \
     --rw=write \
@@ -39,9 +44,13 @@ fio --name=write_seq \
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
index b2f60a92b118..8ebe13d24c67 100644
--- a/tools/testing/selftests/ublk/trace/seq_io.bt
+++ b/tools/testing/selftests/ublk/trace/seq_io.bt
@@ -2,23 +2,64 @@
 	$1: 	dev_t
 	$2: 	RWBS
 	$3:     strlen($2)
+
+	Track request order between block_io_start and block_rq_complete.
+	For each request, record its start sequence number and verify
+	completions happen in the same order.
+
+	Sequence starts at 1 so that 0 means "never seen" (bpftrace maps
+	return 0 for missing keys). On first valid completion, sync
+	complete_seq to handle probe attachment races.
+
+	block_rq_complete is listed first to ensure it's attached before
+	block_io_start, reducing the window for missed completions.
 */
+
 BEGIN {
-	@last_rw[$1, str($2)] = (uint64)0;
+	@start_seq = (uint64)1;
+	@complete_seq = (uint64)0;
+	@out_of_order = (uint64)0;
+	/* Initialize map type with dummy entry */
+	@start_order[0] = (uint64)0;
+	delete(@start_order[0]);
+	printf("BPFTRACE_READY\n");
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
+		$expected = @start_order[args.sector];
+		if ($expected > 0) {
+			/* Sync complete_seq on first valid completion */
+			if (@complete_seq == 0) {
+				@complete_seq = $expected;
+			}
+
+			if ($expected != @complete_seq) {
+				printf("out_of_order: sector %llu started at seq %llu but completed at seq %llu\n",
+					args.sector, $expected, @complete_seq);
+				@out_of_order = @out_of_order + 1;
+			}
+			delete(@start_order[args.sector]);
+			@complete_seq = @complete_seq + 1;
 		}
-		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
+		/* $expected == 0 means we never saw this sector start, skip it */
+	}
+}
+
+tracepoint:block:block_io_start
+{
+	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
+		@start_order[args.sector] = @start_seq;
+		@start_seq = @start_seq + 1;
 	}
 }
 
 END {
-	clear(@last_rw);
+	printf("total_start: %llu total_complete: %llu out_of_order: %llu\n",
+		@start_seq - 1, @complete_seq, @out_of_order);
+	clear(@start_order);
+	clear(@start_seq);
+	clear(@complete_seq);
+	clear(@out_of_order);
 }



Thanks,
Ming

