Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC5C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 07:45:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiCVHqx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiCVHq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 03:46:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F720119
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647934962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDWJ/fJC0l4M5laoXcFLFn4ZLoEAgwp5vYUsFmVLS1g=;
        b=KcN2OP32CgHIEFuhWJTEp+YQhRTmE9pmIfZTVtjliUsEa/Q1ckC1wYV+WbXw9cVn7phbY/
        b+BORfpBE2JqnnoKUO9QTa9J8pvAGTJTqc6/Sz6A4+R51d+/I215sm/a2ONbdWsHZfB1NR
        +4Mga+i3Oofac46aZqrV+WJ9ezHR85k=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-v3XutSCZNmyk7HS9l3kw5g-1; Tue, 22 Mar 2022 03:42:39 -0400
X-MC-Unique: v3XutSCZNmyk7HS9l3kw5g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A32A3C11C62;
        Tue, 22 Mar 2022 07:42:39 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BF92778A;
        Tue, 22 Mar 2022 07:42:32 +0000 (UTC)
Date:   Tue, 22 Mar 2022 15:42:28 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] block: avoid use-after-free on throttle data
Message-ID: <Yjl95JV5yANdC/QK@T590>
References: <20220322065504.GA24523@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322065504.GA24523@kili>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Dan,

On Tue, Mar 22, 2022 at 09:55:04AM +0300, Dan Carpenter wrote:
> Hello Ming Lei,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch ee37eddbfa9e: "block: avoid use-after-free on throttle 
> data" from Mar 18, 2022, leads to the following Smatch complaint:
> 
>     block/blk-throttle.c:1189 throtl_pending_timer_fn()
>     error: we previously assumed 'tg' could be null (see line 1147)
> 
> block/blk-throttle.c
>   1146		/* throtl_data may be gone, so figure out request queue by blkg */
>   1147		if (tg)
>                     ^^
> The patch adds a new check
> 
>   1148			q = tg->pd.blkg->q;
>   1149		else
>   1150			q = td->queue;
>   1151	
>   1152		spin_lock_irq(&q->queue_lock);
>   1153	
>   1154		if (!q->root_blkg)
>   1155			goto out_unlock;
>   1156	
>   1157		if (throtl_can_upgrade(td, NULL))
>   1158			throtl_upgrade_state(td);
>   1159	
>   1160	again:
>   1161		parent_sq = sq->parent_sq;
>   1162		dispatched = false;
>   1163	
>   1164		while (true) {
>   1165			throtl_log(sq, "dispatch nr_queued=%u read=%u write=%u",
>   1166				   sq->nr_queued[READ] + sq->nr_queued[WRITE],
>   1167				   sq->nr_queued[READ], sq->nr_queued[WRITE]);
>   1168	
>   1169			ret = throtl_select_dispatch(sq);
>   1170			if (ret) {
>   1171				throtl_log(sq, "bios disp=%u", ret);
>   1172				dispatched = true;
>   1173			}
>   1174	
>   1175			if (throtl_schedule_next_dispatch(sq, false))
>   1176				break;
>   1177	
>   1178			/* this dispatch windows is still open, relax and repeat */
>   1179			spin_unlock_irq(&q->queue_lock);
>   1180			cpu_relax();
>   1181			spin_lock_irq(&q->queue_lock);
>   1182		}
>   1183	
>   1184		if (!dispatched)
>   1185			goto out_unlock;
>   1186	
>   1187		if (parent_sq) {
>   1188			/* @parent_sq is another throl_grp, propagate dispatch */
>   1189			if (tg->flags & THROTL_TG_WAS_EMPTY) {
>                             ^^^^^^^^^
> But the old code dereferences "tg" without checking.

Here if 'parent_sq' isn't NULL, tg won't be NULL, see sq_to_tg()


Thanks,
Ming

