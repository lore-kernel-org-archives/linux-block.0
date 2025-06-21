Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE71197A8E
	for <linux-block@vger.kernel.org>; Sat, 21 Jun 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750525823; cv=none; b=XuxFZjBeWhyZWJk5hplF5+xEP7wAqxeItB4eJtgczVVbnI0IKE9nOx8wYAc9joNzlK210XJL5rZbHtbxKoPViqolW8Bm3NiLU4MUmyFjVP9teVX+wf4MwBL+iFpI0si5rr3uho/cLRYYFDAe4PXuFXSMFQe/NRaD0U3WRNZ8nYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750525823; c=relaxed/simple;
	bh=4LWfGCi1nLtG/kbGQapjEjSBYdAEFTpn1lP+T/exZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pgy/5FdOTt/K9Y/Usl0kDdi9bdiJ0m1urdaP5kUBdpCMQ3W8MXwSIYLNujor17h6CLjws6c7Hjc9Iha0oPm5PBygKnhy+Y9OUlmAVKT/aRagWOhd45XPxNqnDpPTTeqpufavOkYi1YoqDh3lPfxeNw4Br4NXFqjlTM6RrSp5N+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=f86w9FIN; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="f86w9FIN"
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-739f122a82aso391077a34.0
        for <linux-block@vger.kernel.org>; Sat, 21 Jun 2025 10:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1750525819; x=1751130619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ODKnPeH6lQjDP3d4evNmKT0fMs6HDWUxZMY80qS+CZs=;
        b=f86w9FINqhxPtwSVYH/Vxk/pjxnGafqRJdKRXJp2Ljp8+1VtBOf9csX8p3ptC0sP/e
         qwag1cvhQtWax2XQgJqXPPhHlN8PLRik137N/Tp7fKqt6QQPBMdrO8ZNcnEHycUnlbBs
         b8Zi9gEpUrqR6/GwkvVk1BhW95q9f6oxYyQ0B9LdNBCTC2/ybeKyPpy+9cLumVyFi0nj
         qOfL1CjCQgzQS3fzQockbDyRMIXqiZJ0Nd4YH2EUpvpcotCCfzlO1xhT2Kpxc1qdpN2e
         aNj7TrYbF8n+ascBl1CFKrdMRYg9PGTv0J5k0W5T2KK3OfeHQhhAbcImOFTnIbo1IMPm
         nquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750525819; x=1751130619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ODKnPeH6lQjDP3d4evNmKT0fMs6HDWUxZMY80qS+CZs=;
        b=bTxV2/VsFLJRAuU+O8kMCFvDgrczDYq+ow0ywcCYax4sSzgUCA3YBtsId1q5gn8LPz
         GTV2JMvxHPs3K2V6iizoPx7sOv0PWdnlXHhKcJthZxVzPe4C8jJnl7GBm3dTIz7f1Xbx
         VwJG0ZWgw24uhy9ulxUJKU8QMQG1sKTTPFVIxAyOPGSHYpjw3CpPhe0E8xPuh/DwN7vb
         7MQ86Kzo9ly5yhW8nW/HrQ+APW+HP7EszzMXNg/7VaIBosWrClRKg/d5V0Wr7IyFJMSr
         Cg6Co8z/TMjUK2akZrBaHSf1tYNFX3oC3a3lX9QHa4V7kH1vu2p2dHx846ch+yRC22Xf
         ypKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUv+ERJJRy+wFFlroYwJ9xaP8+nj+5gf2fsl+r2AiXudYtB9RvzqpIFS/a+OF618HC455rTz49L5V2woA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhtawwlf+WV2X3x0zLBu1FDmz3o1zBTHqICQfuXPOCUbkcrRgs
	91hP1meesXGY6rOpSVYxJwvlczP9UtL1qiRNVLVyzbCe4iA68LnsfzmDYrmz1I+fTp86/VUD1hR
	awgTHcg0GwDnsETqlhgJE+Fq+F14YXHZwStJj
X-Gm-Gg: ASbGncvyh+ql2N2cgrntQ70O0GDHMB+lFyeade6846EnIRHvQLxTtmRWqGYHKwlh/XN
	s5cm7e6lyQY7JCd8+zT9p3nAcdMAQ5dYdbyhatry057FXvyMxIokGGF9Q3h5CENRFylaxNYkD7W
	xNQIULVnskPY3uGMspm/G52BiGNL1bgPnrhBa87JqZFU9BebS3Mk5RP1L5WLbLBIF4S9OONUE4d
	p0R0cxioBRBMqrdcpRs8wGCoCax9e2P/78VkXCD0JKEU1yh/911qkgeUxd47E/KHOAWg1L4ILoa
	JTI3Bd7gl9IoTUictyt9E9LkTD5RV9U6w6nrgusPMFjYRsz1daYSDAk=
X-Google-Smtp-Source: AGHT+IHf8GUT8X9P1v61r8Wg3nG5BNMKExX+Olc0ps7UyKoekod4H18jPb5pBrWghJeHzbugL58NdV31JC7s
X-Received: by 2002:a05:6870:b622:b0:2ea:b84:295d with SMTP id 586e51a60fabf-2eec574d648mr1621484fac.0.1750525819147;
        Sat, 21 Jun 2025 10:10:19 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-2ee8a707d30sm249439fac.24.2025.06.21.10.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jun 2025 10:10:19 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4037A340363;
	Sat, 21 Jun 2025 11:10:18 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 375EEE42425; Sat, 21 Jun 2025 11:10:18 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: update UBLK_F_SUPPORT_ZERO_COPY comment in UAPI header
Date: Sat, 21 Jun 2025 11:10:14 -0600
Message-ID: <20250621171015.354932-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

UBLK_F_SUPPORT_ZERO_COPY has a very old comment describing the initial
idea for how zero-copy would be implemented. The actual implementation
added in commit 1f6540e2aabb ("ublk: zc register/unregister bvec") uses
io_uring registered buffers rather than shared memory mapping.
Remove the inaccurate remarks about mapping ublk request memory into the
ublk server's address space and requiring 4K block size. Replace them
with a description of the current zero-copy mechanism.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/uapi/linux/ublk_cmd.h | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
index 77d9d6af46da..a8718075b15c 100644
--- a/include/uapi/linux/ublk_cmd.h
+++ b/include/uapi/linux/ublk_cmd.h
@@ -133,12 +133,32 @@
 
 #define UBLKSRV_IO_BUF_TOTAL_BITS	(UBLK_QID_OFF + UBLK_QID_BITS)
 #define UBLKSRV_IO_BUF_TOTAL_SIZE	(1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
 
 /*
- * zero copy requires 4k block size, and can remap ublk driver's io
- * request into ublksrv's vm space
+ * ublk server can register data buffers for incoming I/O requests with a sparse
+ * io_uring buffer table. The request buffer can then be used as the data buffer
+ * for io_uring operations via the fixed buffer index.
+ * Note that the ublk server can never directly access the request data memory.
+ *
+ * To use this feature, the ublk server must first register a sparse buffer
+ * table on an io_uring instance.
+ * When an incoming ublk request is received, the ublk server submits a
+ * UBLK_U_IO_REGISTER_IO_BUF command to that io_uring instance. The
+ * ublksrv_io_cmd's q_id and tag specify the request whose buffer to register
+ * and addr is the index in the io_uring's buffer table to install the buffer.
+ * SQEs can now be submitted to the io_uring to read/write the request's buffer
+ * by enabling fixed buffers (e.g. using IORING_OP_{READ,WRITE}_FIXED or
+ * IORING_URING_CMD_FIXED) and passing the registered buffer index in buf_index.
+ * Once the last io_uring operation using the request's buffer has completed,
+ * the ublk server submits a UBLK_U_IO_UNREGISTER_IO_BUF command with q_id, tag,
+ * and addr again specifying the request buffer to unregister.
+ * The ublk request is completed when its buffer is unregistered from all
+ * io_uring instances and the ublk server issues UBLK_U_IO_COMMIT_AND_FETCH_REQ.
+ *
+ * Not available for UBLK_F_UNPRIVILEGED_DEV, as a ublk server can leak
+ * uninitialized kernel memory by not reading into the full request buffer.
  */
 #define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << 0)
 
 /*
  * Force to complete io cmd via io_uring_cmd_complete_in_task so that
-- 
2.45.2

