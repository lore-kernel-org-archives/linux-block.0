Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C0C4332E
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741D82051A
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 12:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="Mv6lV69/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCTMRp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:17:45 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36029 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCTMRo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 08:17:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so1173753wrs.3
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv6Nv+6LJBnq5DZKchYhL0m3LA+Tdn3F16jhKKXecEw=;
        b=Mv6lV69/HzDcrtQzHRO16E3I9XP32B1cCujWesi6N2q4oDmZd48HiqUSEu3jI/ZLy0
         GJYW2/v8nCRjVttHdXZUdYzx2+JJScGHCQ8/uZQQI6qQrb531shZvYpbkLpbUHQYAwP7
         NmPHNFx/15c45oHcKL8qUbIOjcnYiwIYnLWe5HVelM895rLvQzU3vYiSFb0O/Q8Drjda
         AOjO6sbThXWo85I5n9Fauo6zKYBoG8KnoaYVdh4pzcm0sADeyGQVr5EjvivX5qAVWdmp
         ZSxbOLUBxRt7nQHo/xY4T+HHLe64lhoptvn1gsJ/9Xdj/Zv37Juj7xikKdIB+aq+DbjS
         b8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nv6Nv+6LJBnq5DZKchYhL0m3LA+Tdn3F16jhKKXecEw=;
        b=K/kmuZvN7PHJFdvzXpBZWQs+//obsCzm17fv0zSlT7Id1cJ9+t617HJpyItc8zmdN9
         W78RVoYDRFCfCSKPdZWHJlV9z+yCf2bi3PLsWECW0jK5ftyWGLBrN381E0m/UEz9QecW
         4p2ywrAzh6xtVp5RNML1ptRpvcFuItryhMzuxWi4BgYscxqaKHta6jjFOao5TfHciMSt
         tzfU3mV/0UFlKWTFou2qYX+Em/NChYQ3nWVLVSzghTFbcmaIvu5fZ3OxegfEx3yB7Yb0
         QBBT30aJnTxSRY3MRF9ju9qYsLYF70d5/aHIOrlv4+gV1X6yWCVx/9QhM0AhsgyPjo7f
         63mA==
X-Gm-Message-State: ANhLgQ1QiQN2cILzNdX7YUVOKi+N54MnNbUWhrsp8FXUjtDF0GqbEwHc
        NoWusBgWxb1LmD0CcJAMtw5DP3fBQxk=
X-Google-Smtp-Source: ADFU+vs8A8qMkFr+lNLox6jkgMkXOhVEFI/rz47VpAGKJiDi2bpBTpA5OdLchMJ866tsx6VlH08Y8g==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr10388762wrt.89.1584706660967;
        Fri, 20 Mar 2020 05:17:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Fri, 20 Mar 2020 13:16:57 +0100
Message-Id: <20200320121657.1165-27-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18cb5d18..9aa45cf61088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14284,6 +14284,13 @@ F:	arch/riscv/
 K:	riscv
 N:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 W:	http://sourceforge.net/projects/roccat/
@@ -14425,6 +14432,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.17.1

