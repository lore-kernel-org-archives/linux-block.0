Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5523C17
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751626475; cv=none; b=cv5+zMRnTCi2xefuqSb5tuP+lFKt8YcPP6lmjG5KvxSHsRnGzNidHAKwIyybCcru/dIO7IAshYSNGHV4XDhozKUtd4J9XRNSVGOM9568FBNHOwxXz5W3twh/6xl2tQAmsRoIFa2wvkjljgcHBDVLCNeb5CZa7TVxjIicq8ym7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751626475; c=relaxed/simple;
	bh=acWFAKj9ksbQwEG1YdLJ3RCxzlnJS2v3PsdLl/awsOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h5zqb8wbsPj7ditw8cUs6l+D7oIML76QoplGjXGJTPxJvg3IXUtCRLaeqM7YsqQqEDVFJrApH77fpjT6ocRJtebCZPUHZ547jXBFyUss6pHN9UMvpEMTW9A2qzS7rzGMswAk9VSQfyTZh/Uf7MhgFLujIWxfqnpNxmD+g+k5iN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CvKDMqHs; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CvKDMqHs"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751626473; x=1783162473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=acWFAKj9ksbQwEG1YdLJ3RCxzlnJS2v3PsdLl/awsOo=;
  b=CvKDMqHsj03db5ElMqkfI1/6o7zoghkxW0uI67d9aQ+9q5+HCQ8ixdJ8
   P0EYGWsccRXiOgyobv4KOcY553dFjn/qm+rMjSHnjkIocoLMJG1go2Lh1
   mpZwjMmJtxvDVDYang0i0sJi35hfNANIpVFOezNv+QSl0/4iL+MQ6tctU
   kT2Sxzg/st5dYknGSH5z03tF4Zrs94fPujtb13p3IPzHYugosBcPrwaQy
   Het7xlccEjZ4bINMivNNEpfTIVXZu+zszdmRz50yUd08oTdrF4P8QoakF
   rB2jI860pKxOCfe6LObAluu5OrV43HinxTwRPe1obBMCSiTnX+jKAj2hG
   Q==;
X-CSE-ConnectionGUID: +Scx1WgoTtWPsS1Qnt0Y2w==
X-CSE-MsgGUID: 1B/94ws3Qj+Dr8ODNjOOeA==
X-IronPort-AV: E=Sophos;i="6.16,287,1744041600"; 
   d="scan'208";a="90698180"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2025 18:54:27 +0800
IronPort-SDR: 6867a454_aClqYZWgQbyLpPqJLIi9ShEMeWexN9YlrtaP7WEObsWyYEg
 3iVLp8bTJlvIpYg+kCh6efJ3qXudCyQ0A0YGBUQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2025 02:52:20 -0700
WDCIronportException: Internal
Received: from 5cg21468j0.ad.shared (HELO shinmob.wdc.com) ([10.224.173.175])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Jul 2025 03:54:27 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] common/null_blk: check FULL file availability before write
Date: Fri,  4 Jul 2025 19:54:25 +0900
Message-ID: <20250704105425.127341-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit e2805c7911a4 ("common/null_blk: Log null_blk configuration
parameters") introduced the write to the $FULL file in
_configure_null_blk(). However, the $FULL file is not available when
_configure_null_blk() is called in the fallback_device() context. In
this case, the write fails with the error "No such file or directory".
To avoid the error, confirm that $FULL is available before write to it.

Fixes: e2805c7911a4 ("common/null_blk: Log null_blk configuration parameters")
Link: https://github.com/linux-blktests/blktests/issues/187
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/null_blk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/null_blk b/common/null_blk
index 83f508f..7395754 100644
--- a/common/null_blk
+++ b/common/null_blk
@@ -64,7 +64,7 @@ _configure_null_blk() {
 	fi
 	params+=("$@")
 
-	echo "$nullb_path ${params[*]}" >>"${FULL}"
+	[[ -n "${FULL}" ]] && echo "$nullb_path ${params[*]}" >>"${FULL}"
 
 	for param in "${params[@]}"; do
 		local key="${param%%=*}" val="${param#*=}"
-- 
2.50.0

