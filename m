Return-Path: <SRS0=CiZa=NZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468DEC43441
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 113B1214F1
	for <linux-block@archiver.kernel.org>; Wed, 14 Nov 2018 19:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V5wyySP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113B1214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeKOFoS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:44:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46589 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFoR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 00:44:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id t13so5290971ply.13
        for <linux-block@vger.kernel.org>; Wed, 14 Nov 2018 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G/Y5lp9QbfVD1h8Q3c10aUq3gCyj1b6nDnsXbcW1OzQ=;
        b=V5wyySP+N+88Iomzwr0NVrgnj93+y1JgdF+M0oByzIxjQQxd7RSfPYpOGzkic8oneB
         YMvEWP2lfBDdnjRsOLva3cj94VJwOEZ6+JDeoH8E7uZITQXgA7KaThfUpPMlGKQvm4Uy
         GfMLV62yV1weKG1BK8CfC8uocA0ZYr925GzMynXcaOECu5A4FHDIY8Nd4TMp2kVJb5wg
         SxRThr12WTk69dEXLNlXxGoVUTWMq5yCDyyflJVsQqDBChD3kFEyRaBPgTTgB6HEi0S+
         S7l/Zg3dYMEoPeu97/QwmSfDy+EQrnPFHaEWQubueiMBP6+q4JrAX+2fUiMObS6JGJ6e
         ZDAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=G/Y5lp9QbfVD1h8Q3c10aUq3gCyj1b6nDnsXbcW1OzQ=;
        b=HgNGVrKDv0D75eIE2RtLarti5/Y6VodGoM23w+n2qkx1BT0+8PkQjHdYw8gjia50KX
         EMUyhDNiFZ9WwetAd43F2PunY9AmOjkmhhqfzmP11+n+eyifO8LNHkQG57TQYFuy6J7f
         nyYOU9pdB+iAzhM/x7UxaOUnGTYj7oJfiylxp9xlag1FiyJKxCEEdiAiCo8ypBBSssA6
         czlzTsxdpeB+/bJCVXXyDw5ZcHR0JOYbiqsfRliCBYLHdp13VXFIoVYxpLlLZY0LjZsJ
         9dHXdWE2BYf3WYtTFsEVt8svHVGSwS+3v128NJ83LZdiUMtk//QKL1BJp+PJ5Z5sRD03
         eHbA==
X-Gm-Message-State: AGRZ1gIFrwnPAZU9lqy71WSIloL84EE6UFElmaLBZ8n9hnUpDJtAs8KK
        fs6LtyVRliFfKP9Oh3Lg1uWy4Q==
X-Google-Smtp-Source: AJdET5fY84KKGZSNyl7HYjJ/fw0wPxBPcwjQtzxM81+yFi+Wmrev/IkG70ra4jl0Gb1vGmyp5948XQ==
X-Received: by 2002:a17:902:5a03:: with SMTP id q3-v6mr3269560pli.186.1542224383784;
        Wed, 14 Nov 2018 11:39:43 -0800 (PST)
Received: from gwendal.mtv.corp.google.com ([2620:15c:202:1:3c8f:512b:3522:dfaf])
        by smtp.gmail.com with ESMTPSA id q11-v6sm22984060pgp.62.2018.11.14.11.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 Nov 2018 11:39:42 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     osandov@osandov.com
Cc:     osandov@fb.com, linux-block@vger.kernel.org
Subject: [PATCH v2] makefile: Add install rule
Date:   Wed, 14 Nov 2018 11:39:31 -0800
Message-Id: <20181114193931.90009-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <CAPUE2uuGz5qOZ0aFVsuATPqt3XCtmj_nSd0rE44wpihRPzkskA@mail.gmail.com>
References: <CAPUE2uuGz5qOZ0aFVsuATPqt3XCtmj_nSd0rE44wpihRPzkskA@mail.gmail.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add rule to install to a target directory, /usr/local/blktests by
default.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Makefile     | 11 ++++++++++-
 README.md    |  3 +++
 src/Makefile |  6 +++++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 38b8ad1..9793a2d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,9 +1,18 @@
+prefix ?= /usr/local
+dest = $(DESTDIR)$(prefix)/blktests
+
 all:
 	$(MAKE) -C src all
 
 clean:
 	$(MAKE) -C src clean
 
+install:
+	install -m755 -d $(dest)
+	install check $(dest)
+	cp -R tests common $(dest)
+	$(MAKE) -C src dest=$(dest)/src install
+
 # SC2119: "Use foo "$@" if function's $1 should mean script's $1". False
 # positives on helpers like _init_scsi_debug.
 SHELLCHECK_EXCLUDE := SC2119
@@ -13,4 +22,4 @@ check:
 		tests/*/rc tests/*/[0-9]*[0-9]
 	! grep TODO tests/*/rc tests/*/[0-9]*[0-9]
 
-.PHONY: all check
+.PHONY: all check install
diff --git a/README.md b/README.md
index be55aba..7967569 100644
--- a/README.md
+++ b/README.md
@@ -22,6 +22,9 @@ Some tests require the following:
 - multipath-tools (Debian, openSUSE) or device-mapper-multipath (Fedora)
 - dmsetup (Debian) or device-mapper (Fedora, openSUSE, Arch Linux)
 
+Build blktests with `make install`. Optionally, install it to a known location
+with `make install`, `/usr/local/blktests` by default.
+
 Add the list of block devices you want to test on in a file named `config`:
 
 ```sh
diff --git a/src/Makefile b/src/Makefile
index 15c1022..b2bd321 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -20,10 +20,14 @@ all: $(TARGETS)
 clean:
 	rm -f $(TARGETS)
 
+install: $(TARGETS)
+	install -m755 -d $(dest)
+	install $(TARGETS) $(dest)
+
 $(C_TARGETS): %: %.c
 	$(CC) $(CPPFLAGS) $(CFLAGS) -o $@ $^
 
 $(CXX_TARGETS): %: %.cpp
 	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
 
-.PHONY: all clean
+.PHONY: all clean install
-- 
2.18.1

