Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F6C74A44
	for <linux-block@archiver.kernel.org>; Tue, 14 Mar 2023 03:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCND4q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 13 Mar 2023 23:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCND4n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Mar 2023 23:56:43 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5487DA6
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678766200; x=1710302200;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GblOj47hnS+4ZIpJ8tCfvCHdlaLv67OYRfr6hEzUKnE=;
  b=lZu6Ik31WA38G2mm/t1H4smMXb9YgbD6uRiCac7cJrv4tTR23BPat9S9
   Vbj+QTRAQDaEXeiVdaNcJ7odI2fnbT7yvwRpk1ygvtuiO9ka0BEB941al
   WywLoKlV6k2ORYm0CFvMWkI8kP7BZWzBe5FUf0emFQgIpTylPrdHq/mmO
   dgvwCpp4ChIwz+5g5FfJiXmiH+k+dgvgD7ipV5JhYCiuYR2dwRnfIvcvQ
   9qSiAHB2U/paTod99dFepUE2F94+0AX7Aiy0w0K2U+fzqIdum5CBdNblx
   AzRz1aSxX2zQXRNtnMa/R+NMqzPzN1mvDLQcHbfv9cAkFp9nnbDulASHL
   A==;
X-IronPort-AV: E=Sophos;i="5.98,258,1673884800"; 
   d="scan'208";a="230514169"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2023 11:56:40 +0800
IronPort-SDR: G+jfqjQULaz5EqrIfE7QKqcDWn+VM7krnu1zs0YtL9Nf7LuXbitMrLmaIDqUVaQGGkheYGTRM4
 rbudroN+17UTkPF+c01/BNYwsACTksH9EPp7Eq1TZXzaluXIgbpRjKzXZw2SbYyFpKD9QSvlko
 qqjMr9tjDb6k7a4+4J4fZtvfKoxpAWUvdrGhTGrpHzihBYH25LPffZY7M3uxdqYBlkJmMTv0gZ
 gZPyeUvQxILm7CVL3Jq9Bc6c8vmTRPUSAu22U24j+RkWipSI7nahIHzQXTmE8M7qrPu0b6nFYu
 4Q8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 20:07:27 -0700
IronPort-SDR: lEDLntpwqw5xDjMM5GQv3/ZeOVz1noMDDGtVsx3LOl2sUv6FreBay+gwIRvkkuI5tyTxgfc6JM
 Ez3rZ0Cc6oI/LDW+4jFIc89m8AvtyrnxamE3YuDgqxKalzWDPB6hPdM61xkwGaA4ku2Gn/IJCJ
 mySaHvYnoWCbV3VnZCrHztEC45SpX0eqD6F7HTdy6lGNo9+l7CUyARQ4uN8rr5EoHocPi63n81
 gFLfdJxY+x0BggrFczt64a1M/1adJb6nskrAmgwE/UlGNFcP+QYD8iuCqR7U3wLQ1DBeDbxQAk
 J84=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 13 Mar 2023 20:56:41 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PbKTM6c2sz1RtVp
        for <linux-block@vger.kernel.org>; Mon, 13 Mar 2023 20:56:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1678766199; x=1681358200; bh=GblOj47hnS+4ZIpJ8tCfvCHdlaLv67OYRfr
        6hEzUKnE=; b=TqzMQnSARBxNFJgn3wEKPE6J2AqZl/G0gvLZNM+XbKI3TW+8179
        hNH7LlMDDzIJRv2SQN1pMi75+/DDFSGpD+7tFR6qVnZFb1DtXwprnJjzqZPmxdV8
        WS/NtF4LoydGyaBrmXE6DKgujUeXC6nLyt1LvayLUsBb9iDL05GG9qDYBjwCYPcW
        nnIHJEd7DRD+zDYIEXQ12w90GCZ9Yv4riRRpkJlWvDA1znuFLzgc9bYZwsqgPYLo
        eAyCvncWNeulj3RE9L4P5fhoy8fZnyIznccz0IqZmLWqXI6vj9tONIIUNmpcWM00
        +V9EzqpzUSnbNE11s6HQ2pOBxgbmwl2QCPg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sFstM4IuRsnw for <linux-block@vger.kernel.org>;
        Mon, 13 Mar 2023 20:56:39 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PbKTL60jnz1RtVm;
        Mon, 13 Mar 2023 20:56:38 -0700 (PDT)
Message-ID: <91a7d0c6-8ecd-cbea-f5f0-52188cf62501@opensource.wdc.com>
Date:   Tue, 14 Mar 2023 12:56:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] null_blk: execute complete callback for fake timeout
 request
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <20230312123556.12298-1-akinobu.mita@gmail.com>
 <49cfce8b-042e-7248-928f-4a5c5f7d0e31@opensource.wdc.com>
 <ZA9UQgy/wy03xQ1j@kbusch-mbp.dhcp.thefacebook.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZA9UQgy/wy03xQ1j@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/14/23 01:50, Keith Busch wrote:
> On Mon, Mar 13, 2023 at 10:00:30AM +0900, Damien Le Moal wrote:
>> On 3/12/23 21:35, Akinobu Mita wrote:
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 4c601ca9552a..52d689aa3171 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1413,7 +1413,7 @@ static inline void nullb_complete_cmd(struct nullb_cmd *cmd)
>>         case NULL_IRQ_SOFTIRQ:
>>                 switch (cmd->nq->dev->queue_mode) {
>>                 case NULL_Q_MQ:
>> -                       if (likely(!blk_should_fake_timeout(cmd->rq->q)))
>> +                       if (!cmd->fake_timeout)
>>                                 blk_mq_complete_request(cmd->rq);
> 
> I think you can remove the fake_timeout check from here now since this function
> is never called when it's true.

Right. Sending a proper patch with that.

-- 
Damien Le Moal
Western Digital Research

