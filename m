Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC83C433EF
	for <linux-block@archiver.kernel.org>; Sat, 12 Mar 2022 07:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiCLH7Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Mar 2022 02:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiCLH7W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Mar 2022 02:59:22 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1715F2559B
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 23:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647071895; x=1678607895;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=u8bXSjLGKAEKuAzCEJFQ5kH7GhC3yhWPmGQlbCYM65I=;
  b=qtCwovwphLjkOc7UP68UyhzVassdTs9C1Tkb6FMOsLKG6GZTLbh58Xtw
   AuQpVXQx0dHqkTlEY6axpWwz5qRgbrdukdKNHBBhLKHPGFxlW5qyCcOOH
   7gPDqGmxjUqvHJxCsO6B9OggBSbQSklM8SobWwkvyMYINrVip397+HbI1
   907qIX6Fjt5IHyRJcH1bYHlfgeyq83XNFBKD675T9Cw/5l2G/SDSi9Ev2
   hOqgN0R9Uo9jJL0VR7txYP6t5B2KxsubRfAa4JOxHfhKMuTzhYEUSsLhG
   AQ1BJZHkkwZTS8251101mNGKE6gwLvcUdf3DweGcrO52kLymlXzfQU9we
   g==;
X-IronPort-AV: E=Sophos;i="5.90,175,1643644800"; 
   d="scan'208";a="200012742"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Mar 2022 15:58:14 +0800
IronPort-SDR: 6++pmOMhLrmmxVCxBYUaC0vE7Y7douLdq7Z9WiB4sy4wFacpI626OdrxO0MOIACOTR1sRzKHeb
 wcAahBn9TiSMY7g0uKAALOFNhhnMakIAmZ64LLwBO1ROJTpzL6GTMpSBtB2N89/nahMgA87S95
 OgTmRqI5XV1czcPDxLZZe7P0X77MO3QUFiHKObX8oPmOJaPBXlVIzV0bF/txp5PpY0rLtRZdbX
 frYkr76blQ4pYenRXXNDMgMGFYltHOxLyO8nPwqdFfaFcsVqptPitETPna5n8OluYglc6K3EMv
 Ia4ujVHYthsZlCngOUMHew97
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:30:25 -0800
IronPort-SDR: u/x2884dDrcjnSQpWBQBjeaPiSX8X8GS2Zv7RqubvjfwlvWdr/DrLNG/zEo46plsYw+ibBUGsF
 /tOZCVL3Egp8zB8pUo+IGUUMgAeNnbs+XGnl5n2lBhQgnY+SwolUc2zCJXDk2s/0GLcYqBC2PN
 BIrE8lhQLnvTo2pASgRdZ6Qwr3pjU6XIDcr0ys8bbvFoa+9iM2ihaSlXYarScntSlYGX35Iz4W
 du660Sr5SiDRhy+4tIlCkfp2nWi9zT9T7eZJHNo+WDv3a4PBzvvRbXxb7JpRdXHB3D7podqauq
 SqU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 23:58:16 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KFwCV2FvFz1SVp4
        for <linux-block@vger.kernel.org>; Fri, 11 Mar 2022 23:58:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1647071892; x=1649663893; bh=u8bXSjLGKAEKuAzCEJFQ5kH7GhC3yhWPmGQ
        lbCYM65I=; b=HhbyZ1YqjZkumkudr7E9KEN24KeApfLrZD4XuFNs8ZWwaS6Ove3
        G/KgESWWP9ZZ64GpXu08LDzLRHQIWKPXuR/2LND2X2r8IYhBpgryEdEdqKF0s+OV
        4xkxXwuXnE/dW+RclrUZWl89xTIcZdEqIw3+gCRysoVv2VX6Qtnv/COTLmpN+hUt
        SNVuYEck/VT2nhkGGMOX+YMxF+QGbBR5QTWgb6WACPqhCCJvtVCfWsrFlm1KDH+Y
        RAlCBrNrsae6wleoseTYAkVoGYssnLjCHJcQG5xu3zDXKtWVOOqoLfQe5L5NW72v
        zZ42NRBYnM68kfoOudfWe9b91z/coK/Vm+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bzGZKkWKA1yA for <linux-block@vger.kernel.org>;
        Fri, 11 Mar 2022 23:58:12 -0800 (PST)
Received: from [10.225.163.91] (unknown [10.225.163.91])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KFwCP6Cq6z1Rvlx;
        Fri, 11 Mar 2022 23:58:09 -0800 (PST)
Message-ID: <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
Date:   Sat, 12 Mar 2022 16:58:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        jiangbo.365@bytedance.com, kanchan Joshi <joshi.k@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshiiitr@gmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <CGME20220308165414eucas1p106df0bd6a901931215cfab81660a4564@eucas1p1.samsung.com>
 <20220308165349.231320-1-p.raghav@samsung.com>
 <20220310094725.GA28499@lst.de>
 <e02dfd21-31c6-95b6-1127-3f18c79116ee@samsung.com>
 <20220310144449.GA1695@lst.de> <Yiuu2h38owO9ioIW@bombadil.infradead.org>
 <20220311205135.GA413653@dhcp-10-100-145-180.wdc.com>
 <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YivMBj7+j/EZcMVV@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/12/22 07:24, Luis Chamberlain wrote:
> On Fri, Mar 11, 2022 at 01:31:02PM -0800, Keith Busch wrote:
>> On Fri, Mar 11, 2022 at 01:04:35PM -0800, Luis Chamberlain wrote:
>>> On Fri, Mar 11, 2022 at 12:51:35PM -0800, Keith Busch wrote:
>>>
>>>> I'm starting to like the previous idea of creating an unholey
>>>> device-mapper for such users...
>>>
>>> Won't that restrict nvme with chunk size crap. For instance later if we
>>> want much larger block sizes.
>>
>> I'm not sure I understand. The chunk_size has nothing to do with the
>> block size. And while nvme is a user of this in some circumstances, it
>> can't be used concurrently with ZNS because the block layer appropriates
>> the field for the zone size.
> 
> Many device mapper targets split I/O into chunks, see max_io_len(),
> wouldn't this create an overhead?

Apart from the bio clone, the overhead should not be higher than what
the block layer already has. IOs that are too large or that are
straddling zones are split by the block layer, and DM splitting leads
generally to no split in the block layer for the underlying device IO.
DM essentially follows the same pattern: max_io_len() depends on the
target design limits, which in turn depend on the underlying device. For
a dm-unhole target, the IO size limit would typically be the same as
that of the underlying device.

> Using a device mapper target also creates a divergence in strategy
> for ZNS. Some will use the block device, others the dm target. The
> goal should be to create a unified path.

If we allow non power of 2 zone sized devices, the path will *never* be
unified because we will get fragmentation on what can run on these
devices as opposed to power of 2 sized ones. E.g. f2fs will not work for
the former but will for the latter. That is really not an ideal situation.

> 
> And all this, just because SMR. Is that worth it? Are we sure?

No. This is *not* because of SMR. Never has been. The first prototype
SMR drives I received in my lab 10 years ago did not have a power of 2
sized zone size because zones where naturally aligned to tracks, which
like NAND erase blocks, are not necessarily power of 2 sized. And all
zones were not even the same size. That was not usable.

The reason for the power of 2 requirement is 2 fold:
1) At the time we added zone support for SMR, chunk_sectors had to be a
power of 2 number of sectors.
2) SMR users did request power of 2 zone sizes and that all zones have
the same size as that simplified software design. There was even a
de-facto agreement that 256MB zone size is a good compromise between
usability and overhead of zone reclaim/GC. But that particular number is
for HDD due to their performance characteristics.

Hence the current Linux requirements which have been serving us well so
far. DM needed that chunk_sectors be changed to allow non power of 2
values. So the chunk_sectors requirement was lifted recently (can't
remember which version added this). Allowing non power of 2 zone size
would thus be more easily feasible now. Allowing devices with a non
power of 2 zone size is not technically difficult.

But...

The problem being raised is all about the fact that the power of 2 zone
size requirement creates a hole of unusable sectors in every zone when
the device implementation has a zone capacity lower than the zone size.

I have been arguing all along that I think this problem is a
non-problem, simply because a well designed application should *always*
use zones as storage containers without ever hoping that the next zone
in sequence can be used as well. The application should *never* consider
the entire LBA space of the device capacity without this zone split. The
zone based management of capacity is necessary for any good design to
deal correctly with write error recovery and active/open zone resources
management. And as Keith said. there is always a "hole" anyway for any
non-full zone, between the zone write pointer and the last usable sector
in the zone. Reads there are nonsensical and writes can only go to one
place.

Now, in the spirit of trying to facilitate software development for
zoned devices, we can try finding solutions to remove that hole. zonefs
is a obvious solution. But back to the previous point: with one zone ==
one file, there is no continuity in the storage address space that the
application can use. The application has to be designed to use
individual files representing a zone. And with such design, an
equivalent design directly using the block device file would have no
difficulties due to the the sector hole between zone capacity and zone
size. I have a prototype LevelDB implementation that can use both zonefs
and block device file on ZNS with only a few different lines of code to
prove this point.

The other solution would be adding a dm-unhole target to remap sectors
to remove the holes from the device address space. Such target would be
easy to write, but in my opinion, this would still not change the fact
that applications still have to deal with error recovery and active/open
zone resources. So they still have to be zone aware and operate per zone.

Furthermore, adding such DM target would create a non power of 2 zone
size zoned device which will need support from the block layer. So some
block layer functions will need to change. In the end, this may not be
different than enabling non power of 2 zone sized devices for ZNS.

And for this decision, I maintain some of my requirements:
1) The added overhead from multiplication & divisions should be
acceptable and not degrade performance. Otherwise, this would be a
disservice to the zone ecosystem.
2) Nothing that works today on available devices should break
3) Zone size requirements will still exist. E.g. btrfs 64K alignment
requirement

But even with all these properly addressed, f2fs will not work anymore,
some in-kernel users will still need some zone size requirements (btrfs)
and *all* applications using a zoned block device file will now have to
be designed based on non power of 2 zone size so that they can work on
all devices. Meaning that this is also potentially forcing changes on
existing applications to use newer zoned devices that may not have a
power of 2 zone size.

This entire discussion is about the problem that power of 2 zone size
creates (which again I think is a non-problem). However, based on the
arguments above, allowing non power of 2 zone sized devices is not
exactly problem free either.

My answer to your last question ("Are we sure?") is thus: No. I am not
sure this is a good idea. But as always, I would be happy to be proven
wrong. So far, I have not seen any argument doing that.

-- 
Damien Le Moal
Western Digital Research
