Return-Path: <SRS0=N1jC=SE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F56C43381
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 01:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EFF20657
	for <linux-block@archiver.kernel.org>; Tue,  2 Apr 2019 01:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfDBBCc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbfDBBCc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 21:02:32 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 54F0A3082E03;
        Tue,  2 Apr 2019 01:02:32 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 46B4319C7C;
        Tue,  2 Apr 2019 01:02:27 +0000 (UTC)
Date:   Tue, 2 Apr 2019 09:02:23 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: blk-merge warning in for-5.2/block
Message-ID: <20190402010222.GD21944@ming.t460p>
References: <100ac534-cce5-47d2-d703-e81fcbaca34f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <100ac534-cce5-47d2-d703-e81fcbaca34f@kernel.dk>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 02 Apr 2019 01:02:32 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 01, 2019 at 08:25:00AM -0600, Jens Axboe wrote:
> Hi Ming,
> 
> I'm getting this one when building the new set with gcc 8.3.0:
> 
> 
> -- In file included from block/blk-merge.c:13:
> block/blk-merge.c: In function ‘blk_rq_map_sg’:
> block/blk.h:73:56: warning: ‘bvec.bv_offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
>                                                     ~~~~^~~~~~~~~~~
> block/blk-merge.c:530:17: note: ‘bvec.bv_offset’ was declared here
>   struct bio_vec bvec, bvprv = { NULL };
>                  ^~~~
> In file included from block/blk-merge.c:13:
> block/blk.h:76:18: warning: ‘bvec.bv_len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>   if (addr1 + vec1->bv_len != addr2)
>               ~~~~^~~~~~~~
> block/blk-merge.c:530:17: note: ‘bvec.bv_len’ was declared here
>   struct bio_vec bvec, bvprv = { NULL };
>                  ^~~~
> In file included from ./arch/x86/include/asm/page.h:76,
>                  from ./arch/x86/include/asm/thread_info.h:12,
>                  from ./include/linux/thread_info.h:38,
>                  from ./arch/x86/include/asm/preempt.h:7,
>                  from ./include/linux/preempt.h:78,
>                  from ./include/linux/spinlock.h:51,
>                  from ./include/linux/seqlock.h:36,
>                  from ./include/linux/time.h:6,
>                  from ./include/linux/stat.h:19,
>                  from ./include/linux/module.h:10,
>                  from block/blk-merge.c:6:
> ./include/asm-generic/memory_model.h:55:52: warning: ‘bvec.bv_page’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
>                                                     ^
> block/blk-merge.c:530:17: note: ‘bvec.bv_page’ was declared here
>   struct bio_vec bvec, bvprv = { NULL };
>                  ^~~~

It is one issue only if one bio doesn't include any bvec, I will post a
patch soon to fix it.

Thanks,
Ming
