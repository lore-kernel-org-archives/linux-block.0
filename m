Return-Path: <SRS0=Y8Hj=QU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D29C282C2
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4CC222CD
	for <linux-block@archiver.kernel.org>; Wed, 13 Feb 2019 09:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qWLuD1DZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391384AbfBMJxz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:53:55 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:53472 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732639AbfBMJxy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Feb 2019 04:53:54 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1D9mgQd163807;
        Wed, 13 Feb 2019 09:53:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=btF1v4tjdgTzSKMBIbwAhAtSt7P45B069orpzvat5Jc=;
 b=qWLuD1DZD6/wUpoWBSTdHIxSeQKRBla1wZg8UPPgt5bqzTn5W9KPRlKvO8bAJn8EHY4/
 PvvoQHDCUAwmLe/41X+ECE0oYqhMbyfh6nzT0AzNUBDMFxtk4e7zJPJZ2kvs/B+HoqK+
 kCwnoGxysZLmsveQgorOIinbY5Epx0RBj4h3ziSm+l/j7bzJ9KkZZIM0GTlmXm8vO45P
 3k6KfGRPm4to53iAH+bg02GgPuO5XaGVlI3ngciTQrfsu004DGT76UWwlRgjO7ZO+i1M
 dITJbA/FsRA9kNAdWHm6Tg5ttAhPla0QaIeJSK6uXyTYiMsJQVg9aTHMwgNLYa6dxgms fQ== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2qhree11te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:48 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rlxn030542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Feb 2019 09:53:47 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x1D9rkId000779;
        Wed, 13 Feb 2019 09:53:46 GMT
Received: from localhost.localdomain (/116.239.187.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Feb 2019 09:53:46 +0000
From:   Bob Liu <bob.liu@oracle.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        martin.petersen@oracle.com, shirley.ma@oracle.com,
        allison.henderson@oracle.com, david@fromorbit.com,
        darrick.wong@oracle.com, hch@infradead.org, adilger@dilger.ca
Subject: [RFC PATCH v2 9/9] xfs: Add tracepoints and logging to alternate device retry
Date:   Wed, 13 Feb 2019 17:50:44 +0800
Message-Id: <20190213095044.29628-10-bob.liu@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213095044.29628-1-bob.liu@oracle.com>
References: <20190213095044.29628-1-bob.liu@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902130072
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Allison Henderson <allison.henderson@oracle.com>

This patch adds new log entries and trace points to the
alternate device retry error path

Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 fs/xfs/xfs_buf.c   | 10 ++++++++++
 fs/xfs/xfs_buf.h   |  1 +
 fs/xfs/xfs_trace.h |  6 +++++-
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e54dbc776d15..1a0427137883 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -847,6 +847,11 @@ xfs_buf_read_map(
 
 		for (i = 0; i <= retries; i++) {
 			bp->b_error = 0;
+
+			if (i > 0)
+				xfs_alert(bp->b_target->bt_mount,
+					  "Retrying read from disk %lu",i);
+
 			_xfs_buf_read(bp, flags);
 
 			switch (bp->b_error) {
@@ -854,6 +859,11 @@ xfs_buf_read_map(
 			case -EFSCORRUPTED:
 			case -EFSBADCRC:
 				/* loop again */
+				trace_xfs_buf_ioretry(bp, _RET_IP_);
+				xfs_alert(bp->b_target->bt_mount,
+					  "Read error:%d from disk number %lu",
+					   bp->b_error, *bp->b_rd_hint);
+
 				continue;
 			default:
 				goto retry_done;
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index af9bdff29e66..69605a50c15e 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -306,6 +306,7 @@ extern void __xfs_buf_ioerror(struct xfs_buf *bp, int error,
 		xfs_failaddr_t failaddr);
 #define xfs_buf_ioerror(bp, err) __xfs_buf_ioerror((bp), (err), __this_address)
 extern void xfs_buf_ioerror_alert(struct xfs_buf *, const char *func);
+extern void xfs_buf_ioretry_alert(struct xfs_buf *, const char *func);
 
 extern int __xfs_buf_submit(struct xfs_buf *bp, bool);
 static inline int xfs_buf_submit(struct xfs_buf *bp)
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 6fcc893dfc91..4b948cf2dd65 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -276,6 +276,7 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		__field(int, pincount)
 		__field(unsigned, lockval)
 		__field(unsigned, flags)
+		__field(unsigned short, rd_hint)
 		__field(unsigned long, caller_ip)
 	),
 	TP_fast_assign(
@@ -289,10 +290,11 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		__entry->pincount = atomic_read(&bp->b_pin_count);
 		__entry->lockval = bp->b_sema.count;
 		__entry->flags = bp->b_flags;
+		__entry->rd_hint = bp->b_rd_hint;
 		__entry->caller_ip = caller_ip;
 	),
 	TP_printk("dev %d:%d bno 0x%llx nblks 0x%x hold %d pincount %d "
-		  "lock %d flags %s caller %pS",
+		  "lock %d flags %s rd_hint %hu caller %pS",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long long)__entry->bno,
 		  __entry->nblks,
@@ -300,6 +302,7 @@ DECLARE_EVENT_CLASS(xfs_buf_class,
 		  __entry->pincount,
 		  __entry->lockval,
 		  __print_flags(__entry->flags, "|", XFS_BUF_FLAGS),
+		  __entry->rd_hint,
 		  (void *)__entry->caller_ip)
 )
 
@@ -312,6 +315,7 @@ DEFINE_BUF_EVENT(xfs_buf_free);
 DEFINE_BUF_EVENT(xfs_buf_hold);
 DEFINE_BUF_EVENT(xfs_buf_rele);
 DEFINE_BUF_EVENT(xfs_buf_iodone);
+DEFINE_BUF_EVENT(xfs_buf_ioretry);
 DEFINE_BUF_EVENT(xfs_buf_submit);
 DEFINE_BUF_EVENT(xfs_buf_lock);
 DEFINE_BUF_EVENT(xfs_buf_lock_done);
-- 
2.17.1

