Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEF8495521
	for <linux-block@vger.kernel.org>; Tue,  3 Mar 2026 16:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553819; cv=pass; b=UEJuwngaVmy2873EsIxe08V+rSLX3RwsnNYWx6e3sIZD3IME1cOCT0tpf6lxAIQ2mhzQ+AxWAcV3fmUoJZWT2DJZ8LxVDNOBL/Al2H5FNxifoqUXqHBvFcIG/oXmdWu5gKnfEqQP+BhYuetlVpcP/1+oPpmMDu+ieUJDLC3ZSVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553819; c=relaxed/simple;
	bh=MStpt1FzvcpzR5yxaJgsp3P0lILS3ADSfoOCrfTnaww=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ckVhtDkS6aXnYc+/SbmsFfz0WoMXODOV3SU/6LNvyzFeU61srOoV8SwqSxJL7VYngCWxOnRWlkcV1JzZZ6ywRcd5w2zFxCkBvCVWQc+BTzjtR8U4PJz4KVp9deaedoV9XGo0oezfqPBWXTljB3Ar0bV5e72H+XYU3LWwRf5la38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRKNW1TP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tNalDtui; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRKNW1TP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tNalDtui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772553815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=B375N+Hbu1dtT3u3Qv0jjeRxaTS1eEfE/ooqZPwvpD0=;
	b=KRKNW1TP65PMNsCSv/SaHarIZMajd2Qo0CbRT9SZcL14+48kILea6KTCaIN1t7+0HF06EN
	DgmJIrR5rt4WQHlPVBJYv5C3dvErsVKpUO7MOm+iCCOHZMu5nqDnP5IxSrPG2QdI9Dk6ip
	4zSTj9+6HwdYiS97QWIXSo28DleCFo4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-evRD9hrOOOqep03Ri32iPw-1; Tue, 03 Mar 2026 11:03:34 -0500
X-MC-Unique: evRD9hrOOOqep03Ri32iPw-1
X-Mimecast-MFC-AGG-ID: evRD9hrOOOqep03Ri32iPw_1772553810
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-439bcec86dfso1405455f8f.3
        for <linux-block@vger.kernel.org>; Tue, 03 Mar 2026 08:03:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772553809; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1vRCTr88001C7kuWu88pIMdg+AaxCgLFDRt1a17WYkC7vgjdQ1vIAlNpGl5ofE26p
         wZecHxU64D89+Luq5jioV48Q5PC5+HiIqbINKNqcMN1j3BDP+tThN3+0tA4kQ+BJEVqr
         dqZbtgBT3IjmlRsrxNXiRz72NrxnQxYi3rsQWW9phHTyVCfofq8eKLKeJ1eT0GcG+zmG
         1IDQ6Aa1pZauH/7XyZjf2uWByxOPoVSixPjKdevTGjUhlrfEjipEltQUlxvdUEQ6oO0M
         2ST2aI1eeRecJfsUxPIrYd8F8VtAUSOXE8Xh/XgDPVcUfu6u4N8ZihPBOEgqrKTHb+oS
         cJgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=B375N+Hbu1dtT3u3Qv0jjeRxaTS1eEfE/ooqZPwvpD0=;
        fh=OOEzeCCKLYRkUrha2nJKn19wxd6EUOGQWI5MZxbSw6k=;
        b=AAjXt7uBeo/Xl3OQFJJz2EQ8u8k4W+9aBcj3dXBeutMtDjl7fTv0XmCTGtFABIAApj
         +DpTXTUPT2VUpfs1jhFYW4SYUh5m2z7Mi1DfCmlvo0DV7FozpqRpQs0DMkyYbMsAxKFh
         xZpOCH0xJrN+jR7d2PwmGw4LE9353VuM/ADtyDDWuu6xWpBTH+oHxwJaPdQUqSDhkBvr
         f8Wq1zC/W5XZ+SkuzWzsrghBypmlU7BUJinODcE0GTXOx/JDPav59L09Noz6rp/UDoRg
         IOY4fDaSSUXd03hkxYIQbPhZnmYEqDq2CwYv7ZTSKCTmsr+DSA4JQ1Y3QIPo6xpuf+1Q
         23iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772553809; x=1773158609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B375N+Hbu1dtT3u3Qv0jjeRxaTS1eEfE/ooqZPwvpD0=;
        b=tNalDtuiISQrD5WbxurHzukzj1VEs8Rsjd59lnRbjqIWRqyxLKuHDnGAMqgdQwcuSO
         98kIcdHfDBzFHqgBYRMmINRqP+5pvv7ywm5kBE+QXViCdNd1CwN4xnZt4lDiC4eily8b
         qjTFq59Ix3A1/GdRsX6sD+AZowmcH59VVFv90xeAGQ2++44XNuoRsnR0pU+rP3L2w5fx
         TaEAKJRkTPwhJjKomO75eEWygtMMAbsxzS4qceelRGUp3SUa7WBe7Q3usfE52wHuCrLB
         y6Se5ERB1CbZsS12x7tou+pa/FAbbWIFcNaakDN0fsrOl3qaSskT5K6wWkQ8G4rCjLIo
         jwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772553809; x=1773158609;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B375N+Hbu1dtT3u3Qv0jjeRxaTS1eEfE/ooqZPwvpD0=;
        b=MkHA/Qi5F8NcnsecIZBr+4G8cRZyL49izgybj4qIDB/5thzHtj47pSIIIQ2x7Os9Vt
         hQ0DH3/a/BC8FuYCQutQUqS7UKoq4P8b1HvtuzPfECQDfHqEv5GkMUAVT+0Ue7EUTGSl
         mpjQENuzzCT2eOJwLfI6JacH4P5ze+tn0aB414zho2wDkn7W9qMv7UoJVm+HWlg2Hguo
         tKBEsVvjCbwrZjjaIFazOj67VTnZwSm+8JGD0fEGdgMIvGl9Wle3o8zheByxZBSrkYs9
         P7KOI3EFJ5pXXPlydNwFnnFxrJM/sT1oYisAUxXYovtC/Yok0gXjoUvl7TUiqdSjmFRP
         Ta8w==
X-Gm-Message-State: AOJu0YwuAG3VkHyUUpF3lhqXpgvXvwq1gVJtaN1qHUSYT51DSsaleUqV
	OJlax9NTe+2dVY5oqBrgknGNt8IdgdR7ShnX9x97ljynprcCQIF/1I7wByBWt/YhcxUXaEpqlWc
	RRzdwFHhe/MGvoBHO2m3dRSK0IKGZgNx9SQQbDsah3tW6YJerBLXb+BlGb9sjIwvu3u/Nil0gBf
	bnfvT3btoIHwl5xYjoysmE5pc23xayoebggb33MyrXZtmRGm/4gCiJ
X-Gm-Gg: ATEYQzw7qWsW8PX2iFwR1QkZZISqncsXvPvVYbw3HBLQ2zDc3egaPu1rJKuXTu77m7E
	s3Ignw1UMTSkvqHVKAcfk13fo12pI8CWlWnbzVrGtZwJj61ABdCwbC4l9G6khzX3o8G5pI7+WWA
	m52MJK6DNEGqZKJfq+OkqJiV2D+a3rx4xMl+q6Rwb8/P2qYisZGcQ38TnG6P4KxToTFN0VLRWOF
	tj8j3ZPrQExRYF9JD+QsKoF2qO8Uct/Cwmm/Ez1m39PDPfZkPA=
X-Received: by 2002:a05:651c:3044:b0:385:c21f:37f4 with SMTP id 38308e7fff4ca-389ff142005mr111013121fa.16.1772553336675;
        Tue, 03 Mar 2026 07:55:36 -0800 (PST)
X-Received: by 2002:a05:651c:3044:b0:385:c21f:37f4 with SMTP id
 38308e7fff4ca-389ff142005mr111012861fa.16.1772553336039; Tue, 03 Mar 2026
 07:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Tue, 3 Mar 2026 23:55:23 +0800
X-Gm-Features: AaiRm53W-AqeNhj6xbey46lZ6-Xj4kk6t-wEUC_oJTzXz8WOsFFYDsAQzKmoPuY
Message-ID: <CAHj4cs9qsvcii+KuDWkRPMF6XdDfUwmnjn2Ox6TmGV1u4PpTJA@mail.gmail.com>
Subject: [bug report] Most blktests block/ failed with "Timed out while
 waiting for udev queue to empty."
To: linux-block <linux-block@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Ming Lei <ming.lei@redhat.com>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

Hi

CKI reported that most blktests block/ failed at "udevadm settle"[2]
on the latest linux-block/for-next[1] today.
Seems it's one regression issue and I will try to bisect it tomorrow.

[1]
commit: for-next (7.0.0-rc2, upstream-block, b82c5e4f)
[2]
block/001 (stress device hotplugging)                        [failed]
    runtime    ...  531.793s
    --- tests/block/001.out 2026-03-02 23:17:54.816626772 +0000
    +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/results/nodev/block/001.out.bad
2026-03-02 23:26:52.842946157 +0000
    @@ -1,4 +1,8 @@
     Running block/001
     Stressing sd
    +Timed out while waiting for udev queue to empty.
     Stressing sr
    +Timed out while waiting for udev queue to empty.
    +Timed out while waiting for udev queue to empty.
    +Timed out while waiting for udev queue to empty.
    ...
    (Run 'diff -u tests/block/001.out
/mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/results/nodev/block/001.out.bad'
to see the entire diff)
>>> 2026-03-02 23:26:52 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/tests/block/001
** storage/blktests/tests/block/001 FAIL Score:1
Uploading resultoutputfile.log .done
>>> 2026-03-02 23:26:53 | Start to run test case  /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/tests/block/002 ...
block/002 (remove a device while running blktrace)
block/002 (remove a device while running blktrace)           [failed]
    runtime    ...  361.751s
    --- tests/block/002.out 2026-03-02 23:17:54.816626772 +0000
    +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/results/nodev/block/002.out.bad
2026-03-02 23:32:55.837327191 +0000
    @@ -1,2 +1,5 @@
     Running block/002
    +Timed out while waiting for udev queue to empty.
    +Timed out while waiting for udev queue to empty.
    +Timed out while waiting for udev queue to empty.
     Test complete
>>> 2026-03-02 23:32:55 | End /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/tests/block/002
** storage/blktests/tests/block/002 FAIL Score:1
Uploading resultoutputfile.log .done
>>> 2026-03-02 23:32:56 | Start to run test case  /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/tests/block/006 ...
block/006 (run null-blk in blocking mode)
block/006 (run null-blk in blocking mode)                    [failed]
    runtime    ...  120.067s
    --- tests/block/006.out 2026-03-02 23:17:54.817585748 +0000
    +++ /mnt/tests/s3.amazonaws.com/arr-cki-prod-lookaside/lookaside/kernel-tests-public/kernel-tests-production.tar.gz/storage/blktests/blk/blktests/results/nodev/block/006.out.bad
2026-03-02 23:34:57.275131017 +0000
    @@ -1,2 +1,2 @@
     Running block/006
    -Test complete
    +Timed out while waiting for udev queue to empty.
modprobe with --wait option succeeded but still null_blk has references




-- 
Best Regards,
  Yi Zhang

