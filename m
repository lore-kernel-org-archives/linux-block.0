Return-Path: <SRS0=imVF=W2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC56C3A59B
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 23:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9862A2343A
	for <linux-block@archiver.kernel.org>; Fri, 30 Aug 2019 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567208399;
	bh=tepavUerUfnWjCraglwSvqGogI76BfV/2NaN1BKELR8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1erQ08IpKV2LvKw30fs684HOFJ/jq3J9KMeCB9XRyf7MrWSGh8IVYu+w5ZiXsMMxZ
	 1UId8fieDvuyW87a0AQN+RhRNsdRZtLZbOOyLculKnAkbCNEk+hoX3rxfYe7hU6/Vn
	 jG+DmoeOUWjGN6ij1/C/4VvPzOzC7qkaU3PzOTrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfH3Xj6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:39:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39918 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728237AbfH3Xj6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Aug 2019 19:39:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so7689585qki.6;
        Fri, 30 Aug 2019 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4zSHmBuu2z620JnQtJpjdnCiY4EyNxgyK8eXuy8Fp3g=;
        b=crrlzWVCPrad6E/l5gUOJeUFBDMbX2j42jRsRshhDO06W+hRwrtPoDupOYNX9YRJAS
         qnaa5R2MPgzHxkAKRiuhfPVvVLRyPRjcFQPhypTjiPF7t7eFlMfsEjVn3KyPHLDk0tqQ
         yzsUwnmgWOy++tGxNtoL8EJjG9cCf/a82pn9HBy5c0eyiyVMTDys9ARccj420+yyXD3M
         u/4j0d25UBsVS2oOWjfMOsVza8V1XM1cmrSPZjkQ84f8wIG6V/G+16MRkQM6ofxYrrBL
         dlIUE9zVIml5Qt9U1Nn4by/DEDj1Re1H7tzZmS4OJNf71UuwFJWukVGyB2Bq2WuQJAFd
         Om5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=4zSHmBuu2z620JnQtJpjdnCiY4EyNxgyK8eXuy8Fp3g=;
        b=TcjAQrfoR+WbvNr+dCO9X0MdGBh/CznZo6/1oxWw+zWyv9rkWkMCH7Lrr89AulmyWr
         uV+4iL2V0w+xqkhZ7pmQIHVU/okSnxszBCPVUfIEhnoaCTicHIpmuCT3mv9zrdBIvoRP
         VZq1O8nWVdkT7WFFB670uvkaJkEQgFIQVxPgFPX5E0BjRAXpB+KYFk4wjbpwZ8Op7t1E
         0k7I5TCvpjgtGEWC9JTJFQVGLfwJx5FJ7XnZc54PiZHoClO/+PL7w5o5bebJl2AIT7PX
         uDWzMGzGPC0Opifl4GLk2Ll2P9A2zA1s70SpoQtYdKGXmQ1gSR8HXOL3MKjZ+5RVUNJn
         FKZg==
X-Gm-Message-State: APjAAAVmrcDWQZ/Z/S54IA3i5VNqR5Lr9GAJLgzz2rZpgXvuk0Za0t8i
        /zK6DPwfUVBbUD/8dO+iQqE=
X-Google-Smtp-Source: APXvYqzzYmdlBxTIfr5O1rnxrjD1VLtmo8nqYlAbq7V/ubUjey9bDE5btLXe/5jb2phbO5KCpgThPQ==
X-Received: by 2002:a37:7cc3:: with SMTP id x186mr18149092qkc.169.1567208397456;
        Fri, 30 Aug 2019 16:39:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ca48])
        by smtp.gmail.com with ESMTPSA id q25sm3339719qkm.30.2019.08.30.16.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 16:39:56 -0700 (PDT)
Date:   Fri, 30 Aug 2019 16:39:54 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [block/for-next] writeback: don't access page->mapping directly in
 track_foreign_dirty TP
Message-ID: <20190830233954.GC2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

page->mapping may encode different values in it and page_mapping()
should always be used to access the mapping pointer.
track_foreign_dirty tracepoint was incorrectly accessing page->mapping
directly.  Use page_mapping() instead.  Also, add NULL checks while at
it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Jan Kara <jack@suse.cz>
Fixes: 3a8e9ac89e6a ("writeback: add tracepoints for cgroup foreign writebacks")
---
 include/trace/events/writeback.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 3dc9fb9e7c78..3a27335fce2c 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -251,9 +251,12 @@ TRACE_EVENT(track_foreign_dirty,
 	),
 
 	TP_fast_assign(
+		struct address_space *mapping = page_mapping(page);
+		struct inode *inode = mapping ? mapping->host : NULL;
+
 		strncpy(__entry->name,	dev_name(wb->bdi->dev), 32);
 		__entry->bdi_id		= wb->bdi->id;
-		__entry->ino		= page->mapping->host->i_ino;
+		__entry->ino		= inode ? inode->i_ino : 0;
 		__entry->memcg_id	= wb->memcg_css->id;
 		__entry->cgroup_ino	= __trace_wb_assign_cgroup(wb);
 		__entry->page_cgroup_ino = page->mem_cgroup->css.cgroup->kn->id.ino;
