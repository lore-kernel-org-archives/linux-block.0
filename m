Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67411CDB474
	for <linux-block@archiver.kernel.org>; Fri, 13 Oct 2023 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjJMCDF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Oct 2023 22:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJMCDE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Oct 2023 22:03:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0908FD6
        for <linux-block@vger.kernel.org>; Thu, 12 Oct 2023 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697162534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1BZTAWCLnjPY0yXHnQbDlEMs44wsXzwC+R4ev+Nup1M=;
        b=TbpbpULOPS4S4EtOqug4aBBnnGhBIMFNPDlyPi86hZe3oy0iNS0w4BkYjX/glegRt0Pt80
        HeYwiB9PQxQcHyAxEWyqDHS014d3o8fCwG6m2KzMaApu14nhCHZXYkFLIFIl6wOzVXq31W
        hC7kkGnrmolllweSfVr+HfaKpFB4hZ8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-385-4u3xc-cXMd-J70mk6Nx6XQ-1; Thu, 12 Oct 2023 22:01:59 -0400
X-MC-Unique: 4u3xc-cXMd-J70mk6Nx6XQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0E9D988B7A6;
        Fri, 13 Oct 2023 02:01:59 +0000 (UTC)
Received: from fedora (unknown [10.72.120.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E997486F32;
        Fri, 13 Oct 2023 02:01:53 +0000 (UTC)
Date:   Fri, 13 Oct 2023 10:01:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>, ming.lei@redhat.com
Subject: Re: [PATCH] blk-mq: add module parameter to not run block kworker on
 isolated CPUs
Message-ID: <ZSilDBknf2yqDKNB@fedora>
References: <20231010142216.1114752-1-ming.lei@redhat.com>
 <ZSWb2DNV9cIPYv5H@slm.duckdns.org>
 <ZSXuqZNsyjJk1FGX@fedora>
 <ZShPS46jgVsaBGHY@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZShPS46jgVsaBGHY@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Tejun,

On Thu, Oct 12, 2023 at 09:55:55AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 11, 2023 at 08:39:05AM +0800, Ming Lei wrote:
> > I appreciate that any specific suggestions about dealing with isolated CPUs
> > generically for bound WQ can be shared.
> 
> Oh, all I meant was whether we can at least collect this into or at least
> adjacent to the existing housekeeping / isolcpu parameters. Let's say
> there's someone who really wants to isolated some CPUs, how would they find
> out the different parameters if they're scattered across different
> subsystems?

AFAIK, the issue is reported on RH Openshift environment and it is real use
case, some of CPUs are isolated for some dedicated tasks(such as network polling,
...) by passing "isolcpus=managed_irq nohz_full".

But blk-mq still queue kworker on these isolated CPUs, and cause very long
latency in nvme IO workloads. Joe should know the story much more then me.


Thanks,
Ming

