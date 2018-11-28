Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92124C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC0D2082F
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 03:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NS/jKRyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AC0D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeK1Owr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 09:52:47 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:51018 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeK1Owq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 09:52:46 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAS3nT5F033592;
        Wed, 28 Nov 2018 03:52:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BDUE6wDq/IbemDKwp/UVciMiYE8vE607IFhP3GTLrWc=;
 b=NS/jKRybQ+dpqYqVhrQoFpv/cqqqSIQybQAmwhgQAkas9G1XwQ+E1jIdZGFDPo8wxC3r
 RBfiG1ksStLtt0d/f/g8OsGfBBkRYwpqzITuDiDKitgrZn6JMRrOwfatlCg4S+Ctrp2Q
 RkYsQ3jFnhui7xuGGoixTyEyBkvI2WL50iZlxAtkyhiY78dhh291icl2vmOupPvUhkSq
 FwBlTpj8PlaG40yfPCqKauTxnpY5c2xPpm6phtWza7V9twmEysr18u1n8zh8dgx7xGbv
 2gZPzp9qBDojByYb5YrXpjzXwScCiwD/FraZoiZjTR4x5ZqHPNYptuDW1S1FRKqUdcnX 3w== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2nxx2u7tkw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:38 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qbVO012583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Nov 2018 03:52:37 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wAS3qbr1006058;
        Wed, 28 Nov 2018 03:52:37 GMT
Received: from localhost.localdomain (/70.176.225.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 19:52:36 -0800
From:   Allison Henderson <allison.henderson@oracle.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     martin.petersen@oracle.com, shirley.ma@oracle.com,
        bob.liu@oracle.com, allison.henderson@oracle.com
Subject: [PATCH v1 7/7] xfs: Add tracepoints and logging to alternate device retry
Date:   Tue, 27 Nov 2018 20:49:51 -0700
Message-Id: <1543376991-5764-8-git-send-email-allison.henderson@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
References: <1543376991-5764-1-git-send-email-allison.henderson@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811280033
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds new log entries and trace points to the
alternate device retry error path

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c   | 14 +++++++++++++-
 fs/xfs/xfs_buf.h   |  1 +
 fs/xfs/xfs_trace.h |  6 +++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 81f6491..f203ddebe 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -833,6 +833,10 @@ xfs_buf_read_map(
 		for (i = 0; i <= blk_queue_get_mirrors(q); i++) {
 			bp->b_error = 0;
 			bp->b_rw_hint = i;
+
+			if (i > 0)
+				xfs_alert(bp->b_target->bt_mount,
+					  "Retrying read from disk %hu",i);
 			_xfs_buf_read(bp, flags);
 
 			switch (bp->b_error) {
@@ -840,6 +844,11 @@ xfs_buf_read_map(
 			case -EFSCORRUPTED:
 			case -EFSBADCRC:
 				/* loop again */
+				trace_xfs_buf_ioretry(bp, _RET_IP_);
+				xfs_alert(bp->b_target->bt_mount,
+					  "Read error:%d from disk number %hu",
+					   bp->b_error, bp->b_rw_hint);
+
 				continue;
 			default:
 				goto retry_done;
@@ -852,8 +861,11 @@ xfs_buf_read_map(
 		 * if we had to try more than one mirror to sucessfully read
 		 * the buffer, write the buffer back
 		 */
-		if (!bp->b_error && i > 0)
+		if (!bp->b_error && i > 0) {
+			xfs_alert(bp->b_target->bt_mount,
+				"Re-writeing verified data");
 			xfs_bwrite(bp);
+		}
 
 		return bp;
 	}
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index db138e5..23c9c3e 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -300,6 +300,7 @@ extern void __xfs_buf_ioerror(struct xfs_buf *bp, int error,
 		xfs_failaddr_t failaddr);
 #define xfs_buf_ioerror(bp, err) __xfs_buf_ioerror((bp), (err), __this_address)
 extern void xfs_buf_ioerror_alert(struct xfs_buf *, const char *func);
+extern void xfs_buf_ioretry_alert(struct xfs_buf *, const char *func);
 
 extern int __xfs_buf_submit(struct xfs_buf *bp, bool);
 static inline int xfs_buf_submit(struct xfs_buf *bp)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 3043e5e..1d98a3e 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -276,6 +276,7 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		__field(int, pincount)
 		__field(unsigned, lockval)
 		__field(unsigned, flags)
+		__field(unsigned short, rw_hint)
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
@@ -286,10 +287,11 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		__entry->pincount = atomic_read(&bp->b_pin_count);
 		__entry->lockval = bp->b_sema.count;
 		__entry->flags = bp->b_flags;
+		__entry->rw_hint = bp->b_rw_hint;
 		__entry->caller_ip = caller_ip;
 	),
 	TP_printk("dev %d:%d bno 0x%llx nblks 0x%x hold %d pincount %d "
-		  "lock %d flags %s caller %pS",
+		  "lock %d flags %s rw_hint %hu caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long long)__entry->bno,
 		  __entry->nblks,
@@ -297,6 +299,7 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		  __entry->pincount,
 		  __entry->lockval,
 		  __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
+		  __entry->rw_hint,
 		  (void *)__entry->caller_ip)
 )
 
@@ -309,6 +312,7 @@ DEFINE_BUF_EVENT(xfs_buf_free);
 DEFINE_BUF_EVENT(xfs_buf_hold);
 DEFINE_BUF_EVENT(xfs_buf_rele);
 DEFINE_BUF_EVENT(xfs_buf_iodone);
+DEFINE_BUF_EVENT(xfs_buf_ioretry);
 DEFINE_BUF_EVENT(xfs_buf_submit);
 DEFINE_BUF_EVENT(xfs_buf_lock);
 DEFINE_BUF_EVENT(xfs_buf_lock_done);
-- 
2.7.4

