Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7064FC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52782611BF
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 16:29:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFVQcG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 12:32:06 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59256 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFVQcG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 12:32:06 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 30F0E21971;
        Tue, 22 Jun 2021 16:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624379389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+J3rTZ6rcEmt8AzcmguItPUWTQk4QSYQ2yokivFmpo=;
        b=GOdC2HL0i61aLB8nUybGcMsdxNB1CMPHbl5xh171bIXapgAJUmNUWWo8C/5czLVz/ALHDs
        xGAHT1YvIn1VRbvqQC42GMNCopvTEbQ5baaywwBvtB6zKSQ0BrGEc2+KnlF3kDS+KyxT8g
        TJu2js1ex4ggRV+5AvkzUGDl+V9guLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624379389;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+J3rTZ6rcEmt8AzcmguItPUWTQk4QSYQ2yokivFmpo=;
        b=q9e6GFAlMo5ut1LBLdSeahTtH/lpNPv1nb96/vtSerNTfTjnrr5eL84KAyrD9r79n143qA
        brfffbCIwP071HAQ==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 01BCFA3B8E;
        Tue, 22 Jun 2021 16:29:48 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CCCCB1E1515; Tue, 22 Jun 2021 18:29:48 +0200 (CEST)
Date:   Tue, 22 Jun 2021 18:29:48 +0200
From:   Jan Kara <jack@suse.cz>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luca Mariotti <mariottiluca1@hotmail.it>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Khazhy Kumykov <khazhy@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH FIXES/IMPROVEMENTS 0/7] block, bfq: preserve control,
 boost throughput, fix bugs
Message-ID: <20210622162948.GJ14261@quack2.suse.cz>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
 <3533087.dJKXTdksHR@spock>
 <2CDC43F9-9CD9-4F7F-BD36-CCEB168B5245@linaro.org>
 <8003699.Qy64SzLKsf@spock>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8003699.Qy64SzLKsf@spock>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 22-06-21 09:35:05, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 22. června 2021 9:08:43 CEST Paolo Valente wrote:
> > CCing also Jan and Khazhy, because in your commit log I see also the
> > commit on bfq_requests_merged().
> > 
> > Is this OOPS reproducible for you?
> 
> No, I haven't found a reproducer, at least yet. It took half a day of uptime 
> to hit this, so might not be that easy.

Hum, if you can acquire a crash dump it would be the easiest I guess. We'd
need to find out more about the request we crash on - whether it's
otherwise valid, in what state it is etc...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
