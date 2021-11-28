Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C6C433EF
	for <linux-block@archiver.kernel.org>; Sun, 28 Nov 2021 10:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357182AbhK1KqQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Nov 2021 05:46:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40914 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhK1KoP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Nov 2021 05:44:15 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2B8B021763;
        Sun, 28 Nov 2021 10:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638096059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoUYTeiTe05NOzl1mSaTTf/IPafBnWE8Y3tO4aQmE7Q=;
        b=zdupO+EwOfEta0a3m/Ar6nmdMcXfPSgkytJbBj2CBi3GVqsSo6ErM/wE+WNVnZFwdTNaUy
        VTvzc9WWtEDnyydjAK1Q569kNuTbJrKNkilEL1eErNXd0d/E3ZI8zOPLqZGDib6xwp/Nk4
        gojKuAemY7d6f/64kfVyPly4bNzK2P4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638096059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BoUYTeiTe05NOzl1mSaTTf/IPafBnWE8Y3tO4aQmE7Q=;
        b=DGM51D7RGWzla8scWDhSsi/pea2ZHxCaM/DQWxPeP9gLzK+nA+fGSRWrQwenlR0Bk8ZaSH
        7UHEWoY5qlM4U1Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02EDE13446;
        Sun, 28 Nov 2021 10:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bh0xO7pco2HhSAAAMHmgww
        (envelope-from <hare@suse.de>); Sun, 28 Nov 2021 10:40:58 +0000
Subject: Re: [PATCH RFT 2/3] blk-mq: Delete busy_iter_fn
To:     John Garry <john.garry@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, kashyap.desai@broadcom.com
References: <1635852455-39935-1-git-send-email-john.garry@huawei.com>
 <1635852455-39935-3-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <1b733a65-85cc-4afc-6546-dec26334d2cd@suse.de>
Date:   Sun, 28 Nov 2021 11:40:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1635852455-39935-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/2/21 12:27 PM, John Garry wrote:
> Typedefs busy_iter_fn and busy_tag_iter_fn are now identical, so delete
> busy_iter_fn to reduce duplication.
> 
> It would be nicer to delete busy_tag_iter_fn, as the name busy_iter_fn is
> less specific.
> 
> However busy_tag_iter_fn is used in many different parts of the tree,
> unlike busy_iter_fn which is just use in block/, so just take the
> straightforward path now, so that we could rename later treewide.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   block/blk-mq-tag.c     | 6 +++---
>   block/blk-mq-tag.h     | 2 +-
>   include/linux/blk-mq.h | 1 -
>   3 files changed, 4 insertions(+), 5 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
