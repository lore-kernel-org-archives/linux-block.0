Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1728640DFA4
	for <linux-block@vger.kernel.org>; Thu,  9 Apr 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775741438; cv=none; b=sbVRpukYHNX8+HTsWKAEUI6qOTTMUadhBzxKCfOa+NjWONTr0UXxsxild05G25p2B1PgCGYaDomREHvR8/OASDPVK62XAf9WFwXz+Gewl50/4C2ixgfP1xY9xfIk2qIcoEUyABQauAr4nN9X0YR9WOhvhuHC6Ai4TVk9JDDjt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775741438; c=relaxed/simple;
	bh=S8I1WhVfibkWdm3m6hRnEV5dyAT53W+q1C1XrqjcH44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e09mtXRcYdSd2SqdaZziihkp75bs9JeNb7DxB+AbiGtNHBwO8j8PV8u5wyQEBw2Sa7PjnJgM9hzki9hEk2rYS+ybX62upie4si76gkIAYwmq0v+VqZDHSw+HWeXWt/TmjrFRUOGprY7W6By9cRy8UXPfrrdDzYToKMrFPqPnxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sfvlo5rs; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sfvlo5rs"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso805726a91.0
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 06:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775741436; x=1776346236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R6D8PQmDffDlsSxJlww47UtdQR9Sp6XN9Cej3B1rWb0=;
        b=Sfvlo5rsHrUrk3A5p7DkEQMAk8maj03y5p76E1RRYXmhRL/rXbg7+GDXuLAaKeCX36
         Pid2fZmUrn0Xv5WTB6kLxSwd30746LG+FxNv70MR6wzGJaTHRsUPoOryV9G9ysQDLql/
         ZEYXn5NTAqd7GzCbL0oh+LgGI1St1+W+hKrQudKBUBsyx0sd3wGuLBaekCm7PUjqsKxT
         XtQ7qTfvesOS4Q7vbQqiXetMMwH2GVhALwdd3efblJmR4odAYkhyQmC197+5btfcrsyc
         J/IyVPBNZbzC2Fe7slFMciMn6aPgFWl6jI6kPwxPOlrrMS8f0KWNTXk0O/Xhqdhw91wn
         XAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775741436; x=1776346236;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6D8PQmDffDlsSxJlww47UtdQR9Sp6XN9Cej3B1rWb0=;
        b=aVjB/qT3cQ8FmsxThFP9Kww395tNBKofPy4FQKTKxiyYhbW99AzNUb9B0PNK6hIrGU
         jSru+JL3G6lMXk8boYjRmYsL0VB7DcArVske5MHSI22I+BjDPvoIBXZF1IT5USETjQlY
         HHHyLkoGP419KXNp+ggOOmTPLfHUqAkgTDVlbC8g7Gwa04dtDnTvvTyp4NsfVADZQ4LF
         CVtyGtjBHrEsIykB5Of9rgeqJwwwOQ0ticOcbeG8zO7vArfAMMyP8GqMUQ2CkDAXkxtA
         DMpWVKC3MeasQmYysxaA1OxKBjLfsjmVMqCAsCUI8QTGT4tDR7hdim0sRtDCERcRMvpU
         pQ5g==
X-Forwarded-Encrypted: i=1; AJvYcCWkIbVDMvWDmw2y0i3g25gA08w+e9kf94M1EZco/jfzKcRsdcOk7/q9BJcpPq7ekLyZhDVwPOpoIns2SA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKMmPNV67pLoJsj0yTOgnUSWbi/8YI6j1anO/cH3sbg3HSREjT
	saYlXTnuNtkE6s6pFgj8SuauTaz5QeADyg75tmrbSaulm/41Lf8YRQtaDL63mBElX0xi3A==
X-Gm-Gg: AeBDietpHeW9T2YnDm3QE79YMw3ASmkE4KDEyAb/UPFXgGuTtYdn2vS6+//nq3aKmQc
	mnCYYLUSAVb1ao1FHBhW/hiMwv29kHdeI8vJL1L+SCtu2vaewEJ1ooVTnUCH2KIdyMDmq6bzIqC
	GYwYaSy39oUml/jYt6p7IP9zl1xee1lFh3idwYBOZiv9LXVopJNE6xnderiyaUo6b+82Q/raDUT
	tn5WxvFs8dgyMXcCgZZvSMGuuRTDpbs/jpEANyHU+R5odDKamA/yZSpOBZGF5XMyZ1gt/VAG414
	n82RxZkv1K97CeeleJql29MGX3IlytFyooCr7UKoc75/G/tSf6NFCPru80jR2WTvcDW5GazvApr
	3FObRAPSTeNMMPMta7lIEQT5DbCBkU2DEgSiM8dNO8vZXMQdK0OZQ7ux9A9wvXBX56hisod8DDA
	wzqCL134PjFgCZ267sscvSlRtBxtYRSsgrKxvtSvu9CgzR1fA0MocOJon/URWkq1Do5Q==
X-Received: by 2002:a17:90b:4b0b:b0:35b:e554:53a6 with SMTP id 98e67ed59e1d1-35e357e8828mr3837622a91.11.1775741436218;
        Thu, 09 Apr 2026 06:30:36 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c657dfb7sm21021166a12.24.2026.04.09.06.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 06:30:35 -0700 (PDT)
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Ming Lei <tom.leiming@gmail.com>
Subject: [PATCH 0/7] ublk: followup fixes for SHMEM_ZC
Date: Thu,  9 Apr 2026 21:30:12 +0800
Message-ID: <20260409133020.3780098-1-tom.leiming@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Jens,

Followup fixes for the SHMEM_ZC (shared memory zero copy) patch series,
addressing review feedback from Caleb Sander Mateos.

- Widen ublk_shmem_buf_reg.len to __u64 so 4GB buffers can be registered
  (the __u32 field overflowed to 0 for exactly 4GB)
- Verify all pages in multi-page bvecs fall within the registered maple
  tree range, removing base_pfn from ublk_buf_range since mas.index
  provides the range start PFN
- Simplify the PFN range coalescing loop in __ublk_ctrl_reg_buf
- Replace xarray with IDA for buffer index allocation, removing the
  unnecessary struct ublk_buf
- Allow buffer registration before device is started by taking ub->mutex
  before freezing the queue (same ordering as ublk_stop_dev_unlocked)
- Address documentation review comments
- Update MAINTAINERS email

Thanks,

Ming Lei (7):
  ublk: widen ublk_shmem_buf_reg.len to __u64 for 4GB buffer support
  ublk: verify all pages in multi-page bvec fall within registered range
  ublk: simplify PFN range loop in __ublk_ctrl_reg_buf
  ublk: replace xarray with IDA for shmem buffer index allocation
  ublk: allow buffer registration before device is started
  Documentation: ublk: address review comments for SHMEM_ZC docs
  MAINTAINERS: update ublk driver maintainer email

 Documentation/block/ublk.rst  |  10 +-
 MAINTAINERS                   |   2 +-
 drivers/block/ublk_drv.c      | 201 ++++++++++++++++------------------
 include/uapi/linux/ublk_cmd.h |   3 +-
 4 files changed, 101 insertions(+), 115 deletions(-)

-- 
2.53.0

