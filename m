Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B034BC433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 07:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiCGHhF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 02:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiCGHhE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 02:37:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C245F4F8
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 23:36:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CCD5D1F38E;
        Mon,  7 Mar 2022 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646638569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i79heGhM0+cw/60yWYFhxemETUFloV1wmq7aTwhXehI=;
        b=g/HQSkr+0zOE6gWeyxcoCAfKDlTH9fVxdZukVvMRDKezV+JUTI5KgvyuXlK5agh/hEpJTt
        wflrzFHBgIkr4v7xG0OrztE4w7W1f7a6ygVRQaY3J6bfe+O3dIZAwl78+rihZKALPDcI6r
        QrPqQ8wu4CcQaDlJVlOm4pboJe1TUHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646638569;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i79heGhM0+cw/60yWYFhxemETUFloV1wmq7aTwhXehI=;
        b=iscX/PWC6umfsgzGlPCHX9jpiyfKW7MzIGX6U+E+UIrjh6so94V9wuS0ter40dS/YmrrHi
        7+yYko2LF2BnHEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAC6713A04;
        Mon,  7 Mar 2022 07:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gcANLOm1JWLsVQAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 07 Mar 2022 07:36:09 +0000
Message-ID: <2025c918-9922-836a-9363-98c2e7dcc53a@suse.de>
Date:   Mon, 7 Mar 2022 08:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH V3 3/6] blk-mq: reconfigure poll after queue map is
 changed
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>
References: <20220307064401.30056-1-ming.lei@redhat.com>
 <20220307064401.30056-4-ming.lei@redhat.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220307064401.30056-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 07:43, Ming Lei wrote:
> queue map can be changed when updating nr_hw_queues, so we need to
> reconfigure queue's poll capability. Add one helper for doing this job.
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   block/blk-mq.c | 16 +++++++++++++---
>   1 file changed, 13 insertions(+), 3 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		           Kernel Storage Architect
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
