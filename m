Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79B1C77B6C
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 22:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjC1WRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 18:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjC1WRT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 18:17:19 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF53A9E
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:17:08 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id l19-20020a056a0016d300b006257255adb4so6405661pfc.13
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 15:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680041827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3EqK7sQZOfVTLBQ7dVPZO4hRmfVfAzm1laH3BYvfeCs=;
        b=Jh0ANfJdLtvcj14Ycx8o0NJ4r9qhZa68Pa0uc2IX0QIjCZKetrfT/Nq/ZDVr5AllWU
         XClT4UcNh1sPOxMcsh6sWOQo9/2lETExd/HKLVBB2M4wtgPvzRmNcVBtdBrQWB7ALdhZ
         R5a35ECD7K8gif2eOzvhZ1FDX+1AdzcBxQSZ/AU6EUVqL3HECb2nu5rbm6oZEkaJmqE+
         JiSGi5TQPR/5oszlj+b2yUkvaRVAqFo8Ka4HGQ6Ui7wSkXSWPGkTPTug5dc09uPeC/es
         /a05azr2/gL04QjqP7TTdBynMB9W71leZpwkNhiYtT2r27tRHGjbrwcjlQFLDRhwcOoU
         qhHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680041827;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EqK7sQZOfVTLBQ7dVPZO4hRmfVfAzm1laH3BYvfeCs=;
        b=2OXECpP6mMZkyL6az8pnIKAIjmwzS7jAA00GrKAb48fZcczC0joTt5kzo+ISYJGexp
         OfmiiQcC4H521y4bBEIvw/lT1erRKbqrg9JO+ysFeqY8OVowR7Oaep5QCaP2PgwfYF1t
         vLvyJPGIwricSWKgj/WG8lWqFnHOL48qLFGDcmIf3uWGzLXkDS8iBiY3DlFDMuAf1paw
         wJGCehdYm68GPzy/POYK4/SDkOVjRkrDnBufSOcIOg502HTypsbHXOPnhRZuTOedaVco
         +yFyehZ7/9MdWvIS7w3ZoTuWyUWT6uh6pMjW7GO2Ix3ckPpGvAPCL9z9bb1L1543GyYN
         wAyQ==
X-Gm-Message-State: AAQBX9c1ZEoRv6RajmJQZ0vPudRFM40lePBtBNf2zJR29/zdxgacRC6J
        7UB8nb8edKxRVLFYnwuY8qTAPXmsMzz85NZm
X-Google-Smtp-Source: AKy350b8EHObFwTAz134ielB7Lfw4iTDwRchFeXjbgsPVENWxNL5SgSGxt3wM+3XFB7OgKxVRznr5DrlZ29gVq8P
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:fb57:b0:23d:30c2:c5b7 with SMTP
 id iq23-20020a17090afb5700b0023d30c2c5b7mr60436pjb.3.1680041826556; Tue, 28
 Mar 2023 15:17:06 -0700 (PDT)
Date:   Tue, 28 Mar 2023 22:16:44 +0000
In-Reply-To: <20230328221644.803272-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230328221644.803272-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230328221644.803272-10-yosryahmed@google.com>
Subject: [PATCH v2 9/9] memcg: do not modify rstat tree for zero updates
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>
Cc:     Vasily Averin <vasily.averin@linux.dev>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, bpf@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In some situations, we may end up calling memcg_rstat_updated() with a
value of 0, which means the stat was not actually updated. An example is
if we fail to reclaim any pages in shrink_folio_list().

Do not add the cgroup to the rstat updated tree in this case, to avoid
unnecessarily flushing it.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/memcontrol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 361c0bbf7283..a63ee2efa780 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -618,6 +618,9 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
+	if (!val)
+		return;
+
 	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
-- 
2.40.0.348.gf938b09366-goog

