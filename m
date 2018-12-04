Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0840DC04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C45AE2081C
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 01:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GdqlLdYz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45AE2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbeLDBwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:52:21 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeLDBwU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 20:52:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jgmQpcQxHuexRvCgG6/Z6h9I9dNDaDdFhYff8ArEdNg=; b=GdqlLdYz7B6B5hTlmJ1hjjWa8
        jM6WNXOoDcSgaS6BIOqCr7mQwODmezpmKU+c0cWdfiqzYY24hu5Hlcr7zgMxt68adxXlYjyzxGEMg
        ejfe1mGfvcMPhFJVp+9+jDngYBeYawd0vUJ+3UEx9QLssuckP3RB1J6xDXuPtQHS8yLr3HY0SAJ9V
        4GcfvfFh8yyWRwC3kFBIpmm+zfaCWii8XdiILYy4IcRcz5EsjCmbfhxzrjQwbDVfIti4P7Fv4RuO6
        /KX809nxPN3TNBA9FpIZV4Uz+U+Oj4YppRBEdMKnfHo+t1Cipup3SS/HO7wIASSWftuM9XJ3WAb2d
        Kr/UYDdBw==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gTzsp-0003Zq-OS; Tue, 04 Dec 2018 01:52:19 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v5 01/13] ath6kl: add ath6kl_ prefix to crypto_type
Date:   Mon,  3 Dec 2018 17:52:05 -0800
Message-Id: <20181204015217.16613-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204015217.16613-1-sagi@grimberg.me>
References: <20181204015217.16613-1-sagi@grimberg.me>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sagi Grimberg <sagi@lightbitslabs.com>

Prevent a namespace conflict as in following patches as skbuff.h will
include the crypto API.

Acked-by: David S. Miller <davem@davemloft.net>
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

