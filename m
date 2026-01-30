Received: from mail-dy1-f226.google.com (mail-dy1-f226.google.com [74.125.82.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375F3451D5
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 17:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769793275; cv=none; b=oDSewj61J2UQG5mwNtDwWKMW83mD26Pu1b5tWAxIP7n5WLa0/brc4T29tSf5ymKAqvhZLx80ce5fPvQG4jtVZNvgLfqGI4KMEfvYDnHaSXU7F0f9+FftDQdRPXPlttm7OQmF2chD3WUluf9HvgccvgtUcBaqldMseq0VSXE2UZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769793275; c=relaxed/simple;
	bh=4AhqRcSK5RFr3YMpIfgAjPxjSkOOGh6Ggk88l8ioE6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p+mz88JKX34lGpza1uRVM2ZDGgsPaWQH5yINUKQZ0qGa7C26dsJqVLFSWju4OCD+BzXQcGt2t8AysMrGiBloI+GJq0Wp3v3R8P9v+gESyVVCclyvQ2nNdDmUO16Eg+xycc6VRmftIOgJPKFoWH5OUiik3i8Kr7q350r40v/Ik1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Xk8KRXy8; arc=none smtp.client-ip=74.125.82.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Xk8KRXy8"
Received: by mail-dy1-f226.google.com with SMTP id 5a478bee46e88-2b79658162dso59676eec.3
        for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 09:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769793271; x=1770398071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qs/gvqR82bO0f0PLgN8KfuRjSpNKFdKgyKNx0LU+OsY=;
        b=Xk8KRXy8aa+hkEVXFqBLcfvIT3DnL31KPxSj0v2YY+70DLdp3CUCx53SuIgIspWvWj
         391U+Wf1WlIf260znbKHyv4G2SSHJnUBF1YOZZidiM/SDgYYFI01izKSHCmMqrFlTBav
         teH0e/ms6l8BDuXnfGShxE9LBCMC1Ko46wcY4CB78BvAkDQWA17BupVf82vckZogW7Ny
         379TdRPkMzX3pWNbsJ4ZBgLH8Wt5VVQgrcH+Wy4TZV+NmmTb3mI9FRo0+by2P45R4oZf
         Otb4Gu/81gbHhVjmxUv/E50eNQJZSZj+2/VTCa2+C2xDsEedBJbYZgImXj+1NdXgXiaM
         XS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769793271; x=1770398071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qs/gvqR82bO0f0PLgN8KfuRjSpNKFdKgyKNx0LU+OsY=;
        b=FxiHYPWKedd0xIIp94Fyvq1RqerOekdcXTrXnBsosCzjTcrqK3kINJLKSe3KBZ/pgd
         v10gZDQALciqy+paMh4wkScap7Z6H5aM8Kw2fMChZyBu7XVauiqFCN/sUYO4o6VTEcDY
         KurQwX9C+oql1h8kCOdlCKXu+VHIc2o0+ByLAXG4L1b2QagrTN2rUwoyaF0hhvFTr/Ht
         IyWeNzKMp/zpQcrLr5mHgzuZ1jwFLrYDD2rwWkeOwTc6Y9DhFLckTBh7TNbZJitN8oJZ
         E25fHn3mUn8ah7bf5DPeDj7oYhM+LhoyU6TzvjJkLrg7q9S7/0IWFJHBymFbgE9wTlTI
         Dxaw==
X-Forwarded-Encrypted: i=1; AJvYcCWMSBcjRTb8RN8zKeD5ECLJyVl67bmJyX2YUNlyXDwYDSJKiQJ6XDipXaX7llbifFTHxRSsm6MlpMDgXA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9XWRu7EJbOw97aDBaEOUMVa6gHZYNCTm+lFjXnV2kpyQe9OxX
	usWX8La0V1ON9JQvsLvz7dY0rv5XNLn+LpPY+a/CDbCvKOAUoML5SKRWRDEL+UltP29Loprk8tW
	ihpgWK10pU6AzRYYKVXWE9rUOkW1kVYuOajOs
X-Gm-Gg: AZuq6aKHQIPnKV5UU9ObD4N0qiGzY1in4iapTfO1t+ihdJSAOO0PtiH7LhHYwvcpDkV
	hIrzwb0K5qpFYLzoh37VgkfrGAuMT1Cfy+mFd7LDclRTKJ9vwfGwgpCQgN0sMSXWDokft1kXKBG
	SJVUEXgnNRYfGYBuLlJk+ZMHbC3RgzTOkV+a6lwcQnZ+loWQVZgYZcBWEHKevCU1crFVkxJ2GDd
	juPIcHootKI6goijtFVMmVPzKS1ejSU30g284Va334KGYqM2wc1lOE4kg2dcrT297wxsOb/u+uY
	7YMODbHfpuUiElklgugTxlOiZe1VugFhi/SKClneqsrT3PTnGKcfW7WiKtmnu3u9glKcRAoiVOv
	ckpIkA8ibOhryjsJrvmRdMeMiHS7SsyBHrPM7MCSuqg==
X-Received: by 2002:a05:7300:cd8d:b0:2b7:2f29:64a7 with SMTP id 5a478bee46e88-2b7c865038emr905042eec.2.1769793270542;
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-124a9df4b8bsm1488143c88.8.2026.01.30.09.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 09:14:30 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id AE252340237;
	Fri, 30 Jan 2026 10:14:29 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9F1DAE40249; Fri, 30 Jan 2026 10:14:29 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Govindarajulu Varadarajan <govind.varadar@gmail.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/3] ublk: fix struct ublksrv_ctrl_cmd accesses
Date: Fri, 30 Jan 2026 10:14:11 -0700
Message-ID: <20260130171414.1376543-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct ublksrv_ctrl_cmd is part of the io_uring_sqe. Since commit
87213b0d847c ("ublk: allow non-blocking ctrl cmds in IO_URING_F_NONBLOCK
issue") allowed some commands to be handled in the non-blocking issue,
the SQE may lie in userspace-mapped memory. Validate that the SQE size
is the expected 128 bytes before dereferencing it. Use READ_ONCE() to
copy the ublksrv_ctrl_cmd from the SQE to a local variable. This avoids
data races if userspace writes to the SQE concurrently.

v2:
- Make a local copy of the struct ublksrv_ctrl_cmd (Ming)
- Add Reviewed-by tag (Ming)

Caleb Sander Mateos (2):
  ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd
  ublk: drop ublk_ctrl_start_recovery() header argument

Govindarajulu Varadarajan (1):
  ublk: Validate SQE128 flag before accessing the cmd

 drivers/block/ublk_drv.c | 65 +++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

-- 
2.45.2

