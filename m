Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EE3C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 00:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiCGAIF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 6 Mar 2022 19:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiCGAIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 6 Mar 2022 19:08:04 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7145D18E
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 16:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646611629; x=1678147629;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nNfWDU248eoscI+YgfWro7RpxsGSrUUuiIfQ3hajC6g=;
  b=nXYxLjznjZrY0cflY5l7omRjtIdKg2bNXqnyBt2rcMtZYsyNMLutqKCv
   HWCKAXV4bYSEW71czpnbtX1qIeEl9+lhdvGYuQJ/F2+rxerUVfwK0pcN4
   HcJlYfRlV+HCm/SOAYCd+rLPJeOxaN0CezQqc/gZkMBV3z2Dvfqz5/6zT
   8TyOJeYYKx3AS+KOkn4LIu0Q/whmSIiBbDjFjGgokXovv2Um5dyuvdtwl
   047/sm8bEagZ0BwNqwsABJKGwRupwwVwACXQPHmuIwnQnBjOrxaN70Lqj
   PAY98LUwKu3g7VDG7+c/gtk7Q+SGvhQmGEH3xtEqRnY2bjaqSSxJzIxCF
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,160,1643644800"; 
   d="scan'208";a="199461534"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 08:07:08 +0800
IronPort-SDR: +C+m7dj6W7hIYfY+qyIovyxyxMb0JCllF70u+ZbmDem0/q51EnJlqhg8pPvHIZjcfTzai/h+a6
 SL06K9GFJgCrS+itpyZF5WtGzj+4eo2LIEZWTYTvCFSDpQYhh8jDFF+Wr5rUTJ5VON9UBHZGni
 nGx1OlhEa1b/1TdmeGpxapLNEAoLebr+1eH49iGECI9pngP24cEV2SbPz7lZe78PWKDvv8UlXg
 aJCdR0imhAIpoM2L8N6eNMi6A6Fqp+LRO4tBudWmse8wfSg7kHEBHMRUbvHUIKC38tda6c4Cx5
 E2MbziES9S7cFmfApPxrRvsG
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 15:39:28 -0800
IronPort-SDR: iYpTYFTxTVK61R24Z8JR9uR41jxvgMIHQhcjRh4gCZ8T/TG3Tzv1s9i68y/vsT5rYhPvLuUdXz
 Dt1eLQveOQ8lxbX9j73HmX3UKbrkRgBfNOB/T3usYdNcaCZZwuwIsWuPDgvLj10S4wN1jJntpm
 3hm7JT9RWmeBMASAXnEFQhfQE709ik0rn4MsxC1fVzQN1+Gvyg45MogKCgKYY7p/FAYWRz4N9M
 0bcaRRkLs7qcxDtBGtKNHPRJ2tiyHpHAqvZlQ/KlQYSBYUDWdH6dKshTY5EkutlR0phkPgMfjF
 X44=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2022 16:07:09 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KBf0D5tgQz1SVp6
        for <linux-block@vger.kernel.org>; Sun,  6 Mar 2022 16:07:08 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1646611627; x=1649203628; bh=nNfWDU248eoscI+YgfWro7RpxsGSrUUuiIf
        Q3hajC6g=; b=enC18t7duHeyEqP5ELa2ddd3pfK957Y/2CMNGJIB890YMvd2FPP
        DTIvoBKtCGOMXmYXAvBsDRqqpLuW1LgAMYXvB2TByERvb3SIKMwQT7ww6sZNzBxl
        AyOxzt/pEJ0XtpdN9Gufbd1G+2VPUQw6gAP0knGtg9jv9je7kGD1R2uyGiIHKL2y
        a2lWzL03feeQP35gQJtJaF+66kB7HOzk+x2iemZ4pOCpJExN0+U8S8FK/xTfdRVg
        n/8wfgB14QkaqetaRLaL9lELi1uOPnfdjtNxplYVkKYuLVZJeS4zEoSO+QTR7x3q
        lXGnM7ehMs8lRK+sV5+AodlEBKag7qFbYgQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nYkX0RjOVSPA for <linux-block@vger.kernel.org>;
        Sun,  6 Mar 2022 16:07:07 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KBf084kHKz1Rvlx;
        Sun,  6 Mar 2022 16:07:04 -0800 (PST)
Message-ID: <bcbb135d-9d8b-c2cc-2a2b-a09b9e26dec4@opensource.wdc.com>
Date:   Mon, 7 Mar 2022 09:07:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        lsf-pc@lists.linux-foundation.org,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <20220304001022.GJ3927073@dread.disaster.area>
 <YiKOQM+HMZXnArKT@bombadil.infradead.org>
 <20220304224257.GN3927073@dread.disaster.area>
 <YiKY6pMczvRuEovI@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YiKY6pMczvRuEovI@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/22 07:55, Luis Chamberlain wrote:
> On Sat, Mar 05, 2022 at 09:42:57AM +1100, Dave Chinner wrote:
>> On Fri, Mar 04, 2022 at 02:10:08PM -0800, Luis Chamberlain wrote:
>>> On Fri, Mar 04, 2022 at 11:10:22AM +1100, Dave Chinner wrote:
>>>> On Wed, Mar 02, 2022 at 04:56:54PM -0800, Luis Chamberlain wrote:
>>>>> Thinking proactively about LSFMM, regarding just Zone storage..
>>>>>
>>>>> I'd like to propose a BoF for Zoned Storage. The point of it is
>>>>> to address the existing point points we have and take advantage of
>>>>> having folks in the room we can likely settle on things faster which
>>>>> otherwise would take years.
>>>>>
>>>>> I'll throw at least one topic out:
>>>>>
>>>>>   * Raw access for zone append for microbenchmarks:
>>>>>   	- are we really happy with the status quo?
>>>>> 	- if not what outlets do we have?
>>>>>
>>>>> I think the nvme passthrogh stuff deserves it's own shared
>>>>> discussion though and should not make it part of the BoF.
>>>>
>>>> Reading through the discussion on this thread, perhaps this session
>>>> should be used to educate application developers about how to use
>>>> ZoneFS so they never need to manage low level details of zone
>>>> storage such as enumerating zones, controlling write pointers
>>>> safely for concurrent IO, performing zone resets, etc.
>>>
>>> I'm not even sure users are really aware that given cap can be different
>>> than zone size and btrfs uses zone size to compute size, the size is a
>>> flat out lie.
>>
>> Sorry, I don't get what btrfs does with zone management has anything
>> to do with using Zonefs to get direct, raw IO access to individual
>> zones.
> 
> You are right for direct raw access. My point was that even for
> filesystem use design I don't think the communication is clear on
> expectations. Similar computation need to be managed by fileystem
> design, for instance.
> 
>> Direct IO on open zone fds is likely more efficient than
>> doing IO through the standard LBA based block device because ZoneFS
>> uses iomap_dio_rw() so it only needs to do one mapping operation per
>> IO instead of one per page in the IO. Nor does it have to manage
>> buffer heads or other "generic blockdev" functionality that direct
>> IO access to zoned storage doesn't require.
>>
>> So whatever you're complaining about that btrfs lies about, does or
>> doesn't do is irrelevant - Zonefs was written with the express
>> purpose of getting user applications away from needing to directly
>> manage zone storage.
> 
> I think it ended that way, I can't say it was the goal from the start.
> Seems the raw block patches had some support and in the end zonefs
> was presented as a possible outlet.

zonefs *was* design from the start as a file-based raw access method so
that zoned block devices can be used from applications coded in
languages such as Java, which do not really have a direct equivalent of
ioctl(), as far as I know.

So no, it is not an accident and did not "end up that way". See:

Documentation/filesystems/zonefs.rst

If anything, where zonefs currently falls short is the need to do direct
IO for writes to sequential zones. That does not play well with
languages like Java which do not have O_DIRECT and also have the super
annoying property of *not* aligning IO memory buffers to sectors/pages
(e.g. Java always has that crazy 16B offset because it adds its own
buffer management struct at the beginning of a buffer). But I have a
couple of ideas to solve this.

> 
>> SO if you have special zone IO management
>> requirements, work out how they can be supported by zonefs - we
>> don't need yet another special purpose direct hardware access API
>> for zone storage when we already have a solid solution to the
>> problem already.
> 
> If this is fairly decided. Then that's that.
> 
> Calling zonefs solid though is a stretch.

If you see problems with it, please report them. We have Hadoop/HDFS
running with it and it works great.With zonefs, any application
chuncking its data using files over a regular FS can be more easily
converted to using zoned storage with a low overhead FS. Think Ceph as
another potential candidate.

And yes, it is not a magical solution, since in the end, it exposes the
device as-is.

> 
>>> modprobe null_blk nr_devices=0
>>> mkdir /sys/kernel/config/nullb/nullb0
>>> echo 0 > /sys/kernel/config/nullb/nullb0/completion_nsec
>>> echo 0 > /sys/kernel/config/nullb/nullb0/irqmode
>>> echo 2 > /sys/kernel/config/nullb/nullb0/queue_mode
>>> echo 1024 > /sys/kernel/config/nullb/nullb0/hw_queue_depth
>>> echo 1 > /sys/kernel/config/nullb/nullb0/memory_backed
>>> echo 1 > /sys/kernel/config/nullb/nullb0/zoned
>>>
>>> echo 128 > /sys/kernel/config/nullb/nullb0/zone_size
>>> # 6 zones are implied, we are saying 768 for the full storage size..
>>> # but...
>>> echo 768 > /sys/kernel/config/nullb/nullb0/size
>>>
>>> # If we force capacity to be way less than the zone sizes, btrfs still
>>> # uses the zone size to do its data / metadata size computation...
>>> echo 32 > /sys/kernel/config/nullb/nullb0/zone_capacity
>>
>> Then that's just a btrfs zone support bug where it's used the
>> wrong information to size it's zones. Why not just send a patch to
>> fix it?
> 
> This can change the format of existing created filesystems. And so
> if this change is welcomed I think we would need to be explicit
> about its support.

No. btrfs already has provision for unavailable blocks in a block group.
See my previous email.

> 
>   Luis


-- 
Damien Le Moal
Western Digital Research
