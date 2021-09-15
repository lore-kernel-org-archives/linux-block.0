Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F477C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7AC6121E
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 13:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhIONQe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 09:16:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58792 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234083AbhIONQd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 09:16:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 21FEB221F4;
        Wed, 15 Sep 2021 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631711713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEF7u8XU7SpeSaF4r255WFI/LWFnrYPZGiAayeaOZJU=;
        b=PrXj/5CckEFQedXHwOTos5jEI+itNwZQiSUhAHss2DYyRC5jlpNe5mta4wc5NtVZlyV8X5
        /k48GLs+GpZzuyeusScj6hz7Vj8JpPrWPXdbhXLSNwBgjpH+x/ZIDfhHNn8foLwXYKoJU0
        SHyl70JOseJmjwLo5FRDAste27y6UsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631711713;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rEF7u8XU7SpeSaF4r255WFI/LWFnrYPZGiAayeaOZJU=;
        b=HLkXkMI0URAR8Q4SAWr96N9biMt2ZReC6q1ZjRa3DvNDCxEQ7Hx7gp9BBVHYmGe3Yo7qEd
        wm9EiT1jV5E/U5Dg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 12F75A3B99;
        Wed, 15 Sep 2021 13:15:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C673E1E4318; Wed, 15 Sep 2021 15:15:12 +0200 (CEST)
Date:   Wed, 15 Sep 2021 15:15:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
Message-ID: <20210915131512.GB6166@quack2.suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
 <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
 <20210831095930.GB17119@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210831095930.GB17119@blackbody.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 31-08-21 11:59:30, Michal Koutný wrote:
> Hello Paolo.
> 
> On Fri, Aug 27, 2021 at 12:07:20PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> > Before discussing your patches in detail, I need a little help on this
> > point.  You state that the number of scheduler tags must be larger
> > than the number of device tags.  So, I expected some of your patches
> > to address somehow this issue, e.g., by increasing the number of
> > scheduler tags.  Yet I have not found such a change.  Did I miss
> > something?
> 
> I believe Jan's conclusions so far are based on "manual" modifications
> of available scheduler tags by /sys/block/$dev/queue/nr_requests.
> Finding a good default value may be an additional change.

Exactly. So far I was manually increasing nr_requests. I agree that
improving the default nr_requests value selection would be desirable as
well so that manual tuning is not needed. But for now I've left that aside.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
