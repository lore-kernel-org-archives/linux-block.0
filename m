Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3473AC48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 14:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06F7B61459
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 14:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFOOJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:09:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230076AbhFOOJ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 10:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623766042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UtTAmh9drC0SrvUfvER1V0LyFGa2wzxMUfvsdcM6wCo=;
        b=dRcpQqptjwrkbf2bwfRAHuJ9oAxbW5FbrVE2l/Ix/Vr5gL8qcdQTt6XsNlybc0fK9jJpLv
        S2HCCDXjVClzGT9DR8ktb52ucc++1UoDC3fQrzCYN2OW1bCoCMk7kNpFjCMKI1kQpthV+r
        AE0vmvY3LbSlofcpoGqa03dlToZ9X5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-Dc78i0rYOy-In_jZCE2b4Q-1; Tue, 15 Jun 2021 10:07:21 -0400
X-MC-Unique: Dc78i0rYOy-In_jZCE2b4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CA92803624;
        Tue, 15 Jun 2021 14:07:20 +0000 (UTC)
Received: from T590 (ovpn-12-65.pek2.redhat.com [10.72.12.65])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 116E660877;
        Tue, 15 Jun 2021 14:07:14 +0000 (UTC)
Date:   Tue, 15 Jun 2021 22:07:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Omar Kilani <omar.kilani@gmail.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: Deadlock in wbt / rq-qos
Message-ID: <YMi0C5U0NeMdO04g@T590>
References: <CA+8F9hggf7jOcGRxvBoa8FYxQs8ZV+XueVAd9BodpQQP_+8Pdw@mail.gmail.com>
 <YMhxY9svDeVApu95@T590>
 <CA+8F9hjFDE9b31-qsxsVJf4SV9Ctr-mwOJrsw0kVeC7DdN=5XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+8F9hjFDE9b31-qsxsVJf4SV9Ctr-mwOJrsw0kVeC7DdN=5XQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 06:42:40AM -0700, Omar Kilani wrote:
> Hi Ming,
> 
> It looks to be the same issue based on the log timelines. I *think* that
> patch will fix it but it’s really subtle so I’ll test.
> 
> I can only trigger this on an AMD Milan machine for some reason that I
> don’t understand. Sometimes in 800 seconds, sometimes in 5 hours.
> 
> I have a new build with printk’s on the atomic_inc_below to check the
> acquire condition.
> 
> I’ll add that patch and re-test. But I couldn’t find that change in the
> linux-block git? Is it in a specific branch?

The patch is in the branch of for-5.14/block:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.14/block&id=11c7aa0ddea8611007768d3e6b58d45dc60a19e1

Thanks,
Ming

