Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5BB44AB7C;
	Fri,  4 Sep 2026 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514568; cv=none; b=WuvGiBZBxYX6fhxFkrFO5+PeIVmpwqokWcDPU7JDAZzlJkmAl1rRB395jvSKfNWYi7x/2jfmTaiWdpf3UC4exqMsodpZlpwCLZIpVwlAI853QPptAfJTdV4EK15W4911H4Lm4YV+ygpEDo65fj9pF5XOdGjgr7wjSnxLLNrCPMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514568; c=relaxed/simple;
	bh=2fO1Nem8psV2BkjGVjYicEG3JCcCuYnNeeWE91GQ7rU=;
	h=To:Cc:Message-ID:In-Reply-To:References:From:Subject:Date; b=M+jC3mACRkIlWaG13SX7kfcmNDtXa1aUOBTc9j23z2jiu5CLl9S20A9JlLHgchWaMQqqpGiA5ktEvdSrEiBNgzLUxTi9alzR7FnuOmX5G98ZikRmT9W7DWA2BLEn40oYkC6gBsiw1dfxXopHaElP0OhlFaLul1xDCjJn1OeUq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVSu3bD2; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVSu3bD2"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 87174EC01F3;
	Fri,  4 Sep 2026 05:36:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Sep 2026 05:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
	:feedback-id:from:from:in-reply-to:in-reply-to:message-id
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788514565; x=
	1788600965; bh=Tho79OsiO2FJWFdgFU+2neNMuP7dJTkpAAbGMDaxns4=; b=i
	VSu3bD2lLSQAPfqtO/7+wNjjzQNNyFTKz2tQwQNrLfTu3yLkVz0h+rWHn3XvCkEG
	1f8qAAnW5nlzHOoKsklOLeSvpsNS47tVvGfbW87iYZfvKKo9EppjuUNCTwLRtQum
	f34411Sxk3mv9kkkvQo1v9wb3NzmzKCt0vsMgTnk9OLk/3BCLCnCDNdtbimMdHZs
	ZtfKBymkrGXaw1Kwr7g31np6ILWlK0eAadO9ECk7fUGONRJ2nfQrJYhZ0f3ewXPh
	bKcmWK+lAJqOFmYty+OpmYYD8aVEAAg6cLChz5p26wCmWKXgChbQctw7Hwlew0EK
	YO1CuCzvMAi/hCK998SoA==
X-ME-Sender: <xms:BZGaaiDhvfAj8HQbN5UZic979xOv6X5fGgxiUNvVvkBC-aUMLK2EWA>
    <xme:BZGaamn66LRiJzmoZk5RU7tAgv_zYw9KNLqRioyXwWxxfwEL-8hCME69SdTxpIjh2
    QRC_Ltb2uzFYYjrA5i9xcsd_LdfhpmdvI_3BnIXkSCI-og7-EFzCOSf>
X-ME-Received: <xmr:BZGaaldQ07IDx26WMwRh5VPAYViC6JX-uggLugwq_TQGjCZik_pIiqfsLrybtG0RjItDWoVdtQdjNOddAK2ccizQOW1i5nw-9sk>
X-ME-Proxy-Cause: dmFkZTG2k577uDIDfm5jzfBdETCuanfOTnt5vT+Axih7bVvGSgJDBPpJ+GL/LXsHcgEpZ4
    RC5KHYugI5UaHe6JFYpb4bXBM0FxyLRXOp/X9d5ZOg2Ly58fUO0/OmbwN5cHbLu9sehiqM
    h9MCdGCEJIsgdXf7qX9gR0srfmKNBjWG3Pz0rJGyFDbc7ny0QDgWCsea9K/QVXVwC+WQn1
    /WeYxYu0ujQ+4f7Q6s/BX5WsAHenyiVIakVPqBf8IDrqgnLyqGQRmDhTpKk+gBytK587fb
    RwBpCQY2ZiVruSNCs9KFw8IIZZm1rG9teq5nrbmN6dPQfYZgmVhHgDAJ7hJABVwoGYNPlm
    +3r5vSHxFe5gJ8HuHqY7TnykzX9qYUTISmY30td35xU5S1ME1R7UKyrL0ivYxnss+/r0MF
    3PkDzy5ZllCqCJUKrfshDV/o9he0cauH9FO1LE7Jh6P+ABWEpKLxO30O2TmQmlglJJ2pUW
    EUTTL1x5TCjuO4GCAzBBweH394Zv7cCsQrVfDppKNWwQCC07lhq1c0AO/yyzALe0kfAe8x
    atQfAMA4GVzAmHvDaefxvfMN+72N7SURd0OQVouO1ALhR/RrCYbJ54DDi6MmmgFo/6d0pg
    /UZVVbTkcCBAnrnesIQHbxIhXVP4HGweU/Bs45SyWBYEhbE2FCXlLTLGvFFw
X-ME-Proxy: <xmx:BZGaaiRaxA6NTg0zb9s8sT5l6Ev9-A0oVysI-xghe3LTA5lwgovSvw>
    <xmx:BZGaakt3U5c2d-MGpa3kXmYIPsViI6Qt4NVhWT-UHpBy4wsIvBqzbg>
    <xmx:BZGaardKxOOMvcDSZHfVEmHV1Qya7ELit7V6uAvAG72g2JFtdCy0IQ>
    <xmx:BZGaambIphCkeLh0cEpPvf4ygiDspRGtrpXmvrKa2rBkPIEZAqcaBA>
    <xmx:BZGaaqy6Yd0Ry9tLE0281HJsLSntsRslD5JNEc_IyZPJHgs8KVjSk-DH>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 05:36:03 -0400 (EDT)
To: Jens Axboe <axboe@kernel.dk>,
    Laurent Vivier <laurent@vivier.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
    Joshua Thompson <funaho@jurai.org>,
    linux-block@vger.kernel.org,
    linux-m68k@lists.linux-m68k.org,
    linux-kernel@vger.kernel.org
Message-ID: <082b79a3f2fa2ff5df9b51c582e01a8e47444613.1788513997.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1788513996.git.fthain@linux-m68k.org>
References: <cover.1788513996.git.fthain@linux-m68k.org>
From: Finn Thain <fthain@linux-m68k.org>
Subject: [PATCH v3 28/33] swim: Add some helpful references
Date: Fri, 04 Sep 2026 19:26:36 +1000
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>

These documents relate to the IWM, ISM, SWIM 1, 2, 3 and associated
disk drives. No functional change.

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Finn Thain <fthain@linux-m68k.org>
---
 drivers/block/swim.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/swim.c b/drivers/block/swim.c
index f249b96339d8..3b8acaa21787 100644
--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -8,6 +8,14 @@
  * based on SWIM3 driver (c) Paul Mackerras, 1996
  * based on netBSD IWM driver (c) 1997, 1998 Hauke Fath.
  *
+ * See also:
+ * Inside Macintosh, vol. III, ch. 2
+ * https://archive.org/details/SWIMDesignDocs
+ * NEC uPD72070 FDC datasheet
+ * mkLinux source file swimiiicommonhal.c
+ * http://www.mac.linux-m68k.org/devel/iwm.php.html
+ * MAME source file sonydriv.cpp
+ *
  * 2004-08-21 (lv) - Initial implementation
  * 2008-10-30 (lv) - Port to 2.6
  */
-- 
2.52.0

