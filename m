Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96218C433EF
	for <linux-block@archiver.kernel.org>; Sat,  4 Jun 2022 02:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350169AbiFDCQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 22:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiFDCQe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 22:16:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C74F3879D
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 19:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654308992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CAVPgM6qZdc+rcFlXJ6cxNAqdIfu1YMLp42YefCDdmM=;
        b=bhIYuC63yTTE46WyO8LaveJ+ryGb1ahxVjGrp3/JSvbKKB2QROqXgVuuMv4NTpWohSmRNV
        Zg9QUHHuspBHOXMhPsNu9O3d/fP/zmxpNOHuMsvoLs6sjmZF4DscEJMOdyjr3S/6mWsTGt
        U3hTUjYY+nG2w987HAHc2Qq0BjtcADs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-561-WlB0nJM3Pb-0ptLsha05ag-1; Fri, 03 Jun 2022 22:16:29 -0400
X-MC-Unique: WlB0nJM3Pb-0ptLsha05ag-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EE1D2101A54E;
        Sat,  4 Jun 2022 02:16:28 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 171E7492C3B;
        Sat,  4 Jun 2022 02:16:24 +0000 (UTC)
Date:   Sat, 4 Jun 2022 10:16:19 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] blk-cgroup: Return -ENOMEM directly in
 blkcg_css_alloc() error path
Message-ID: <YprAc9uLaDPXUW2s@T590>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-3-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 02, 2022 at 03:20:19PM -0400, Waiman Long wrote:
> For blkcg_css_alloc(), the only error that will be returned is -ENOMEM.
> Simplify error handling code by returning this error directly instead
> of setting an intermediate "ret" variable.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Looks fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming

