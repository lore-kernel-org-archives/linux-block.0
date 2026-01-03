Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2923DEB6
	for <linux-block@vger.kernel.org>; Sat,  3 Jan 2026 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767401140; cv=none; b=FEyniclFsD7bFz2o036bIUaZHQmZpoUjN0cI79J82dA9u3h7RFTvtDIAYdNylI1v2u8/Z9WUjnBb32N0MjlDfE9d7FF1Q6DZjln7IhEzcOfYvXriFBjm76MKYMISHa4NKHqUaGS3JGEQ5HOP8MzWLwvF/tdOcoVEVAbgZ1eVp7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767401140; c=relaxed/simple;
	bh=C7WOnO6ID4LqxTasOYmRz/f/EOUiS1sTWpJj01SHmZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4ne51C7H8smw8EbaGCqXXzC2HNvdZ2KcvxIIDH2gFxr15sMBCNTBSz8E2oLNNm4SI6ZFc3bdbcGBeClQvWl7KL4ddmLh6gfku+57S+z/qdcXiS7GaxnlB7PwjzJOaFVhw9UE4szaludnj8YtHnYl3OvXzK5Cx0xZnNCKrnrAJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GoNh2+Fj; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GoNh2+Fj"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2a0f3d2e503so23533445ad.3
        for <linux-block@vger.kernel.org>; Fri, 02 Jan 2026 16:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767401134; x=1768005934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=GoNh2+FjIG7Xs9Kvj2DdllebHKjqa3crOSDaGnq6cJONOReQf/mQqKCjZOddaeTQNp
         11Uc0myJDme2oUWEwjuF9RHNwM9UqYX2WvGfvNQXpIwSpkZlUu3w//7f/ZDjlV/nPR2w
         9HD6v9U5JDfqASq24pBOOCqv1XIz+5kojRbp1NZZTxTNFOfDBdhOeJafmIixnT1Z3RLj
         Kju/HYVtiflJIVDz//TuBMfhch87O8mjMoRkS4z+k18pBX0QrZtuJ3W6G5qZVaiFVyLx
         IAp0hswNc9GpUyYrvh6qfZ5VZhFFXxxEXQVRsfif3Os0RVX19pJBgRfAmUMT+ZgK7jMP
         dVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767401134; x=1768005934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bEkLGAxkvhhHV6OBGkQMN8FAiPS5rx2ziWg20da5Ww=;
        b=SyMO3wU0rgOSK4yvgImnO/EhatEHSOp4m2pAfacTrGMM7UbUGJgVz2JQBqzE/YZGkM
         G9sp9wM/dNOL7gtMNTKzUBNiN7vPX6EddA6oHbYVvjdZ2KwGwEf5f01t4FoGv7ue7Z4A
         B6echGqPwIUm51+OVvjH4/AeniGV70UZoxG9+ltpP4LjjIJ98T/jk1/Za4Dusbacx9sE
         +Y0k4KOfXaFfpHOxi2fMgpZfWhHHE2cQtYG7C8x5dsOwGboFOxVxWdQ1RiEFzLabRj6J
         3gJUWqrYipE7OpcPYd1a+Ihk2gjUoTQttc74KJVoPp3P6kwwEiNIjd+xiaZwMSz6E1cC
         Zb1Q==
X-Gm-Message-State: AOJu0YxUv8BN8MEd+CoqaUl1H3g+7EzT7g8Z+GimdMtJS1tlxwY3wUqX
	lG7kNTl0w8qBBuZPpDM12O9n7SN5DPgcfcWq4jHTxfT4LcWNdwyccSQk6fm2GX2F72345BAc0eN
	7SsvRWN0EUJwBKt8o82yEY3/qDwnhxvne4rERxG0ZZt9EOc+wdx3I
X-Gm-Gg: AY/fxX7KdHtWP62JGxxxUEluamRPBIW0DmcXJxZ+migmt/LYyM37Sf/hUP9rBrJK371
	tMhHftU1AHE46MMpuygZRpzAlIdqSlKircNVtFL1DOC0DOVruFRniDVbQc+zUL1hpb8EKIkhJvw
	5TV1SFE0PjNSZ9JgcROJb3vkoFBen975szSUwPG7Smm8Uz7c9hZoXmAz1RTZC/CB2+6AkTmPjqd
	XVlBCJwRHw9dvWnpO7lunm4gNgDmk+1kdlgm2aYCVvaJN3eWRVQH4rc3g6ePT0qy27/xHb1cAH4
	o01SAUEny3LwX5WxieVs63aIyDosj1mti1/s6QYil4RuwtWeaWwVLJUHhrIiDwnfKONWwwXDBrE
	LcSUzJSb0MfVl+mUKA4a8+5UaG2A=
X-Google-Smtp-Source: AGHT+IHawm48E7pqRyjmJ9hUw0NxRRl9Ovxh9zYIlhy1Y4hqCxOwahXdq8vrTBovmg4pUO9Vts97L2O1plEF
X-Received: by 2002:a17:90b:1a86:b0:34a:b4a2:f0b5 with SMTP id 98e67ed59e1d1-34e922090femr27162417a91.5.1767401134519;
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-34f477483cfsm71018a91.4.2026.01.02.16.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 16:45:34 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id F107F3402DF;
	Fri,  2 Jan 2026 17:45:33 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id EE9F7E43D1D; Fri,  2 Jan 2026 17:45:33 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 12/19] selftests: ublk: display UBLK_F_INTEGRITY support
Date: Fri,  2 Jan 2026 17:45:22 -0700
Message-ID: <20260103004529.1582405-13-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260103004529.1582405-1-csander@purestorage.com>
References: <20260103004529.1582405-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for printing the UBLK_F_INTEGRITY feature flag in the
human-readable kublk features output.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 tools/testing/selftests/ublk/kublk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 185ba553686a..261095f19c93 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1452,10 +1452,11 @@ static int cmd_dev_get_features(void)
 		FEAT_NAME(UBLK_F_UPDATE_SIZE),
 		FEAT_NAME(UBLK_F_AUTO_BUF_REG),
 		FEAT_NAME(UBLK_F_QUIESCE),
 		FEAT_NAME(UBLK_F_PER_IO_DAEMON),
 		FEAT_NAME(UBLK_F_BUF_REG_OFF_DAEMON),
+		FEAT_NAME(UBLK_F_INTEGRITY),
 	};
 	struct ublk_dev *dev;
 	__u64 features = 0;
 	int ret;
 
-- 
2.45.2

