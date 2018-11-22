Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA03C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F4020645
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 01:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tVRurzzq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24F4020645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391637AbeKVMdX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:33:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40866 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391620AbeKVMdV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 07:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3rSmEbWASuu7gOOPl+jW7pAMMn1ZzI7tK94ts+5UhSc=; b=tVRurzzqri3+t6n/oNr8mpGSx
        1pg8zyQWL+J3kT1wFwQE7aNFK7x4BvcpYrVblbyOZSszUUnPoBfOfMSkJf6WKlsB+UqTAcWdHnxr/
        VW5KXRIQvEaLmjmeOG9vFU1vKU/BU5jhbcCqkTohIfxFtG4lZYS5tdkVNMdZgopQf7KY5hbh/6MHA
        Lb0Q/IBu0emchvfsKgh1eOT9DhPvmu0ZsYqj6BKJdzZA0HHgU1uLa+TAd1M+1N9vXflUcDnssGcFf
        a3dE7IJZ8EfIpmuyrKodJ8AvV9ojzE3vG/86C6Ji6IOqu7OF02l45EPGtgnb6/OwzM56Gp2ZcN09q
        i/8q71XvA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gPeE5-0006v0-QX; Thu, 22 Nov 2018 01:56:17 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 01/13] ath6kl: add ath6kl_ prefix to crypto_type
Date:   Wed, 21 Nov 2018 17:55:59 -0800
Message-Id: <20181122015615.15763-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Prevent a namespace conflict as in following patches as skbuff.h will
include the crypto API.

Cc: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sagi Grimberg <sagi@lightbitslabs.com>
---
 drivers/net/wireless/ath/ath6kl/cfg80211.c | 2 +-
 drivers/net/wireless/ath/ath6kl/common.h   | 2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      | 6 +++---
 drivers/net/wireless/ath/ath6kl/wmi.h      | 6 +++---
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
index e121187f371f..fa049c4ae315 100644
--- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
+++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
@@ -1322,7 +1322,7 @@ static int ath6kl_cfg80211_set_default_key(struct wiphy *wiphy,
 	struct ath6kl_vif *vif = netdev_priv(ndev);
 	struct ath6kl_key *key = NULL;
 	u8 key_usage;
-	enum crypto_type key_type = NONE_CRYPT;
+	enum ath6kl_crypto_type key_type = NONE_CRYPT;
 
 	ath6kl_dbg(ATH6KL_DBG_WLAN_CFG, "%s: index %d\n", __func__, key_index);
 
diff --git a/drivers/net/wireless/ath/ath6kl/common.h b/drivers/net/wireless/ath/ath6kl/common.h
index 4f82e8632d37..d6e5234f67a1 100644
--- a/drivers/net/wireless/ath/ath6kl/common.h
+++ b/drivers/net/wireless/ath/ath6kl/common.h
@@ -67,7 +67,7 @@ struct ath6kl_llc_snap_hdr {
 	__be16 eth_type;
 } __packed;
 
-enum crypto_type {
+enum ath6kl_crypto_type {
 	NONE_CRYPT          = 0x01,
 	WEP_CRYPT           = 0x02,
 	TKIP_CRYPT          = 0x04,
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 777acc564ac9..9d7ac1ab2d02 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -1849,9 +1849,9 @@ int ath6kl_wmi_connect_cmd(struct wmi *wmi, u8 if_idx,
 			   enum network_type nw_type,
 			   enum dot11_auth_mode dot11_auth_mode,
 			   enum auth_mode auth_mode,
-			   enum crypto_type pairwise_crypto,
+			   enum ath6kl_crypto_type pairwise_crypto,
 			   u8 pairwise_crypto_len,
-			   enum crypto_type group_crypto,
+			   enum ath6kl_crypto_type group_crypto,
 			   u8 group_crypto_len, int ssid_len, u8 *ssid,
 			   u8 *bssid, u16 channel, u32 ctrl_flags,
 			   u8 nw_subtype)
@@ -2301,7 +2301,7 @@ int ath6kl_wmi_disctimeout_cmd(struct wmi *wmi, u8 if_idx, u8 timeout)
 }
 
 int ath6kl_wmi_addkey_cmd(struct wmi *wmi, u8 if_idx, u8 key_index,
-			  enum crypto_type key_type,
+			  enum ath6kl_crypto_type key_type,
 			  u8 key_usage, u8 key_len,
 			  u8 *key_rsc, unsigned int key_rsc_len,
 			  u8 *key_material,
diff --git a/drivers/net/wireless/ath/ath6kl/wmi.h b/drivers/net/wireless/ath/ath6kl/wmi.h
index a60bb49fe920..784940ba4c90 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.h
+++ b/drivers/net/wireless/ath/ath6kl/wmi.h
@@ -2556,9 +2556,9 @@ int ath6kl_wmi_connect_cmd(struct wmi *wmi, u8 if_idx,
 			   enum network_type nw_type,
 			   enum dot11_auth_mode dot11_auth_mode,
 			   enum auth_mode auth_mode,
-			   enum crypto_type pairwise_crypto,
+			   enum ath6kl_crypto_type pairwise_crypto,
 			   u8 pairwise_crypto_len,
-			   enum crypto_type group_crypto,
+			   enum ath6kl_crypto_type group_crypto,
 			   u8 group_crypto_len, int ssid_len, u8 *ssid,
 			   u8 *bssid, u16 channel, u32 ctrl_flags,
 			   u8 nw_subtype);
@@ -2610,7 +2610,7 @@ int ath6kl_wmi_config_debug_module_cmd(struct wmi *wmi, u32 valid, u32 config);
 
 int ath6kl_wmi_get_stats_cmd(struct wmi *wmi, u8 if_idx);
 int ath6kl_wmi_addkey_cmd(struct wmi *wmi, u8 if_idx, u8 key_index,
-			  enum crypto_type key_type,
+			  enum ath6kl_crypto_type key_type,
 			  u8 key_usage, u8 key_len,
 			  u8 *key_rsc, unsigned int key_rsc_len,
 			  u8 *key_material,
-- 
2.17.1

