Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B16C6FD1C
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 10:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCNKVT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Mar 2023 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjCNKUy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Mar 2023 06:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CC83155
        for <linux-block@vger.kernel.org>; Tue, 14 Mar 2023 03:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678789110;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B/Z2QQQ1avl7+e0bXhwsWl9iPkoZQ8xClewQEixlnLE=;
        b=MA67zkM+KCKA+kUHljKNyBR0ZDDIcBUR0PjJNKGfaP8KaiStQzCUqvkNfnHVhAZxJOAd0j
        OUaWBYlzeZZI5+pCc168+ZgwldLMCi+znGf3Qt9iCyS3/Sm1IRcEXwn6vcYX0FSxtOU5Cx
        xMGa1XLjxLSbh1QrsyZqcJ1aLj4Etkw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-erkaKMc2OfKWqj36CavsHg-1; Tue, 14 Mar 2023 06:18:29 -0400
X-MC-Unique: erkaKMc2OfKWqj36CavsHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7906A3C0DDAA;
        Tue, 14 Mar 2023 10:18:28 +0000 (UTC)
Received: from ovpn-8-18.pek2.redhat.com (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A0D8851FF;
        Tue, 14 Mar 2023 10:18:25 +0000 (UTC)
Date:   Tue, 14 Mar 2023 18:18:20 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH] block: do not reverse request order when flushing plug
 list
Message-ID: <ZBBJ7CLOurvOO3OQ@ovpn-8-18.pek2.redhat.com>
References: <20230313093002.11756-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313093002.11756-1-jack@suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 13, 2023 at 10:30:02AM +0100, Jan Kara wrote:
> Commit 26fed4ac4eab ("block: flush plug based on hardware and software
> queue order") changed flushing of plug list to submit requests one
> device at a time. However while doing that it also started using
> list_add_tail() instead of list_add() used previously thus effectively
> submitting requests in reverse order. Also when forming a rq_list with
> remaining requests (in case two or more devices are used), we
> effectively reverse the ordering of the plug list for each device we
> process. Submitting requests in reverse order has negative impact on
> performance for rotational disks (when BFQ is not in use). We observe
> 10-25% regression in random 4k write throughput, as well as ~20%
> regression in MariaDB OLTP benchmark on rotational storage on btrfs
> filesystem.
> 
> Fix the problem by preserving ordering of the plug list when inserting
> requests into the queuelist as well as by appending to requeue_list
> instead of prepending to it.

Also in case of !plug->multiple_queues && !plug->has_elevator, requests
are still sent to device in reverse order, do we need to cover that case?


Thanks,
Ming

