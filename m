Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B5CC61DA4
	for <linux-block@archiver.kernel.org>; Tue, 14 Feb 2023 15:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjBNPGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Feb 2023 10:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjBNPGf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Feb 2023 10:06:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E766EF92
        for <linux-block@vger.kernel.org>; Tue, 14 Feb 2023 07:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676387149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YOYQQDP/bQ++BsAgx83j4BSl7EYN5IbXWPqjeqlaItI=;
        b=jHeJoo124sOClQAJlROc5ov5A1y07HU1dJ/kKjkgGWaLLwrY4LzFGuyqf5us8gegLcmV3o
        M/iGzHLp5J022O39qQEnIvTm35FZFhXrERdqk3+PD671Jk9vJO84gtaIYNpysWbfX/0T09
        BZNCL4r/6Nr9dRMK3gCG4v4DE3BZvbA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-NCWLeWzjP9K8yuD-7y7Psw-1; Tue, 14 Feb 2023 10:05:38 -0500
X-MC-Unique: NCWLeWzjP9K8yuD-7y7Psw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1488418E6C42;
        Tue, 14 Feb 2023 15:05:38 +0000 (UTC)
Received: from T590 (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10F9AC15BA0;
        Tue, 14 Feb 2023 15:05:34 +0000 (UTC)
Date:   Tue, 14 Feb 2023 23:05:29 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: sync mixed merged request's failfast with 1st
 bio's
Message-ID: <Y+ujOTfaesHzErb7@T590>
References: <20230209125527.667004-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209125527.667004-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 09, 2023 at 08:55:27PM +0800, Ming Lei wrote:
> We support mixed merge for requests/bios with different fastfail
> settings. When request fails, each time we only handle the portion
> with same failfast setting, then bios with failfast can be failed
> immediately, and bios without failfast can be retried.
> 
> The idea is pretty good, but the current implementation has several
> defects:
> 
> 1) initially RA bio doesn't set failfast, however bio merge code
> doesn't consider this point, and just check its failfast setting for
> deciding if mixed merge is required. Fix this issue by adding helper
> of bio_failfast().
> 
> 2) when merging bio to request front, if this request is mixed
> merged, we have to sync request's faifast setting with 1st bio's
> failfast. Fix it by calling blk_update_mixed_merge().
> 
> 3) when merging bio to request back, if this request is mixed
> merged, we have to mark the bio as failfast, because blk_update_request
> simply updates request failfast with 1st bio's failfast. Fix
> it by calling blk_update_mixed_merge().
> 
> Fixes one normal EXT4 READ IO failure issue, because it is observed
> that the normal READ IO is merged with RA IO, and the mixed merged
> request has different failfast setting with 1st bio's, so finally
> the normal READ IO doesn't get retried.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Fixes: 80a761fd33cf ("block: implement mixed merge of different failfast requests")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-merge.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Hi Tejun, Jens and Guys,

Any chance to take a look? The patch addresses one RH customer issue.


Thanks, 
Ming

