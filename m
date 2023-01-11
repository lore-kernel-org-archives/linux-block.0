Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB34C46467
	for <linux-block@archiver.kernel.org>; Wed, 11 Jan 2023 18:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjAKS7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Jan 2023 13:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjAKS6w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Jan 2023 13:58:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4611D3D1D2;
        Wed, 11 Jan 2023 10:58:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673463530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyK9122oW1BhwMiBWn/xwy03TseuZ2g0ffK+RsIcqsw=;
        b=2JHpGEBCwLk2oWup8iHq5gqahizThlAXiUt2YQiDCqMnurNAs/2HwKLpLYRQfoXJyx6eeZ
        98r2Cf3L9QSFHZcG0RicDNi/usu8ks4MZpddOIdGUywjnB2UIaASGNHEqrcADHu+fsi8IJ
        uiDWrjPaMwihn7enEThTAg7pfMfnoOzZy5LEh+wzYSD3uYALflsF9EffFIX3rCTOXthJis
        rA0haKRqGyIaNXPHmCozwwvy2LgZXC8XJrmTv7tZajMr9bP6TZgjqEWPMVOs4c1YhK/l3/
        vGESEj4BKzu6thm+zCpB9kW/oeLiwOt4v1jmC5Cn3+/a1Giae80hkVR6IfmI2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673463530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyK9122oW1BhwMiBWn/xwy03TseuZ2g0ffK+RsIcqsw=;
        b=Uyef1tCH8BOJYWt47vk91yc9spxCIMJxN2Oab5WXGOZNN/wuG2K/3ugGY2EXxYcEMYmbWx
        1P/y3oewOPVJ/hCA==
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
In-Reply-To: <Y74cXN4SP7FNtSl3@T590>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590>
Date:   Wed, 11 Jan 2023 19:58:50 +0100
Message-ID: <87zgaoew45.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 11 2023 at 10:18, Ming Lei wrote:
> On Tue, Dec 27, 2022 at 10:28:59AM +0800, Ming Lei wrote:
>> Hello,
>> 
>> irq_build_affinity_masks() actually grouping CPUs evenly into each managed
>> irq vector according to NUMA and CPU locality, and it is reasonable to abstract
>> one generic API for grouping CPUs evenly, the idea is suggested by Thomas
>> Gleixner.
>> 
>> group_cpus_evenly() is abstracted and put into lib/, so blk-mq can re-use
>> it to build default queue mapping.
>> 
>> blk-mq IO perf data is observed as more stable, meantime with big
>> improvement, see detailed data in the last patch.
>> 
>> Please consider it for v6.3!
>> 
>> V4:
>> 	- address comments from John, not export the API, given so far no
>> 	  module uses this symbol
>> 	- add maintainer entry for new added lib/group_cpus.c
>> 	- rebase on 6.2
>
> Any chance to take a look at this patchset?

I'm at it. My sickness+vacation induced backlog is horrible ....
