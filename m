Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D4AC282CE
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC1E20880
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 08:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfDHIa0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:30:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725877AbfDHIa0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 8 Apr 2019 04:30:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 36835AF79;
        Mon,  8 Apr 2019 08:30:25 +0000 (UTC)
Subject: Re: [PATCH] block: remove CONFIG_LBDAF
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     torvalds@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190405160859.5288-1-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <5cd01b3f-84c3-0159-1036-49fca809d171@suse.de>
Date:   Mon, 8 Apr 2019 10:30:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190405160859.5288-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/19 6:08 PM, Christoph Hellwig wrote:
> Currently support for 64-bit sector_t and blkcnt_t is optional on 32-bit
> architectures.  These types are required to support block device and/or
> file sizes larger than 2 TiB, and have generally defaulted to on for
> a long time.  Enabling the option only increases the i386 tinyconfig
> size by 145 bytes, and many data structures already always use
> 64-bit values for their in-core and on-disk data structures anyway,
> so there should not be a large change in dynamic memory usage either.
> 
> Dropping this option removes a somewhat weird non-default config that
> has cause various bugs or compiler warnings when actually used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
