Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E3FC25B0D
	for <linux-block@archiver.kernel.org>; Tue, 16 Aug 2022 04:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiHPEGp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiHPEGO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Aug 2022 00:06:14 -0400
X-Greylist: delayed 307 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 17:35:00 PDT
Received: from relay0-g.mailbaby.net (relay0-g.mailbaby.net [64.20.38.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2653529A7
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 17:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbaby.net;
 q=dns/txt; s=bambino; bh=BnHG3QU6jJwX/8OJ6Jd7Q8OIQOixrdiHvQtNUiv/Yqs=;
 h=from:subject:date:message-id:to:mime-version:content-type:content-transfer-encoding;
 b=MjcAW7STTvwBTczSkgpf3BMNTJJTr41AkoAmWLsdRdAMN+eudigDqk2yFYrFDzeMdMDNyn4Rj
 hAzmnjfIcLI7XAJzb1cCbD5LkGB+zvvGKRiXiQXjvAe/R71b+AWr4wnVzuzROnlxTW9QOKSa5yf
 qRcm+7TJ3hB22SN2dIZXZro=
Received: from webhosting2008.is.cc ([174.138.177.194] webhosting2008.is.cc)
 (Authenticated sender: webhosting2008)
 by relay0-g.mailbaby.net (InterServerMTA) with ESMTPSA id 182a40e16d7000c5c4.001
 for <linux-block@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Tue, 16 Aug 2022 00:29:23 +0000
X-Zone-Loop: dd1672773688220c99811696430ae1b0b33c5dcdeec3
ARC-Authentication-Results: i=1;        rspamd4.mailbaby.net;   auth=pass
 smtp.auth=webhosting2008 smtp.mailfrom=alec@onelabs.com
ARC-Seal: i=1; s=detka; d=mailbaby.net; t=1660609763; a=rsa-sha256;
        cv=none;
        b=AofTmjx1f3UDtyEiisXwcYTtRin7/wq4RJH2HEaGCj18jbxySrztKGr3dsA6hXrB/GRd0V
        LxBs1NLSx5sZIYTC+hRHdqOq668RIL3MGZbYqe+UNV1+y3T41xFGzbFSAFKTeRv/GJ7zQp
        Uht7QXfnmfXNcBQNXhORoUirZ0Fv1rDVRt/YLD9ilFtd3KkGq5I/RydkLmc3ctS10YPbYf
        sc4Qi3qsLXUQdwHgWvQP8PIirAnRGJLJ18qh+PudXtxjcd5louT7tZqMsQewhd+JQLnb44
        alaovjsLdd5y6iVFqaKuClUM1i6LY+eATKzhmVsQDK7rZg9PiyyBe8hiOFzqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbaby.net;        s=detka; t=1660609763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=BnHG3QU6jJwX/8OJ6Jd7Q8OIQOixrdiHvQtNUiv/Yqs=;
        b=jP7EhPQfBp2Svv44lig4JLjN8EUgg05ze6Ofh+r+STkm/t1QgT49ztZ8Y3EgJJSI9p4RLO
        IB6OYrV4WqsWQUN4hvw0+rk8j2xj33x8LF/DiOgiWD/QS9RmL13MjRtRe/X3MfdtRiUybu
        0OIWAeE4DhWaxws+qI6oDua1dJe9sujDQuGS+pch3HALOs69n3QEBHad++8NULZNJtbawi
        xoPxyFxhVvLdxDiN72wAdSMUD+IDbxF5TmxfUVqNT2NsdNUodg7sYPOojhn76XnXOihnqs
        4l6LYMpR5S/IFT952V/VFAYcOtMwYxRbb1DPsMbzqtYX680vZHx96335Y528Wg==
X-SPF:  pass
X-Originating-IP: [174.138.177.194]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=onelabs.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:To:
        From:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=BnHG3QU6jJwX/8OJ6Jd7Q8OIQOixrdiHvQtNUiv/Yqs=; b=x/EKsD75geJsztUislulhGo/62
        h6HjVX4fw6+Ln0frzVQNfLSAfnGV4c8bv22znxG9CWRKz8vOjPWtbkxyMfuj0WNOMT/Xr5pjnn6C0
        ShQvLLdPajWvxhfAFCYpeOCXp2WBC7XiVrQz4hujR8TU303raHkKWC+V41844XbTEGsiED8pEkbEY
        h9LOQNTqPYuuwzuztQkAFV2WL5/WHERKafUMIQs+eqsVMxAH+GARKXPiy3IdL9Zu2pZy+dzYZjxvi
        QI6VeYOUzC6H6pxOn/vMy3A+zy/5WSoXdB1LEeb+nO6AlpMtfBjo32IwjbxsTMjrviAHo6JmIQ9Tk
        PaJyAzMg==;
Received: from [::1] (port=52270 helo=webhosting2008.is.cc)
        by webhosting2008.is.cc with esmtpa (Exim 4.95)
        (envelope-from <alec@onelabs.com>)
        id 1oNkSQ-00BXnB-BP;
        Mon, 15 Aug 2022 20:29:23 -0400
MIME-Version: 1.0
Date:   Mon, 15 Aug 2022 19:29:22 -0500
From:   Alec Ari <alec@onelabs.com>
To:     Linux Block <linux-block@vger.kernel.org>,
        Linux Config <linux-config@vger.kernel.org>
Subject: [PATCH] init/Kconfig: Preserve mtimes in initramfs only if
 BLK_DEV_INITRD
User-Agent: Roundcube Webmail/1.5.2
Message-ID: <520759aec345e48adf6348ef3acc5310@onelabs.com>
X-Sender: alec@onelabs.com
Organization: ONE Labs
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-From-Rewrite: unmodified, already matched
X-AuthUser: alec@onelabs.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

 From: Alec Ari <alec@onelabs.com>
Date: Mon, 15 Aug 2022 19:18:56 -0500
Subject: init/Kconfig: Preserve mtimes in initramfs only if 
BLK_DEV_INITRD

Would preserving mtimes in initramfs prove useful if
BLK_DEV_INITRD is disabled?

Signed-off-by: Alec Ari <alec@onelabs.com>
---
  init/Kconfig | 1 +
  1 file changed, 1 insertion(+)

diff --git a/init/Kconfig b/init/Kconfig
index 80fe60fa7..8322860a7 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1392,6 +1392,7 @@ config BOOT_CONFIG_EMBED_FILE

  config INITRAMFS_PRESERVE_MTIME
  	bool "Preserve cpio archive mtimes in initramfs"
+	depends on BLK_DEV_INITRD
  	default y
  	help
  	  Each entry in an initramfs cpio archive carries an mtime value. When
-- 
2.37.2

