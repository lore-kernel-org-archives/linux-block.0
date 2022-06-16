Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05579C43334
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 23:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiFPX3g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 19:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiFPX3f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 19:29:35 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974E5FF3E
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655422174; x=1686958174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGTIx+c8baM=;
  b=QVaUo7/6S28dzhaEcj9vcyq2EoEtTkc+qPLhoDa4ZMZW59fHpx5UVZkz
   4x3spwpATIasbH8hr6WIbBdmUfpVWtKoqjG3TzSPkCu3BrScmI9VonPzQ
   WrZDC8Qgdf6uBr94DGKRq0p22D7F2r8dte2x0BEluQ5KMu7YcDqvbW7jW
   BriECoYGTBoN/V9n0Sec0f80kwaxX7vhGf2tTCl2n271nz2GQK8JRr5Rc
   hLm4JPcid3zvH+xmV6RVaOAmggOMX0lSg0nzVC+HF+LGzhUbD4yhY6wBq
   DO6BxdDAx+h6zViD7f4UogKjb/nlHcXjoxPl261gltbMZ+UdcReHlu1SS
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208231056"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2022 07:29:33 +0800
IronPort-SDR: gzpJWHPxnwFBUKQhUxIk1OL3pQ/ypL5OjoGMRNMhq6NvsaHeZ/8mmID83ZYnPNuNvK12oNK2Yh
 uK/3/8gOBb8AtH95kG+p3s+o/d97nqyBsaOdJpNMq0528hKHnBGiVLF8YpXd+GELQWhk/CZ3Sk
 Q9IAEDvKicWPuSrylMmnbc0MLrHKSuCaOL/I9efNpcOC4eS0octKdPT3y4C+zrLBarcpZMBZH4
 09Zb4AsNYjMGiK1UFVJ4yyk2Okg4Z6HGWs5N0tS2viLMRBgFLUDErQeoPrwM3Bst0U5RhrWix0
 ySq3xny4lfTrcp+7DQaVMkmf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 15:47:46 -0700
IronPort-SDR: Ezy6P+Shup4rQ5wwsSNtG5BWFNlwCidutToc2uHBnO6Q0tpPba0UNKLyD6OrLL9FV9jmg6jRTm
 o4KTmfIU35a1WvH/MAt+31yRSlMRB5kW1+RNgCYYfHO7+L1w7aP8wNfWzT7tIiKK+XQR0mTS2p
 UVD5wh0GVgNmynYZ3iSgkx7P0ZEkEtwWB/PmI46EXV5Y8y8XX0B1tT1AUD/jQgSbzP9sHkHm4D
 RzX0+VztLuP6sio8cIUOslp4lRXMiSZ+IM0jv9THZaP6QbNi4Y5BKBqjTEVMZPncMgWi2A5a9t
 YvQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jun 2022 16:29:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LPJKn2bBGz1SVp6
        for <linux-block@vger.kernel.org>; Thu, 16 Jun 2022 16:29:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1655422172; x=1658014173; bh=M1Jr05JZnR9lUrkDq8vnHTcIMrK8D3ELTGT
        Ix+c8baM=; b=i+6JJJumlrgRNCcYWcsCF45bt2ecb8JVt57/UQZwPVKB9Y9xlVi
        1GFtdmm9W/cROhD0ul0E796KjYCyQc2As5v8It40xyC7usUlm0PUvk435TQgfYnL
        v3ejtmB2RVfuhEy6vFFyCmZYmZ8MelncumtncOJPBAKtC/m0fsUkSYnXll8GgSUw
        S7z/pTo5/MVw9tPeVY4wvxyp6ldlK0bnNmCWTaLew7A3CMC5blmmvVp6OHM7gDnW
        /kdKsbkT4zg2lD8pZSma7YEw1e1iMCF/T6CrzW9UvDY32bYrIZFfzE9pleN1yoL/
        Qb9Litbg6QNYnKjyxFoLYLaoGlgD7ONJM8w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cEf-fDtSlPom for <linux-block@vger.kernel.org>;
        Thu, 16 Jun 2022 16:29:32 -0700 (PDT)
Received: from [10.225.163.84] (unknown [10.225.163.84])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LPJKj0df1z1Rvlc;
        Thu, 16 Jun 2022 16:29:28 -0700 (PDT)
Message-ID: <065e9c29-0ceb-9b5d-ee99-ab501773c883@opensource.wdc.com>
Date:   Fri, 17 Jun 2022 08:29:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 10/13] dm-table: use bdev_is_zone_start helper in
 device_area_is_invalid()
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        snitzer@redhat.com, axboe@kernel.dk
Cc:     bvanassche@acm.org, linux-kernel@vger.kernel.org,
        jiangbo.365@bytedance.com, hare@suse.de, pankydev8@gmail.com,
        dm-devel@redhat.com, jonathan.derrick@linux.dev,
        gost.dev@samsung.com, dsterba@suse.com, jaegeuk@kernel.org,
        linux-nvme@lists.infradead.org, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615102000eucas1p27720aaa3c309327b2b9a33c5f840f498@eucas1p2.samsung.com>
 <20220615101920.329421-11-p.raghav@samsung.com>
 <064551fa-4575-87cb-d9da-90a34309f634@opensource.wdc.com>
 <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <50731e57-e0bb-179e-388c-32a18b0c610e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/16/22 18:55, Pankaj Raghav wrote:
> drivers/md/dm-table.c
>>> +++ b/drivers/md/dm-table.c
>>> @@ -251,7 +251,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  	if (bdev_is_zoned(bdev)) {
>>>  		unsigned int zone_sectors = bdev_zone_sectors(bdev);
>>>  
>>> -		if (start & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), start)) {
>>
>> This is wrong. And you are changing this to the correct test in the next
>> patch.
>>
> Yeah, I think I made a mistake while committing it. The next patch
> should only have the removing po2 condition check and these changes
> should have been only in this patch. I will fix it up!

This one and the next patch should be squashed together. They both deal
with non power of 2 zone size.


>>>  			DMWARN("%s: start=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)start,
>>> @@ -268,7 +268,7 @@ static int device_area_is_invalid(struct dm_target *ti, struct dm_dev *dev,
>>>  		 * devices do not end up with a smaller zone in the middle of
>>>  		 * the sector range.
>>>  		 */
>>> -		if (len & (zone_sectors - 1)) {
>>> +		if (blk_queue_is_zone_start(bdev_get_queue(bdev), len)) {
>>>  			DMWARN("%s: len=%llu not aligned to h/w zone size %u of %pg",
>>>  			       dm_device_name(ti->table->md),
>>>  			       (unsigned long long)len,
>>
>>


-- 
Damien Le Moal
Western Digital Research
