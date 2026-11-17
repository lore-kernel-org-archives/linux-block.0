Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794884234;
	b=ya/qleJfj2r9WZpD1YwaLAiV4eIIRCbBlG+OIXI8n0bDtPgBFQEenrkAwFTfADmzxJKP
	 I58LDRhg1ChkSB2OnKfKCo8HqvFs9kAVpnDYti812R0QAVsnM0qVZ63oKw4ASEmAXC5V3
	 MhGCkJZGdEVOWZ4c0rdoSTRIzY8CwzT1kj4S9g5inFbBqIVYPyXLL1bH1f1cSvkVfdz3o
	 lpaeYSixJyfnMGdvomY+FQ+y1VmXJAnKc7cH+os1l7wQm0mP2tnFp7dAe7AGuaKzj/nnW
	 1kX2E86fa4oeggXtB/H/cngkiDSmhhT/0j7rJd5+WIWlIf5OCc2NDHjMQAh8WBfvjoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794884234;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=srAD8PPZ4srEw/Uq0xx9Uj89tYV0STJH0kyoiq2DVq8=;
	b=tnjTqPsPXsnryJvsWTh6fOL1OT/lo6GH+Mmb2ECBqH5eS3f363XN5WZFG2AOuj21pBZt
	 X7WJ4oqOV4WWTuNnQk8FuEKFQN+Uy7gpSV3O/SKPHdv2j4MYx7eczn51N69b3sPksXY0V
	 Yd8S6APJbwsIl9EuEAw/vJsVV7Zb2kwU5X3Z9wqTpS6YfXaF5BqmlPo14dADToA70AKv+
	 zyQaHuCNGmVSm9pTkYoL7TDFonzUay85YuMtizqBkGatxIlx9IbWmAU9rqhCn5uJsHzi5
	 6DCF+ZSA+SgOnplskd/oK80UHg1Bwjo/hEDL4B9Cv+t2saaRrDtxms7kFxOsfS3v23g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LWJm3EJM;
	arc=none smtp.remote-ip=91.218.175.251
Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D86606A31C
	for <linux-block@vger.kernel.org>; Tue, 17 Nov 2026 02:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D86606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=LWJm3EJM
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eTjIcgvdBir3T/bQuE1dRMvws9vjJWnMC9oUB5q5fmE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794884232; v=1; x=1795489032;
 b=LWJm3EJMHDveNJj41FUq/f2/dx6tkvQfjPOg2BxyAiduYVCXo1YD42WgAxsyctmEZ8y+t9v4
 Vu4MzW2wjxEveOzIzATTt7CTyizqk0XcneO6VRpHyuaxcfj3CuVX71ktL5CQAwx4RiU/wcZ52eF
 cgw/7Cr3rpiBaBTsX3EvPTOU=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c9eb57379795f743;
	Tue, 17 Nov 2026 02:57:11 +0000
X-Mizu-Trace-ID: c9eb57379795f743
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Mon, 16 Nov 2026 21:56:54 -0500
Subject: [PATCH v3 1/2] block: don't request a module for the none elevator
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-bug-block-elevator-unchanged-v3-1-cb4dda2dadf4@linux.dev>
References: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
In-Reply-To: <20261116-bug-block-elevator-unchanged-v3-0-cb4dda2dadf4@linux.dev>
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>, 
 Ming Lei <tom.leiming@gmail.com>, Nilay Shroff <nilay@linux.ibm.com>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <qiliang.yuan@linux.dev>, Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.13.0

elv_iosched_store() calls elv_iosched_load_module() for the requested
name before anything else, and loads "<name>-iosched" if no elevator
type of that name is registered. "none" never is, so every write of
"none" to queue/scheduler ends up in request_module("none-iosched").

That runs a modprobe helper which can never find the module, and adds
several milliseconds to every switch to "none", including rewrites of
it by udev rules or tuning tools that set the scheduler on each disk.

Return early for "none", like elevator_change() did before the module
loading moved into elv_iosched_load_module().

Writing queue/scheduler of a null_blk disk 20 times takes (median):

  operation             before (ms)  after (ms)  change
  none -> none                13.10        9.11    -30%
  mq-deadline -> none         13.00        7.97    -39%

Fixes: 734e1a8603128 ("block: Prevent deadlocks when switching elevators")
Signed-off-by: Qiliang Yuan <qiliang.yuan@linux.dev>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
---
 block/elevator.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/elevator.c b/block/elevator.c
index 66edf1a5768a8..9d9b2e84a1288 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -775,6 +775,9 @@ static void elv_iosched_load_module(const char *elevator_name)
 {
 	struct elevator_type *found;
 
+	if (!strncmp(elevator_name, "none", 4))
+		return;
+
 	spin_lock(&elv_list_lock);
 	found = __elevator_find(elevator_name);
 	spin_unlock(&elv_list_lock);

-- 
2.43.0

