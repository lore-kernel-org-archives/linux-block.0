Return-Path: <SRS0=wt6W=PH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E6CC43387
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 19:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B65CD2087F
	for <linux-block@archiver.kernel.org>; Sun, 30 Dec 2018 19:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeL3TPq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Dec 2018 14:15:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeL3TPp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Dec 2018 14:15:45 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0609880464;
        Sun, 30 Dec 2018 19:15:45 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6868C5C6DC;
        Sun, 30 Dec 2018 19:15:39 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wBUJFcoG009415;
        Sun, 30 Dec 2018 14:15:38 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wBUJFYLT009408;
        Sun, 30 Dec 2018 14:15:35 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sun, 30 Dec 2018 14:15:33 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Christoph Hellwig <hch@infradead.org>
cc:     Mike Snitzer <snitzer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        AliOS system security <alios_sys_security@linux.alibaba.com>,
        Colin Ian King <colin.king@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Milan Broz <gmazyland@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Shenghui Wang <shhuiw@foxmail.com>,
        Sweet Tea <sweettea@redhat.com>,
        wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>
Subject: Re: [git pull] device mapper changes for 4.21
In-Reply-To: <20181230090646.GB1022@infradead.org>
Message-ID: <alpine.LRH.2.02.1812301413220.7178@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181227160944.GA12190@redhat.com> <20181230090646.GB1022@infradead.org>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 30 Dec 2018 19:15:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Sun, 30 Dec 2018, Christoph Hellwig wrote:

> On Thu, Dec 27, 2018 at 11:09:44AM -0500, Mike Snitzer wrote:
> > - Fix various DM targets to check for device sector overflow if
> >   CONFIG_LBDAF is not set.
> 
> Question to Jens and Linus:
> 
> is there any good reason to keep the CONFIG_LBDAF=n option around?
> Less than 2gig block devices seem to be an absolutele niche, and I
> wonder if it is still worth maintaining the special case just for that.

The CONFIG_LBDAF limit is 2TiB, not 2GiB.

But you're right that 2TiB devices are common and that perhaps this option 
should go away.

Mikulas
