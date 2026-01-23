Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBA91E8342
	for <linux-block@vger.kernel.org>; Fri, 23 Jan 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769178815; cv=none; b=YNQ4a6IHTfvRAp2eYri187TExI2K0Gsjx+7Xki2IDHbLimTm15pBjuy4AftIcgrON8Jf7bydCgc7SQsNjQjUKTXqD5TS4MrtTTRJPkD8cgmlklfsYiL7uz9NtF/82xTrAQCYgH7RYHQFoKjWebrjqdveYKve5zJPzkE2IZM3LoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769178815; c=relaxed/simple;
	bh=emx8G0hDSjjMUQgEG6A6xFCo6ccW8H6NqMNkdeDCerA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxLY/3KxNvFGb1tV+XrnuAaIJpkWKQv7KDt9aFhK8NATJwO7wMyGOryzdGSj55H7bnSMt+8UJMOT98S7racLMh/72CaUuHuPQe7Cmp2Qo/8KkxFs6PhfCZq2xjDpC+ZqtBliqCvWUL/sEYXUHLDI8mqCNutzPE2qPKWe/h27t6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5q2uEYa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5q2uEYa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769178812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JM4JpxZA+2gCwe4vTkVPfg3OyZNp/3usQIlhfTRzTCA=;
	b=V5q2uEYaCx07c/q47QBTarKucWowoGHdF0AmgFjc+RRjmj5NcklA8AW5Kc/9R2QG7REnov
	IKz+75DvhZUutC3iBuTven1dByU5dKAtnt9dRq7voBD4me6rY0ktEPPiEcn+20jvWCsUH5
	UkukC4aU0CFOVa7ai9oIFNEgA9fmU7o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-Ml6Te2z4McqYeQwbCEEQ1Q-1; Fri,
 23 Jan 2026 09:33:27 -0500
X-MC-Unique: Ml6Te2z4McqYeQwbCEEQ1Q-1
X-Mimecast-MFC-AGG-ID: Ml6Te2z4McqYeQwbCEEQ1Q_1769178806
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9B241800357;
	Fri, 23 Jan 2026 14:33:26 +0000 (UTC)
Received: from fedora (unknown [10.72.116.62])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 30AE31800577;
	Fri, 23 Jan 2026 14:33:22 +0000 (UTC)
Date: Fri, 23 Jan 2026 22:33:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Alexander Atanasov <alex@zazolabs.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: ublk: use tmpdir for scratch files and
 improve relative paths use
Message-ID: <aXOGrXo3AbXPHA-K@fedora>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora>
 <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On Fri, Jan 23, 2026 at 03:59:31PM +0200, Alexander Atanasov wrote:
> On 23 Jan 2026, at 15:33, Ming Lei <ming.lei@redhat.com> wrote:
> > 
> > On Fri, Jan 23, 2026 at 11:20:36AM +0000, Alexander Atanasov wrote:
> >> Create a temp dir for temporary files and use it instead of
> >> placing them inside source tree.
> > 
> > Many temporary files are backing files of file storage target, so far
> > the code requires O_DIRECT, or the size could be a bit big.
> > 
> > In case of ramfs/tmpfs of temp dir, it may cause problem for tests.
> > 
> 
> I am aware of O_DIRECT problem but you can export different TMPDIR that has working O_DIRECT.

Can you share how to export TMPDIR capable of O_DIRECT?

> 
> I use sshfs mount of the build to run the tests and that is a problem sshfs/fuse does not
> do O_DIRECT too.
> 
> I think test_generic_06.sh is the only one that fails due to this(thou I still have to investigate).
> 
> If O_DIRECT is required by the tests it may be possible to go thru a RAM disk which does support it,
> so it works eveerywhere
> 
> Other option is to preserve working in source tree as it is now, and just add a variable to specify working directory -
> UBLK_TMPDIR or something.
> 
> 
> I get a lot of out of order io - between 0 and 10 on average on my test setup:
> tools/testing/selftests/ublk/test_generic_01.sh 
> Attached 3 probes
> io_out_of_order: exp 564688 actual 564648
> io_out_of_order: exp 564648 actual 565584
> io_out_of_order: exp 565584 actual 564688
> io_out_of_order: exp 565592 actual 564688
> io_out_of_order: exp 566328 actual 565592
> io_out_of_order: exp 882256 actual 882248
> io_out_of_order: exp 883032 actual 882912
> io_out_of_order: exp 882912 actual 883040
> io_out_of_order: exp 883040 actual 883032
> 
> 
> generic_01 : [FAIL]
> 
> All rq-s are there just reordered , AFAIK blk-mq does not guarantee that requests will be completed in order, what’s the idea to catch this and

If there is just 0 ~ 10, it could be fine. But if all are reorderd,
something must be wrong. One improvement could be check if there is too
many reorder...

Actually what I am trying to test is to make sure same order is observed
from both ublk driver dispatch code path and ublk target io handling code
path, because io_uring task work schedule uses llist, which may introduce io
reorder.

However, that involves ublk kprobe/kfunc trace, which may not be stable,
so I simply check the end-to-end IO order. Sometimes blk-mq IO queue/dispatch
may re-order IO.

I guess the following change may avoid the re-order, but batch IO case may
not be covered:

diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
index 21a31cd5491a..5805da4c84c5 100755
--- a/tools/testing/selftests/ublk/test_generic_01.sh
+++ b/tools/testing/selftests/ublk/test_generic_01.sh
@@ -29,14 +29,8 @@ if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
        exit "$UBLK_SKIP_CODE"
 fi

-# run fio over this ublk disk
-fio --name=write_seq \
-    --filename=/dev/ublkb"${dev_id}" \
-    --ioengine=libaio --iodepth=16 \
-    --rw=write \
-    --size=512M \
-    --direct=1 \
-    --bs=4k > /dev/null 2>&1
+taskset -c 0 dd if=/dev/zero of=/dev/ublkb"${dev_id}" bs=1M count=256 oflag=direct > /dev/null 2>&1
+


> consider it an error? (Latest tree with batch io and batch io fixes on top of if that matters)

Never observe generic_01 failure in my test VM and hardware.

My kernel config is based on Fedora, maybe scheduler config option makes the difference.



Thanks,
Ming

