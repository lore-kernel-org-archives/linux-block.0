Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E9D22B598
	for <linux-block@vger.kernel.org>; Tue, 22 Apr 2025 00:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745280008; cv=none; b=huotUC3GF3FpAYzpiGKRwh7HgBmoerGRoplX3yHoIL7pWaadxtE1PSeVMXvWHGU2YnpGqcrsifU+Z8aZCnLeFvh2szXtLU3XrsQib6b6fAYWswgEURswZwZG8lRhMVM9ULT4WarGGe1qJZUZVPhqGdqi636KkfuEDt2xLxOY0pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745280008; c=relaxed/simple;
	bh=lOJ/79XRkfEy+0NSGTIGMT9EULpR5g734N6gHjFUesA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RvF7Io3N07I403RETY1B/2idkHpudW+eGIBIvDHfeCN3qZjgEDphlwosMVU0y5JijL49MxUtIrINgEgHy7lwRMzYl+ySpaqzxtLrfDTa/mNTYiwDg4qUTekLIlltPvJVLLBIbdo3o4mR2YCHE3s6MD8homtIRO4Yu1uoQOWHP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bLZyaE+h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLZyaE+h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745280005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3xhDl8r+Dd648iY0Dlb9kXVUAjVfAdkeu6NQtSub1I=;
	b=bLZyaE+hok9y+Le8pV6+Az9IFZ8CfEpjgr2U9trJ6a7K4boeVCc3NQZlTOpVnjMSikAqzm
	/xy1Tp13/31FkxhaVoqHVjhmJ27qgGRwSv0u5X5FGMFL0O233D3to6Na3lszkKLIMKjC7T
	e41w3HEb1BOTTzT0XXfOMtpuD0e+VhY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-WQGt4FXxPvm1FcLaGNSRGg-1; Mon,
 21 Apr 2025 20:00:02 -0400
X-MC-Unique: WQGt4FXxPvm1FcLaGNSRGg-1
X-Mimecast-MFC-AGG-ID: WQGt4FXxPvm1FcLaGNSRGg_1745280001
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F0331800368;
	Tue, 22 Apr 2025 00:00:00 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EEF7195608F;
	Mon, 21 Apr 2025 23:59:59 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6.15 1/2] selftests: ublk: fix recover test
Date: Tue, 22 Apr 2025 07:59:41 +0800
Message-ID: <20250421235947.715272-2-ming.lei@redhat.com>
In-Reply-To: <20250421235947.715272-1-ming.lei@redhat.com>
References: <20250421235947.715272-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

When adding recovery test:

- 'break' is missed for handling '-g' argument

- test name of test_generic_05.sh is wrong

So fix the two.

Fixes: 57e13a2e8cd2 ("selftests: ublk: support user recovery")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 tools/testing/selftests/ublk/kublk.c            | 1 +
 tools/testing/selftests/ublk/test_generic_05.sh | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ublk/kublk.c b/tools/testing/selftests/ublk/kublk.c
index 759f06637146..e57a1486bb48 100644
--- a/tools/testing/selftests/ublk/kublk.c
+++ b/tools/testing/selftests/ublk/kublk.c
@@ -1354,6 +1354,7 @@ int main(int argc, char *argv[])
 			value = strtol(optarg, NULL, 10);
 			if (value)
 				ctx.flags |= UBLK_F_NEED_GET_DATA;
+			break;
 		case 0:
 			if (!strcmp(longopts[option_idx].name, "debug_mask"))
 				ublk_dbg_mask = strtol(optarg, NULL, 16);
diff --git a/tools/testing/selftests/ublk/test_generic_05.sh b/tools/testing/selftests/ublk/test_generic_05.sh
index 714630b4b329..3bb00a347402 100755
--- a/tools/testing/selftests/ublk/test_generic_05.sh
+++ b/tools/testing/selftests/ublk/test_generic_05.sh
@@ -3,7 +3,7 @@
 
 . "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
 
-TID="generic_04"
+TID="generic_05"
 ERR_CODE=0
 
 ublk_run_recover_test()
-- 
2.47.0

