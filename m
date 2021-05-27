Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B18DC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E113613D3
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 06:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhE0Gzl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 02:55:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55122 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233762AbhE0Gzj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 02:55:39 -0400
X-Greylist: delayed 476 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 02:55:39 EDT
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 70381218D6;
        Thu, 27 May 2021 06:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1622097968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cUdguaf5AA5XDOdciV6pDFpokiuGGiK+ivP1GzQM0A=;
        b=GzpcEy/rrM43/jkNUDW0/7lZiQEggxniO0DF4oT4089pjUhbeIDdfl0TfytZqYnusTIwah
        jQqxu4/Wm1IG1QkuIhLErO1mq+ipkcmzDdUnul224CNYJKLnAqSMf3DW1h6x7LTmKGp9FS
        F+DP+uXlG1LfjwUEd+3khTAX2Eaulas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1622097968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cUdguaf5AA5XDOdciV6pDFpokiuGGiK+ivP1GzQM0A=;
        b=pGjgXtZlS+YauB9Sui2pviB2lU4KG9L9VkjKFffv8VIKb9YQVQ1/71P/b9O/BDbvvqNNW6
        /yjFqCKPHRPVQABw==
Received: from director2.suse.de (director2.suse-dmz.suse.de [192.168.254.72])
        by imap.suse.de (Postfix) with ESMTPSA id 5BF0911A98;
        Thu, 27 May 2021 06:46:08 +0000 (UTC)
Subject: Re: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <adam.manzanares@wdc.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-3-bvanassche@acm.org>
From:   Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <6722db4a-347e-2281-87a0-6c6daaba802f@suse.de>
Date:   Thu, 27 May 2021 08:46:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210527010134.32448-3-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/27/21 3:01 AM, Bart Van Assche wrote:
> Document the locking strategy by adding two lockdep_assert_held()
> statements.
> 
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		        Kernel Storage Architect
hare@suse.de			               +49 911 74053 688
SUSE Software Solutions Germany GmbH, 90409 Nürnberg
GF: F. Imendörffer, HRB 36809 (AG Nürnberg)
