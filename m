Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A301F09A1;
	Tue,  1 Apr 2025 11:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.216.63.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506521; cv=none; b=Zfs9kyCF3G6GWnZ/BbHljIlDg2oybAMS8YqGLeb+blMwiJ88frN+LaDAKJkIDBwkA8cjrmvxMiu70PrRgcEUeVr4zCc9s7YJebmzHSb21TPiFpNlBunc70dIuoewlvBjqRJjlWGkl8Ei4F7lrvKb6+Fi9ucS/RG5Psa5GfOZjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506521; c=relaxed/simple;
	bh=cHaN8SO4B2c1NSsrSJnbOuQP90QVINkhPBnrv48jD5o=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Yn6it3LDb1kNli4hikN1JTVjwtzTtwiYPIjiQTVqldntLJ4M/yc3peWYelRzuxfVf0TKbh84si4f3dO0X1XDELkJ4bjO4tycZRmjGKgTcF6S+iCWgqlTtV3qFnSbvyPP+A42q3v+g0hZk9hpwtuWB/JNueQgTQ2LXhZE7ajExG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=63.216.63.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4ZRlvL137sz5B1L5;
	Tue,  1 Apr 2025 19:21:50 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 531BLaWB075046;
	Tue, 1 Apr 2025 19:21:36 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 1 Apr 2025 19:21:39 +0800 (CST)
Date: Tue, 1 Apr 2025 19:21:39 +0800 (CST)
X-Zmail-TransId: 2afb67ebcc43ffffffff9c2-81950
X-Mailer: Zmail v1.0
Message-ID: <20250401192139605xby4g5ak51tei46zArAT8@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <geoff@infradead.org>
Cc: <axboe@kernel.dk>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
        <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
        <naveen@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yang.yang29@zte.com.cn>, <xu.xin16@zte.com.cn>,
        <ye.xingchen@zte.com.cn>, <feng.wei8@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBibG9jazogcHMzZGlzazogVXNlIHN0cl9yZWFkX3dyaXRlKCkgaGVscGVy?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 531BLaWB075046
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 67EBCC4E.000/4ZRlvL137sz5B1L5

From: Feng Wei <feng.wei8@zte.com.cn>

Remove hard-coded strings by using the str_read_write() helper.

Signed-off-by: Feng Wei <feng.wei8@zte.com.cn>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
 drivers/block/ps3disk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index dc9e4a14b885..b7fe90b6fdef 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -9,6 +9,7 @@
 #include <linux/ata.h>
 #include <linux/blk-mq.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/module.h>

 #include <asm/lv1call.h>
@@ -233,7 +234,7 @@ static irqreturn_t ps3disk_interrupt(int irq, void *data)
 		op = "flush";
 	} else {
 		read = !rq_data_dir(req);
-		op = read ? "read" : "write";
+		op = str_read_write(read);
 	}
 	if (status) {
 		dev_dbg(&dev->sbd.core, "%s:%u: %s failed 0x%llx\n", __func__,
-- 
2.25.1
