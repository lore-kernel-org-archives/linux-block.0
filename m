Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433CDC004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17F4D20578
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 19:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pHek5J7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbfEGTlL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 15:41:11 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:44423 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGTlL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 15:41:11 -0400
Received: by mail-pg1-f176.google.com with SMTP id z16so8804892pgv.11
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=60dHSE0MbDZfwrjfUd1bAjkgAYHQku7uaagXZkwFET8=;
        b=pHek5J7S5HFYwE4Xs+UknCksvNtR1B5LZO3fWyIpL9FEHyiV1rmz7fQ9b2kNddAnQk
         2uSoc+rKuPM4LFmnwJ+HK55NVGtCINJva7Df6APxuQ2SYGuVdhhT+nqs6AqqLp9M9n6t
         sP/5pYGZ42l8NwKIqDQKBQMPcz26nZ11p3QAhCJyZSEu234YSa3ii2ZajnFHtr62teup
         YdZB6rdvvwzAkdK2FCavXkmq3snivBm74CD1o0BtsZZkqddJqc6g/JRiBFLyj+J3J59r
         HpNUwTxAMx9HVGH3L8+faf8/MToajHgSl59XJbYqV0PHkyQVLgcgicFQhW2bOPrykk3j
         TaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=60dHSE0MbDZfwrjfUd1bAjkgAYHQku7uaagXZkwFET8=;
        b=MohUQC64WY4Fe2YEieJERCzlfhExKQANhjyvxtskudssBOfY3YuXkjvsBgDNaPABAz
         H9CSje8n8PdnhLQttXeSdmR6aPiEl6dkUyl+BzHE7KbEV89zEj8ByIROHDgZ8ke9GuO1
         mMdXM/5k/glI92we+JKGDD7bzCiL6miIQcatU8o+yHBUV7dqdm0tXlOnrm8GymhN4+p2
         qZRuLhRJ2hfmiOLbnD6DDbilkFflZadMpAJ9lb0iczNiePK7wmdYoAmHA2CXmXBEXOAP
         6l1nHy/OnE5i4g0oCQt6fIzIqG+4lNL4p6Zkn3gyni1m8NzomQO+TB4KFzqY7SLvjONY
         DMpQ==
X-Gm-Message-State: APjAAAUwBpAAVtlHxkvkpXRAoSDfeWpWizuPn5OWzjzVhs0Y89MpubO+
        kcox6PKQ5L/2h6kwL3rzMWkBzDJ62c8HNw==
X-Google-Smtp-Source: APXvYqxk1w+OWmZsJHc+K3vwEncdTcXPlrfqUhW1nX9pI+qy0hcqtO/LglwPWede+dBNm1kAw3vyNA==
X-Received: by 2002:a63:3182:: with SMTP id x124mr33085441pgx.364.1557258070173;
        Tue, 07 May 2019 12:41:10 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id t5sm1565147pgn.80.2019.05.07.12.41.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:41:08 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] io_uring changes for 5.2
Message-ID: <6031a661-195e-4351-59ff-086b799a50c4@kernel.dk>
Date:   Tue, 7 May 2019 13:41:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Set of changes/improvements for io_uring that are queued up for 5.2.
This pull request contains:

- Fix of a shadowed variable (Colin)

- Add support for draining commands (me)

- Add support for sync_file_range() (me)

- Add eventfd support (me)

- cpu_online() fix (Shenghui)

- Removal of a redundant ->error assignment (Stefan)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.2/io_uring-20190507


----------------------------------------------------------------
Colin Ian King (1):
      io_uring: fix shadowed variable ret return code being not checked

Jens Axboe (4):
      io_uring: add support for marking commands as draining
      fs: add sync_file_range() helper
      io_uring: add support for IORING_OP_SYNC_FILE_RANGE
      io_uring: add support for eventfd notifications

Shenghui Wang (1):
      io_uring: use cpu_online() to check p->sq_thread_cpu instead of cpu_possible()

Stefan Bühler (1):
      req->error only used for iopoll

 fs/io_uring.c                 | 194 ++++++++++++++++++++++++++++++++++++++++--
 fs/sync.c                     | 135 +++++++++++++++--------------
 include/linux/fs.h            |   3 +
 include/uapi/linux/io_uring.h |   5 ++
 4 files changed, 267 insertions(+), 70 deletions(-)

-- 
Jens Axboe

