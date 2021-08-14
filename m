Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7B6C4338F
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 09:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB13860EE0
	for <linux-block@archiver.kernel.org>; Sat, 14 Aug 2021 09:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237645AbhHNJNf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Aug 2021 05:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237547AbhHNJNe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Aug 2021 05:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628932385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AgM9wQjlbA+g1qn4Zgr5hjXwUSBX0Df22ncvONuM9No=;
        b=a7RZ+QL86dAfNveU91m7HL8yrbpuqQyAMpl5KqFcYTonlzUK9b9knUAvmQbRr+h9obM3n6
        5fmb5PvQJZodDZ1CBj/5gRtRrbaBkkbFdnrLbX7jbeMl+jl3P2XJvR6DRla73FEt3Gos/K
        3e4QdQJNDE7QCcD1KKDnXUbpksWz3WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-l_UKb5ZgPBa4KBAH732zcA-1; Sat, 14 Aug 2021 05:13:03 -0400
X-MC-Unique: l_UKb5ZgPBa4KBAH732zcA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D61968042F4;
        Sat, 14 Aug 2021 09:13:01 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C31C73AC4;
        Sat, 14 Aug 2021 09:12:52 +0000 (UTC)
Date:   Sat, 14 Aug 2021 17:12:46 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH V4 0/7] loop: cleanup charging io to mem/blkcg
Message-ID: <YReJDkp8kswVdvBj@T590>
References: <20210806080302.298297-1-ming.lei@redhat.com>
 <20210809064159.GA19070@lst.de>
 <YRHx/qaKgEqWdXOP@T590>
 <20210812090037.GE2867@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812090037.GE2867@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On Thu, Aug 12, 2021 at 11:00:37AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 10, 2021 at 11:26:54AM +0800, Ming Lei wrote:
> > Can you share us what your expectations are in the re-write? Such as:
> > 
> > 1) no impact on normal non-cgroup path
> > 2) ...
> > 3) ...
> 
> Get the call cgroup mess out of this driver entirely?
 
Firstly the patch 2/7 in this series cleans up cgroup references by
killing unnecessary #ifdef and moving cgroup references into common
helpers, and the cgroup uses have been cleaned a lot.

Secondly the issue is that we need to wire proper cgroups(blkcg & memcg) for
loop's IO because loop uses wq or kthread for handling IO, and IMO it isn't
possible to moving cgroup references out of loop entirely if we want to
support this cgroup's function for loop driver.

Finally the current cgroup reference is actually very simple: retrieve
blkcg from bio_blkcg(bio) and memcg from the the blkcg. Then applies
the two in the single function of loop_workfn() only.


Thanks,
Ming

