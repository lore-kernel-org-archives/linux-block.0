Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B52C433E5
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 19:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 473F2207BB
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 19:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIpehUOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgG0TCJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgG0TCJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 15:02:09 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511B8C061794;
        Mon, 27 Jul 2020 12:02:09 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id a19so1986129qvy.3;
        Mon, 27 Jul 2020 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPEUCGwUhu6gC7effbwPg+v6omwHm9FSYu/MnszzrTw=;
        b=CIpehUOt0pFLGtZUceSvBaC7bKoxZRO5SIVUlQxu72u1BpL2T7RsEqJZkmlZgbQlNI
         ytkyQCLn2n1RnVX+H6GtBKDp9qt8SAvZpm+2KnCzJD1HwCKKDqzR1jYaRyopVDaNCv9s
         wXE2QZvRW2KliOdYmLGCiSjgteZdqeX6yWfWIceG+rdnBhUECimGxWr4I/vf0lIeubN/
         092IvLfWVygDK6Uzi4Fjb4JPPrGBf2Lz5twZNdFtfUgwfT6lg5vUcDV/tD0uGvNIFGg4
         QX4TrAF1mhaZZhLCC0oWLJOgeYHHZOlxlDWwZ4ztcNmURs54knHDYuGFLPELdHHT9TCB
         /K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPEUCGwUhu6gC7effbwPg+v6omwHm9FSYu/MnszzrTw=;
        b=rprPbP/DjpHBlxj0YU7KVKeAx9NjDNFLD0U2GxPA2+C5/VAnbBNtGcU/f1SIcs/mY/
         /snB1zAAhaa2i7T4izGz6KXjwVnl934vPN29kJN4CkCaOmBx2f8DZOQckvdNOXKikAgl
         VmbTBlkLo6b8RDSrnTHlKXboYAmDMIenxHPc2bebwgvW1r1nadNXQuZbUBcTHHTN+qZl
         on6+5PQhUAmYlzMoik7uf7itj7MYzulEi9laECXRJuPv1dznpmloxTkZYoILzKGtNAtr
         bfggl0w3SbBEzVbtPtU0qWyIsrs15RL+QuFQGrGFh2mWVZWvqkSaRZOo7220YeRikBfe
         Bn9Q==
X-Gm-Message-State: AOAM531Tb+SgLosve1WIsReDQRi+Lw6JgvVozVp/06I1tFcUAC9xtnhZ
        3q77kJWIPuzqJdtu/D9VdH0l4DqoAg==
X-Google-Smtp-Source: ABdhPJxl55vKVbiqhnwds/IIJ1yz9AlsuPAU+JHNpS/sdbZCaQOhnqlEjfFyhJfVgvLP1VrKW1oURQ==
X-Received: by 2002:ad4:4ead:: with SMTP id ed13mr8757280qvb.161.1595876528455;
        Mon, 27 Jul 2020 12:02:08 -0700 (PDT)
Received: from localhost.localdomain ([209.94.141.207])
        by smtp.gmail.com with ESMTPSA id 6sm18964139qkj.134.2020.07.27.12.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 12:02:07 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] block/scsi-ioctl: Prevent kernel-infoleak in scsi_put_cdrom_generic_arg()
Date:   Mon, 27 Jul 2020 15:00:13 -0400
Message-Id: <20200727190013.324812-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727161932.322955-1-yepeilin.cs@gmail.com>
References: <20200727161932.322955-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_put_cdrom_generic_arg() is copying uninitialized stack memory to
userspace due to the compiler not initializing holes in statically
allocated structures. Fix it by adding a padding field to `struct
compat_cdrom_generic_command`.

Cc: stable@vger.kernel.org
Fixes: f3ee6e63a9df ("compat_ioctl: move CDROM_SEND_PACKET handling into scsi")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
    - Add a padding field to `struct compat_cdrom_generic_command`,
      instead of doing memset() on `cgc32`. (Suggested by Jens Axboe
      <axboe@kernel.dk>)

 block/scsi_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/scsi_ioctl.c b/block/scsi_ioctl.c
index ef722f04f88a..72108404718f 100644
--- a/block/scsi_ioctl.c
+++ b/block/scsi_ioctl.c
@@ -651,6 +651,7 @@ struct compat_cdrom_generic_command {
 	compat_int_t	stat;
 	compat_caddr_t	sense;
 	unsigned char	data_direction;
+	unsigned char	pad[3];
 	compat_int_t	quiet;
 	compat_int_t	timeout;
 	compat_caddr_t	reserved[1];
-- 
2.25.1

