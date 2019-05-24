Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB07DC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD857204EC
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 14:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403927AbfEXOq6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 10:46:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38954 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403997AbfEXOq5 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 10:46:57 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7F4281110;
        Fri, 24 May 2019 14:46:57 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9A552CFD6;
        Fri, 24 May 2019 14:46:54 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Setting up default iosched in 5.0+
References: <20190518093310.GA3123@avx2>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Fri, 24 May 2019 10:46:54 -0400
In-Reply-To: <20190518093310.GA3123@avx2> (Alexey Dobriyan's message of "Sat,
        18 May 2019 12:33:11 +0300")
Message-ID: <x49ftp329lt.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 24 May 2019 14:46:57 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Alexey,

Alexey Dobriyan <adobriyan@gmail.com> writes:

> 5.0 deleted three io schedulers and more importantly CONFIG_DEFAULT_IOSCHED
> option:
>
> 	commit f382fb0bcef4c37dc049e9f6963e3baf204d815c
> 	block: remove legacy IO schedulers
>
> After figuring out that I silently became "noop" customer enabling just
> BFQ didn't work: "noop" is still being selected by default.
>
> There is an "elevator=" command line option but it does nothing.
>
> Are users supposed to add stuff to init scripts now?

A global parameter was never a good idea, because systems often have
different types of storage installed which benefit from different I/O
schedulers.  The goal is for the default to just work.

If you feel that the defaults don't work for you, then udev rules are
the way to go.

If you also feel that you really do want to set the default for all
devices, then you can use the following udev rule to emulate the old
elevator= kernel command line parameter:

https://github.com/lnykryn/systemd-rhel/blob/rhel-8.0.0/rules/40-elevator.rules

Cheers,
Jeff
