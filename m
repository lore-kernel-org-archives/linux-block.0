Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB553C47095
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F16C215A4
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 15:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="WXydZ7GB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgJGPzU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 11:55:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38954 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPzU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 11:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z5udLltffkLJI9drucFdIqOZx1b8+mVHzFbzJoFwRjY=; b=WXydZ7GBEWK47T6TzK1Ygl7ZLD
        XJpRfRj7nQ8y95YWRPJ8rSMDbithPdnei+IbZAZV88PQg+pdC9eLUqC2Ilk74agTD9c8y6teLM0rS
        H70jpSMtJmcnvH27CgZAvJyMAi3jUYgu+nRyTaHcRYa9/LcvGViT2F20MWlmihXjvYD77Eo5v/+qb
        qwxfw9DUtFgICIZn+38Vh64w4roruEtmkkCDbc6Z7rFFX2rL2hN3Mb6KVWdgZMwhK+aTyIX21hy85
        GsnczW5aVnTHnEKtExl6qpkzYgOsDF3vpfA+TXsn7n4Kynjgpva4uuxaLdfDnQ5IRytwtKpYA8Ezk
        36jhqs2g==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kQBmf-0000Ah-KX; Wed, 07 Oct 2020 09:55:18 -0600
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        Stephen Bates <sbates@raithlin.com>
References: <20200930185422.11494-1-logang@deltatee.com>
 <20200930185422.11494-5-logang@deltatee.com>
 <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <517a5fd9-50eb-eb5e-5911-093dc5d1a759@deltatee.com>
 <BYAPR04MB49650C6419A84705D04FFE63860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <39ab50dd-b117-2e53-a7ca-b390ade7dd1e@deltatee.com>
Date:   Wed, 7 Oct 2020 09:55:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49650C6419A84705D04FFE63860A0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 6:24 p.m., Chaitanya Kulkarni wrote:
> On 10/6/20 17:10, Logan Gunthorpe wrote:
>>> With this patch or this series will I be able to write the testcase ?
>> This patch helps with that but other helpers introduced in this series
>> would require minor changes.
>>
>> As far as I can see, you'd only have to adjust _create_nvmet_passthru()
>> to take an optional argument because, presently, it always uses
>> $_test_dev_nvme_ctrl for the backing device.
>>
>> This can easily be done if and when someone writes such a test.
>>
>> However, I'm not even sure right now if that test would pass in the
>> kernel as is -- it seems like an odd thing to do.
>>
>> Logan
>>
> This test should pass if I remember the code correctly where we don't
> 
> have any PCIe specific checks for the passthru controller and it is an

Yes, there's no explicit restrictions, but that doesn't mean there are no bugs
with that particular stack.

> important to support this scenario in order to write device independent
> 
> testcases as rest of the testcases are.

Ok, feel free to write a test for this. It's not important to me.

Logan

