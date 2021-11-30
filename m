Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0B7C433EF
	for <linux-block@archiver.kernel.org>; Tue, 30 Nov 2021 15:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239499AbhK3PrX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Nov 2021 10:47:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59370 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbhK3PrW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Nov 2021 10:47:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED1DD1FD58;
        Tue, 30 Nov 2021 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1638287040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+LxImOFfWaJr/KHQ23gVc45lrPs++Xkxk7rBfe/2r4=;
        b=p/fkOEHpMZYASCT2QRFSwkZsYRb2TvvX5xwITx0ApzDxgrmnk3AcRqzKrf6GVZxAQj8Qcc
        q3M54U51ruESOQqwzYHmBMDgSO02Y9MkcWBi1oj4dBUajk4pkC4OJ9ArSjGR08gOxMZZyS
        Q2AEutvSQ6aFMSdOGPWhynKSRcYB6MQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1638287040;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n+LxImOFfWaJr/KHQ23gVc45lrPs++Xkxk7rBfe/2r4=;
        b=9iL0/pesqLFX4XgTj7UtQMGsZ0hmwTGSPtZJLzzOGI5k7cXZZbR/3m67CbuB1kTXo1SsK2
        t3JLOvTx1+7rMlDQ==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id DEBBCA3B92;
        Tue, 30 Nov 2021 15:44:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7359B1E1494; Tue, 30 Nov 2021 16:43:59 +0100 (CET)
Date:   Tue, 30 Nov 2021 16:43:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/7] block: remove the nr_task field from struct
 io_context
Message-ID: <20211130154359.GK7174@quack2.suse.cz>
References: <20211130124636.2505904-1-hch@lst.de>
 <20211130124636.2505904-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130124636.2505904-2-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 30-11-21 13:46:30, Christoph Hellwig wrote:
> Nothing ever looks at ->nr_tasks, so remove it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
