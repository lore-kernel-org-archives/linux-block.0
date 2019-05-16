Return-Path: <SRS0=mde3=TQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4EC04AB4
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FF5205C9
	for <linux-block@archiver.kernel.org>; Thu, 16 May 2019 08:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfEPIty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 May 2019 04:49:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:33324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbfEPIty (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 May 2019 04:49:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5869AEDB;
        Thu, 16 May 2019 08:49:53 +0000 (UTC)
Subject: Re: [PATCH 3/4] block: remove the segment size check in bio_will_gap
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
References: <20190516084058.20678-1-hch@lst.de>
 <20190516084058.20678-4-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <388e2afd-ed84-708c-c89d-8dc41d53d7d9@suse.de>
Date:   Thu, 16 May 2019 10:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516084058.20678-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/16/19 10:40 AM, Christoph Hellwig wrote:
> We fundamentally do not have a maximum segement size for devices with a
> virt boundary.  So don't bother checking it, especially given that the
> existing checks didn't properly work to start with as we never fully
> update the front/back segment size and miss the bi_seg_front_size that
> wuld have been required for some cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-merge.c | 19 +------------------
>   1 file changed, 1 insertion(+), 18 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
