Return-Path: <SRS0=i0oD=EB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9751CC388F9
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689B720829
	for <linux-block@archiver.kernel.org>; Mon, 26 Oct 2020 21:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603749056;
	bh=Ce6Z/v4C/uHsQ5uIPnR5h2yHOXb4YAK05bn+Jpyu/R4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Js+q6ovYRwa3aR0Br6r4MeA+1kecVgbM20uwlt3cIDibuN2a4kHthgjTLsu3TtSRw
	 60Zm+g+bRYqhtgf6k5Ibms/a5dfgKfJVyDhnjQopFCMJokiDPV8XJWAQPTgIF/P80T
	 IFaDo6RbKa8ddM6WaPL+xC1xFPg3u6Uo0njbXCpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390850AbgJZVuw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 17:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390765AbgJZVuv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 17:50:51 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0BDD207F7;
        Mon, 26 Oct 2020 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603749050;
        bh=Ce6Z/v4C/uHsQ5uIPnR5h2yHOXb4YAK05bn+Jpyu/R4=;
        h=From:To:Cc:Subject:Date:From;
        b=YKh7GKQOTqTowF0V35OFfN6eL/TeNp6jOkDzKl6IjFTUXMol3IVKkD9L5A2Ui1ue7
         iZJjT+tg+1mdcCWp/9vgP8ClqXf+Tha/Q2fKiRo+dejnm9IfnzcCBa0Ay8V4Xlsf6u
         kAUfDe/OUbOE7y1aHxM2w0JQYjO3I7e8WWRSg+OY=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>, Coly Li <colyli@suse.de>,
        David Sterba <dsterba@suse.com>,
        Jackie Liu <liuyun01@kylinos.cn>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drbd: fix duplicate array initializer
Date:   Mon, 26 Oct 2020 22:50:33 +0100
Message-Id: <20201026215043.3893318-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are two initializers for P_RETRY_WRITE:

drivers/block/drbd/drbd_main.c:3676:22: warning: initialized field overwritten [-Woverride-init]

Remove the first one since it was already ignored by the compiler
and reorder the list to match the enum definition. As P_ZEROES had
no entry, add that one instead.

Fixes: 036b17eaab93 ("drbd: Receiving part for the PROTOCOL_UPDATE packet")
Fixes: f31e583aa2c2 ("drbd: introduce P_ZEROES (REQ_OP_WRITE_ZEROES on the "wire")")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/block/drbd/drbd_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 65b95aef8dbc..6102efbe57ab 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -3628,9 +3628,8 @@ const char *cmdname(enum drbd_packet cmd)
 	 * when we want to support more than
 	 * one PRO_VERSION */
 	static const char *cmdnames[] = {
+
 		[P_DATA]	        = "Data",
-		[P_WSAME]	        = "WriteSame",
-		[P_TRIM]	        = "Trim",
 		[P_DATA_REPLY]	        = "DataReply",
 		[P_RS_DATA_REPLY]	= "RSDataReply",
 		[P_BARRIER]	        = "Barrier",
@@ -3641,7 +3640,6 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_DATA_REQUEST]	= "DataRequest",
 		[P_RS_DATA_REQUEST]     = "RSDataRequest",
 		[P_SYNC_PARAM]	        = "SyncParam",
-		[P_SYNC_PARAM89]	= "SyncParam89",
 		[P_PROTOCOL]            = "ReportProtocol",
 		[P_UUIDS]	        = "ReportUUIDs",
 		[P_SIZES]	        = "ReportSizes",
@@ -3649,6 +3647,7 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_SYNC_UUID]           = "ReportSyncUUID",
 		[P_AUTH_CHALLENGE]      = "AuthChallenge",
 		[P_AUTH_RESPONSE]	= "AuthResponse",
+		[P_STATE_CHG_REQ]       = "StateChgRequest",
 		[P_PING]		= "Ping",
 		[P_PING_ACK]	        = "PingAck",
 		[P_RECV_ACK]	        = "RecvAck",
@@ -3659,24 +3658,26 @@ const char *cmdname(enum drbd_packet cmd)
 		[P_NEG_DREPLY]	        = "NegDReply",
 		[P_NEG_RS_DREPLY]	= "NegRSDReply",
 		[P_BARRIER_ACK]	        = "BarrierAck",
-		[P_STATE_CHG_REQ]       = "StateChgRequest",
 		[P_STATE_CHG_REPLY]     = "StateChgReply",
 		[P_OV_REQUEST]          = "OVRequest",
 		[P_OV_REPLY]            = "OVReply",
 		[P_OV_RESULT]           = "OVResult",
 		[P_CSUM_RS_REQUEST]     = "CsumRSRequest",
 		[P_RS_IS_IN_SYNC]	= "CsumRSIsInSync",
+		[P_SYNC_PARAM89]	= "SyncParam89",
 		[P_COMPRESSED_BITMAP]   = "CBitmap",
 		[P_DELAY_PROBE]         = "DelayProbe",
 		[P_OUT_OF_SYNC]		= "OutOfSync",
-		[P_RETRY_WRITE]		= "RetryWrite",
 		[P_RS_CANCEL]		= "RSCancel",
 		[P_CONN_ST_CHG_REQ]	= "conn_st_chg_req",
 		[P_CONN_ST_CHG_REPLY]	= "conn_st_chg_reply",
 		[P_RETRY_WRITE]		= "retry_write",
 		[P_PROTOCOL_UPDATE]	= "protocol_update",
+		[P_TRIM]	        = "Trim",
 		[P_RS_THIN_REQ]         = "rs_thin_req",
 		[P_RS_DEALLOCATED]      = "rs_deallocated",
+		[P_WSAME]	        = "WriteSame",
+		[P_ZEROES]		= "Zeroes",
 
 		/* enum drbd_packet, but not commands - obsoleted flags:
 		 *	P_MAY_IGNORE
-- 
2.27.0

