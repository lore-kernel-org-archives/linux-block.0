Return-Path: <SRS0=NSF0=DQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A3EC433E7
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD47621D43
	for <linux-block@archiver.kernel.org>; Fri,  9 Oct 2020 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EdihgDVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732962AbgJIJHT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Oct 2020 05:07:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:32954 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732712AbgJIJHS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Oct 2020 05:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602234438; x=1633770438;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HliFFEe+UfJwpQoAKazyUDDEPyp1zWArC0eClgCWa6s=;
  b=EdihgDVu5/ZHwbef9fPFhMhONYJjT2VEmIzNTOtwFTmkCssH0xlTwy3u
   9QUhhGKEvK1VKTsOz252XN0k5gfJrffYXglbk8FwqyjzRpl+9l3QdC9d0
   U+Ab9oQcVHFNbldNZoEvA+t5c8CX1/pYyiYIO/sHfsxk7pnP6c86x6Deq
   niIEQP4RC4BGrwrXmjNf2EArzZxjEjO+pEPTCUhthTmEMJ01DlRQ2JeG/
   oylmvuNWsrXDDTr6JxLrY8p71ccIs1hAoL5fOQ/AAFOTZ4VetRBdK+lus
   LiJinESvRTlhbj5EWWyXBfG7vxq2RSYu76LRF+oLNzDpU9m8+r3Dfrq2m
   w==;
IronPort-SDR: t/S1TVOeCiqY/52iOLmquwDE6/0Vby6zobbiiN1tXyCioorcv1eY1+Zl98pNj8OL9kugVDD5ew
 GifOJLXfLi4duxwZuftYm+1DuYBCNgg2KS4SZs7GRe7HrDB1GYIxzUCBONPAUcN4gagLzKLmrL
 6Ie9DPc0vR7RC7r2vW1eSfrkIbnqTr0d20TdEs+9ZfxtR3s9mMAb6V2mMrdSiPm3cGIiuTlrNL
 Zhj9Fxq1+u63QgRLf9VUX/0cHYKwsTJH/gAQLz8gKNf+edgEPYxmroCJU+h7q+YDwiW8uqHmpd
 VN4=
X-IronPort-AV: E=Sophos;i="5.77,354,1596470400"; 
   d="scan'208";a="153866767"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 09 Oct 2020 17:07:18 +0800
IronPort-SDR: e7kVYXS8DYk9nq/a1ysWHZkYdOlXHdbedqfYyIgenRyZX48xltDK+MIJog1ejIdP3+huwuxjTa
 KJhjR6pEa9QYMnx0Q0OCI6x69bCdW0Ihb9nA1yrPTJRprUWTfwL/Oyfb0zTml6bIGCrNfXtPho
 wvY1wlKxUJCOGGjV8+xijZz/DfKeGXmb7ncC/gntrKNT0xhXajXcJ7DmkxrRpzXq95BM0emtSZ
 zPNbYthjPSqaLL3qVBx+bGvnywMaqEYT18wuF5uMbNTVmoxg17WIpzMTmYY8LdjvwfUYYKXk3J
 3sl1mXmqc3Efwa7lkMA1WJkN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 01:54:00 -0700
IronPort-SDR: C8HgZuFf0i2GD6UYnzpS7OBC1T5LqII8S+x3Tp1wxMEKx/zIpFfBd+iq+QDoEbYpm8pP9FNvKg
 z0Vi1ziJWJJ7PC1kMvcNldcHEZYF2tHS/cWU76VZJ/TiBk5ybpWDYcykwUVmmtkcW6XhnZfCe9
 vHps6f4w9DPKLM8MbaT0eJT4ybzVbG9tMLi5lPmDQYIeC0qoZRz1U3uUyXkKuLW+bP2UWiLjRH
 TKkgE5xF2QGOoqk6Jl/yM4YM3aGwDKfb4DSFjMpsYnmWjKj+UsOz68Cqgx8z1i9+SbzHLlgsaL
 j5A=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Oct 2020 02:07:18 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix uapi blkzoned.h comments
Date:   Fri,  9 Oct 2020 18:07:14 +0900
Message-Id: <20201009090714.285968-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Update the kdoc comments for struct blk_zone (capacity field description
missing) and for struct blk_zone_report (flags field description
missing).

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 include/uapi/linux/blkzoned.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 42c3366cc25f..656a326821a2 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -93,12 +93,15 @@ enum blk_zone_report_flags {
  * @non_seq: Flag indicating that the zone is using non-sequential resources
  *           (for host-aware zoned block devices only).
  * @reset: Flag indicating that a zone reset is recommended.
- * @reserved: Padding to 64 B to match the ZBC/ZAC defined zone descriptor size.
+ * @resv: Padding for 8B alignment.
+ * @capacity: Zone usable capacity in 512 B sector units
+ * @reserved: Padding to 64 B to match the ZBC, ZAC and ZNS defined zone
+ *            descriptor size.
  *
- * start, len and wp use the regular 512 B sector unit, regardless of the
- * device logical block size. The overall structure size is 64 B to match the
- * ZBC/ZAC defined zone descriptor and allow support for future additional
- * zone information.
+ * start, len, capacity and wp use the regular 512 B sector unit, regardless
+ * of the device logical block size. The overall structure size is 64 B to
+ * match the ZBC, ZAC and ZNS defined zone descriptor and allow support for
+ * future additional zone information.
  */
 struct blk_zone {
 	__u64	start;		/* Zone start sector */
@@ -118,7 +121,7 @@ struct blk_zone {
  *
  * @sector: starting sector of report
  * @nr_zones: IN maximum / OUT actual
- * @reserved: padding to 16 byte alignment
+ * @flags: one or more flags as defined by enum blk_zone_report_flags.
  * @zones: Space to hold @nr_zones @zones entries on reply.
  *
  * The array of at most @nr_zones must follow this structure in memory.
-- 
2.26.2

