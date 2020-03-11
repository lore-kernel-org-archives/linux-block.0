Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by archive.lwn.net (Postfix) with ESMTP id 23A247E28E
	for <lwn-linux-block@archive.lwn.net>; Wed, 11 Mar 2020 16:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730257AbgCKQN0 (ORCPT <rfc822;lwn-linux-block@archive.lwn.net>);
        Wed, 11 Mar 2020 12:13:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37782 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgCKQNZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 12:13:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id a141so2794295wme.2
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 09:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I3kVX6++L7kNCPOrYtHpas6ehZhq6nwdW2vZ3hL5it4=;
        b=B8ipCE+6QkSWWTG+L84+Yqpt3OvqzkyF+JD3sYvqXEGIgHaaVTM1Eua1drz9fIGPr+
         z1ngIjh/htbPBUF7MacH82Gqv+XDMTOhI3JSCZHrFblbL5dapGth3jysP1OndAPq3xcF
         I1bhP4pw6SIwTUSDeLtpO4RixRhAZCbJ0n7vq0upwLrAA1AQOt+E+tUWgKrIg0UWJrQ5
         3JeRXGhKt4MJ4JKUWIR8k3U4i938DDfGrNRW1sx8Tks53PAGNP3PEPgmnNU9ffLRas+y
         UbZ6rQWaVOgbD5/4Oewyw478Q990HXPFlJaHxsulYHJkPCA6bnXxNG4VsDCbOw1jxs59
         zQ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I3kVX6++L7kNCPOrYtHpas6ehZhq6nwdW2vZ3hL5it4=;
        b=Xa2zoInL5oGaPo8IWXHj1hPKI7dyryBpRJYQa/XUP6rIUbR/+/Nhq6SZXf31D2r2rX
         0k8mAnDlXB1s4z+15+fPQo4QuqBwE/y83hH9lLrweqsW1OAYJEFRpwO8AbK7kI27HsJf
         8dvI5Os32ojp8qasDMP4ty9g3V5HOMrLBJ/+Ph1ItrBFkvF9lrHySlKcQqSZx0IP+p7M
         Ab5TYIx+dIOze+TuYFUHad22rc9koJmKm2B1ZD8sfQRfmd0LEQMgi8CEvel5cXLJnZgv
         cve6IMBlQ/DzPW9cLp4IVqNyUvsFVmdqJgkQGQEqePfOUnawW1gIa3Bk8iI3CyBmCgiO
         O6sg==
X-Gm-Message-State: ANhLgQ1EVbj9lUe6lwGtD8I1J2Kxf0DX/aVi/nvUQLLtjPjzYJ7jmd51
        2UzZsfDvqa1SlR5veedemnNbxHgIuow=
X-Google-Smtp-Source: ADFU+vuBFTsiSi2bo+ig0p9N51VSTkp196wL0slmxG7E5TQFb051rum8rRnMBBaBrdg/h0AgnSRGUg==
X-Received: by 2002:a05:600c:278a:: with SMTP id l10mr4228930wma.45.1583943202306;
        Wed, 11 Mar 2020 09:13:22 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4963:f600:4938:8f65:9543:5ec9])
        by smtp.gmail.com with ESMTPSA id v13sm2739332wru.47.2020.03.11.09.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 09:13:21 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v10 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Wed, 11 Mar 2020 17:12:40 +0100
Message-Id: <20200311161240.30190-27-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
References: <20200311161240.30190-1-jinpu.wang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Archived-At: <http://archive.lwn.net:8080/linux-block/20200311161240.30190-27-jinpu.wang@cloud.ionos.com/>
List-Archive: <http://archive.lwn.net:8080/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6fbdf354d34..f65067d4a34e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14286,6 +14286,13 @@ F:	arch/riscv/
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
@@ -14427,6 +14434,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
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

