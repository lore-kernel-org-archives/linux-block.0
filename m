Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA7C3F2D0
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58624672
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQTDDFpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1Gl1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:41:27 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54517 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1Gl1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 01:41:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id dw13so875180pjb.4
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2020 22:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RF9tXMqH5IFSvwyrzV693N167Q3mcb3XDjDmX8n/l+E=;
        b=KQTDDFpHSHmpDIPiKbs4TzJOJx+6dAWvbnj+Rg1PyDP4scHKyf/xJYaOqyy8SUPKPB
         28HUg3iIE4RQ2vkjATGHaf2tSlKZWTOk6JehugMSvNYvfZvyWvzr2ZW4+lBPHS3gQAdV
         SecH3GKUq0Mbvlzyek6eFFv2x9hTEmTUI4O5nX7yhckqwzrua2Vjw9+GGtDT/eRhxsJP
         7EkwUejQamgZMP7KmRFSP5/mFXRxMSk+fZgO+nmLQFODkC+TWxm0IOcUPrhmomXj9gTQ
         DawBWANcCS+6i2CerR0Ev2zNQ+hfWi4qvlirWw/naeTZu18eymcdetytOMkjomGDydeS
         DKiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RF9tXMqH5IFSvwyrzV693N167Q3mcb3XDjDmX8n/l+E=;
        b=AX3nGvgG7DFWR4rWqm+niM/gSHDchhTKtzuaXcj63aOFBTC8IllAHkbuNk2rPMC3GG
         RZrCpiEsXGyBBmudw8B+UeF4IQaB4yIufn0fZnw74ZVXSj9EdAZd7Gpiq01m7t0O1YAg
         Oi7Do+Ez+5Pry/C+y0XAg4xxrJPenoOiAxUSjuqZX4I9/HdknHb4fMePeed33Rsp94Cw
         dHNVCojwa9TmMB00oBr3WcV0CRHV9n4GVj4tlgtSGjV0HTeJwzgD5VUIL1KEixUpjVWz
         /R4VI2pMCqsOfLQSXFuzy+JzlfCCMGvkCu45ohPxh6D791z27iRn4evbH4W+ynag++uO
         iqXA==
X-Gm-Message-State: APjAAAWLRrdWmLAoMD/hj43nqVrBwybxNyzJJJUgnDDNbRcfjoAfrb+V
        DfSqPY0RQFraIL8V9cS9LsXUZKbhcpk=
X-Google-Smtp-Source: APXvYqwXBTa1NPLOXOdv9XMJL4+pbLl1KOa6hlBD5UBlROn2h81/lQxvm867u3Bhnix41a0Eythb7w==
X-Received: by 2002:a17:902:bf49:: with SMTP id u9mr2634575pls.199.1582872084386;
        Thu, 27 Feb 2020 22:41:24 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id w11sm9420707pfn.4.2020.02.27.22.41.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:41:23 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 0/2] nbd: requeue request if only one connection is configured
Date:   Fri, 28 Feb 2020 01:40:28 -0500
Message-Id: <20200228064030.16780-1-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

NBD server could be upgraded if we have multiple connections.
But if we have only one connection, after we take down NBD server,
all inflight IO could finally timeout and return error. These
patches fix this using current reconfiguration framework.

I noticed that Mike has following patchset

nbd: local daemon restart support
https://lore.kernel.org/linux-block/5DD41C49.3080209@redhat.com/

It add another netlink interface (NBD_ATTR_SWAP_SOCKETS) and requeue
request immediately after recongirure/swap socket. It do not need to
wait for timeout to fire and requeue in timeout handler, which seems more
like an improvement. Let fix this in current framework first.

Changes compared to v2:
Fix comments in nbd_read_stat() to be aligned with the code change
suggested by Mike Christie.

Hou Pu (2):
  nbd: enable replace socket if only one connection is configured
  nbd: requeue command if the soecket is changed

 drivers/block/nbd.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

-- 
2.11.0

