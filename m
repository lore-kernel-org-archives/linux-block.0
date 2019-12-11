Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAECC43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CAC82073B
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 04:24:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C44Wii17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfLKEYx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 23:24:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39096 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbfLKEYx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 23:24:53 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so8398699pjb.6;
        Tue, 10 Dec 2019 20:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCFfqgYBUHORRZAXz0u1t9CrHuOIZanYgjOuQc5MI40=;
        b=C44Wii177/uMXj8Mmpff75pIIpPmcFQwgaPEBWdhU7hQoVs+n+MJmNVNXMIXxLKrDW
         9edlLaBI8+4/iTI92+z4856xb/GnEtBWETNGkQoETSY1ukQfDLyf1VBC8KJYkxgqNnsy
         RToZcu66XFgKlic4ml2Myo0UmaR0d9p7fz0H3FFXyqx6cIbs6ak8F+6PaafLfnHpEndi
         VE2qIisgz8HptNV+CctKjKEmv1VgmuSPN/AzM+ZHKdr6OYdzt8J8iHX9wmiYNQ8Kd8eT
         9wBkfOh2n0qOb//QX1kgNqn6infiNH2mbzaHgYI6sAU7u1sGZ6T/ncUH97nJASNvkNMn
         +jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCFfqgYBUHORRZAXz0u1t9CrHuOIZanYgjOuQc5MI40=;
        b=UpBuo6q28rIaZT4kF7x6xcjSWcDgxBOSKlE2HKjBnOd3vXS9w7D2wgC0h//Cm2glAw
         EtNwwcWOVOEEyD0x3fvC62FYrtfr12urfE50Fz4WoQlCk4fcCYhp2egHbT23USxjyM/l
         TC/bChTdbXYkPn7RpTIQDFLEfaVWzWp7aoxX9nfSyI2FZ0q2nQIsqpHTteLR69UUo3mF
         A/oiuVmEx1oE68GwJI13/7blQ4YOAbN4hlZucfECH6/4zLyqBklUef2kCBGGCcbXtu94
         7Gf3hUAjnqwbNRTFl4NofMfpfn2WoGK6u3ZlvdE6HoWJ0NTH3ppEW4pKSaOfOAqNyEmk
         spjA==
X-Gm-Message-State: APjAAAUeBfPQiQ8NPErd5rE5JLRteF9dOqK6Lno1oxZ33i8zthk/ETAy
        cskCot+ypwRg8N/p7mG9UWc=
X-Google-Smtp-Source: APXvYqwuDHvHi0kuhv5k7XhTYVm0P1tUAaFRdqch3kOwlNDt+3YGwFscAsMaal2g+E/WWOX862OunA==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr1095998plp.54.1576038292830;
        Tue, 10 Dec 2019 20:24:52 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id z23sm586738pgj.43.2019.12.10.20.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 20:24:51 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     jgross@suse.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        roger.pau@citrix.com
Cc:     SeongJae Park <sjpark@amazon.de>, pdurrant@amazon.com,
        sjpark@amazon.com, xen-devel@lists.xenproject.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] xenbus/backend: Add a memory pressure handler callback
Date:   Wed, 11 Dec 2019 04:24:25 +0000
Message-Id: <20191211042428.5961-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Granting pages consumes backend system memory.  In systems configured
with insufficient spare memory for those pages, it can cause a memory
pressure situation.  However, finding the optimal amount of the spare
memory is challenging for large systems having dynamic resource
utilization patterns.  Also, such a static configuration might lack
flexibility.

To mitigate such problems, this patchset adds a memory reclaim callback
to 'xenbus_driver' (patch 1) and use it to mitigate the problem in
'xen-blkback' (patch 2).  The third patch is a trivial cleanup of
variable names.

Base Version
------------

This patch is based on v5.4.  A complete tree is also available at my
public git repo:
https://github.com/sjp38/linux/tree/blkback_squeezing_v6


Patch History
-------------

Changes from v5
(https://lore.kernel.org/linux-block/20191210080628.5264-1-sjpark@amazon.de/)
 - Wordsmith the commit messages (suggested by Roger Pau Monné)
 - Change the reclaim callback return type (suggested by Roger Pau Monné)
 - Change the type of the blkback squeeze duration variable
   (suggested by Roger Pau Monné)
 - Add a patch for removal of unnecessary static variable name prefixes
   (suggested by Roger Pau Monné)
 - Fix checkpatch.pl warnings

Changes from v4
(https://lore.kernel.org/xen-devel/20191209194305.20828-1-sjpark@amazon.com/)
 - Remove domain id parameter from the callback (suggested by Juergen Gross)
 - Rename xen-blkback module parameter (suggested by Stefan Nuernburger)

Changes from v3
(https://lore.kernel.org/xen-devel/20191209085839.21215-1-sjpark@amazon.com/)
 - Add general callback in xen_driver and use it (suggested by Juergen Gross)

Changes from v2
(https://lore.kernel.org/linux-block/af195033-23d5-38ed-b73b-f6e2e3b34541@amazon.com)
 - Rename the module parameter and variables for brevity
   (aggressive shrinking -> squeezing)

Changes from v1
(https://lore.kernel.org/xen-devel/20191204113419.2298-1-sjpark@amazon.com/)
 - Adjust the description to not use the term, `arbitrarily`
   (suggested by Paul Durrant)
 - Specify time unit of the duration in the parameter description,
   (suggested by Maximilian Heyne)
 - Change default aggressive shrinking duration from 1ms to 10ms
 - Merge two patches into one single patch

SeongJae Park (2):
  xenbus/backend: Add memory pressure handler callback
  xen/blkback: Squeeze page pools if a memory pressure is detected

 drivers/block/xen-blkback/blkback.c       | 23 +++++++++++++++--
 drivers/block/xen-blkback/common.h        |  1 +
 drivers/block/xen-blkback/xenbus.c        |  3 ++-
 drivers/xen/xenbus/xenbus_probe_backend.c | 31 +++++++++++++++++++++++
 include/xen/xenbus.h                      |  1 +
 5 files changed, 56 insertions(+), 3 deletions(-)

-- 
2.17.1

