Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84ECC43215
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DDC20708
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 06:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403390;
	bh=ZKAtWUsN0FqEAoJtA7XbheslHWVtULPIZOm3hQjh9nA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AXEZZaIrOiB95dmrRoZnRX5cUgoE8g45jkGzXw2twIEW4HBIRD4er0OecuMaAhXa2
	 Qozaqm5No1q00zedpjfanEXKmdXXwgrnCGgiEe2r4p28dvvk4Y8z7G3ggjH88XjaR8
	 AaJcrvMf1qcaoihySTqXXsQ9iciFA/gYyX3Xja5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729499AbfKVGNw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:13:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:51326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbfKVGNw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 743842071C;
        Fri, 22 Nov 2019 06:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403231;
        bh=ZKAtWUsN0FqEAoJtA7XbheslHWVtULPIZOm3hQjh9nA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vHift0Qs0tJbq2rRq4SCRtrg82znDRSK3Ouey/3+3b8FJiiH9IISkJ9LKhqc9bNXy
         I6N5jiP9/YltENrKoJ5DKDqT2kPM054TFy6estp+zwvz3CksjjsA72pLuUSHRE5ule
         tXWfEMKd5W3N6ezxPIGMYXrT1PgknEwO/xjiDfcw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Roland Kammerer <roland.kammerer@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 44/68] drbd: fix print_st_err()'s prototype to match the definition
Date:   Fri, 22 Nov 2019 01:12:37 -0500
Message-Id: <20191122061301.4947-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit 2c38f035117331eb78d0504843c79ea7c7fabf37 ]

print_st_err() is defined with its 4th argument taking an
'enum drbd_state_rv' but its prototype use an int for it.

Fix this by using 'enum drbd_state_rv' in the prototype too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/drbd/drbd_state.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_state.h b/drivers/block/drbd/drbd_state.h
index 7f53c40823cd5..75219cd2534aa 100644
--- a/drivers/block/drbd/drbd_state.h
+++ b/drivers/block/drbd/drbd_state.h
@@ -126,7 +126,7 @@ extern enum drbd_state_rv __drbd_set_state(struct drbd_device *, union drbd_stat
 					   enum chg_state_flags,
 					   struct completion *done);
 extern void print_st_err(struct drbd_device *, union drbd_state,
-			union drbd_state, int);
+			union drbd_state, enum drbd_state_rv);
 
 enum drbd_state_rv
 _conn_request_state(struct drbd_connection *connection, union drbd_state mask, union drbd_state val,
-- 
2.20.1

