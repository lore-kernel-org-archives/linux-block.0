Return-Path: <SRS0=QOfo=4T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD43C3F2D2
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522652187F
	for <linux-block@archiver.kernel.org>; Mon,  2 Mar 2020 13:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d6xYnQrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCBNt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:49:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44557 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726884AbgCBNt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 2 Mar 2020 08:49:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583156967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Euwc957JHVuZZnneWo2wuqYBPZ3mMB+2hqiWfeydWrM=;
        b=d6xYnQrOfGQr+REjdtnOloeZeidIrjK2K1R5KE9ri2iAAT37Lv7QjjxtmjHEVeazB6GrhV
        ge2pyf/nNqefwbMTJDwQJPV3z6Gtd5rs8i/gqVUUGXOW+ahL8EfC7A/z6Mzi/f84c5XiRn
        lMONeF9cBWZdZ7paFrsnPOmg+kwVU6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-9W5EV10OMlqs-XNFM04AXg-1; Mon, 02 Mar 2020 08:49:24 -0500
X-MC-Unique: 9W5EV10OMlqs-XNFM04AXg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 453BF800053;
        Mon,  2 Mar 2020 13:49:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.70])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9BFB35D9C9;
        Mon,  2 Mar 2020 13:49:20 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Mar 2020 14:49:22 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:49:19 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Coly Li <colyli@suse.de>, axboe@kernel.dk,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.de, mkoutny@suse.com
Subject: Re: [PATCH 1/2] bcache: ignore pending signals in
 bcache_device_init()
Message-ID: <20200302134919.GB9769@redhat.com>
References: <20200302093450.48016-1-colyli@suse.de>
 <20200302093450.48016-2-colyli@suse.de>
 <20200302122748.GH4380@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302122748.GH4380@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 03/02, Michal Hocko wrote:
>
> I cannot really comment on the bcache part because I am not familiar
> with the code.

same here...

> > This patch calls flush_signals() in bcache_device_init() if there is
> > pending signal for current process. It avoids bcache registration
> > failure in system boot up time due to bcache udev rule timeout.
>
> this sounds like a wrong way to address the issue. Killing the udev
> worker is a userspace policy and the kernel shouldn't simply ignore it.

Agreed. If nothing else, if a userspace process has pending SIKILL then
flush_signals() is very wrong.

> Btw. Oleg, I have noticed quite a lot of flush_signals usage in the
> drivers land and I have really hard time to understand their purpose.

Heh. I bet most if not all users of flush_signals() are simply wrong.

> What is the actual valid usage of this function?

I thinks it should die... It was used by kthreads, but today
signal_pending() == T is only possible if kthread does allow_signal(),
and in this case it should probably use kernel_dequeue_signal().


Say, io_sq_thread(). Why does it do

		if (signal_pending(current))
			flush_signals(current);

afaics this kthread doesn't use allow_signal/allow_kernel_signal, this
means that signal_pending() must be impossible even if this kthread sleeps
in TASK_INTERRUPTIBLE state. Add Jens.

Oleg.

