Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2420C28B2B
	for <linux-block@archiver.kernel.org>; Wed, 17 Aug 2022 16:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiHQQK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Aug 2022 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240956AbiHQQKY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Aug 2022 12:10:24 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D54389C
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660752619; x=1692288619;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tGXL1veMClRR6J6COmjOo7zqJDj1I9afT5K0DiyexSs=;
  b=Xz7nYeL3PSf3lLgiGCeJz9UcofjvxzWAcsr/NlPDXJ9A/UZ7kNpvX9fW
   XYDkQN6jdTUNXuTI5tr9b4/kYVc6ISfx2J7e7da5c0HQBfpfAcrIfEk6x
   QVoTmu1fYJbnKO+C7l70+GoxDQ3rSrH1zhZaHoEfHMk1BM282n03kISPm
   BVa4b2/20GCOZKjrKJEqS35tLrglDtRrF+bWaLA4RkdLJUL3JeGh4rWE8
   buhtDzZ4WAizHn9u90GzZatyQWDHbKz06MKgjsXk/F4WjtZaccgiNicXx
   IONrz/3B8PUea7mdFqQokxdFerTNy+9RIqfZi9OnfpG4CM+Fv3ZgHfl+r
   w==;
X-IronPort-AV: E=Sophos;i="5.93,243,1654531200"; 
   d="scan'208";a="321047341"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2022 00:10:18 +0800
IronPort-SDR: jijUlydlNH7R+tcQK7zTg1FXRcQoYAEA6GlTuDI61cl/MtLEpluVZhq8kRGwF1oNC6FiArLXYb
 XpwRXCx2M2xCPk5uvp4SXBMYK2P4EQg6Rat+QBL/sqvzkmaf7QbKUMoGj2v6vJXrbN1JJ+fikb
 iBUU5U7cGx8L3H0e3SjYlHPlxdTMydwemxSBMSwk6EK+Erc8GGDWAfcqbInGE6lmvjK7OW8/0F
 npti0npYzA/uT5o6LDanc+I25EXkumJEtXVxbsPgZNx6rI++xzzsDenz2kwerV6OuhGzvK0qYu
 7N25Jlisn/hXCxLjlWaFsOt8
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 08:31:06 -0700
IronPort-SDR: Gm6VZsZnDqYoqsNzhn5nFK9JdjnGS2l0VZM0aeH6e/KAf7BpRNpLCLr9LlDkw00fSoyFCKso1F
 UOzATMzqKiS2dyzXwkhq0DlcQGJj68QFOhhwzPlNOBE0iIlhgXQWMHDULfQdOAN35E0/YQ7TXJ
 H0KT/t8ifxX5q62Fqs5RNUOeOywWvVtQxPRY+R981Lq+Sqhy3EbGm6Co4yTu7fFOYLjbKrgREN
 Xlp16+qm7cCrZapYA1bgP8sLGuuFB/CGowuDpGU3/lXCJhrIoCRGIee4Db3XPoxbO97rbnZflF
 v98=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2022 09:10:19 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M7CfL2b3Bz1RwsC
        for <linux-block@vger.kernel.org>; Wed, 17 Aug 2022 09:10:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660752617; x=1663344618; bh=tGXL1veMClRR6J6COmjOo7zqJDj1I9afT5K
        0DiyexSs=; b=m9BkyA42lhKQOlCHS75npA6KAXx1QnGZcXPa+ScENhVWJDJNb7B
        CA4xAIg2JLIQh1qDtAFUfRAdEgicNU7AzvGl1UX407LVeNHE65d+ytCK6hieUVyP
        GfegZ1iiJLB6FcIM+/XCOJO7XUf2WX7xe7nJat0qikxM2uttvMxMvTRO3z7r6ERf
        ywpSS5GyDiYyH5Of0AxXUKuEzNQGyHY+oEQHV1sxk6T1Gk/2q/GT7quFCU/K4TUD
        dfYtsC3MKMsJlsS/IgqSjBoNzukrcw9g15hSBhwy2cI7TC86JIrtSHtbDD025sK3
        K8pihhaJ2GB2m9/g249orQLFyIo8N6bv99w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HuM1PULjeL7r for <linux-block@vger.kernel.org>;
        Wed, 17 Aug 2022 09:10:17 -0700 (PDT)
Received: from [10.11.46.122] (unknown [10.11.46.122])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M7CfJ44Fbz1RtVk;
        Wed, 17 Aug 2022 09:10:16 -0700 (PDT)
Message-ID: <840ce5cf-32d5-d694-cb79-2df871a607c9@opensource.wdc.com>
Date:   Wed, 17 Aug 2022 09:10:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v11 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        snitzer@kernel.org, hch@lst.de, agk@redhat.com
Cc:     pankydev8@gmail.com, gost.dev@samsung.com, matias.bjorling@wdc.com,
        hare@suse.de, bvanassche@acm.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        jaegeuk@kernel.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>
References: <20220816131536.189406-1-p.raghav@samsung.com>
 <CGME20220816131551eucas1p218faf35348e78a73aaa87d5477ecdb2e@eucas1p2.samsung.com>
 <20220816131536.189406-14-p.raghav@samsung.com>
 <30790cae-5440-2447-a8b8-52a57fa16fa5@opensource.wdc.com>
 <ab3ef674-c453-5b38-80b5-f41dcfed62bb@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ab3ef674-c453-5b38-80b5-f41dcfed62bb@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/17 0:35, Pankaj Raghav wrote:
> Hi Damien,
>>> + */
>>> +static bool bio_in_emulated_zone_area(struct dm_po2z_target *dmh,
>>> +				      struct bio *bio, int *offset)
>>
>> This function name reads like it is a block layer helper. It mat be less
>> confucing to keep using the dm_po2z_ prefix for it.
>>
> Good point. Even though it is a static function in the same file, it could
> be confused for a block helper at the caller site.
>>> +{
>>> +	/*
>>> +	 * Read operation on the emulated zone area (between zone capacity
>>> +	 * and zone size) will fill the bio with zeroes. Any other operation
> 
>>> +
>>> +	return DM_MAPIO_KILL;
>>> +}
>>
> Do you see any more issues apart from the two you pointed out?

nope

-- 
Damien Le Moal
Western Digital Research
