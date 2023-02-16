Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83375C636D7
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 06:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBPGeB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 01:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPGeB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 01:34:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02866410A0
        for <linux-block@vger.kernel.org>; Wed, 15 Feb 2023 22:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676529198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YbrYERJ9XaGdZbLte00vvKVjWqo5ie2nK3zqWPAWmJ8=;
        b=dJlhLAUN6gCa3fWYFqFVBT6rKSs/oALi3syAlEcFmlQUq60qTm1CJzZLHESGosHpqzR3Hf
        tUw9EkOlpsl6V/PjX6FXdfDjQ7QiFZoSuvvPtHMjTKXxok6yyLgLo3skkaaxTC8Rk54LYE
        MUMVt1++12e0MkhVfDf9TXRnlbC5OIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-rHvtf8zjMp2qRXsTTBJsbg-1; Thu, 16 Feb 2023 01:33:16 -0500
X-MC-Unique: rHvtf8zjMp2qRXsTTBJsbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5409C85A5B1;
        Thu, 16 Feb 2023 06:33:16 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 620D52166B30;
        Thu, 16 Feb 2023 06:33:11 +0000 (UTC)
Date:   Thu, 16 Feb 2023 14:33:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jinke Han <hanjinke.666@bytedance.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [PATCH] block: Fix io statistics for cgroup in throttle path
Message-ID: <Y+3OInqy6EaeUfF8@T590>
References: <20230216032250.74230-1-hanjinke.666@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216032250.74230-1-hanjinke.666@bytedance.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 16, 2023 at 11:22:50AM +0800, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> In the current code, io statistics are missing for cgroup when bio
> was throttled by blk-throttle. Fix it by moving the unreaching code
> to submit_bio_noacct_nocheck.
> 
> Fixes: 3f98c753717c ("block: don't check bio in blk_throtl_dispatch_work_fn")
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Looks fine,

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming

