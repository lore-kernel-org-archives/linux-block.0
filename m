Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C2C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 09:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35BE620835
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 09:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfEAJQy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 05:16:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfEAJQy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 May 2019 05:16:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A6903082134;
        Wed,  1 May 2019 09:16:54 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 10E8766614;
        Wed,  1 May 2019 09:16:48 +0000 (UTC)
Date:   Wed, 1 May 2019 17:16:41 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: Re: [PATCH 0/2] block/iov_iter: fix two issues related with
 BIO_NO_PAGE_REF
Message-ID: <20190501091639.GA14820@ming.t460p>
References: <20190426104521.30602-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426104521.30602-1-ming.lei@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 01 May 2019 09:16:54 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 26, 2019 at 06:45:19PM +0800, Ming Lei wrote:
> Hi,
> 
> Fix two issues related with BIO_NO_PAGE_REF, both are introduced
> recently in for-5.2/block.
> 
> Ming Lei (2):
>   block: fix handling for BIO_NO_PAGE_REF
>   iov_iter: fix iov_iter_type
> 
>  fs/block_dev.c      | 3 ++-
>  include/linux/uio.h | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> -- 
> 2.9.5
> 

Hi Jens,

The two page leak issues are quite serious, given whole system memory
can be consumed up easily in some dio tests.

Could you consider to merge them if you are fine?

Thanks,
Ming
