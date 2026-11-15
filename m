Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794707931;
	b=TwlAXb73Yquc7UCsAhqEEvUNFTu1aQmHSFS9Yyvyq+Ib4AC2uxZUgBoZisieL8kRY4Cd
	 1vo3B2TAhrZAbJGQf2O1Ym1R90FfnukXULoSzyuGJWvtIaiwW7Nd9QfLel05AZc+zjqGu
	 ze2wcGODXrz2Q9fv3SzXwERT67jis67GBhs4HtGM32v7fpSb9j8Dnb3ImsDWmA8fsg8Ye
	 wKD0QU2Hm16fcxcrR/D1NXvQHlOr/QyDiTVUjB53nAly5WO7tAIyn6jAmFWPohorYQuSq
	 MyZ72QJzYK2cNe9w7RbgCjvtsqFTfN17jIybkIYNdJU4m08/wlaT+DLeV4XvS9p6i4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794707931;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=srAD8PPZ4srEw/Uq0xx9Uj89tYV0STJH0kyoiq2DVq8=;
	b=CcxdPJJ21es6bGxZwOIeJ/ABSg13EbBqC7DB8UdFsAAlrOLxyX24DuYNQfGc7mxAIY/V
	 HoRZlTu3Etlt4wNiO7RBZzSmT44aeVPi5Pj0/DjrPfJDnhY1Lha7ouPYIcPbyWLMPkuFH
	 wIVW089gTN4fzmy8ZEbx4B21/tjdv0Gtn9sWLxSCdn3YA7KhDxXUDK4SAN9RywlmxvpSN
	 pYidKkrZCnwqlktOwKsvZ8NdxxGhf3tCLEr0T/ds+af6KcuFhuFOvTQPIcudychjpd/sV
	 7W7kulu6QryAWmrXllDwAfmSqvy35vUKAVlH3V+DPLIgvbJxdeAysM18oDsBqBUJFCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ps09aw3y;
	arc=none smtp.remote-ip=95.215.58.146
Received: from mta1.migadu.com (out-146.mta1.migadu.com [95.215.58.146])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCB606A329
	for <linux-block@vger.kernel.org>; Sun, 15 Nov 2026 01:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBCB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Ps09aw3y
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eTjIcgvdBir3T/bQuE1dRMvws9vjJWnMC9oUB5q5fmE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794707928; v=1; x=1795312728;
 b=Ps09aw3yTeS8cxTFh4CogmdsiEqlTAuAj7oS0FeNfbZQu9dT2lfTwKYDcc/QsUZB4PLJCimM
 /vklJa8sInkyMDvksJXXaXkr3qk46rk5K0fGkV2DMBUbpGDb244NroJDKuV6b84OcIrmwZKOQMI
 f1jozr4U85dEeq4z1vwJjRs8=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 87fa3ca848fad161;
	Sun, 15 Nov 2026 01:58:48 +0000
X-Mizu-Trace-ID: 87fa3ca848fad161
X-Migadu-Flow: FLOW_OUT
From: Qiliang Yuan <qiliang.yuan@linux.dev>
Date: Sat, 14 Nov 2026 20:58:32 -0500
Subject: [PATCH v2 1/2] block: don't request a module for the none elevator
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
Message-Id: <20261114-bug-block-elevator-unchanged-v2-1-5a1fe7d72fa0@linux.dev>
References: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
In-Reply-To: <20261114-bug-block-elevator-unchanged-v2-0-5a1fe7d72fa0@linux.dev>
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

