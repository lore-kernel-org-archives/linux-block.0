Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C5C6FA8E
	for <linux-block@archiver.kernel.org>; Sat,  4 Mar 2023 08:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCDIAe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Mar 2023 03:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDIAd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Mar 2023 03:00:33 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6834F10AB0
        for <linux-block@vger.kernel.org>; Sat,  4 Mar 2023 00:00:32 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F173B21FF0;
        Sat,  4 Mar 2023 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677916830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y6sL+0koV15HCEsLXsyTvxPxnQPCO+SWdqKpKczNZY=;
        b=GI8WRT5xK1by6ci2E2LlZkfedzk488NHl8RJLM+cQ8iOyrWdPS4tG/fLILYxXUx4YgUtzI
        UpNA9vt+0GTX+FQurQOcq9IQgr61Rf1jnpn/2/LlCzKPDB5ZfZ0/hl3E9Oi9crYE1VsA2Q
        1RJ3fec9bIOIBSBS02j1DTCPIy8sHJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677916830;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7y6sL+0koV15HCEsLXsyTvxPxnQPCO+SWdqKpKczNZY=;
        b=fUSHaDJfVOfVbeq5EAuWPRMWYMPOSjCWx12f/TOBjjD5sa7D9TtuKBoVnFylKP0DWQpXhK
        YkummfEZogyYmvDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6C08A13901;
        Sat,  4 Mar 2023 08:00:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EJ2KFp76AmTdFgAAMHmgww
        (envelope-from <hare@suse.de>); Sat, 04 Mar 2023 08:00:30 +0000
Message-ID: <80db29ee-70c7-5dad-cd5e-d2348d6d789d@suse.de>
Date:   Sat, 4 Mar 2023 09:00:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] nvme: fix handling single range discard request
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org
References: <20230303231345.119652-1-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230303231345.119652-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/4/23 00:13, Ming Lei wrote:
> When investigating one customer report on warning in nvme_setup_discard,
> we observed the controller(nvme/tcp) actually exposes
> queue_max_discard_segments(req->q) == 1.
> 
> Obviously the current code can't handle this situation, since contiguity
> merge like normal RW request is taken.
> 
> Fix the issue by building range from request sector/nr_sectors directly.
> 
> Fixes: b35ba01ea697 ("nvme: support ranged discard requests")
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 28 +++++++++++++++++++---------
>   1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index c2730b116dc6..d4be525f8100 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -781,16 +781,26 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
>   		range = page_address(ns->ctrl->discard_page);
>   	}
>   
> -	__rq_for_each_bio(bio, req) {
> -		u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> -		u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> -
> -		if (n < segments) {
> -			range[n].cattr = cpu_to_le32(0);
> -			range[n].nlb = cpu_to_le32(nlb);
> -			range[n].slba = cpu_to_le64(slba);
> +	if (queue_max_discard_segments(req->q) == 1) {
> +		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
> +		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
> +
> +		range[0].cattr = cpu_to_le32(0);
> +		range[0].nlb = cpu_to_le32(nlb);
> +		range[0].slba = cpu_to_le64(slba);
> +		n = 1;
> +	} else { > +		__rq_for_each_bio(bio, req) {
> +			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
> +			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
> +
> +			if (n < segments) {
> +				range[n].cattr = cpu_to_le32(0);
> +				range[n].nlb = cpu_to_le32(nlb);
> +				range[n].slba = cpu_to_le64(slba);
> +			}
> +			n++;
>   		}
> -		n++;
>   	}
>   
>   	if (WARN_ON_ONCE(n != segments)) {
Now _that_ is odd.
Looks like 'req' is not formatted according to the 'max_discard_sectors' 
setting.
But if that's the case, then this 'fix' would fail whenever 
'max_discard_sectors' < 'max_hw_sectors', right?
Shouldn't we rather modify the merge algorithm to check for 
max_discard_sectors for DISCARD requests, such that we never _have_
mis-matched requests and this patch would be pointless?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

