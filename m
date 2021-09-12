Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A80C433EF
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 12:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E198604E9
	for <linux-block@archiver.kernel.org>; Sun, 12 Sep 2021 12:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhILMFV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Sep 2021 08:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229635AbhILMFV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Sep 2021 08:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631448246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wEJckPZrYm83PmRL1SySj+1NRWEYHMFBXCvgyFe5hiM=;
        b=IXoUCBpS98dzLVGdxLu61zfk+219RjuulN+/OK0dUZd4FIxeEkKe7FV7qe12o09p1QfW0S
        GiX+iFsTWSrlZWlKGOHX11FGHuZa5lFj17KvGhJG5zcsXIbFzhAvxbEXwrOhYPV6wTG5UA
        HAHYlz5crUM+7SFB+y8vSD7YNoWL8qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-vxSeOV9UOWK08LLX91Yr0g-1; Sun, 12 Sep 2021 08:04:01 -0400
X-MC-Unique: vxSeOV9UOWK08LLX91Yr0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE7D91084683;
        Sun, 12 Sep 2021 12:03:59 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (unknown [10.66.61.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9455C1D1;
        Sun, 12 Sep 2021 12:03:57 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     bvanassche@acm.org, osandov@osandov.com
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH blktests] nvmeof-mp/001: fix failure when CONFIG_NVME_HWMON enabled
Date:   Sun, 12 Sep 2021 20:03:36 +0800
Message-Id: <20210912120336.6035-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Skip checking ng0n1/hwmon5 in count_devices

$ use_siw=1  ./check nvmeof-mp/001
nvmeof-mp/001 (Log in and log out)                           [failed]
    runtime  3.695s  ...  4.002s
    --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
    +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
    @@ -1,3 +1,3 @@
     Configured NVMe target driver
    -count_devices(): 1 <> 1
    +count_devices(): 3 <> 1
     Passed
$ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvmeof-mp/001 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
index 69f1e24..3c3e8d5 100755
--- a/tests/nvmeof-mp/001
+++ b/tests/nvmeof-mp/001
@@ -11,6 +11,7 @@ count_devices() {
 	local d devs=0
 
 	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
+		[[ "$d" =~ hwmon[0-9]|ng[0-9]n[0-9] ]] && continue
 		[ -d "$d" ] && ((devs++))
 	done
 	echo "$devs"
-- 
2.21.3

