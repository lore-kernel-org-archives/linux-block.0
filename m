Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DF0C10F13
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB8F2173C
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 15:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bF7zOORD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfDKPHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:07:04 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44566 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfDKPHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 11:07:03 -0400
Received: by mail-pl1-f195.google.com with SMTP id g12so3530449pll.11
        for <linux-block@vger.kernel.org>; Thu, 11 Apr 2019 08:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=8fFl1KuZoclNUfLG0OkPR+aRz0hGPPyI7B0rMVNLNoU=;
        b=bF7zOORDDzu2L6/Gk9houVBMS0F+etz1ZRQnZ3oQ7JxCLFhweCnJRh+zabl7QUVFP8
         gERr8ctF4S1QrqIW942mlu07Tg2eAIb1gO3IHKWwVtSeD4eheJtQnj08UiAGDFqI+Q03
         cKMM1nEtSZWKI3OeAPJfaijBIIzeXB4bnK3Wp5kWiZQFg0bUxp07YppQK1diXYqFI5+D
         E4OSTH8oPFIf2+5wJKWEd3JqqDlUPJOgD+Dplg36G/sIZeEOUjn4WA+9t3L+ODHO37+R
         l2rhGYRIgeStqkSOVCLjNj40tsKZjv/V7aGIplRD5ps/Io3kEW7jZr+kiT0Gj6qIq9Y0
         bymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8fFl1KuZoclNUfLG0OkPR+aRz0hGPPyI7B0rMVNLNoU=;
        b=k37K4kHjmop5iDYiU9FAHNKK3ZmaYpXToHjN8l/2oKhG/T6Vwst0WU03xUj2cXqLXn
         f+cXV3g0W36k/cBt4Y+KvN58zo/yA9cqUfOtEWoMlovnj5zD5wGdAt5iIJTklTBNavGM
         PbFDiGx1rfleMhLMjLsQumCq8lCvnQZbQB4C21UoieIBGBbESDHcGVEOaK38rlQHb1eu
         P1ZoLinBJIYOgf6oJ+obAp9rFmpC5DWBMWQ1uqcWhwEA3Nimvi/+w82DEwITYAtI5PVK
         RENCdhyqjgj/VlZauaB66jH6iLvI4Gr56UjsENbFuJz4PUF3wDlQ3L8WDpgSryNZlhxt
         Eruw==
X-Gm-Message-State: APjAAAXSFHGpwE4+VnCGZlzZPSpLs6uT8UVReDfIn2WmRs3ICk4fLaHW
        cGUrEfP6k2LNSX0kR09LRjZX7Q==
X-Google-Smtp-Source: APXvYqzkK2fwA3xttHv+v2T4W2fsvztfyL1CwtxgTdnlJTBhimSgXlYSmigd6E3WbEZ8rbErOTVRug==
X-Received: by 2002:a17:902:e407:: with SMTP id ci7mr50459344plb.219.1554995223000;
        Thu, 11 Apr 2019 08:07:03 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id s12sm62905062pgc.28.2019.04.11.08.07.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 08:07:01 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@infradead.org, clm@fb.com
Subject: [PATCHSET 0/3] io_uring: add sync_file_range and drains
Date:   Thu, 11 Apr 2019 09:06:54 -0600
Message-Id: <20190411150657.18480-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In continuation of the fsync barrier patch from the other day, I
reworked that patch to turn it into a general primitive instead. This
means that any command can be flagged with IOSQE_IO_DRAIN, which will
insert a sequence point in the queue. If a request is marked with
IOSQE_IO_DRAIN, then previous commands must complete before this one
is issued. Subsequent requests are not started until the drain has
completed. The latter is a necessity since we track this through the
CQ index. If we allow later commands, then they could complete before
earlier commands and we'd mistakenly think that we have satisfied the
sequence point.

Patch 2 is just a prep patch for patch 3, which adds support for
sync_file_range() through io_uring. sync_file_range() is heavily used
by RocksDB.

Patches are also in my io_uring-next branch;

git://git.kernel.dk/linux-block io_uring-next

 fs/io_uring.c                 | 142 +++++++++++++++++++++++++++++++++-
 fs/sync.c                     | 135 +++++++++++++++++---------------
 include/linux/fs.h            |   3 +
 include/uapi/linux/io_uring.h |   3 +
 4 files changed, 216 insertions(+), 67 deletions(-)

-- 
Jens Axboe


