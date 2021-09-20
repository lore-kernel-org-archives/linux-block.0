Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43A3C433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 09:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C12060F58
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 09:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhITJ3r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 05:29:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39396 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbhITJ3m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 05:29:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 77C011FE4F;
        Mon, 20 Sep 2021 09:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632130095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZV3Z2qToZweZs8QTz2OimWgiO8TTeuT6YjfFeWNPyY=;
        b=McOokvNLBLfN5l4sdy81ay/9CWn4l/P1+0hIqiF1zSIwtOJO8QQnT6zv6AHBeJauWzrwEK
        RBkzssfHLTlbdRaLWIAHN2SCfdBzhllEq017O4JsdTmT4ZsN/qdcQ3jlb2ZH3SpMRWUkkh
        oogH9qvO4Muq3YccHLWDpp8jZjVR2eE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632130095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZV3Z2qToZweZs8QTz2OimWgiO8TTeuT6YjfFeWNPyY=;
        b=N7ZpnOX0QpkinotDQgV/YQ9/rj83icoVxXAhg/Tgi81cpwntm9D2p/w4jdbfTit0BuxnKq
        3qLKBphCfcntdPBQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 6782CA3B89;
        Mon, 20 Sep 2021 09:28:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3E6761E0BF7; Mon, 20 Sep 2021 11:28:15 +0200 (CEST)
Date:   Mon, 20 Sep 2021 11:28:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jan Kara <jack@suse.cz>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] bfq: Limit number of allocated scheduler tags per
 cgroup
Message-ID: <20210920092815.GA6607@quack2.suse.cz>
References: <20210715132047.20874-1-jack@suse.cz>
 <751F4AB5-1FDF-45B0-88E1-0C76ED1AAAD6@linaro.org>
 <20210831095930.GB17119@blackbody.suse.cz>
 <20210915131512.GB6166@quack2.suse.cz>
 <AF7AAF20-7D9E-4305-901A-86A3717A9CFB@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AF7AAF20-7D9E-4305-901A-86A3717A9CFB@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat 18-09-21 12:58:34, Paolo Valente wrote:
> > Il giorno 15 set 2021, alle ore 15:15, Jan Kara <jack@suse.cz> ha scritto:
> > 
> > On Tue 31-08-21 11:59:30, Michal Koutný wrote:
> >> Hello Paolo.
> >> 
> >> On Fri, Aug 27, 2021 at 12:07:20PM +0200, Paolo Valente <paolo.valente@linaro.org> wrote:
> >>> Before discussing your patches in detail, I need a little help on this
> >>> point.  You state that the number of scheduler tags must be larger
> >>> than the number of device tags.  So, I expected some of your patches
> >>> to address somehow this issue, e.g., by increasing the number of
> >>> scheduler tags.  Yet I have not found such a change.  Did I miss
> >>> something?
> >> 
> >> I believe Jan's conclusions so far are based on "manual" modifications
> >> of available scheduler tags by /sys/block/$dev/queue/nr_requests.
> >> Finding a good default value may be an additional change.
> > 
> > Exactly. So far I was manually increasing nr_requests. I agree that
> > improving the default nr_requests value selection would be desirable as
> > well so that manual tuning is not needed. But for now I've left that aside.
> > 
> 
> Ok. So, IIUC, to recover control on bandwidth you need to
> (1) increase nr_requests manually
> and
> (2) apply your patch
> 
> If you don't do (1), then (2) is not sufficient, and viceversa. Correct?

Correct, although 1) depends on HW capabilities - e.g. for standard SATA
NCQ drive with queue depth of 32, the current nr_requests setting of 256 is
fine and just 2) is enough to recover control. If you run on top of virtio
device or storage controller card with queue depth of 1024, you need to
bump up the nr_requests setting.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
