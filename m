Return-Path: <SRS0=37yO=WZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6788C3A59F
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB78022CEA
	for <linux-block@archiver.kernel.org>; Thu, 29 Aug 2019 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118843;
	bh=4Io0qdtnBpV0fKGKKFoTdzzV5/Z9V59BSGJOd7nlAyk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=HrRQRQ9bWWUoMbyr5PG/+snybaaDGxos1CHCEmuaJKf22PX+EpK4UshWMjlaEJtD2
	 pmLNxkiqIltATex2Xl2WP+mRU2yc+Qo9y+VNW5w6AbrexxlAWxGCnMDSl21de4wrrO
	 3wgpJYZq6bGJnpTPm54u+DgjBixXpGGL12Cg2hxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfH2WrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Aug 2019 18:47:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41269 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbfH2WrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Aug 2019 18:47:22 -0400
Received: by mail-qt1-f193.google.com with SMTP id i4so5594585qtj.8;
        Thu, 29 Aug 2019 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=stn8jXy5KV4bjvXX2LSzpfTIHdHk9m4JPzhqUrS1Dnc=;
        b=FXuiV4Lt2csrGq8gjKW5mbRzUJLfLE0M+xMbw2EPhdFZb9o5E0v2CfxMaVOMwSsLVl
         qTcSnR9TZ3pe2mcl1wWPY+JzuW9moF2lbK79MCt4luyK5LoBhw19Ka3EQsobFvil4Vqp
         /rZXia2R2/rmVTprJY3DQ0/yN6yGYv4LEd8p1SualAdb5rYidLgSwpONY3BR9+/Sl8CJ
         o7Bjhv2xXlSFgLeFPGIdY3BJ1JAJSGBzAPU0fc1KsQqiwXtYXmW/Bon5pWrx/rJPKUfC
         D3bqHY2i9jXs5jo7X8muRC2etpThtoj362eOGCFYTdfKGainbyqgH0s0WJd/T3hu6SHY
         LI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=stn8jXy5KV4bjvXX2LSzpfTIHdHk9m4JPzhqUrS1Dnc=;
        b=lB6rjgpo5XaR+dq/9xDmvrB73B/j4+ujwSrIIFgRGt96ikyIjPwDBewp0DNpUR/2lE
         K6Pml6t9yQLdH8wAPWYaDTvwLlleWdPk+hW1ICNmnyGdimGYpYXf+xctLp6b425LUhqx
         yy7YNy9TBOLu98M+buUTgqgqia8b4wpN5a0YtFR2Om8u5xWMcQSXhHhUOYOMVNWiHmem
         KtOz16qBJFY6cwoXNyenQrlZxZhJi41XNfQGoUA0r7lgjC4PwxEqKxnW/Wq/IDJHO9y2
         HX1zI6MMSnDYhHEU1mMgyhZx78XSahIH+A+lQEuob2nCgzfL+TYXZs9jCB9SZRAumx4P
         1u7Q==
X-Gm-Message-State: APjAAAXQLfq3Fk0vZIjrEb4akJ1duDW86W3pn6haYBUAZHKEXk/Zy8U7
        trmOm3NmslLjCroxJW4AMTw=
X-Google-Smtp-Source: APXvYqxMY6+rf8bZteHgghYY26rUA+pY61xHdRLP6pDlYcgGmy7+AW1LDbuNqdXYXSwSuzu3SRUJ1A==
X-Received: by 2002:a0c:9289:: with SMTP id b9mr3551708qvb.211.1567118841562;
        Thu, 29 Aug 2019 15:47:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:7e32])
        by smtp.gmail.com with ESMTPSA id e27sm2252064qte.14.2019.08.29.15.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2019 15:47:20 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:47:19 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH block/for-next] writeback: add tracepoints for cgroup foreign
 writebacks
Message-ID: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

cgroup foreign inode handling has quite a bit of heuristics and
internal states which sometimes makes it difficult to understand
what's going on.  Add tracepoints to improve visibility.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/fs-writeback.c                |    5 +
 include/trace/events/writeback.h |  123 +++++++++++++++++++++++++++++++++++++++
 mm/memcontrol.c                  |    5 +
 3 files changed, 133 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 658dc16c9e6d..8aaa7eec7b74 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -389,6 +389,8 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	if (unlikely(inode->i_state & I_FREEING))
 		goto skip_switch;
 
+	trace_inode_switch_wbs(inode, old_wb, new_wb);
+
 	/*
 	 * Count and transfer stats.  Note that PAGECACHE_TAG_DIRTY points
 	 * to possibly dirty pages while PAGECACHE_TAG_WRITEBACK points to
@@ -673,6 +675,9 @@ void wbc_detach_inode(struct writeback_control *wbc)
 		if (wbc->wb_id != max_id)
 			history |= (1U << slots) - 1;
 
+		if (history)
+			trace_inode_foreign_history(inode, wbc, history);
+
 		/*
 		 * Switch if the current wb isn't the consistent winner.
 		 * If there are multiple closely competing dirtiers, the
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index aa7f3aeac740..3dc9fb9e7c78 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -176,6 +176,129 @@ static inline unsigned int __trace_wbc_assign_cgroup(struct writeback_control *w
 #endif	/* CONFIG_CGROUP_WRITEBACK */
 #endif	/* CREATE_TRACE_POINTS */
 
+#ifdef CONFIG_CGROUP_WRITEBACK
+TRACE_EVENT(inode_foreign_history,
+
+	TP_PROTO(struct inode *inode, struct writeback_control *wbc,
+		 unsigned int history),
+
+	TP_ARGS(inode, wbc, history),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(unsigned long,	ino)
+		__field(unsigned int,	cgroup_ino)
+		__field(unsigned int,	history)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name, dev_name(inode_to_bdi(inode)->dev), 32);
+		__entry->ino		= inode->i_ino;
+		__entry->cgroup_ino	= __trace_wbc_assign_cgroup(wbc);
+		__entry->history	= history;
+	),
+
+	TP_printk("bdi %s: ino=%lu cgroup_ino=%u history=0x%x",
+		__entry->name,
+		__entry->ino,
+		__entry->cgroup_ino,
+		__entry->history
+	)
+);
+
+TRACE_EVENT(inode_switch_wbs,
+
+	TP_PROTO(struct inode *inode, struct bdi_writeback *old_wb,
+		 struct bdi_writeback *new_wb),
+
+	TP_ARGS(inode, old_wb, new_wb),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(unsigned long,	ino)
+		__field(unsigned int,	old_cgroup_ino)
+		__field(unsigned int,	new_cgroup_ino)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name,	dev_name(old_wb->bdi->dev), 32);
+		__entry->ino		= inode->i_ino;
+		__entry->old_cgroup_ino	= __trace_wb_assign_cgroup(old_wb);
+		__entry->new_cgroup_ino	= __trace_wb_assign_cgroup(new_wb);
+	),
+
+	TP_printk("bdi %s: ino=%lu old_cgroup_ino=%u new_cgroup_ino=%u",
+		__entry->name,
+		__entry->ino,
+		__entry->old_cgroup_ino,
+		__entry->new_cgroup_ino
+	)
+);
+
+TRACE_EVENT(track_foreign_dirty,
+
+	TP_PROTO(struct page *page, struct bdi_writeback *wb),
+
+	TP_ARGS(page, wb),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(u64,		bdi_id)
+		__field(unsigned long,	ino)
+		__field(unsigned int,	memcg_id)
+		__field(unsigned int,	cgroup_ino)
+		__field(unsigned int,	page_cgroup_ino)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
+		__entry->bdi_id		= wb->bdi->id;
+		__entry->ino		= page->mapping->host->i_ino;
+		__entry->memcg_id	= wb->memcg_css->id;
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
+	),
+
+	TP_printk("bdi %s[%llu]: ino=%lu memcg_id=%u cgroup_ino=%u page_cgroup_ino=%u",
+		__entry->name,
+		__entry->bdi_id,
+		__entry->ino,
+		__entry->memcg_id,
+		__entry->cgroup_ino,
+		__entry->page_cgroup_ino
+	)
+);
+
+TRACE_EVENT(flush_foreign,
+
+	TP_PROTO(struct bdi_writeback *wb, unsigned int frn_bdi_id,
+		 unsigned int frn_memcg_id),
+
+	TP_ARGS(wb, frn_bdi_id, frn_memcg_id),
+
+	TP_STRUCT__entry(
+		__array(char,		name, 32)
+		__field(unsigned int,	cgroup_ino)
+		__field(unsigned int,	frn_bdi_id)
+		__field(unsigned int,	frn_memcg_id)
+	),
+
+	TP_fast_assign(
+		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
+		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
+		__entry->frn_bdi_id	= frn_bdi_id;
+		__entry->frn_memcg_id	= frn_memcg_id;
+	),
+
+	TP_printk("bdi %s: cgroup_ino=%u frn_bdi_id=%u frn_memcg_id=%u",
+		__entry->name,
+		__entry->cgroup_ino,
+		__entry->frn_bdi_id,
+		__entry->frn_memcg_id
+	)
+);
+#endif
+
 DECLARE_EVENT_CLASS(writeback_write_inode_template,
 
 	TP_PROTO(struct inode *inode, struct writeback_control *wbc),
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eb626a290d93..b74c9d143d5e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4159,6 +4159,8 @@ static int mem_cgroup_oom_control_write(struct cgroup_subsys_state *css,
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 
+#include <trace/events/writeback.h>
+
 static int memcg_wb_domain_init(struct mem_cgroup *memcg, gfp_t gfp)
 {
 	return wb_domain_init(&memcg->cgwb_domain, gfp);
@@ -4296,6 +4298,8 @@ void mem_cgroup_track_foreign_dirty_slowpath(struct page *page,
 	int oldest = -1;
 	int i;
 
+	trace_track_foreign_dirty(page, wb);
+
 	/*
 	 * Pick the slot to use.  If there is already a slot for @wb, keep
 	 * using it.  If not replace the oldest one which isn't being
@@ -4356,6 +4360,7 @@ void mem_cgroup_flush_foreign(struct bdi_writeback *wb)
 		if (time_after64(frn->at, now - intv) &&
 		    atomic_read(&frn->done.cnt) == 1) {
 			frn->at = 0;
+			trace_flush_foreign(wb, frn->bdi_id, frn->memcg_id);
 			cgroup_writeback_by_id(frn->bdi_id, frn->memcg_id, 0,
 					       WB_REASON_FOREIGN_FLUSH,
 					       &frn->done);
