Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E27BC433E2
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED300208E4
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 22:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="YoR6c5kk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgINWXi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 18:23:38 -0400
Received: from ale.deltatee.com ([204.191.154.188]:52810 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINWXh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 18:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dqw1SaPMocuQT5PB+DtX7iJhle+q2CX18bBEWWD5sKs=; b=YoR6c5kkwh6cnaHidpiEswvMVr
        YDba6YAenPqeZjwYEv+FvO3MR6XhBPFup4LUv6JGHw1K/Dwdy9HUDwBSmu34GQe8aHRAWYpH9U9cJ
        r/yz2Pka32rfhf2WRJMOAxLnPNQ/QIdYQRW79b9rVHlOMhGe+hyGk+5O4RuFKfeaS6p04fhF4H3UO
        ylBYHDPdLZmyKW2OsXERo31r/jAgf/TcIAY5IeBR0AOZ2dPStoxHSwkdTYwYUqiD98LtxEXqFj1GA
        SQZi9jb5wNicuQol6EFAnRuTENwRlHly2SBs0PC8e7CROKzRhfOb0ovStYt3aBE2AB4Rgh7NP7jxn
        Twjhtvnw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kHwsm-00066X-MU; Mon, 14 Sep 2020 16:23:33 -0600
To:     Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200903235337.527880-1-sagi@grimberg.me>
 <20200903235337.527880-2-sagi@grimberg.me>
 <20200914215145.GA148663@relinquished.localdomain>
 <1c502865-5ac1-9952-1b79-fef0f61749c6@deltatee.com>
 <20200914220951.GD148663@relinquished.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com>
Date:   Mon, 14 Sep 2020 16:23:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914220951.GD148663@relinquished.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: hch@lst.de, kbusch@kernel.org, Chaitanya.Kulkarni@wdc.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me, osandov@osandov.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v7 1/7] nvme: consolidate nvme requirements based on
 transport type
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-09-14 4:09 p.m., Omar Sandoval wrote:
>> I noticed this too during my review, but based on my read of the current
>> blktest code, the return value of the requires() function is not
>> actually used. It seems to only check if SKIP_REASON is set.
>>
>> If we want to ensure the return value of requires() is correct, perhaps
>> we should check it after we call it and then consult SKIP_REASON? And
>> WARN or fail if SKIP_REASON is set when requires() didn't return 1.

> Oops, you're right, I actually changed this a few months ago in
> 4824ac3f5c4a ("Skip tests based on SKIP_REASON, not return value").
> Totally forgot about that :) IMO it's still cleaner to chain them
> together.

In my opinion, this creates a bit of confusion when reading the code.
The &&s make it look like the return value is important when, in fact,
it is not.

It is also easy to make the assumption that adding any bash command to
the && list will skip the test -- however that is not the case and
people may introduce subtle bugs that look correct, but go unnoticed.

Logan
