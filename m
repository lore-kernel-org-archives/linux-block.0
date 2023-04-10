Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D3AC77B76
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 18:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjDJSHX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 14:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjDJSHR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 14:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1184B271E
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681149982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ddb11bpE10RLPxQ5OZMNM1/VWI/36T+YPvgCbdN/u2Y=;
        b=E3oNpdbuUgOkVuhl/ZXDURdllCrMs+x6m4ZlZhhVRgCeL8u3rl5ZPFGuQTCxR0Pcl2Tzn1
        VplhpDw3qKHO38wZfVtTZnwvfIDfioQagH/4Xf1Ol65eHx+uV0EiYK3QeD6k+g62a+m/+X
        KTS2+TSzOAWHkYRyk5kr813Yid1Udec=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-T0XEX0X8OPiz08rsUql4tQ-1; Mon, 10 Apr 2023 14:06:19 -0400
X-MC-Unique: T0XEX0X8OPiz08rsUql4tQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 103D52A59577;
        Mon, 10 Apr 2023 18:06:19 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55AFB492C13;
        Mon, 10 Apr 2023 18:06:18 +0000 (UTC)
From:   Eric Blake <eblake@redhat.com>
To:     josef@toxicpanda.com, linux-block@vger.kernel.org,
        nbd@other.debian.org
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] docs nbd: userspace NBD now favors github over sourceforge
Date:   Mon, 10 Apr 2023 13:06:11 -0500
Message-Id: <20230410180611.1051618-5-eblake@redhat.com>
In-Reply-To: <20230410180611.1051618-1-eblake@redhat.com>
References: <20230410180611.1051618-1-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

While the sourceforge site for userspace NBD still exists, the code
repository moved to github several years ago.  Then with a recent
patch[1], the github landing page contains just as much information as
the sourceforge page, so we might as well point to a single location
that also provides the code.

[1] https://lists.debian.org/nbd/2023/03/msg00051.html

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>

---
v2: split into its own patch
---
 Documentation/admin-guide/blockdev/nbd.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/blockdev/nbd.rst b/Documentation/admin-guide/blockdev/nbd.rst
index d78dfe559dcf..faf2ac4b1509 100644
--- a/Documentation/admin-guide/blockdev/nbd.rst
+++ b/Documentation/admin-guide/blockdev/nbd.rst
@@ -14,7 +14,7 @@ to borrow disk space from another computer.
 Unlike NFS, it is possible to put any filesystem on it, etc.

 For more information, or to download the nbd-client and nbd-server
-tools, go to http://nbd.sf.net/.
+tools, go to https://github.com/NetworkBlockDevice/nbd.

 The nbd kernel module need only be installed on the client
 system, as the nbd-server is completely in userspace. In fact,
-- 
2.39.2

