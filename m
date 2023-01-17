Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB109C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 08:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbjAQIHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 03:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235887AbjAQIHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 03:07:31 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519C693C3
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673942850; x=1705478850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h+hpWb1N2z+sU/R5W+ZfOI5VrXzlmlexOMQc9+gqGoI=;
  b=n7rceKAJ2gvN9KQxNYgiGFj9I/1WOPJ7Cuzkmp4wkNmoGd7WwCHA59Ao
   ckKXmeeYDAKWFbY2oQ76qb8USY1FXTbwK9ZvXJGJ1KSSQnt1gK32QS2zp
   ejE/V9L1wFASDbihPoptXQ670Xhu5iE0OZ2Cz872ySaGxBV4y95Kab9A3
   DQXWLc2F/JhsdX+mOh/moTtrbOzms7PfXTsQYA+2PWB5JDQl0Nf3oJueb
   MRq3OQFow0HvSasESmRnM5aJR1FXXOjoNLJC0lNiOE8DwwP7Xe7hFuIhH
   OGLkmRP+rMNNtNeGw2gW+x74wqiycoyqC+tCVdMXLlTi3XL6BoIKgtSMt
   g==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="219318752"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 16:07:29 +0800
IronPort-SDR: CX3RX0ktcms+WgBwLBH3TgJzksqJVv1KrneF1vSQ8d4uf/KPWSp39OruON8Eb/yyjkVvIxZg2i
 3giCMPmOaqKELa3t/M5PIy/aKUhFmx2pXOX7d7Ona63EibSPB3/EU/Fb33cqjysf6AbpAL0ICI
 7Amm0Tq8a1FTVzzK11PuVNJcoNAttk/3D0iUcaax/q27XKWL4gf/lv/Fum0KqrLZ6KXPuwbt5U
 wHxXuIoo32kN/nM7tw1FDnpawymf5BdnFJTIaeG5dowGGRiUmI1ZbXr0QV6z0xHgCBr0RJdlcL
 eKY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 23:24:37 -0800
IronPort-SDR: mX/wWisAbxSLHcUHUn4KdeZIL2m5fR3nyfxtgxuBIIP+I2u4tCp14aP3UL20XFlf7pdpW6ssFk
 pWQj5/6MsZrtqCTKrxuUyzu4vQ+PxZX9vRBgnpAGifbjQyRhZkjM5tSi+GNLuo+laiCcioXK+e
 ON+0TegVJu7MXHyLkSmB3zJwzbQHVf3HsvsusIccDq3N3oaDXncuKuiqIPMgQzEhkdjUuHMJhb
 xXiAWHHAA9lI05WCM1DenEYQiYHH1AJb+7/uUa+51xMpEIwhEHJRVZsbLaQqBVjsIv9hl3jnA3
 4Sw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Jan 2023 00:06:56 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Nx1gz1CCJz1RvTr
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 00:06:55 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673942814; x=1676534815; bh=h+hpWb1N2z+sU/R5W+ZfOI5VrXzlmlexOMQ
        c9+gqGoI=; b=iHt7q5R6/sEMGvZ/mKYvjSUXdc8Z2SGxfcYpbOLKOwiR4XeNv9Y
        s/1MJEBcguILOW5Pr0FX4Ip2j/8KPCrzLLqsaZVyApGBIUTo1gPEnLr2zLanV1Z6
        K/FK/xqBF6hqu/1WIWobJ5gyFZ8pdaVpmKAq/o2qbzDL8ajfBt2vGMUMl6DKzY37
        f9rsI4zDi2hBL9uJVFximnJ08YMeCcWHnppHghhV285D0lTlGJ5zJmIY+6DXaXva
        +9SNheIQ2i/Q9r2n7GnV1C7ODQ45P7IuMCyWuAxnrTvnCjaL0xNl7fXScqSOuxMi
        7bz+QUbVMBbidxXD2JhHnooxMOU+8+FgVMQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N-A4veIPETG4 for <linux-block@vger.kernel.org>;
        Tue, 17 Jan 2023 00:06:54 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Nx1gx2ppjz1RvLy;
        Tue, 17 Jan 2023 00:06:53 -0800 (PST)
Message-ID: <2bd49412-de68-91d3-e710-0b24fed625d2@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 17:06:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 07/18] block: introduce duration-limits priority class
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
References: <20230112140412.667308-1-niklas.cassel@wdc.com>
 <20230112140412.667308-8-niklas.cassel@wdc.com>
 <Y8ZNftvsEIuPqMFP@infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y8ZNftvsEIuPqMFP@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 16:25, Christoph Hellwig wrote:
> On Thu, Jan 12, 2023 at 03:03:56PM +0100, Niklas Cassel wrote:
>> From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
>>
>> Introduce the IOPRIO_CLASS_DL priority class to indicate that IOs should
>> be executed using duration-limits targets. The duration target to apply
>> to a command is indicated using the priority level. Up to 8 levels are
>> supported, with level 0 indiating "no limit".
>>
>> This priority class has effect only if the target device supports the
>> command duration limits feature and this feature is enabled by the user.
>> In BFQ and mq-deadline, all requests with this new priority class are
>> handled using the highest priority class RT and priority level 0.
> 
> Hmm, does it make sense to force a high priority?  Can't applications
> use CDL to also fore a lower priority?

They can, by using a large limit for "low priority" IOs. But then, these
would still have a limit while any IO issued simultaneously without a CDL
index specified would have no limit at all. So strictly speaking, the no
limit IOs should be considered as even lower priority that CDL IOs with
large limits.

The other aspect here is that on ATA drives, CDL and NCQ priority cannot
be used together. A mix of CDL and high priority commands cannot be sent
to a device. Combining this with the above thinking, it made sense to me
to have the CDL priority class handled the same as the RT class (as that
is the one that maps to ATA NCQ high prio commands).

-- 
Damien Le Moal
Western Digital Research

