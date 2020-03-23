Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EACE7C10F26
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 07:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C338C20732
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 07:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCWHGH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 03:06:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55178 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWHGH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 03:06:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 605E9AFCA;
        Mon, 23 Mar 2020 07:06:05 +0000 (UTC)
Subject: Re: [PATCH 2/7] bcache: add bcache_ prefix to btree_root() and
 btree() macros
To:     Coly Li <colyli@suse.de>, axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
References: <20200322060305.70637-1-colyli@suse.de>
 <20200322060305.70637-3-colyli@suse.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <4242c8b7-0168-c554-c3ce-32bb0be0de84@suse.de>
Date:   Mon, 23 Mar 2020 08:06:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322060305.70637-3-colyli@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/20 7:03 AM, Coly Li wrote:
> This patch changes macro btree_root() and btree() to bcache_btree_root()
> and bcache_btree(), to avoid potential generic name clash in future.
> 
> NOTE: for porduct kernel maintainers, this patch can be skipped if
> you feel the rename stuffs introduce inconvenince to patch backport.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>   drivers/md/bcache/btree.c | 15 ++++++++-------
>   drivers/md/bcache/btree.h |  4 ++--
>   2 files changed, 10 insertions(+), 9 deletions(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare@suse.de                               +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
