Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC49C433EF
	for <linux-block@archiver.kernel.org>; Thu,  7 Apr 2022 14:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242899AbiDGOST (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Apr 2022 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiDGOST (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Apr 2022 10:18:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC7E181D9F
        for <linux-block@vger.kernel.org>; Thu,  7 Apr 2022 07:16:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2263B1F85A;
        Thu,  7 Apr 2022 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649340977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qge20Ekuk8Pm3DEgLGtbIznDg/k54NnfqX3Glve+OeQ=;
        b=16aybM8S/PRIrOvyUcthbbtTQQxgg2RG1VkJzoWdzZGAPUFZ22djAS/ccWEyEVyJG8GGxy
        10rOrA/9Z3TI5/pJJ5+z/pK9T/R6xNHjhYlnMbQA+VdPAbi0Pihhh7F13reqa/vamP0Cxv
        IiwUF21QuxMnqvlJt8spMawRzG+5Rfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649340977;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qge20Ekuk8Pm3DEgLGtbIznDg/k54NnfqX3Glve+OeQ=;
        b=h1LBBVzkt+txlFFsMYhgN/Wk/2UsVzJ8eiFGaixA8Bpc6USTYP8KYarl3Y7MlLsKrrKAuW
        EYReOlvTuN/ZmMDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 10CE3A3B94;
        Thu,  7 Apr 2022 14:16:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BAE93A061A; Thu,  7 Apr 2022 16:16:16 +0200 (CEST)
Date:   Thu, 7 Apr 2022 16:16:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Chris Murphy <lists@colorremedies.com>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: 5.17, WARNING: at block/bfq-iosched.c:602
 bfqq_request_over_limit+0x122/0x3a0
Message-ID: <20220407141616.koxfr7vhhi4brqyg@quack3.lan>
References: <CAJCQCtTw_2C7ZSz7as5Gvq=OmnDiio=HRkQekqWpKot84sQhFA@mail.gmail.com>
 <d6626daa-94a3-6f76-53d9-a350e1db2d53@kernel.dk>
 <5C015FDB-B35D-45D3-9CE7-E3B2544DAA67@linaro.org>
 <6f72e1fa-6651-005a-7935-93b0450dce9f@huawei.com>
 <20220406160359.5stdu2unbu2kiva5@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406160359.5stdu2unbu2kiva5@quack3.lan>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed 06-04-22 18:03:59, Jan Kara wrote:
> Hello!
> 
> On Wed 06-04-22 09:44:55, yukuai (C) wrote:
> > 在 2022/04/04 22:35, Paolo Valente 写道:
> > > This seems to have to do with Jan's patches on tag allocation. I'm CCing him too. Jan, I'm willing to provide my usual dev version for testing, if useful.
> > 
> > I had observed this warning for a long time, and it's very to reporduce
> > by our reporducer for the problem that Jan fixed recently.
> > 
> > I thougt this warning is due to bfqq is associated with wrong cgroup,
> > which should be fixed by Jan's patch.
> > 
> > What do you think, Jan ?
> 
> Hum, the warning suggests that the blkcg's idea of cgroup hierarchy is not in
> sync with BFQ's idea of cgroup hierarchy. One possibility how this could
> happen is if bfqq is moved from one bfqg to another between the depth check
> and the for_each_entity() loop. This should actually get fixed as a
> side-effect of my patches because they change the logic so that alive bfqq
> can change parent only if they contain a single process. But nevertheless
> we should make the logic inside bfqq_request_over_limit() more robust in
> place of process moving between cgroups. So I'll send a patch for that on
> top of my patches.

Posted: https://lore.kernel.org/all/20220407140738.9723-1-jack@suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
