Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D2C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19781610FB
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 06:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238241AbhHRGGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 02:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbhHRGG3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 02:06:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4895C0617AD
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:53 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nt11so1954827pjb.2
        for <linux-block@vger.kernel.org>; Tue, 17 Aug 2021 23:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4cKFwd96rtgoKUA6YKX4IuNE9lx/g0UxBcz1pPF338=;
        b=XMP/StYU8/uLPb/wnRLBGcR3u0V44//53QV0+x1LgHJ11cZUCGD0IAf1IdZ9lDwoLp
         ZWOz/05bmRXmG9lRDJTD/ZXWTRiCTSdo0A6fczMhmhv2vGilaJvHGHdE7jf23BYsCSiQ
         dajYZnjb8/arsD8ARG/qxbTWVP2y2RLAspLSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4cKFwd96rtgoKUA6YKX4IuNE9lx/g0UxBcz1pPF338=;
        b=lS31q3oh1MffTRGgJ7TjhEd/UYcRx2I2WHTOBHehEjbm2OvuFzlYs8nRHf0ZYrl61+
         DSid+AL0+nz9cIziWLS0rmbqNQvVVlxqDuPexRBOPbFJy/tPlX+EuVF34xuc7CCC0iLg
         rsnJytsWeKp3OwRkJt+0Vusn6ZlmHy2L1QOAXHz2W/ixYr/WBO7W6shSOzWIqXqg9AWT
         Ue7p5Cg2lqnbklIASzPNRiwj1xj3hb5ivMjFFqKU617ghAQmbuJK2/5HK7oEI4pX652F
         PX1vVVKQ/oly0LFk6vExjDWKLotTfV/ZQrUf9AYpXFjyYGOuQVlPWgdM4IAIqV/lUx+K
         SXcw==
X-Gm-Message-State: AOAM532d7J83pDW3DdaGfvr9YR3yCIZb0OFP6PzK2behXDscM/rELsSd
        lBLIWlQ8q84+PTz+YWo2wVpMTA==
X-Google-Smtp-Source: ABdhPJzh3Fos81jJQtXdS+gHGD3Ay4RQaFm6BN3MlQDNgQinKTKzGT7YEaeNTn6TT/NjBcYzUiAE7g==
X-Received: by 2002:a17:90a:c244:: with SMTP id d4mr7684531pjx.38.1629266753333;
        Tue, 17 Aug 2021 23:05:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j4sm5379890pgi.6.2021.08.17.23.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:05:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: [PATCH v2 03/63] rpmsg: glink: Replace strncpy() with strscpy_pad()
Date:   Tue, 17 Aug 2021 23:04:33 -0700
Message-Id: <20210818060533.3569517-4-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818060533.3569517-1-keescook@chromium.org>
References: <20210818060533.3569517-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189; h=from:subject; bh=zEHqpi3jCPJJtimsK7NnbA6EWwLoFKP9r9dL5ArZyiQ=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhHKMe8xrKEUyyynWY+9ZZnkpsPM1eYEwBqySCGW3z U2JTvZSJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYRyjHgAKCRCJcvTf3G3AJsNcD/ 9XTm0UNtLhF3pcJlIGQ3OBX+21oX4i3rCVVUF6tE46BnLDEeTE53Dgx2PT3pmkaqnzHQEBiWdAf3D+ 2ibPEIWXlwbj/FEpJcA5DcOhIfEfnzVBjHhlpnJrh3SUlVbIH9XtzFjtsdZ62/6vRCWqqArv25gvTH 5vxwJnbsrBQoJVmDrGhqBbXkHwDMfTU3uqjDwaqLe+Jkddl6WDrvL7HDi/a/O+TPG8Ryye+tkF8oUf ynPS+GUMYS16FY7ASzH/0ByS7HnPSf7jbXyCDl9CItMWBCukRuP92dgD5E5h+780QjYVR1TOYTsK7L 29q0KYIRAz/CU7s7NU3I6O+skA8+wO2q8V/qNN9IwIYlovEae8xYxtZGFKS7Asnkx5L41BTHNAewGa ywsnWka4jG//fkzAcJxqaWp/LNz7YIf4ftOs7TahiCUUPyNjn9hGBXe/6UCbulNetUvkUh3MpYNLgO 29/PcVY/jHQm6XmFOLai05ukoMYzOImxjihjBRnvhun0ISzdDvZiF7LuyX34tnTNoUqw0tPYmoyzzS qwS895l/S/Iu0aJ6C60OCVKPU+rRZE7aqmw0H4xtsS4EhelVEbtCx+EFSZg6NR+iqtNBvI80hwpi2k l928h0W2SY4eY/GnEj658aM4Rs5DKGjtsLy4poujBDA8Ehq211Zk9Xhct33g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The use of strncpy() is considered deprecated for NUL-terminated
strings[1]. Replace strncpy() with strscpy_pad() (as it seems this case
expects the NUL padding to fill the allocation following the flexible
array). This additionally silences a warning seen when building under
-Warray-bounds:

./include/linux/fortify-string.h:38:30: warning: '__builtin_strncpy' offset 24 from the object at '__mptr' is out of the bounds of referenced subobject 'data' with type 'u8[]' {aka 'unsigned char[]'} at offset 24 [-Warray-bounds]
   38 | #define __underlying_strncpy __builtin_strncpy
      |                              ^
./include/linux/fortify-string.h:50:9: note: in expansion of macro '__underlying_strncpy'
   50 |  return __underlying_strncpy(p, q, size);
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/rpmsg/qcom_glink_native.c: In function 'qcom_glink_work':
drivers/rpmsg/qcom_glink_native.c:36:5: note: subobject 'data' declared here
   36 |  u8 data[];
      |     ^~~~

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Link: https://lore.kernel.org/lkml/20210728020745.GB35706@embeddedor
---
 drivers/rpmsg/qcom_glink_native.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 05533c71b10e..c7b9de655080 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1440,7 +1440,7 @@ static int qcom_glink_rx_open(struct qcom_glink *glink, unsigned int rcid,
 		}
 
 		rpdev->ept = &channel->ept;
-		strncpy(rpdev->id.name, name, RPMSG_NAME_SIZE);
+		strscpy_pad(rpdev->id.name, name, RPMSG_NAME_SIZE);
 		rpdev->src = RPMSG_ADDR_ANY;
 		rpdev->dst = RPMSG_ADDR_ANY;
 		rpdev->ops = &glink_device_ops;
-- 
2.30.2

