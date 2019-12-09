Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C1FC43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B885207FD
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 13:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=selectel-ru.20150623.gappssmtp.com header.i=@selectel-ru.20150623.gappssmtp.com header.b="O2lYhYzw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLIN6O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 08:58:14 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40188 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIN6N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 08:58:13 -0500
Received: by mail-lj1-f196.google.com with SMTP id s22so15741084ljs.7
        for <linux-block@vger.kernel.org>; Mon, 09 Dec 2019 05:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=selectel-ru.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Ww0J4xrSwk7Dc08ZydhXIKlnai+yEByb16Ya4jyElM4=;
        b=O2lYhYzwftjBFmL5yryCwRYNxQ+RGZnwtA2LlGng7yKd9PsFP6xxXazM/CMo/f/gcH
         B/1VLnd32ZmF1yJEY6i6/1F6IbK+Y0iBnaJRCLaZ7gRgFE/0Kq06c1iL7K4BceeGFPdN
         ctXwyvK7RtjRD4ENc4cZBtB0V/lmNelmALb76LdDpXcZW75PJHBH4HXrM3QEnI7U08PO
         gsijq9b97ylJmnkWvhYQGTMQNktKqMSUmOyZqVdiFYo9hoRfSR63Avjy37diSuWu9NbA
         E4fdJgJoyLFzHFGKZqvJWlhG4WrN8tOk9L1W7FgXBczGWvo/ARrtTOnx37/26Vg6IEel
         VgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ww0J4xrSwk7Dc08ZydhXIKlnai+yEByb16Ya4jyElM4=;
        b=eI+qMZv+TOSm7UsTtXb+tITCayZSMj9+Axy8MHcHEnWwfU9sD6IOqBuJLMVZ4orBlS
         o9xV8jBdaK0ySbNF7fZ0+6Z7xbs0B1AHdSNksFCDeM3Nrb+MHM08YSNeY63AksuWSq6l
         YvCG3jIn19EDUPy9Xc8Gc80jMiL0saVbEtdlOB3YDuWxjSTZEao5Gnx3GjmQOQ8D9eGr
         7XWvIPrIRPDpVXO5Uweo0736Ugl4Wmy6DJSvOGD0z6Mh6K5DK9pl8r08BbgUCaaZyUBa
         relusReQPn5HyC50qxlOt1SWB1KDo/gn5ezqyNj9RA39G9fODqMEqGHC/OTOvyuHFnoM
         vSeQ==
X-Gm-Message-State: APjAAAUzrCoV5F7AflHU3OlzLR5J9PcyYXFHXnQelL6XIGZXA7hTdUgu
        5vG57AdDdt57uOL9grLkhVhOp0YEMXQ=
X-Google-Smtp-Source: APXvYqw1Uencs01se1dsdy3OnCA6PYykNUxyD+p3gv+X1zQtcyPQQ4q5JN44yYAKgMtEGI5RB2FqWw==
X-Received: by 2002:a2e:9a93:: with SMTP id p19mr17128397lji.158.1575899890869;
        Mon, 09 Dec 2019 05:58:10 -0800 (PST)
Received: from some-laptop.eq.selectel.org ([188.93.16.2])
        by smtp.gmail.com with ESMTPSA id g14sm11099511ljj.37.2019.12.09.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 05:58:10 -0800 (PST)
From:   Aleksei Zakharov <zaharov@selectel.ru>
To:     linux-block@vger.kernel.org
Cc:     Aleksei Zakharov <zaharov@selectel.ru>
Subject: [PATCH 0/2] block: add bio split counters for iostat
Date:   Mon,  9 Dec 2019 16:57:59 +0300
Message-Id: <cover.1575899438.git.zaharov@selectel.ru>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There's a mechanism which splits IO's if their size
is greater than queue/max_sectors_kb setting. But there's
no counter for split requests. Having splits counter helps
to understand workload profile and necessity
of settings tuning.


bi_flags converted to int from short.
Add BIO_SPLITTED flag and set it in bio_split() for new bio.
Add splits[] counters.
In blk_account_io_start() check the BIO_SPLITTED flag
and if it's set increment appropriate splits counter.

Aleksei Zakharov (2):
  block: extend bi_flags to int and introduce BIO_SPLITTED
  block: add iostat counters for requests splits

 Documentation/ABI/testing/procfs-diskstats |  3 +++
 Documentation/ABI/testing/sysfs-block      |  5 ++++-
 Documentation/admin-guide/iostats.rst      | 10 ++++++++++
 block/bio.c                                |  2 ++
 block/blk-core.c                           |  2 ++
 block/genhd.c                              |  8 ++++++--
 block/partition-generic.c                  |  8 ++++++--
 include/linux/blk_types.h                  |  5 +++--
 include/linux/genhd.h                      |  1 +
 9 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.17.1

