Return-Path: <SRS0=zlmp=6K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8570BC54FCB
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDB320700
	for <linux-block@archiver.kernel.org>; Sun, 26 Apr 2020 13:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgDZNH6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:07:58 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38270 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgDZNH6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Apr 2020 09:07:58 -0400
Received: by mail-lj1-f193.google.com with SMTP id e25so14671013ljg.5;
        Sun, 26 Apr 2020 06:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/MBrzI+kWs5DA8ffL+OUrhz5HYBrpy6azkX7d6OMK6E=;
        b=sTHlVWC3nN+DdM+8BmqgTTddFbmA85tRz+ybJiuBD79XNF/u64mm8TuOyGJ1RksdAT
         SvvMF5BG2ABDRaZXXt4BVQd7Gm8WmOBlLWovdYYa4+KkV8vdA03U4E458fBAa/5n916B
         4l/MQEK4G1c35xiArTZ4I+b6QnvGKUnzHM+TGC2camAMqTgnn94hsoNYWXLon7VNxkGe
         rT2YPYmJi1gxiF15Ai9kibZvWF+KxhNh7YIshYf7lYABJ2wiGHXxHioGuFDpmbry4SS2
         biFY7zSnR+TI2DhCVz9Suf73LbTRImkuxe6PgOXeZNHdXrrB0f5DJIKBmsSqyUduJNeu
         Watg==
X-Gm-Message-State: AGi0PuYRGsKxNAsyYTUrEXyx2ob9bk1eA72ieYaF/Is/GxcOsnauoaKv
        y0hcim9pRnFYTvTf3eMq4GCUcEtiuZI=
X-Google-Smtp-Source: APiQypIwbPT3N1mpiifhxrKn6yfdWNb2A/kHJHkXdTXYDx5pRd2wWt4xhRYv71Ngcu3W3zoqfcUiEA==
X-Received: by 2002:a2e:85c4:: with SMTP id h4mr11648938ljj.112.1587906476310;
        Sun, 26 Apr 2020 06:07:56 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.211])
        by smtp.googlemail.com with ESMTPSA id l8sm7983371ljo.5.2020.04.26.06.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 06:07:55 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, Willy Tarreau <w@1wt.eu>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] floppy: suppress UBSAN warning in setup_rw_floppy()
Date:   Sun, 26 Apr 2020 16:07:25 +0300
Message-Id: <20200426130728.63399-1-efremov@linux.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These patches are based on Willy's cleanup patches
https://lkml.org/lkml/2020/3/31/609.

The first two patches indroduce defines to make it more clear why
cmd_count in struct floppy_raw_cmd allows out-of-bounds access for
cmd, reply_count, reply fields. The last one handles the warning.

Changes in v2:
 - add FD_RAW_CMD_FULLSIZE to the second patch
 - add union with fullcmd to struct floppy_raw_cmd in the last patch

Denis Efremov (3):
  floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
  floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
  floppy: suppress UBSAN warning in setup_rw_floppy()

 drivers/block/floppy.c  | 34 +++++++++++++---------------------
 include/uapi/linux/fd.h | 26 ++++++++++++++++++++++----
 2 files changed, 35 insertions(+), 25 deletions(-)

-- 
2.25.3

