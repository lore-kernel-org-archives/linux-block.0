Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361A0C43214
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D066101A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhHRGG2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238041AbhHRGG0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:06:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F34C061796
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:52 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x4so1141436pgh.1
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=23NqigPoreurbrTRI3DzstnCrCz1u9qo8AUicrCllIQ=;
        b=UbvCFEyRrZ9eZIo3hC/X1djDK0zyKbZ+dpC5E+yFQ4NxlkNH9dIRozkfEuSe7qJjsQ
         cxD/56o5spuj40J0Wg3fR6Wyk3fwk8hV9DWgzhqsRRVRBgGzTqUDfya1TW7GvmKLZ6wo
         D9xixUQS4qz6M4i5bzbYYLvrORORYZfKr8WPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=23NqigPoreurbrTRI3DzstnCrCz1u9qo8AUicrCllIQ=;
        b=ARp4yg/YnK5UJi3flHu/Sm8sdLrNeoFX7xTCuVo9wAXlP/T/Uny3ZN65x1o3e0aw19
         +ibWvAywms82ZTTBMfXt1rsV0oZMdz1Zn6OdO03IZh+se0tFvdgczftLlrhF9axEqixS
         xKdF6T3gydhy+lis4G7bkz8qvI4ofxruPmyOHQQYrpyw4wffM/283hmAQyKHNfkhcqC8
         pGIU9hMkDqpoOaw///l5NJcMYixf58ViVftS8uwv375xhK7cq/ULkIfpKnUxvpfY/FJ6
         UEupBjsOIh/Md3wKQB1VosX+OP7sIFDzwyNedDDCpWtug88x6W6Ur0vEJCA8YmLuSikN
         qMPw==
X-Gm-Message-State: AOAM531lYa4t43HtCuG4WbdPJhJjcv/vHrDdnQ4eVBaj/F9gXyaLl6xu
        UIbZ/OcXD7i+evuPLRUz14EsuA==
X-Google-Smtp-Source: ABdhPJylu+fvLjWopDWFH3olkAdKgN4Z9FIPk8JyyTRG5xBoS/mN6Ano8pbp8qiJIYenr0R5MuEjMA==
X-Received: by 2002:a05:6a00:16d2:b029:300:200b:6572 with SMTP id l18-20020a056a0016d2b0290300200b6572mr7570097pfc.62.1629266751598;
        Tue, 17 Aug 2021 23:05:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l6sm4585677pff.74.2021.08.17.23.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Stanislav Yakovlev <stas.yakovlev@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 01/63] ipw2x00: Avoid field-overflowing memcpy()
Date:   Tue, 17 Aug 2021 23:04:31 -0700
Message-Id: <20210818060533.3569517-2-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4716; h=from:subject; bh=3b5t4fLR/wEetR2E8Hwk2j3VzU8yz2BgAEsleqg3XAU=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMd3RE3VXLm1V4wHPPpY4uHLTNlH2i9cpT7/zcX 6bMNqjOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjHQAKCRCJcvTf3G3AJhpED/ 9b4pyd/DG5mv5Tblws3aMWZNDSeCRn3/s9TjbgOMXM4o11x/1+ZleM6Vk2EDLRI/StjZkH7suUShf9 pz8qPCLJYcMOnhXplowR65ecymaR26AWdAh+maUgxLzeDfaqIYCYeE1R/AQ0WwLm+5Exoa4ZI5WS0f rqmhbs0ehQFD4CZMRmfHfUrVstRDcMCvaGy4vJOILTRKBHVmbSZT9t4ZS26+G0Gn3/MfEpQl02c5VG giy+jakP/HC0SaKYh6fz0PynTwGctBrg0Jtrm+P5sBZ5LrYnPR4gQcC+zRGDLNvr9SJfvI3/F80g1h nBOlSrzvmz1/1UBqHvztStqbaaBG+fsJReRuAfOS4pPpyfoSreYc0FSty2WowsZKIQG4KRrFpPJq8y oyVcu4SpPwu0e+hpIT5XJ/ZlUJ3z+GSZyrMGUWADhlMLpd7MuTx1T01Z2DheK2fn7PAfCsewxY48vA klRgq5EmEm78Ws6wLDcon05s0EfYr4KarT1JdG+fV2JuY2Ks6lWjaiGXCMr3QOUuFt3P5lmt4vhwnj EdC/X6leqQSQ89oEFJBzrtCAV0vFOs8DxlHiDaWhg8+sGBq2zvBRy+rxcDyNI36k1pUC1aChW0369A Gf5WfOMa8Bm/SsspWmkkegUh+h5Z0fYmtTzn/GA0ekK/0u14dQxgyN2mEtFg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for FORTIFY_SOURCE performing compile-time and run-time
field bounds checking for memcpy(), memmove(), and memset(), avoid
intentionally writing across neighboring fields.

libipw_read_qos_param_element() copies a struct libipw_info_element
into a struct libipw_qos_information_element, but is actually wanting to
copy into the larger struct libipw_qos_parameter_info (the contents of
ac_params_record[] is later examined). Refactor the routine to perform
centralized checks, and copy the entire contents directly (since the id
and len members match the elementID and length members):

struct libipw_info_element {
        u8 id;
        u8 len;
        u8 data[];
} __packed;

struct libipw_qos_information_element {
        u8 elementID;
        u8 length;
        u8 qui[QOS_OUI_LEN];
        u8 qui_type;
        u8 qui_subtype;
        u8 version;
        u8 ac_info;
} __packed;

struct libipw_qos_parameter_info {
        struct libipw_qos_information_element info_element;
        u8 reserved;
        struct libipw_qos_ac_parameter ac_params_record[QOS_QUEUE_NUM];
} __packed;

Cc: Stanislav Yakovlev <stas.yakovlev@gmail.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../net/wireless/intel/ipw2x00/libipw_rx.c    | 56 ++++++-------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 5a2a723e480b..7a684b76f39b 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -927,7 +927,8 @@ static u8 qos_oui[QOS_OUI_LEN] = { 0x00, 0x50, 0xF2 };
 static int libipw_verify_qos_info(struct libipw_qos_information_element
 				     *info_element, int sub_type)
 {
-
+	if (info_element->elementID != QOS_ELEMENT_ID)
+		return -1;
 	if (info_element->qui_subtype != sub_type)
 		return -1;
 	if (memcmp(info_element->qui, qos_oui, QOS_OUI_LEN))
@@ -943,57 +944,34 @@ static int libipw_verify_qos_info(struct libipw_qos_information_element
 /*
  * Parse a QoS parameter element
  */
-static int libipw_read_qos_param_element(struct libipw_qos_parameter_info
-					    *element_param, struct libipw_info_element
-					    *info_element)
+static int libipw_read_qos_param_element(
+			struct libipw_qos_parameter_info *element_param,
+			struct libipw_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct libipw_qos_parameter_info) - 2;
+	size_t size = sizeof(*element_param);
 
-	if ((info_element == NULL) || (element_param == NULL))
+	if (!element_param || !info_element || info_element->len != size - 2)
 		return -1;
 
-	if (info_element->id == QOS_ELEMENT_ID && info_element->len == size) {
-		memcpy(element_param->info_element.qui, info_element->data,
-		       info_element->len);
-		element_param->info_element.elementID = info_element->id;
-		element_param->info_element.length = info_element->len;
-	} else
-		ret = -1;
-	if (ret == 0)
-		ret = libipw_verify_qos_info(&element_param->info_element,
-						QOS_OUI_PARAM_SUB_TYPE);
-	return ret;
+	memcpy(element_param, info_element, size);
+	return libipw_verify_qos_info(&element_param->info_element,
+				      QOS_OUI_PARAM_SUB_TYPE);
 }
 
 /*
  * Parse a QoS information element
  */
-static int libipw_read_qos_info_element(struct
-					   libipw_qos_information_element
-					   *element_info, struct libipw_info_element
-					   *info_element)
+static int libipw_read_qos_info_element(
+			struct libipw_qos_information_element *element_info,
+			struct libipw_info_element *info_element)
 {
-	int ret = 0;
-	u16 size = sizeof(struct libipw_qos_information_element) - 2;
+	size_t size = sizeof(struct libipw_qos_information_element) - 2;
 
-	if (element_info == NULL)
+	if (!element_info || !info_element || info_element->len != size - 2)
 		return -1;
-	if (info_element == NULL)
-		return -1;
-
-	if ((info_element->id == QOS_ELEMENT_ID) && (info_element->len == size)) {
-		memcpy(element_info->qui, info_element->data,
-		       info_element->len);
-		element_info->elementID = info_element->id;
-		element_info->length = info_element->len;
-	} else
-		ret = -1;
 
-	if (ret == 0)
-		ret = libipw_verify_qos_info(element_info,
-						QOS_OUI_INFO_SUB_TYPE);
-	return ret;
+	memcpy(element_info, info_element, size);
+	return libipw_verify_qos_info(element_info, QOS_OUI_INFO_SUB_TYPE);
 }
 
 /*
-- 
2.30.2

