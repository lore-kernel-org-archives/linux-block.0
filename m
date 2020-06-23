Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6371AC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3078C2078E
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 22:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592949797;
	bh=Bvq9D0O/hhO4RfjRIqep/CpdeImt0qPBseiaBGu+0C4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=c+AaTC4vQ+7539gwq/E9vdAR3HMd0u7pARuL/Eo1hshJPm/HvCUK4tN0ezYpwfIcl
	 DInaahB9WWPE28TG8z+LfwExshQgVvmTirpwtaXqZTsIUwkI0NHqc4/csFp0FqId+o
	 S+iwKoguZD2UvPJlEbQMd/R0ZMHUNx1Naw53O57A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbgFWWDQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:03:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56176 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387602AbgFWWDQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 18:03:16 -0400
Received: by mail-pj1-f67.google.com with SMTP id ne5so51497pjb.5;
        Tue, 23 Jun 2020 15:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zr2cbrFuPDxTuDeglx6Y4wt+neydmKrKJZF2csCmx64=;
        b=hmAUj42uQk8tLlAvcBkbicizeJjO6NBuk3HK9btTnaEOaOh1UrvSvV3Mk0bHfa5UHc
         TppFgHY3KfC6Ts//m0AUYOE5TI0LfMYEZN0NWEcV3fQ1bGIbVDm3rUJ9xP8EpbbouH+k
         HREKIlt7RyspUGGe70c/tIr85MKk/yy+DzM5IMt9DiPC5u0Q28xhurpfVuxO31jXCkix
         W72P11QwI9/ZbmSz9DvrWy1Q7/ol1WCZTtUQWn0X6SGYlIxvT2jqZH/8GMa8EMA8cUW5
         moxqIJP6V7kFmI3wYOvMAYapfqkBTH0Y4Z1+I9WbMbpmDaJFyWQRf/4WgXJwE3EMlZ09
         JWsA==
X-Gm-Message-State: AOAM530WVWLhkEKUe+Y018BcpLZFLEfrRqshGJfx8robyi/QKbg89d32
        cvXc3YJ5NgviMG+59NtSwwk=
X-Google-Smtp-Source: ABdhPJxtt5Pir2cVgspMhA/MbZOePvLcVnPr3V93XKYtegNa4j6/08YrGhW1wAtceAEXLw9OA4alYQ==
X-Received: by 2002:a17:902:7403:: with SMTP id g3mr23759989pll.342.1592949795184;
        Tue, 23 Jun 2020 15:03:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id k7sm18088717pfp.84.2020.06.23.15.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:03:13 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id C5E4440430; Tue, 23 Jun 2020 22:03:12 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, damien.lemoal@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, martin.petersen@oracle.com, satyat@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 0/2] block: kdocify the request_queue
Date:   Tue, 23 Jun 2020 22:03:09 +0000
Message-Id: <20200623220311.8033-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart suggested we add docs for the degugfs_mutex, while at it I noticed
we don't have a nice way to add docs for members of the request_queue so
I figured I'd add one as I drive by.

Come bike shed with me.

Luis Chamberlain (2):
  block: add initial kdoc over the request_queue
  block: move request_queue member docs to kdoc

 include/linux/blkdev.h | 159 ++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 99 deletions(-)

-- 
2.26.2

