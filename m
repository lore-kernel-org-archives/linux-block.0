Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C343C04EB8
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 11:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA922146D
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 11:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA922146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbeLDLgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:36:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40650 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeLDLgJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Dec 2018 06:36:09 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BCD7308339D;
        Tue,  4 Dec 2018 11:36:09 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25B585DE01;
        Tue,  4 Dec 2018 11:35:56 +0000 (UTC)
Date:   Tue, 4 Dec 2018 19:35:52 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>
Subject: Re: [PATCH] blk-mq: Set request mapping to NULL in
 blk_mq_put_driver_tag
Message-ID: <20181204113550.GA11121@ming.t460p>
References: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHsXFKFOBSmZeT9j7U2S6J4Af2k2ODe_pkFVGJg73v0Wp7O38A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 04 Dec 2018 11:36:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Dec 04, 2018 at 03:30:11PM +0530, Kashyap Desai wrote:
> Problem statement :
> Whenever try to get outstanding request via scsi_host_find_tag,
> block layer will return stale entries instead of actual outstanding
> request. Kernel panic if stale entry is inaccessible or memory is reused.
> Fix :
> Undo request mapping in blk_mq_put_driver_tag  nce request is return.
> 
> More detail :
> Whenever each SDEV entry is created, block layer allocate separate tags
> and static requestis.Those requests are not valid after SDEV is deleted
> from the system. On the fly, block layer maps static rqs to rqs as below
> from blk_mq_get_driver_tag()
> 
> data.hctx->tags->rqs[rq->tag] = rq;
> 
> Above mapping is active in-used requests and it is the same mapping which
> is referred in function scsi_host_find_tag().
> After running some IOs, “data.hctx->tags->rqs[rq->tag]” will have some
> entries which will never be reset in block layer.

However, if rq & rq->tag is valid, data.hctx->tags->rqs[rq->tag] should
have pointed to one active request instead of the stale one, right?

Thanks,
Ming
