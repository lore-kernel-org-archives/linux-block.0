Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905ECC10DAA
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1C521D7D
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 09:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUS5XxD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgIIJvi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIJvh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Sep 2020 05:51:37 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231DC061573;
        Wed,  9 Sep 2020 02:51:37 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u13so1706855pgh.1;
        Wed, 09 Sep 2020 02:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/9l1F2fFs2dFU7DfJaEfmDwpck1jBFfm2qL4yv6i45A=;
        b=gUS5XxD26ZqiyNIqxlgKKs1/c7QFsxEH6CoGq9vg+43Xi818ir8GnGC14nZcyjs5N9
         4YcZE76uvR0x9I4oMz3/jNgpmRz5m2wGQFnCirGqSnqJWTnz6vpHB/YEVsy8goMTLypT
         xtW4iTa5CSFWxHkDaDSG64BAAuqK5NRqH1Hd1VoH3bS6nNctyiIF9PN9HdzqaHfaaZ6E
         sYfLQHR73Sh/urkiEgZwViqIc2rZF4Fxzcoh6Af/+b4pyOsvHbTBod2os3UrDWAJlbjo
         yVvZVkkThHDFIMCLvSqPYE6B7xCkPY5fD7VmtkLcfpt+EoiO4K+uUp+TVKVEFbg5WS57
         7wKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/9l1F2fFs2dFU7DfJaEfmDwpck1jBFfm2qL4yv6i45A=;
        b=q78xFu1tevyCwbzzhXqUnwEtzF2tEllrL5p20JRdrLWYw7qtZUVQTqL/seH3FMBV15
         N9YL5GeYpBo5iyFTsJuBL3imUskIdA2qtSrSoNJsRwEYsh8o3ejGDyBpFzuU6O7a0VFk
         PP7tCtQ4dlAm2ude/K5557nOBLLXzPkJoRV0exDeT8QCFmCHms8TBCXJt9qbOo4agSmC
         2ByJDVg5TfjS/EsywrdzzBiodcqw1VL+YVufs1Jojo00XS9lh8W+liDSt70Gwfn8wCCj
         Gd6cpdlNpMzPzeJT1UQIwTpO5xuIT+MjYwmuCtIkWZe3vHfUVSHf2oS+JnWgVEWXUQAX
         rhJg==
X-Gm-Message-State: AOAM5331Kszz9wXMVBl7MULJMBxqbN7tldlhGm5WhKyM5dzSqM4E6r0N
        kdFOt4sD0qrQeoFDw7Y2G++DavWPOtrb
X-Google-Smtp-Source: ABdhPJxPvdD+1JahpDgWNitQ/DG2DsQjU5/g4ZEcoeE50l/NWqFVWK6cL3krfXar1a6p6baMtWmGGw==
X-Received: by 2002:a63:d449:: with SMTP id i9mr18251pgj.83.1599645096850;
        Wed, 09 Sep 2020 02:51:36 -0700 (PDT)
Received: from localhost.localdomain (n11212042027.netvigator.com. [112.120.42.27])
        by smtp.gmail.com with ESMTPSA id 25sm1603638pjh.57.2020.09.09.02.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 02:51:36 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v3] block/scsi-ioctl: Prevent kernel-infoleak in scsi_put_cdrom_generic_arg()
Date:   Wed,  9 Sep 2020 05:50:57 -0400
Message-Id: <20200909095057.1214104-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200727190013.324812-1-yepeilin.cs@gmail.com>
References: <20200727190013.324812-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

scsi_put_cdrom_generic_arg() is potentially copying uninitialized stack
memory to userspace, since the compiler may leave a 3-byte hole in the
middle of `cgc32`. Prevent it by adding a padding field to `struct
compat_cdrom_generic_command`.

Cc: stable@vger.kernel.org
Fixes: f3ee6e63a9df ("compat_ioctl: move CDROM_SEND_PACKET handling into scsi")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v3:
    - Improve commit message. scsi_put_cdrom_generic_arg() does not
      *always* leak kernel information. It is compiler dependent.
      Reference: https://www.nccgroup.com/us/about-us/newsroom-and-events/blog/2019/october/padding-the-struct-how-a-compiler-optimization-can-disclose-stack-memory/
    - Base the patch against mainline 5.9-rc4.

Change in v2:
    - Add a padding field to `struct compat_cdrom_generic_command`,
      instead of doing memset() on `cgc32`. (Suggested by Jens Axboe
      <axboe@kernel.dk>)

$ # before
$ pahole -C "compat_cdrom_generic_command" !$
pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */

	/* XXX 3 bytes hole, try to pack */

	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 9 */
	/* sum members: 41, holes: 1, sum holes: 3 */
	/* last cacheline: 44 bytes */
};
$ # after
$ pahole -C "compat_cdrom_generic_command" block/scsi_ioctl.o
struct compat_cdrom_generic_command {
	unsigned char              cmd[12];              /*     0    12 */
	compat_caddr_t             buffer;               /*    12     4 */
	compat_uint_t              buflen;               /*    16     4 */
	compat_int_t               stat;                 /*    20     4 */
	compat_caddr_t             sense;                /*    24     4 */
	unsigned char              data_direction;       /*    28     1 */
	unsigned char              pad[3];               /*    29     3 */
	compat_int_t               quiet;                /*    32     4 */
	compat_int_t               timeout;              /*    36     4 */
	compat_caddr_t             reserved[1];          /*    40     4 */

	/* size: 44, cachelines: 1, members: 10 */
	/* last cacheline: 44 bytes */
};
$ _

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

