Return-Path: <SRS0=eqh8=ZK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7270BC432C0
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F81620700
	for <linux-block@archiver.kernel.org>; Mon, 18 Nov 2019 00:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="ecbZ4/TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfKRAVF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 17 Nov 2019 19:21:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41496 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfKRAVF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 17 Nov 2019 19:21:05 -0500
Received: by mail-ot1-f67.google.com with SMTP id 94so12973811oty.8
        for <linux-block@vger.kernel.org>; Sun, 17 Nov 2019 16:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKZrDtVIpLnMit2BarIDGe/EvWMjXIglUl2svaa0fMg=;
        b=ecbZ4/TRy2hUTyMYqzoL9hGVU3gt3kFQyf7Vu8toJq6PuKdr6h/s2Xy59VlLT/pXjz
         /6gZhPcxCcprj7d0piA2C7X870j5+hREdVzyhNoaBWbhx3dIMQnCbP2XEo0E+9hTJbki
         j4ZeRwanzBqAAI1yteXPWJody9n5Un4DmNqXatr1WKe9cPrWcIJvqozt4QJabGHXKY6q
         3bbXsCnLMFUQCfZVWtM10iedHLiknSHPKgZziGPbSChn1FG3Nukq5V9Px1p8eNxHA6F0
         bJ3j364MWNJqHnHvhOjMJYMsBhKVDv5MHDzpEeyKn2BTPch7cj+jqauOGGY6J99Fkb0V
         dLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKZrDtVIpLnMit2BarIDGe/EvWMjXIglUl2svaa0fMg=;
        b=PiqdRuSkn7zEumGQA2wfpfGif/spopi4hQBHnQ9zozYnyBq63M8YyyyWVCRn/xOOzx
         LAIkGrO94i4HTqnL4oHNjAftbYYW2q8SHTokm9cL8d3SSTkTlYFk+3Dbx3vLyOm7O1zG
         PmhboAI0DG52j1menZbRjEl/HI+C5Sx8oX2sRZe/SC86jJFxJPdEaWLjeC/eOJVUWU0D
         ely27LX4ukpsX/OHH91inEED3LSykcmuCZXj8kVYTnvDVZusmcXvpDCkrGCFqB95com7
         GpZE7Mclmm4mK2T2c4JqQ10/mFsOXrrnLs372B0iuKBcMkADzHrvzJuO3Ohel05iOH74
         iEnQ==
X-Gm-Message-State: APjAAAWC5YUlxq46S9JkdbEr1RNh219NQNKol46zzz87xDkcXdbPjM+9
        kO1F+EJ3TB7Q7eO7gsicVa2vig==
X-Google-Smtp-Source: APXvYqxbMvNwtxYCgpWn0NDF+Vux6CK9suZWIN8wxrT7oMCsq2kSUhzh+QrnrPIC2ga6ATO37xh6sA==
X-Received: by 2002:a05:6830:2257:: with SMTP id t23mr21240719otd.129.1574036464138;
        Sun, 17 Nov 2019 16:21:04 -0800 (PST)
Received: from com.attlocal.net ([2600:1700:4870:71e0::10])
        by smtp.gmail.com with ESMTPSA id 65sm5532194oie.50.2019.11.17.16.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 16:21:03 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     axboe@kernel.dk
Cc:     Frederick Lawler <fred@fredlawl.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        bvanassche@acm.org
Subject: [PATCH v2 0/4] skd/mtip32xx: Prefer pcie_capability_read_word()
Date:   Sun, 17 Nov 2019 18:20:53 -0600
Message-Id: <20191118002057.9596-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

These changes are in reference to Bjorn's suggestions here:
https://lore.kernel.org/lkml/CAErSpo6BmWDxi3Vckm03=fZHEUosTgkMUjqCvYRA186jv8XbFw@mail.gmail.com/
https://lore.kernel.org/lkml/CAErSpo5TZC3iM09SB1td+F7b-+aiu9EHwPYa1ayiU-i1tseV5w@mail.gmail.com/

And the patches are rebased ontop of 54ecb8f7028c ("Linux 5.4-rc1")

Changes since v1:
    * Replace magic numbers constants

This is a long time coming, apologies for dragging my feet on getting
these trivial patches out.

Frederick Lawler (4):
  skd: Prefer pcie_capability_read_word()
  skd: Replace magic numbers with PCI constants
  mtip32xx: Prefer pcie_capability_read_word()
  mtip32xx: Replace magic numbers with PCI constants

 drivers/block/mtip32xx/mtip32xx.c | 28 ++++++++++++----------------
 drivers/block/skd_main.c          | 14 ++++++--------
 2 files changed, 18 insertions(+), 24 deletions(-)

--
2.20.1

