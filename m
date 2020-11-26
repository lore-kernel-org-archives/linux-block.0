Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A389C64E7A
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 302B320DD4
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 10:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="CnWoSEng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgKZKrb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 05:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388340AbgKZKra (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 05:47:30 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64A5C0613D4
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:29 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y4so1776276edy.5
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2020 02:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X8yu13oIh/JXch52+JZCHnrSj26jPVrm5ONB1ko1hmI=;
        b=CnWoSEngNJgDdzaaG4hLtojTeGeo/LNkJ6HhOvHH7dd2xUmOUxcuw8dsptvfWLGDdN
         d0tyitpMpSZyzOOQm4L+bb7q54i5Nd5xc8/+qbfu5vMbfJhrCQf6dSz+4wKvQCZrkAtb
         2WZQkYv+/bwd0WvZC7ztw1kQR7mp7ghIOXJ90+UGmGcijusMvd61MNMfqrGjjkhuwr6E
         91T/e/h3rCNB86PbJWNmOQbjUMjAU+g5fsC2I9qAgyQ89KoVaZZEVOYQcTPdpZblmyCc
         evytewJEgi1UfqpunNWqLsCw+xlyM35smdPH7qBngo7Om6fW8brdtElFbImlPfdBssLD
         9b0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X8yu13oIh/JXch52+JZCHnrSj26jPVrm5ONB1ko1hmI=;
        b=FZV1ZGF/R6rR42LRRowwKVJ3+AyOyWXOypRNeeqglqSUBW2/SRJ9u9F95fJJ2ndZmk
         YNQoemxdR/qCpeZoZnjG1M0+T1nKv47HGbVyk9JXuILzErqxuKwqK544e7hnYAj6xZ4S
         wC1/OXNfa8q2lrwgDfxVrksjcJq7+oB4Z4zhtmMmjkPdpZERzmPZ5z5ShdwcvlEo80wC
         xhHg6QvS87Q+vFd1ISUeEeo2WPOBWZheFv7DxJpi9ZqiaDiFDuG0NHiCS1zOzBtCQefR
         5iVH4/D7xJFq1elWCKhfN7Iqa+1gHoSnij/74x4+u6dqW4kuN9GK+8FTWddMK2h1I51l
         +ybw==
X-Gm-Message-State: AOAM533nayBbfmjntOaUKU9GTyuDU1t16I4oTXsjrdPap60S2uJcKtX/
        HEAcZViO/iBmCpEKmJ4xJyuu4UKmX8LgWA==
X-Google-Smtp-Source: ABdhPJwuFBL2g1I02Q62kidqcObfxhPUEeEohUJHmcwE2kWifTRNBp1Qmu5ZoP5+LlHcLq072AACvg==
X-Received: by 2002:a50:f30f:: with SMTP id p15mr1984602edm.4.1606387648435;
        Thu, 26 Nov 2020 02:47:28 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4961:8400:6960:35a2:747a:e0ad])
        by smtp.gmail.com with ESMTPSA id f19sm2910053edm.70.2020.11.26.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 02:47:28 -0800 (PST)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, danil.kipnis@cloud.ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>
Subject: [PATCH for-next 4/8] Documentation/ABI/rnbd-clt: session name is appended to the device path
Date:   Thu, 26 Nov 2020 11:47:19 +0100
Message-Id: <20201126104723.150674-5-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
References: <20201126104723.150674-1-jinpu.wang@cloud.ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

When mapping a device,
/sys/devices/virtual/rnbd-client/ctl/devices/<device_id> was created.
But we found out that it had a problem when mapping the same file
on different servers. So we append the session name after the
device_id as below.
/sys/devices/virtual/rnbd-client/ctl/devices/<device_id>@<session_name>

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/ABI/testing/sysfs-class-rnbd-client | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-rnbd-client b/Documentation/ABI/testing/sysfs-class-rnbd-client
index ca3267b81886..2aa05b3e348e 100644
--- a/Documentation/ABI/testing/sysfs-class-rnbd-client
+++ b/Documentation/ABI/testing/sysfs-class-rnbd-client
@@ -95,12 +95,12 @@ Description:	Expected format is the following::
 		---------------------------------
 
 		After mapping, the device file can be found by:
-		o  The symlink /sys/class/rnbd-client/ctl/devices/<device_id>
+		o  The symlink /sys/class/rnbd-client/ctl/devices/<device_id>@<session_name>
 		points to /sys/block/<dev-name>. The last part of the symlink destination
 		is the same as the device name.  By extracting the last part of the
 		path the path to the device /dev/<dev-name> can be build.
 
-		* /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<device_id>/dev)
+		* /dev/block/$(cat /sys/class/rnbd-client/ctl/devices/<device_id>@<session_name>/dev)
 
 		How to find the <device_id> of the device is described on the next
 		section.
@@ -110,7 +110,7 @@ Date:		Feb 2020
 KernelVersion:	5.7
 Contact:	Jack Wang <jinpu.wang@cloud.ionos.com> Danil Kipnis <danil.kipnis@cloud.ionos.com>
 Description:	For each device mapped on the client a new symbolic link is created as
-		/sys/class/rnbd-client/ctl/devices/<device_id>, which points
+		/sys/class/rnbd-client/ctl/devices/<device_id>@<session_name>, which points
 		to the block device created by rnbd (/sys/block/rnbd<N>/).
 		The <device_id> of each device is created as follows:
 
-- 
2.25.1

