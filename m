Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB46DC04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8220C20672
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="CXvOeROw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8220C20672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbeLDR7K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:59:10 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:38926 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDR7K (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:59:10 -0500
Received: by mail-yb1-f175.google.com with SMTP id w17-v6so7217421ybl.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id;
        bh=GmszWqYPL+AmUPgI7T9NwuxYNlScNnG8gZ5JtkXpEes=;
        b=CXvOeROwSvle1E8/KdZ9S+xPxk2AjH2NRQrh9FteTMqLWmLuWQOIVtq7n50fXkRs/J
         q3+LhBIyoBIpQguZbx88c1fZ+NbtASKcFTKqg3Cv7Vu50UKy2fKpJJ46HRCx52bi6pGL
         s6oR7Pny0I80kXeq5OTdolIy0tC1tAnkNHExByiV22czSAF5IDZUrDDDOZGMsjM3nR5P
         Zv2HjYEFVMnZq9FzQxhOJmy3QbcTEMO05wyfs0x/fZf5MWAPCPAgoCT2pHIUgen9O4Zc
         7PpWyUQlnRVR5R1sV5jTC/EUtaFVs+nNFpzTmxU+VCleV1OFP39h3me5m0TxNm6K9S6m
         /4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=GmszWqYPL+AmUPgI7T9NwuxYNlScNnG8gZ5JtkXpEes=;
        b=CYOGDtbtFcKTrI8mX93UPuw2AMYcKir2Q+Brf1sIFgHRMtS4otGH6+ndyP401j661E
         ZYSl3AsX4YKVc3R/6dvJl3OrzAlB/ylzIDOtUdCa6U4XcRjrhMOF0rc+VRU7HdP2gjNt
         88Pi9Gu/xZuFyTWQ7/7gSE7as/MEYi19onJZYQQeXbSicgeu7lYh/vxK0jA4LPTSoWnw
         K86x1dBLknC34s8w6VL6g9+3gaVKtSaqjIVPpZsUFRjywiKJjM5TCSWQgszLl2oF8kBz
         vXD7DykH1qyH3u8ph1j2Wn9PbMI6S94jV3/yKFTFUL0avpZ9wwODBRh6GD80gD+++hjD
         zOEQ==
X-Gm-Message-State: AA+aEWYtHqIT1wiyica3E0L74zpOcwLn5mfCfq0aAbX+wjUWllCtNokK
        AdoVyhQWX1YRcSB5aK6VMMn9ug==
X-Google-Smtp-Source: AFSGD/XIjgV0iHclOxAiyWgzxtnOvk34W2FLtlHv9M6x4wWNsK1+yun/YhK/CAuj4XmYMdM2Y21/JA==
X-Received: by 2002:a25:aaa1:: with SMTP id t30-v6mr21204231ybi.175.1543946349639;
        Tue, 04 Dec 2018 09:59:09 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x203sm6225276ywd.41.2018.12.04.09.59.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:59:08 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH 0/3] Unify the throttling code for wbt and io-latency
Date:   Tue,  4 Dec 2018 12:59:01 -0500
Message-Id: <20181204175904.8486-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Originally when I wrote io-latency and the rq_qos code to provide a common base
between wbt and io-latency I left out the throttling part.  These were basically
the same, but slightly different in both cases.  The difference was enough and
the code wasn't too complicated that I just copied it into io-latency and
modified it for what I needed and carried on.

Since then Jens has fixed a few issues with wakeups with the niave approach.
Before you could easily cycle waiters back to the end of the line if they were
woken up without the ability to actually do their IO yet.  But because this was
only in wbt we didn't get it in io-latency.

Resolve this by creating a unified interface for doing the throttling, and then
just handle the differences between the two users with user specific callbacks.
This allows us to have one place where we have to mess with wakeups, and gives
each user the ability to be their own special snowflake.

Jens, I based this on for-next from 12/03, let me know if you want a different
base.  I tested this with my blktests test.  Thanks,

Josef

