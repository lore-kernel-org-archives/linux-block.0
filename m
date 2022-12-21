Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF9BC4332F
	for <linux-block@archiver.kernel.org>; Wed, 21 Dec 2022 00:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiLUAuq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Dec 2022 19:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbiLUAun (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Dec 2022 19:50:43 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAFBDDE
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 16:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671583841; x=1703119841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mgy4QsxpsG/BZ8QSqbrCL7R/weUFusCtMwcZ/VyWzwI=;
  b=UCfUMzVf3vUec+ntMreOXHOFv8BV43vQ8CzfiNWIgX/1BTw6nBK0/G2e
   emZGx6wS1QHYiMP3v9OBNqMYho877nI0Qun3DHI7WziMfREIhUmQ/okVH
   1m2malwhznUpmFpaEDSgMNkI6AOlDhpG2jAJw6eHCIKbOAaCbzvHOnluw
   atxaX0mf7buFuVnfDnylFb2vH42emeqGGGSNClGkfmM17m6UqMNem7y5P
   RxrAp/pePyfV1UviT0twyGLnUG5WVK3FxsESPmZ0h+3i2PZzk1FuFbXDx
   cLo8DSSaMPQGs/qUN7OFoNQR/JDGNTtaB+Ea54owWxojiUQ4gE27zXB5W
   A==;
X-IronPort-AV: E=Sophos;i="5.96,261,1665417600"; 
   d="scan'208";a="219336232"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 08:50:41 +0800
IronPort-SDR: Ct+2vVjuZpnd3SHIEvwFpUkttzmFSWSwYtco6MPTmF8lwu2F7LPDTg3w9U2hZkjCPrr6s2ly52
 vR4DQvjjCEV4ikjw6vG/BjKK7obl6UHvCK8ReqXwZxe+nK5vuUPEggg1AM5PeETS6J7X/fYAq+
 zVAXveX8sZnTZ98QxMQRLrR4iQ2Q416uVE/p0x1bHllvRK/mDpu5npVvX6S6DJo7mRZzgV6hpG
 iB10izyz3/R4Ugxjl9PqH7mgo/jOa1EladyLSmHA6Jsz16wLQ0lYRngcYiFNMaySwJpydYo7wo
 EWQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:08:56 -0800
IronPort-SDR: cyT110tEyf151YGv/LCMqb6+RrI9DnUYjTvVCX37yiSkLt3qeTfq4bljvt+Gb+UeTn/VIGyHgv
 +BgvNKB8BFWxvKdCwGB1/hZBvxwirWT8R+GEdGaSN77LS5zj/evNKRjDf37VH+S0sgBCpCbtUu
 HdkEy/WSLLOIbMbXpChr0cV8+CyjtkgFRKEOMyWZzijBfAN53evL8Ef6wVl02UFRJzaEUYZSg0
 qPoiyohUIwp3AINP75LU9sFLxpULNWADp6zIBi6F6Y3JHNemEbV8CfBNWyQmgT142Nn2jPoUxG
 iqE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:50:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcFH50Gcmz1Rwt8
        for <linux-block@vger.kernel.org>; Tue, 20 Dec 2022 16:50:40 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671583840; x=1674175841; bh=Mgy4QsxpsG/BZ8QSqbrCL7R/weUFusCtMwc
        Z/VyWzwI=; b=SIsjgvseVLqJLxGdAr1X09eS9g9tD9cXJSa9Ny1lGW9cxwrMP7V
        094e1HPfMPY3+vtMZpFZjPO0u+e/z3LOHA+YaFEl61s6wkZXIxDt31IgqTXSPnqV
        pGh7qCfHr/pcN0QZ362ts+grXogGyIrcqF3DFcPq9TKzHrIl+Bkmt90NXoYfMdAm
        lL5CJWPwMD2nrqvfNeGsuE0m9DAOYLAxsDfSV8uhKS5gN99pwTnIaTIzTigby6fS
        0whQp6bnn/PqTIU+QDlfqpLSRq+duyyXlfl6Yl53LaMEPFYfs9JtRXNhfonJlDvW
        W4JnctW0+oclxmz+odFF0cEW2pD9+ghS/Zw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YzCNTbN5fmfN for <linux-block@vger.kernel.org>;
        Tue, 20 Dec 2022 16:50:40 -0800 (PST)
Received: from [10.89.80.120] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcFH30Y8wz1RvLy;
        Tue, 20 Dec 2022 16:50:38 -0800 (PST)
Message-ID: <eb58939f-567e-c0c1-bafb-383f18f3d58e@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 09:50:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH V10 1/8] block, bfq: split sync bfq_queues on a
 per-actuator basis
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arie van der Hoeven <arie.vanderhoeven@seagate.com>,
        Rory Chen <rory.c.chen@seagate.com>,
        Glen Valante <glen.valante@linaro.org>,
        Gabriele Felici <felicigb@gmail.com>,
        Carmine Zaccagnino <carmine@carminezacc.com>
References: <20221209094442.36896-1-paolo.valente@linaro.org>
 <20221209094442.36896-2-paolo.valente@linaro.org>
 <cd41583b-ef11-a3b7-1e39-c4a224050c7d@opensource.wdc.com>
 <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <60582F89-8020-4468-80FE-BC52202D1129@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/12/20 22:10, Paolo Valente wrote:
>>> -	/*
>>> -	 * Does queue (or any parent entity) exceed number of requests that
>>> -	 * should be available to it? Heavily limit depth so that it cannot
>>> -	 * consume more available requests and thus starve other entities.
>>> -	 */
>>> -	if (bfqq && bfqq_request_over_limit(bfqq, limit))
>>> -		depth = 1;
>>> +	for (act_idx = 0; act_idx < bfqd->num_actuators; act_idx++) {
>>> +		struct bfq_queue *bfqq =
>>> +			bic ? bic_to_bfqq(bic, op_is_sync(opf), act_idx) : NULL;
>>
>> Commented already: why not add a "if (!bfqq) return NULL;" in
>> bic_to_bfqq() ?
> 
> You have probably missed my reply on this.  The problem is that your
> proposal would improve code (only) here, but it would entail the above
> control for all the other invocations, for which it is useless :(

But then you have *a lot* of "if (bfqd)" tests that are useless elsewhere since
bic_to_bfqq() never returns NULL.

And for this line, I personally would prefer seeing something like:

		struct bfq_queue *bfqq;


		if (bic)
			bfqd = bic_to_bfqq(bic, op_is_sync(opf), act_idx)
		else
			bfqd = NULL;

Which is a lot simpler to read.


-- 
Damien Le Moal
Western Digital Research

