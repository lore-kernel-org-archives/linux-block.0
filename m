Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC32EE14D4
	for <linux-block@archiver.kernel.org>; Thu,  7 Sep 2023 03:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237024AbjIGDpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 23:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjIGDpj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 23:45:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A70CE6
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 20:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694058283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpk/JLwGOs1eIjILox3z19SNd6kr3FuL2TFM0S4zDCQ=;
        b=Udd8JOXHNqheW3TaU/M74vMO1NFrC60zd0yziVbOa1ILDJfeedKnSleBnIjWIxGC+kTItw
        SqCAlf1EZtSQbMHUKXrLQWkmuL257tk0N1sFuS6c/Byk8ci33QjuaMOD3hrEGLp6/maop8
        +ATUrtuQQChXwfHGKCcvT4a9h5KboRY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-uByImZJyOSSBhsRwCKBLRQ-1; Wed, 06 Sep 2023 23:44:39 -0400
X-MC-Unique: uByImZJyOSSBhsRwCKBLRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 749D838149AE;
        Thu,  7 Sep 2023 03:44:39 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 99F0B21EE56A;
        Thu,  7 Sep 2023 03:44:37 +0000 (UTC)
From:   Yi Zhang <yi.zhang@redhat.com>
To:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     shinichiro.kawasaki@wdc.com, dwagner@suse.de
Subject: [PATCH blktests] tests/nvme/031: fix connecting faiure
Date:   Thu,  7 Sep 2023 11:44:23 +0800
Message-Id: <20230907034423.3928010-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

allow_any_host was disabled during _create_nvmet_subsystem, call
_create_nvmet_host before connecting to allow the host to connect.

[76096.420586] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[76096.440595] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[76096.491344] nvmet: connect by host nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 for subsystem blktests-subsystem-0 not allowed
[76096.505049] nvme nvme2: Connect for subsystem blktests-subsystem-0 is not allowed, hostnqn: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
[76096.519609] nvme nvme2: failed to connect queue: 0 ret=16772

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/031 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/031 b/tests/nvme/031
index d5c2561..696db2d 100755
--- a/tests/nvme/031
+++ b/tests/nvme/031
@@ -42,10 +42,12 @@ test() {
 	for ((i = 0; i < iterations; i++)); do
 		_create_nvmet_subsystem "${subsys}$i" "${loop_dev}"
 		_add_nvmet_subsys_to_port "${port}" "${subsys}$i"
+		_create_nvmet_host "${subsys}$i" "${def_hostnqn}"
 		_nvme_connect_subsys "${nvme_trtype}" "${subsys}$i"
 		_nvme_disconnect_subsys "${subsys}$i" >> "${FULL}" 2>&1
 		_remove_nvmet_subsystem_from_port "${port}" "${subsys}$i"
 		_remove_nvmet_subsystem "${subsys}$i"
+		_remove_nvmet_host "${def_hostnqn}"
 	done
 
 	_remove_nvmet_port "${port}"
-- 
2.34.3

