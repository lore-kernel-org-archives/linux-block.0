Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FCC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3F820739
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 00:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="indJGTPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgJGAKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Oct 2020 20:10:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:32930 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgJGAKT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Oct 2020 20:10:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=j3Cr2cb8eBkvIoAig81+fwGrbmja7dlTy4mkKB0Hfy8=; b=indJGTPgJ9/eZYGcv3e0s7U2+T
        kcZQxuBq5DpObf9GiacIowKEqLciTiPlUnvdcP5fL3lT+ABtGvSVkZ9cEO95rjbmw2vbFpyebcT3U
        OFDLg3Oe/sDDXb8EuNbr6alvuWv6D1H/w/4Ri+yF42X7+PL6FveAxzxWva0Y1T0ma97VbqOFdV1RO
        5hS+7eha5PR364vK6YPnUJvgEcleB9ju3qocpQrkg28t2DhA9aUpMbbmjsatWt/jRnR5M7K5fv/xk
        5g6UtUgPKo7L7+KdrUvkMzH3AafaOJhS8Ev24rn0r79CoWp8Xqp/yPcbCETJe8RctZ5Cpaov4wQMp
        R4SBm0zg==;
Received: from [172.16.1.162]
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1kPx28-0007AV-Qe; Tue, 06 Oct 2020 18:10:17 -0600
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
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <517a5fd9-50eb-eb5e-5911-093dc5d1a759@deltatee.com>
Date:   Tue, 6 Oct 2020 18:10:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49657A481271ADC1F576377B860D0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Chaitanya.Kulkarni@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v2 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 2020-10-06 5:55 p.m., Chaitanya Kulkarni wrote:
> On 9/30/20 11:54, Logan Gunthorpe wrote:
>> This ensures we find the correct nvme loop device if others exist on a
>> given system (which is generally not expected on test systems).
>>
>> Additionally, this will be required in the upcomming test nvme/037 which
>> will have controllers racing with ones being destroyed.
>>
>> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> 
> If I create a passthru testcase with :-
> 
> 1. Create nvme-loop based nvme ctrl backed by null_blk say /dev/nvme1
> 
> 2. Create a nvme-loop based passthru ctrl backed by /dev/nvme1 say nvme2.
> 
> 
> With this patch or this series will I be able to write the testcase ?

This patch helps with that but other helpers introduced in this series
would require minor changes.

As far as I can see, you'd only have to adjust _create_nvmet_passthru()
to take an optional argument because, presently, it always uses
$_test_dev_nvme_ctrl for the backing device.

This can easily be done if and when someone writes such a test.

However, I'm not even sure right now if that test would pass in the
kernel as is -- it seems like an odd thing to do.

Logan
