Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116A4C3279D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3F15206F0
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WomVnvTx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgJGAOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:14:46 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32972 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgJGAOq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 20:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hUEDYTtYWRLTZhUJ1PsnTG6DKx8J9AiKmozhxnd9g4Y=; b=WomVnvTxGhGIUQZu62C6lncFUu
        W/EtMAVRX4r5X2yCavZqOW/QOtThugT/K6DAWw+hbKyAl5tBV+P2Z51HP2X19GPw652+tB9w3iGMg
        6YGVy+e33IEhaOmr1vKnHWF4NROcNJzeikdaR65s/8LLn+YYy36RYoEBqSVRF48uizjJyjuL5kRP0
        GikLOIGvasauzQVTy+nTD3m+Gi2CrRHLhd+FcTm142tYKDyNxhA1mjBXXhLB98SBi74UQ6OPfV/V7
        O4hHkrvHx8DXhuy0+t+CkUatb8nrM5A+vWoZ3LRCIEyvhDio6gzuEBaDaMU2FZpaa2WK/tioAwhiU
        yJ9ydGQA==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kPwjn-0006fK-Tc; Tue, 06 Oct 2020 17:51:20 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-3-logang@deltatee.com>
 <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <b809f785-fc8b-4fa5-5de2-26dc9a4aed94@deltatee.com>
Date:   Tue, 6 Oct 2020 17:51:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB4965388F1D0E70EDCEDD57E2860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 02/11] common/xfs: Create common helper to
 check for XFS support
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 5:44 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>>  
>>  requires() {
>>  	_nvme_requires
>> -	_have_program mkfs.xfs && _have_fio
>> +	_have_xfs
>> +	_have_fio
> Can you make _have_xfs return true false ? so it can be used with && ?

_have_xfs() does return true/false and can be used with && or in a
conditional.

Per [1], my opinion is that using && in the requires() function where
the return value is ignored is confusing so I prefer not to do it in new
code.

If we want to reconsider this we, should add a check to ensure the
return value of requires() matches the expectation of the global
variable it uses.

Logan

[1]
https://lore.kernel.org/linux-block/92478e6f-622a-a1ae-6189-4009f9a307bc@deltatee.com/
