Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B434811FE
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031627; cv=none; b=MiGs9mgoSUF3K5GTYf3/2X4jAcEewzmBVDUcjQOnZm7oyQlEbV2PFbvX7/j0cfrknkyvwP2paK8vYNYC6IXsZSSRWaFaUZ1sEXWrHCDyWUWZlscj9H/bF7DAukzx5L2PmJmRVBvM7MmHfwdOho8HyhJOsMp2pnL2w3micboe3i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031627; c=relaxed/simple;
	bh=Bo/AuMp6nGigNsF3jMHM0FZaBRFmoWZbVgcoPf85sX0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HyXMyAMaPtcwecatdyEvcSclAVNwqZMkkKnA56B1RSvWwxdufNPZEeLiVSfZ7WQ4i2WVN5x/TjKYG5ya8CswOhcaSklA3n9cgGNpC+RL0u7nNNGIL5tLLaLp8OvBF1mIRosbgrcSHUuGzPW29C9R7Yz/40VtfRxsIMGznIkB6pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZlqfKiEd; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZlqfKiEd"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bb5be6742fso50487839f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 09:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706031624; x=1706636424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q9u3L05iFUb+VmQr8yafm/DvsF754CGQpFLVlB6QK0=;
        b=ZlqfKiEd64TIhxxQK1k3QPdOXOZRpQrWKPQM+1D+JBTMqu1vnSn33RZ4CI2npWQ6P/
         tdVB+Dy+cdeGl86r6dW8BKAfLorsEtATwOcbPwcQDj9CVMKWSrUMNDCUI/PkU2XP3SuY
         +4woSMS9NUt5S3CzwwIuIN6gUqT6kRL/PDaDTeEWkSg23SL/jbznxKFsIb2CJqrJmUai
         SVBnA6g+Iz82U2iZU5EQxuLv092egZvyRVQQaXZkSpVvKfE5p2ykcdAcVi4lG0JehcQk
         LNkRotb7qbtmGulK0YiDG5boppYkAMLaa1Db4eOrKabG1vRVsu3z8vzY1OYCXkWb2CDN
         SLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031624; x=1706636424;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q9u3L05iFUb+VmQr8yafm/DvsF754CGQpFLVlB6QK0=;
        b=qO22QlktjmGi5u0Fn0qhYWgg7PeK8jaOMMlOYOOum0KvNVpg53egYZ9er4xZOaOZBA
         HXUyX+xc//YpBXXa+osrciB9KNtQKIHFZvy66Z6oGc7DP5XOBFs6BhpIXLcFtnUnTHNm
         fulIUu+erRESnOJPz7Mom8NSn5NGcbfhQkUxpKT75Vu41e4WzgyD5028CC7hAx1kw6yM
         k0Tm903nFo107XOyRv/Kq+TmfAuidvgnOpu5ueTjnLNQ2viCzAeJfyf77by6qE7Fl+M0
         N1TDlN0KpY29jbjvVD/NKXTCnjkmXSgrWN2Ghgu1fsLXcvGk08k4ZBWPz+OCNs/P6RYd
         z69Q==
X-Gm-Message-State: AOJu0YzDATe5vGiyOyi/8ZL3+kPRxKVAxt3nsQvP2r2bcsjUZJarP+q7
	MMrtFKxCjbWDCHOr2GTxkAU58Zb05wOx4KwPESb+XigGS/BHUwj+uCh4vhdGRF98KO9E0Bm4PKL
	KGL8=
X-Google-Smtp-Source: AGHT+IEI7m30twDTiHwBKiTsiFawB0nVMoVajaadHJSo1fVRGuRL+HR+YgTyp9be0d0RPJbRaN55Ww==
X-Received: by 2002:a5d:93d5:0:b0:7bf:356b:7a96 with SMTP id j21-20020a5d93d5000000b007bf356b7a96mr10621586ioo.2.1706031624188;
        Tue, 23 Jan 2024 09:40:24 -0800 (PST)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l15-20020a6b700f000000b007bf4b9fa2e6sm4647700ioc.47.2024.01.23.09.40.23
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:40:23 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Subject: [PATCHSET v3] mq-deadline and BFQ scalability improvements
Date: Tue, 23 Jan 2024 10:34:12 -0700
Message-ID: <20240123174021.1967461-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It's no secret that mq-deadline doesn't scale very well - it was
originally done as a proof-of-concept conversion from deadline, when the
blk-mq multiqueue layer was written. In the single queue world, the
queue lock protected the IO scheduler as well, and mq-deadline simply
adopted an internal dd->lock to fill the place of that.

While mq-deadline works under blk-mq and doesn't suffer any scaling on
that side, as soon as request insertion or dispatch is done, we're
hitting the per-queue dd->lock quite intensely. On a basic test box
with 16 cores / 32 threads, running a number of IO intensive threads
on either null_blk (single hw queue) or nvme0n1 (many hw queues) shows
this quite easily:

The test case looks like this:

fio --bs=512 --group_reporting=1 --gtod_reduce=1 --invalidate=1 \
	--ioengine=io_uring --norandommap --runtime=60 --rw=randread \
	--thread --time_based=1 --buffered=0 --fixedbufs=1 --numjobs=32 \
	--iodepth=4 --iodepth_batch_submit=4 --iodepth_batch_complete=4 \
	--name=scaletest --filename=/dev/$DEV

and is being run on a desktop 7950X box.

which is 32 threads each doing 4 IOs, for a total queue depth of 128.

Results before the patches:

Device		IOPS	sys	contention	diff
====================================================
null_blk	879K	89%	93.6%
nvme0n1		901K	86%	94.5%

which looks pretty miserable, most of the time is spent contending on
the queue lock.

This RFC patchset attempts to address that by:

1) Serializing dispatch of requests. If we fail dispatching, rely on
   the next completion to dispatch the next one. This could potentially
   reduce the overall depth achieved on the device side, however even
   for the heavily contended test I'm running here, no observable
   change is seen. This is patch 2.

2) Serialize request insertion, using internal per-cpu lists to
   temporarily store requests until insertion can proceed. This is
   patch 3.

3) Skip expensive merges if the queue is already contended. Reasonings
   provided in that patch, patch 4.

With that in place, the same test case now does:

Device		IOPS	sys	contention	diff
====================================================
null_blk	2867K	11.1%	~6.0%		+226%
nvme0n1		3162K	 9.9%	~5.0%		+250%

and while that doesn't completely eliminate the lock contention, it's
oodles better than what it was before. The throughput increase shows
that nicely, with more than a 200% improvement for both cases.

Since the above is very high IOPS testing to show the scalability
limitations, I also ran this on a more normal drive on a Dell R7525 test
box. It doesn't change the performance there (around 66K IOPS), but
it does reduce the system time required to do the IO from 12.6% to
10.7%, or about 20% less time spent in the kernel.

 block/mq-deadline.c | 178 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 17 deletions(-)

Since v2:
	- Update mq-deadline insertion locking optimization patch to
	  use Bart's variant instead. This also drops the per-cpu
	  buckets and hence resolves the need to potentially make
	  the number of buckets dependent on the host.
	- Use locking bitops
	- Add similar series for BFQ, with good results as well
	- Rebase on 6.8-rc1

