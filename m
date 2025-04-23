Received: from mail-io1-f98.google.com (mail-io1-f98.google.com [209.85.166.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6812561A3
	for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 21:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745443747; cv=none; b=Se3FtZS1hZ2CZSgJ04HLdiXt6SKz84QwBN2ca41W7BN2b1lKoOP7EG/Up0stSCg7wTwXWPE9BEoiik2EdWBJW5SLZ1I3DWR3Y+bjN+hSGnbAk4zXT1NiHW0uz1ZkwzBJaA9JYSYG3sRgWKzOBp220OScr0n5CJBHeIZdssNTSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745443747; c=relaxed/simple;
	bh=jJSiliExjwUUvw/BU9r1P+5HjN0QJ5w1C+YK80oL/2w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ezsnqnvHhAeoOFdXuZOgKRnvDIkqCKvQo8X++nfcTRLI7t0QQN9f6PRk7AUEZnrxnvIUo6godo1bQxsYf5Z6d7WHkmjskrTjgUIPu559tdMJd+SZ9imwMKWQtKO6xhP3szymFfIXygkiY31NK6ECkN+rBnNdOnZSf1X35O5+x9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=cJ2EuQGV; arc=none smtp.client-ip=209.85.166.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="cJ2EuQGV"
Received: by mail-io1-f98.google.com with SMTP id ca18e2360f4ac-85b3f92c8f8so30537139f.1
        for <linux-block@vger.kernel.org>; Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745443745; x=1746048545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p70N9HNH8cUqo3HNYWsa7JaG+3jvutETuIK4V8wGm8A=;
        b=cJ2EuQGVBAZjd6DeGTUxu/SqNrcAiyXtOdWlQclZmXKCE6JN7jQhE3o2LDmgIZvYxC
         pxmkMKkwAzBWRumnE6s2KqBY1+h9Q0MvCWPahgkl9QRtNIohtaXJnSxJVGCydbrHvxws
         vjckyHKVcv/gp5CaKpeZNxPla1uNk8aWfPv0T1QlhOUnL98ED2LxbhefVC9wTpAc2wHS
         qBaBHEisUm73GsBopd0dAr4Xjy2kk12d/ea88nv2AQTZtWUtpqJUA+S+Di6/TkjQHpcQ
         3IKBdwsJDTcCKA8kewMIbzPFUUdlV6dD7qKbNKpzd8QSf7JMernFf7k8tKnFLjaO4W3r
         IpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745443745; x=1746048545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p70N9HNH8cUqo3HNYWsa7JaG+3jvutETuIK4V8wGm8A=;
        b=V7P1UUyZbV2KZ3OM4KIuMs0Ai8m7cvPxi/eGbP30cvHasqMBPZHe+xhJqIDq6yrWDi
         EyegB5WaJXWTb0YYq+aY6EiVPvPWSOvtIW4b/nFp79FQa2FJH08Fs+sYixWDYO3L9THe
         C0ObjhTL5/gW+CxpR8AD86TPMtBXTMoiTE1F9rKdXQuEb1qgNIUKn/XDmmxUfCBBSn5g
         CK0TVRXROZ+68Z09G9FCrCJJXlnLLlzQfyoqJjYaG97LiDUjnNrdgINNTdpbSzvcEosb
         93ht/StJ4x9KSNXEft6Lnh2FRBBXLOt3vYQvgsMwF8t8LWXflOmIyRXAC592iUmwRSAc
         oPKw==
X-Gm-Message-State: AOJu0YzJfIn4/BJwvko3Ke+QlgwLVnPmU6bBjEuaSkLhYVvXWeIa/BKF
	sVWk+TLsfOTObVGrTbc4rwy9ny9g4MsSWIy8DjheVyNJ7PRfuUlg20RWWImaip1QQIyaEV1ML8q
	zwPX6Aw5Tn1q43obsvqX+Af+fhENRTiTlcSukQuhksq0sS374
X-Gm-Gg: ASbGncv0WDs8hmA+BB1VmmFn4A/DZi6bEmarmMugz0UTKL40pqFMnWvay8ZRcjl+iwC
	mnfggAdxpEdwlSVQNrB+Y6AjmX6XT9yvUoPbHu5F2Xaf4X2+rrhn5+T/AIOmyOllxZ/KCqMgqNb
	+IPMRipuUimpHwivVkQFzkHzOe51gmvNMJCZrTQpqXZAVCtFEEAGW+WphPpdK4n/K831/LyjNti
	OtF4k2NCL4jYK+r93DGXabFMt4f/xyNn/EPvz0/QmRvxsuf8YbCmN2GHBg8NEmApbUzakGG05HW
	YLv4FbvwKWBne9gh7MQKmv0k/kMoA90=
X-Google-Smtp-Source: AGHT+IHQLlCt2rIpn1OkhY9M+ASyaXRIpQfgsycsrGOxsBZNZm0fdBuOgsIDF+Bpowlmb+xJRe3aHQmKkEh8
X-Received: by 2002:a05:6e02:1fc5:b0:3d3:d823:5402 with SMTP id e9e14a558f8ab-3d9303af911mr2416635ab.7.1745443745096;
        Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3d92758f821sm1201265ab.10.2025.04.23.14.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 14:29:05 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id EBDE43404EA;
	Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id E1482E40371; Wed, 23 Apr 2025 15:29:03 -0600 (MDT)
From: Uday Shankar <ushankar@purestorage.com>
Subject: [PATCH 0/2] selftests: ublk: misc fixes
Date: Wed, 23 Apr 2025 15:29:01 -0600
Message-Id: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1bCWgC/x3MwQpAQBCA4VfRnG2NwcWrSLLMMtmWdpCSd7c5f
 of/f0A5Cis02QORL1HZQkKRZzAuQ5jZyJQMhFRjRaU5rV97Ze8O1kNNaYkJ0RZuqCBFe2Qn9z9
 su/f9AC8mi6pgAAAA
X-Change-ID: 20250423-ublk_selftests-3b2e200b1fa4
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>
X-Mailer: b4 0.14.2

Fix a couple of small issues in the ublk selftests

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
---
Uday Shankar (2):
      selftests: ublk: kublk: build with -Werror
      selftests: ublk: common: fix _get_disk_dev_t for pre-9.0 coreutils

 tools/testing/selftests/ublk/Makefile       | 2 +-
 tools/testing/selftests/ublk/test_common.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d2ce053979d1d302fb009f6e1538a0776f177e1a
change-id: 20250423-ublk_selftests-3b2e200b1fa4

Best regards,
-- 
Uday Shankar <ushankar@purestorage.com>

