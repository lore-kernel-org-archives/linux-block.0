Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDCDC38145
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 01:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234765AbiIBB7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 21:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbiIBB72 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 21:59:28 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C88A99C7
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 18:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662083967; x=1693619967;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=hmi4fA20yl+crdbD+cyzbGeImsRtqQImsVakk6DVim4=;
  b=VsJ/LmMSTd1jTWEdNbPFUExy6VC7efZXdc1V/uJ1//NDKp9/ZjFWVSO3
   l6b/ZI8D67icVGtrllVrqHvAlhAb20I+YV+Axt1NmaPyF4UT+NVUQjyMR
   rHad0/MKWt9edesL/+QXb0fAM9FXHzIOw+OowH+rcxjIIOZNifoKp+Om5
   t3zPPYEBdinizDQB3qbHwbykhOIlwXUlw5EstViIivH4KpGqjr3aViYXh
   WJDhiva+Ge+nAktYEmeCGgzR5ZJRm25ueh369KA7W94zDvGqCoJVmlsBT
   dDxQQBDKyPFK/CeOn30PlYo858UmApelXT5HgY7KBkx6+81nSmvJZ2r/i
   w==;
X-IronPort-AV: E=Sophos;i="5.93,281,1654531200"; 
   d="scan'208";a="210284051"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2022 09:59:25 +0800
IronPort-SDR: os9tx1lt0YvRU1pU3FmLWYc5uOBNj+P17X/DzAqt92IB0UtLIeyy7teJxq1YUxhhLcL3j8uhyg
 D6/jmMZUT3x+Y1PogGZDbTgofHCCbXS8wqwP3kXEui4EcOv5yPEazD/C+Xy96eZwi/JKqYriSI
 Ga+6vmGARVRv+Vu4dRYFEAguABOqNau3MXrS7P9yngNitaVzqL9SXGvE44VHbTlg6o+ZwUb/HG
 mbEatzwAc7l+a6cQL+RXi5jrmmMXrgeQ7eiZKw4V74LzVgKSsyK4TVEwoY42MrNsh8kJyl9/sD
 vZr9cAiNQuFmIn6J3eLZ+1fX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:14:31 -0700
IronPort-SDR: keGN2Kl79Mj9wzGIUB1eKhYQ806MvapgnFsF6iNaernbhgR/YtATbP0bto2aGsQ8BVAqxDZ/p8
 C925aR9UYjk5tfydkG9qAX0kTgp04ktkjw3AQHHg13XDKV/viFhRqgjGxQDHGyNo2/wurvP63z
 zimw2yr03arxmnp6wXTa3fedEzaJc6mz+PLhlEiGIgKcU9MlnJVfXaKzNplsB+TFv09yLt5GXs
 VUuz7HOqm4hNSVD9qZi/LS4kBpIc6clseTouoRvmX0KoAGF4ZFjcfcHqxohfN2DmUacDJbQFN2
 DJ8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Sep 2022 18:59:26 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MJh193GHsz1Rwtm
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 18:59:25 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:references:to:from:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1662083964; x=1664675965; bh=hmi4fA20yl+crdbD+cyzbGeImsRtqQImsVa
        kk6DVim4=; b=hKCRXiO7WYClkrRcbzSiijjmciqDBZrrfeKWlekjT63Xng9DCZS
        fr/3mbddvWMzPYYJaY1zv5F3OX3CQucxffd7GM+E/iByLtT3/6IEKabqg2wPBNM5
        zOKC9e603bRPhHAFXrLaRiIzR2vrrt6/zLQDUuFLUGjnob5/fpYV/tpW92eLo6sJ
        sVpbHOj/7rcFZzjcoklnC5kOYRL5OUqaklKmMaPozO+g3pw3uFzEb0LsCv+Yi29Y
        qnIC54GO+FpV92is+T1Cg7a1eJzlwk5mZvBPGTcyQebPW/ht1dVjfaUL/7jblFd1
        dl7NLKWCjQlidPAuKQ2Tx5o4qjIjKk5b1OA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4mV-N1VJ8fYn for <linux-block@vger.kernel.org>;
        Thu,  1 Sep 2022 18:59:24 -0700 (PDT)
Received: from [10.225.163.56] (unknown [10.225.163.56])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MJh162Ks6z1RvLy;
        Thu,  1 Sep 2022 18:59:22 -0700 (PDT)
Message-ID: <32fea8c5-fcc2-001c-eb10-3138e16b0e74@opensource.wdc.com>
Date:   Fri, 2 Sep 2022 10:59:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 15/17] btrfs: calculate file system wide queue limit for
 zoned mode
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-16-hch@lst.de>
 <429d26b8-f7d8-6365-a2fa-f4ed892182e4@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <429d26b8-f7d8-6365-a2fa-f4ed892182e4@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/2/22 10:56, Damien Le Moal wrote:
> On 9/1/22 16:42, Christoph Hellwig wrote:
>> To be able to split a write into properly sized zone append commands,
>> we need a queue_limits structure that contains the least common
>> denominator suitable for all devices.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>  fs/btrfs/ctree.h |  4 +++-
>>  fs/btrfs/zoned.c | 36 ++++++++++++++++++------------------
>>  fs/btrfs/zoned.h |  1 -
>>  3 files changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 5e57e3c6a1fd6..a37129363e184 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -1071,8 +1071,10 @@ struct btrfs_fs_info {
>>  	 */
>>  	u64 zone_size;
>>  
>> -	/* Max size to emit ZONE_APPEND write command */
>> +	/* Constraints for ZONE_APPEND commands: */
>> +	struct queue_limits limits;
>>  	u64 max_zone_append_size;
> 
> Can't we get rid of this one and have the code directly use
> fs_info->limits.max_zone_append_sectors through a little helper doing a
> conversion to bytes (a 9 bit shift) ?

Note: Only a suggestion, not sure that would be much of a cleanup.

> 
> [...]
>>  	/* Count zoned devices */
>>  	list_for_each_entry(device, &fs_devices->devices, dev_list) {
>>  		enum blk_zoned_model model;
>> @@ -685,11 +677,9 @@ int btrfs_check_zoned_mode(struct btrfs_fs_info *fs_info)
>>  				ret = -EINVAL;
>>  				goto out;
>>  			}
>> -			if (!max_zone_append_size ||
>> -			    (zone_info->max_zone_append_size &&
>> -			     zone_info->max_zone_append_size < max_zone_append_size))
>> -				max_zone_append_size =
>> -					zone_info->max_zone_append_size;
>> +			blk_stack_limits(lim,
>> +					 &bdev_get_queue(device->bdev)->limits,
>> +					 0);
> 
> This does:
> 
> 	t->max_zone_append_sectors = min(t->max_zone_append_sectors,
>                                         b->max_zone_append_sectors);
> 
> So if we are mixing zoned and non-zoned devices in a multi-dev volume,
> we'll end up with max_zone_append_sectors being 0. The previous code
> prevented that.
> 
> Note that I am not sure if it is allowed to mix zoned and non-zoned drives
> in the same volume. Given that we have a fake zone emulation for non-zoned
> drives with zoned btrfs, I do not see why it would not work. But I may be
> wrong.
> 

-- 
Damien Le Moal
Western Digital Research

