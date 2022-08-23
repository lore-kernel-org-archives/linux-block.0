Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D870CC32774
	for <linux-block@archiver.kernel.org>; Tue, 23 Aug 2022 12:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbiHWMSp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Aug 2022 08:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359737AbiHWMQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Aug 2022 08:16:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3519926D;
        Tue, 23 Aug 2022 02:41:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C3A5833B4A;
        Tue, 23 Aug 2022 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661247704; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yRu5XT+5vnVozy2B9jrgC9j7gnP78QLLHJ2olzlomGw=;
        b=NIFqyjZzrKwd1GfRkh8IWWX10l8YJnEFlnc7qU058Mtuw8PxMdfm/fmgYmPjvcNkYF5WiQ
        /MJuoK1BuB3qpyiSQPcv4eLdWCy2MwvER9mc5Uy5RsveC1YlPxfJtaP7atIzPIxMJpFgWY
        fOAwSXCJ5pTkKtr++8a6uZW6KGmogxI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A30913AB7;
        Tue, 23 Aug 2022 09:41:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IAuxINigBGOUeQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Tue, 23 Aug 2022 09:41:44 +0000
Date:   Tue, 23 Aug 2022 11:41:43 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, tj@kernel.org, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: Re: [PATCH v8 4/4] blk-throttle: fix io hung due to configuration
 updates
Message-ID: <20220823094143.GA1729@blackbody.suse.cz>
References: <20220823033130.874230-1-yukuai1@huaweicloud.com>
 <20220823033130.874230-5-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220823033130.874230-5-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello.

On Tue, Aug 23, 2022 at 11:31:30AM +0800, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  block/blk-throttle.c | 58 +++++++++++++++++++++++++++++++++++++++-----
>  block/blk-throttle.h |  9 +++++++
>  2 files changed, 61 insertions(+), 6 deletions(-)

I see v8 is just naming+comments [1] change, calculations remain, so it
can have

Reviewed-by: Michal Koutný <mkoutny@suse.com>

[1] I assume dropping of the overflow/signedness is intentional after
previous debate.

