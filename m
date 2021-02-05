Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE0C0C4332E
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B5C64E7B
	for <linux-block@archiver.kernel.org>; Fri,  5 Feb 2021 02:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhBEClE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 21:41:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229741AbhBECkx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 Feb 2021 21:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612492765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5bn83n8Mnv4jhBjQZjCE0HJfiM3n4fNsp/V9eJl1PE=;
        b=cOLu8m4KPROK8AUdK9B3Gdwqm8/+aUZltWVTmfUubOHitKE4lmB9VknOpPb24zHGupU8Po
        jIh8iqRO+mKNsJ6sT4bJydI4ff1gwlbVzMuV7kCyLGx7gv6HXDiJdAdHJvOJnuFaMow0kb
        eIyfFwvcLgFt6OjHcB44oJRMFgjVIlI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-rxueXqjkMfWAm_nysfAjig-1; Thu, 04 Feb 2021 21:39:21 -0500
X-MC-Unique: rxueXqjkMfWAm_nysfAjig-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4E3CBBEE5;
        Fri,  5 Feb 2021 02:39:19 +0000 (UTC)
Received: from T590 (ovpn-13-14.pek2.redhat.com [10.72.13.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 819451002391;
        Fri,  5 Feb 2021 02:39:10 +0000 (UTC)
Date:   Fri, 5 Feb 2021 10:39:06 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     John Garry <john.garry@huawei.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, pragalla@codeaurora.org,
        axboe@kernel.dk, evgreen@google.com, jianchao.w.wang@oracle.com,
        linux-block@vger.kernel.org, stummala@codeaurora.org
Subject: Re: use-after-free access in bt_iter()
Message-ID: <20210205023906.GB1498829@T590>
References: <f98dd950466b0408d8589de053b02e05@codeaurora.org>
 <056783fa-a510-2463-f353-c64dd8f37be9@acm.org>
 <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1027dc3-d5a7-02c8-ef02-e34aeb12c0ac@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 04, 2021 at 04:17:51PM +0000, John Garry wrote:
> On 04/02/2021 15:51, Bart Van Assche wrote:
> > On 2/4/21 3:46 AM,pragalla@codeaurora.org  wrote:
> > > Is this issue got fixed on any latest kernel ? if so, can you please
> > > help point the patch ?
> > > If not got fixed, can we have a final solution ? i can even help in
> > > testing the solution.
> > Hi John,
> > 
> 
> Hi Bart,
> 
> > Some time ago you replied the following to an email from me with a
> > suggestion for a fix: "Please let me consider it a bit more." Are you
> > still working on a fix?
> 
> Unfortunately I have not had a chance, sorry. But I can look again.
> 
> So I have only seen KASAN use-after-free's myself, but never an actual oops.
> IIRC, someone did report an oops.
> 
> @Pradeep, do you have a reliable re-creator? I noticed the timeout handler
> stackframe in your mail, so I guess not. However, as an experiment, could
> you test:
> https://lore.kernel.org/linux-block/1608203273-170555-2-git-send-email-john.garry@huawei.com/
> 
> This should fix the common issue. But no final solution to issues discussed
> from patch 2/2, which is more exotic.
> 

If still no progress, I'd suggest to consider the patches I posted:

https://lore.kernel.org/linux-block/accb98d8-8186-2e74-a5c3-e0f09ce2b3ff@acm.org/#r

The idea is quite simple at least, :-)

-- 
Ming

