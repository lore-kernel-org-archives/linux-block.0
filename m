Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE02C05027
	for <linux-block@archiver.kernel.org>; Sun, 12 Feb 2023 12:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBLMSb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 12 Feb 2023 07:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjBLMSa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 12 Feb 2023 07:18:30 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF14217
        for <linux-block@vger.kernel.org>; Sun, 12 Feb 2023 04:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676204270; x=1707740270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U0pE+Um/t6PUndwLm9q+39ASUQUXQbmHYp5YVcs+D4w=;
  b=ANC6pBfFmZuSEk9a9PILt+bEQlGDZokXEcsOrQ4X0QkpkjLVxyFJeCnS
   7NwrHdsI+i4bw3YtFGyk1nRSlGxOw9qN/18L/6FWVUDp8LTH8X2s9CGsm
   vq70R1Gukzq2n5Ymt/zqn00yaPwO63genTYAfn/1CvtgoyAkMndi9ZNqa
   zcpvorlKpKWxPHRHaB/VX+IjRjLYY3lhTqzeXePqHaJG+Ph3cRG+ZP9wY
   FEF2K5DKubMWkjnnFYAsZItlc9TE7B74SMd2N8CqIArDVC8rpLYRe/DlQ
   cEkYszFqG71j7Nc6ctlcmGZKpjXC/JRjtJKfzQ/s9jusuHQ0Yzzqd1vPj
   A==;
X-IronPort-AV: E=Sophos;i="5.97,291,1669046400"; 
   d="scan'208";a="335072295"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2023 20:17:14 +0800
IronPort-SDR: DMAqMpxUQdYDNkILEWcjQ5hitJXgf9ojvQNeOkTLs02WkvdHeuSBmit3eky+tIJTHb6CM3FopT
 7uBYsqFOFn69xaCMYSnK4/3tqUI2h9giO8mrFszuSKzZv/8jlMhBgSul5Um5/hpyD/Xhy/fu6p
 OgcC7px4BsbnVBy3UnpRi0rFPiQzdDWKn7ZkjAh9D5lWUaIK9d58QKn9vFRdo6s2uOQi1hcrJ9
 5zuXlElo1fRemtxXMjUQ4AtOb8NpDptOo53yfmL96ins4Us/j02UuezSXHOFn+HSadWECxN5cF
 7LY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 03:28:40 -0800
IronPort-SDR: RGa0t0T965HHwZvAF/xQcrPlDmvpQeiZ+XYJ6Jnkt8Wjt/tYBQhPJUd/P9a9ARb3jTA4TQT3Vw
 Ew2wRo/qMjalhP1VIppiHwp8Z8zdmtbbyBHfgfncqCC6d62DW8VXi2rg4pejpk7/qgHUUXMuJk
 mrCXrVm3Ti/pa3fWvjl978gPLdfdQZMYhNePTw10o3pB3nuCC3heYQ9SYyxW8U51RGpAOHQaKk
 g8DsWVW7y7yojbpN34RGDT+QyKl6QF5VQQeuxhAAKRmrS5vrXfHBS0cf+OT1HrcKhLippyQbMf
 YFU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2023 04:17:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PF60n6B0Rz1RvTr
        for <linux-block@vger.kernel.org>; Sun, 12 Feb 2023 04:17:13 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1676204233; x=1678796234; bh=U0pE+Um/t6PUndwLm9q+39ASUQUXQbmHYp5
        YVcs+D4w=; b=Jkc4HP1D637Cnlsq19RfNmutENnCpgea27MZK2s6AqlIit04/EL
        XtD3WqThnbXbTq0SW1Qa+T9965ynEySzerKNrj15rHeWz8B3sVBej0VGpJBLb0Eo
        rAf1wZ2R5JukDzRn9MkUdH5XE63L69s/dKFng3Mm9GhZxjrBrdcibxPBRrTfeCda
        WZBnIeDTTTB9ZD8ZOxmMQYn8NcUrNthuKfFrU6MzsyrU+8ElY/6aeajlWgvNwhey
        AbbO255nVlw01tNXy/miZrKMhNfKpmZYFnt1Fe2AnEHoHwuDJwlfZr+6BDwVf9s1
        dsimiLf6U7KAMFHyOtHf5rg72SmyHrxgXFQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YwCSan_lC6eO for <linux-block@vger.kernel.org>;
        Sun, 12 Feb 2023 04:17:13 -0800 (PST)
Received: from [10.225.163.109] (unknown [10.225.163.109])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PF60l5Lgwz1RvLy;
        Sun, 12 Feb 2023 04:17:11 -0800 (PST)
Message-ID: <16f5f350-5aae-8ba1-d72c-fded975fb5af@opensource.wdc.com>
Date:   Sun, 12 Feb 2023 21:17:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/12] pata_parport: remove devtype from struct pi_adapter
To:     Ondrej Zary <linux@zary.sk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tim Waugh <tim@cyberelk.net>, linux-block@vger.kernel.org,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230211144232.15138-1-linux@zary.sk>
 <20230211144232.15138-4-linux@zary.sk>
 <909afe94-d786-a94c-5142-818e540705cc@omp.ru>
 <202302112147.50725.linux@zary.sk>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <202302112147.50725.linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/12/23 05:47, Ondrej Zary wrote:
> On Saturday 11 February 2023 20:11:06 Sergey Shtylyov wrote:
>> On 2/11/23 5:42 PM, Ondrej Zary wrote:
>>
>>> Only bpck driver uses devtype but it never gets set in pata_parport.
>>> Remove it.
>>>
>>> Signed-off-by: Ondrej Zary <linux@zary.sk>
>>> ---
>>>  drivers/ata/pata_parport/bpck.c | 2 +-
>>>  include/linux/pata_parport.h    | 3 ---
>>>  2 files changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/ata/pata_parport/bpck.c b/drivers/ata/pata_parport/bpck.c
>>> index b9174cf8863c..451a068fe28a 100644
>>> --- a/drivers/ata/pata_parport/bpck.c
>>> +++ b/drivers/ata/pata_parport/bpck.c
>>> @@ -241,7 +241,7 @@ static void bpck_connect ( PIA *pi  )
>>>  
>>>  	WR(5,8);
>>>  
>>> -	if (pi->devtype == PI_PCD) {
>>> +	if (1 /*pi->devtype == PI_PCD*/) {	/* FIXME */
>>>  		WR(0x46,0x10);		/* fiddle with ESS logic ??? */
>>
>>    Why not drop this entire *if* stmt? 
> 
> I decided to keep it (for now) as a marker of a possible bug. I currently don't have HW to test this driver.

Then leave that if as-is and only add a comment detailing what needs to be
done (rather than just "FIXME"). This "if (1)" is just too odd and will
likely trigger code checker warnings.

> 
>>
>>>  		WR(0x4c,0x38);
>>>  		WR(0x4d,0x88);
>> [...]
>>
>> MBR, Sergey
>>
> 
> 

-- 
Damien Le Moal
Western Digital Research

