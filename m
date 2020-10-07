Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D47C41604
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74E5215A4
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="HD9tfI+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgJGPxu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:53:50 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38936 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPxu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 11:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=zJTcEz7rUO3DGiHLK/RyvreZiaypX+Dmx17AyGTD6II=; b=HD9tfI+NEJ/ZdYCnN4Vyd50bYD
        9djIMgLs0BWD50ZiwbQya7jiej3acTgbPxw18TmVEgwO8a420Ypd4LhODFw8VATpEPF+s3SB6HNrC
        noG3ktwUXoCsQyPK0Cbx0RTHd61kbB73QbI2oSsu7nCPPSrZB3oFnibXik0Noa9i6a07TdUnxZkME
        oSwWxUx1rJg6mRn7ry1xCvHWg4ExyP4/ow0E20qZsqq0bS+hUGu/yJ7C8j/1YD1GQX68JDHYEVRYI
        TV3CMqTd771oXRH36uFy+c/c6Ywg5+4RKH8RyNAHfP3BbAQwxweepHm5Bf+WYGAQzGOyOMDD4E90k
        9ZzsTvSw==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kQBlC-00009t-E7; Wed, 07 Oct 2020 09:53:47 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-4-logang@deltatee.com>
 <BYAPR04MB4965C2DDD4A5FBD86A128FE9860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <868f8fb6-6024-d60d-a9aa-6513b9d0986f@deltatee.com>
 <BYAPR04MB49652338A4FE3805F9394A88860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2af98b64-1f3b-6570-d5be-a2e2bc4950f9@deltatee.com>
Date:   Wed, 7 Oct 2020 09:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49652338A4FE3805F9394A88860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 03/11] common/xfs: Create common helper to
 verify block device with xfs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 6:20 p.m., Chaitanya Kulkarni wrote:
> On 10/6/20 16:59, Logan Gunthorpe wrote:
>>> The mount dir should be a parameter and not the hardcode value
>>> to make it reusable.
>> I also disagree here. It is already reusable and is used in a number of
>> places; none of those places require changing the mount directory. If
>> and when a use comes up that requires a different directory (not sure
>> what that would be), a parameter can be added. It is typically standard
>> practice in the Linux community to not add features that have no users
>> as it's confusing to people reading the code.
>>
>> Logan
>>
> Well if you are making a helper it should be generic if you have a usecase,

"Generic" isn't a binary yes/no quality. Why add the mount option (that nobody is using) 
and not a size option as well that nobody uses? For that matter, fio has a ton of options
we could expose. (think io-method, read/write pattern, etc, etc). The criteria we
decide upon which options get exposed as arguments is what the code that's actually
using it needs -- not what's available or what you imagine future use cases might be.
If there are no users in the code it should not be exposed. If a use case comes along,
an argument can easily be added when the new test is added to the code base.

> mounted on different mount points not just one which is important testcase,
> 
> that will require a prep patch.

So? That's normal.
 
> Why can't we do that right now when we have a clear usecase ?

We don't have a clear use case that's being added to the code though... We 
have an imagined use case that hasn't been written. Add the feature when you
add this use case.

Logan
