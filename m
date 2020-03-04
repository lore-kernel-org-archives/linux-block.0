Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9A9C3F2CD
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 12:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B5E21741
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 12:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQV4CPDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgCDMNc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 07:13:32 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726502AbgCDMNc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Mar 2020 07:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583324011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0AlLJlySgJflpiD8p5xjYnYy0wapGuU9+wJE1BBt5dE=;
        b=XQV4CPDZrB2YJdtn5C/P85Yt0Db3MI/M4wEfQo11Eh/CZSc0QhiQBNom0rwzMnFvXdX24y
        jDTj/bWusu9DeOhvh+0Xgt1t4ZlJJb2VGY+xOfavnOo/DYSPaP2SjIA75rGfsF3GgmXg+l
        BMryr2DmfNzOvnapJGbhCgKKvk3sFXU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-nylSmxiDN8K4IY2lXc9pJw-1; Wed, 04 Mar 2020 07:13:29 -0500
X-MC-Unique: nylSmxiDN8K4IY2lXc9pJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCBD100550E;
        Wed,  4 Mar 2020 12:13:27 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 39FAC8D57C;
        Wed,  4 Mar 2020 12:13:26 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed,  4 Mar 2020 13:13:27 +0100 (CET)
Date:   Wed, 4 Mar 2020 13:13:25 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Coly Li <colyli@suse.de>, axboe@kernel.dk,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mkoutny@suse.com
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
Message-ID: <20200304121324.GC13170@redhat.com>
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz>
 <20200302134919.GB9769@redhat.com>
 <20200303080544.GW4380@dhcp22.suse.cz>
 <20200303121918.GA27520@redhat.com>
 <20200303160307.GI4380@dhcp22.suse.cz>
 <20200304113613.GA13170@redhat.com>
 <20200304115718.GI16139@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304115718.GI16139@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/04, Michal Hocko wrote:
>
> So what would be a legit usecase to drop all signals while explicitly
> calling allow_signal?

Not sure I understand... Did you mean kthread should use kernel_dequeue
rather than flush?

Yes, they should do the same if kthread allows a single signal, iow if
it calls allow_signal() once.

But currently they differ.

1. flush_signal() is faster but we can optimize kernel_dequeue_signal().

2. kernel_dequeue_signal() does not necessarily clears TIF_SIGPENDING
   and I think this needs some fixes. Probably klp_patch_pending() is
   the only problem...

Oleg.

