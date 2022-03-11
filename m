Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D649C433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Mar 2022 11:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbiCKL3h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Mar 2022 06:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiCKL3h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Mar 2022 06:29:37 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A905E02DD
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 03:28:34 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0645321122;
        Fri, 11 Mar 2022 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646998113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nXnVVU9mJr2oUWZo5uF4R5G+rKXl8MBZ78ucP/Gp1g=;
        b=S/1h7Drq/pXs8cIE7F4Y6skaN1u4iOWTcOSw8Tzd/tNIymNt3inrlZYRjhQHJh5QVMufSb
        m/4WHd4H4aP2Xd5mzjQkugW3SWgOnTnJvOql6KuyL6EylWK2bg9xZpSebFJExIJzg4kbVI
        ZpavvxMMIAiGpzBRw8XQ5Q1J/2fdH9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646998113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0nXnVVU9mJr2oUWZo5uF4R5G+rKXl8MBZ78ucP/Gp1g=;
        b=3w2CyyFuhTIP1sciBIjNCjSucd2+/1D0vey8ukacrfk3rbUv156idqsUmXvAk8ay1TNPOF
        DVZbSQAFXrwvQ1Aw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ED285A3B8A;
        Fri, 11 Mar 2022 11:28:32 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 35D93A0611; Fri, 11 Mar 2022 12:28:29 +0100 (CET)
Date:   Fri, 11 Mar 2022 12:28:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     "yukuai (C)" <yukuai3@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-block@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/4 v5] bfq: Avoid use-after-free when moving processes
 between cgroups
Message-ID: <20220311112829.li3i2rpns7npb7o3@quack3.lan>
References: <20220121105503.14069-1-jack@suse.cz>
 <4b44e8db-771f-fc08-85f1-52c326f3db18@huawei.com>
 <20220124140224.275sdju6temjgjdu@quack3.lan>
 <75bfe59d-c570-8c1c-5a3c-576791ea84ec@huawei.com>
 <20220202190210.xppvatep47duofbq@quack3.lan>
 <20220202215356.iomsjb57jmbfglt4@quack3.lan>
 <6ec28c27-1dce-33e3-1cb7-2e08892471bb@huawei.com>
 <20220209174055.yrlipalcrtetxelm@quack3.lan>
 <c238763f-cbac-d722-11c2-e0c6db9603ea@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c238763f-cbac-d722-11c2-e0c6db9603ea@huawei.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri 11-03-22 14:39:10, yukuai (C) wrote:
> 在 2022/02/10 1:40, Jan Kara 写道:
> > 
> > I had a look into debug data and now I think I understand both the WARN_ON
> > hit in bic_set_bfqq() as well as the final BUG_ON in bfq_add_bfqq_busy().
> > 
> > The first problem is apparently hit because __bio_blkcg() can change while
> > we are processing the bio. So bfq_bic_update_cgroup() sees different
> > __bio_blkcg() than bfq_get_queue() called from bfq_get_bfqq_handle_split().
> > This then causes mismatch between what bic & bfqq think about cgroup
> > membership which can lead to interesting inconsistencies down the road.
> > 
> > The second problem is hit because clearly __bio_blkcg() can be pointing to
> > a blkcg that has been already offlined. Previously I didn't think this was
> > possible but apparently there is nothing that would prevent this race. So
> > we need to handle this gracefully inside BFQ.
> > 
> > I need to think what would be best fixes for these issues since especially
> > the second one is tricky.
> 
> Hi, Jan
> 
> Just to be curiosity, do you have any ideas on how to fix these issues?

Sorry for the delay. I was on vacation and then busy with other stuff. I
have some version of the fixes ready but I want to clean them up a bit
before posting. It shouldn't take me long...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
