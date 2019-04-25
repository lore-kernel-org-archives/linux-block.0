Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0AC43218
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2FD42077C
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 16:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfDYQXL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 12:23:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbfDYQXL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 12:23:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 26A4DAE32;
        Thu, 25 Apr 2019 16:23:10 +0000 (UTC)
Subject: Re: [PATCH 2/2] block: remove the i argument to
 bio_for_each_segment_all
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org,
        linux-bcache@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190425070300.3388-1-hch@lst.de>
 <20190425070300.3388-3-hch@lst.de>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <ba0bf822-3fd0-b385-1c13-074e5f161d44@suse.de>
Date:   Fri, 26 Apr 2019 00:23:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425070300.3388-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/25 3:03 下午, Christoph Hellwig wrote:
> We only have two callers that need the integer loop iterator, and they
> can easily maintain it themselves.
> 
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  block/bio.c                       | 29 ++++++++++-------------------
>  block/bounce.c                    |  3 +--
>  drivers/md/bcache/btree.c         |  3 +--

For the bcache part,

Acked-by: Coly Li <colyli@suse.de>


Thanks.

-- 

Coly Li
