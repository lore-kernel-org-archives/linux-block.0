Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C43C3DA7A
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 06:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjAFGvz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 01:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjAFGvy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 01:51:54 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ABC1A806
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 22:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672987912; x=1704523912;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+194s3REqJq98XWX2HOu1IzSr6E0qcXR6yy/oNtqljc=;
  b=bQ7XZT24RBIzD9xwFkLcGJWpW1HxJ4B5TjtqUEJfdr96hx7tQf0e/zgi
   Itg/rsKE1CZeOUuZy0kSs42V/WOzWjMEqCrKi5UwJwxTyiCSfdvYOY4pA
   6jYN2fm7YNqLoRUspEqc595cUoxGseaM9bf0+5zJ99br/WAe4+cuYz4Hd
   +9S3pLEkDnPYMIRSy51jKIMv/iD1Aio8cx0NT9dDCiv810Psrc5bEGQvF
   4sIDIjOryEijcMEnNf7SUhPWT+qh6ZvGPbnauTvTqGTUkWMbxzo1vpZZV
   phZ1zjpinaxiYqwI6Tq4JLBKz8axW3hNhhUqdzUFbnRW6YydvCgFNR8TK
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,304,1665417600"; 
   d="scan'208";a="218418794"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jan 2023 14:51:52 +0800
IronPort-SDR: 7BIECNkgscSzQG8v4+G7l5PUCIrCj5RvbKdrgHQcZD7hTX1eBReOzNwJpplq+i7N0VMIO5Kte/
 +NZY6FlTSkoEXALw02J2sLqm8zXSb2e82VVJGyLH14t3VMgA/bdtpWPoSbklMLQVpWZUzdecII
 9IyMfp4v23joF9ZFlzbbvXlN9qFj3BmSCdqZWmLLDX7772GDLv9kuY4LZ2n5TT5ykOvJ0zNCDf
 bQk/rcTJBH9X6VzMHHF5vv/UbfQnw8/Voc/AqZRXuJkkg5lXH4SWv+PhND6C9oq6eQ9VLWPXtX
 /VQ=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2023 22:04:02 -0800
IronPort-SDR: csY3jg13Vg3cE0PhTZC9SfX7M6M4HvO182KiEZ2gEsiBFBgLmsu0Pw2olpygAYLKvCIiNxq7SM
 N8A6pjm5lEZ0TmqH8rBTBekjy5eoCQci5i71Ie58WSbF5VdQdVjeY7ZpoNzrdWuvzWbb85HIgK
 LweAV8kQAXVfZ5tWz6T/t5NxtGqB9DBsoNDsmNM/ZlLFuSrxBQuLG1mZ/W2TKydDxWXczrZebN
 1Hh9aM5NKDuwa3cF11juymdrRKnoBoxg5lqksF08dg15GRNUFMgr6BKCmVlBWgKXW5oWBpPVy5
 4YA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jan 2023 22:51:52 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NpDXS1kcMz1RvTr
        for <linux-block@vger.kernel.org>; Thu,  5 Jan 2023 22:51:52 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1672987910; x=1675579911; bh=+194s3REqJq98XWX2HOu1IzSr6E0qcXR6yy
        /oNtqljc=; b=Fe5+7PEEcpoT0BbQPZkrutKaylGAMWWISieHPNInAWv18wREilq
        w3FniOtce8H9NVvR6teNPDZ1eByyHdG4E2Hgts0/OIASavh4Ttbs98GFyRk23/7D
        XUgoeX6IgtFvTkpS3CLNKlJI97/r02Ay+wsg+CmyGMZgIvqb75l2mhF1QDevfcbB
        cUuo7eJ04UvYyk8jPk4+zgjQWLxLx7fEiqouF/6yzIfRF34MyZtDj8ubAhYkEbAy
        d0eI9jxbtir1dV7waiyj5Dbtq0ZnG4Wx64LN1mZohFZjhzQvJFdl/h2dyhBEN6cF
        ytVBZnoARzZxGUUTm1RfU++Lp5TEKupGByw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JM1Y894Ydr3Z for <linux-block@vger.kernel.org>;
        Thu,  5 Jan 2023 22:51:50 -0800 (PST)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NpDXP4M8lz1RvLy;
        Thu,  5 Jan 2023 22:51:49 -0800 (PST)
Message-ID: <b5c57ca5-49b0-b9c6-4a65-a8867a74e950@opensource.wdc.com>
Date:   Fri, 6 Jan 2023 15:51:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 0/7] Improve libata support for FUA
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-ide@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <Y7WuEqMgySOCCTqy@slm.duckdns.org>
 <79260c74-92dd-2cdf-ad71-e70d9fa0f8a9@opensource.wdc.com>
 <Y7cT3SSssHzBYqU4@slm.duckdns.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <Y7cT3SSssHzBYqU4@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 03:15, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jan 05, 2023 at 12:43:06PM +0900, Damien Le Moal wrote:
>>> These optional features tend to be broken in various and subtle ways,
>>
>> FUA is not optional for any drive that supports NCQ. The FUA bit is a
>> mandatory part of the FPDMA READ/WRITE commands. The optional part is
>> support for the non-ncq WRITE FUA EXT command.
> 
> Optional in the sense that it isn't essential in achieving the main function
> of the device, which means that most don't end up using it.

OK. Granted. But for this particular case, scsi & nvme subsystem do not
treat FUA as "optional". If it is supported, it will be used even though
you are correct that we can work without it. I do not think we should
treat ATA devices any differently.

>>> especially the ones which don't show clear and notable advantages and thus
>>> don't get used by everybody. I'm not necessarily against enabling it by
>>> default but we should have better justifications as we might unnecessarily
>>> cause a bunch of painful and subtle failures which can take a while to sort
>>> out.
>>
>> Avoiding regressions is always my highest priority. I know that there
>> are a lot of cheap ATA devices out there that have questionable ACS spec
>> compliance.
> 
> A lot of historical devices too which don't get much scrutiny or testing but
> can still cause significant griefs for the users.

Yes. There are a lot of s****y old devices that do not correctly handle
synchronize cache, and likely fua too. Hence my propsal to limit
enabling FUA support to newer devices based on the standards version
supported. Note that this patch set excludes all ide/pata devices. These
will still operate with fua off by default since they do not support NCQ.

>>> * Can the advantages of using FUA be demonstrated in a realistic way? IOW,
>>>   are there workloads which clearly benefit from FUA? My memory is hazy but
>>>   we only really use FUA from flush sequence to turn flush, write, flush
>>>   sequence into flush, FUA-write. As all the heavy lifting is done in the
>>>   first flush anyway, I couldn't find a case where that optimization made a
>>>   meaningful difference but I didn't look very hard.
>>
>> The main users in kernel are file systems, when committing
>> transactions/metadata journaling. Given that this is generally not
>> generating a lot of traffic, I do not think we can measure any
>> difference for HDDs. The devices are too slow to start with, so saving
>> one command will not matter much, unless the application is fsync()
>> crazy (and even then, not sure we'll see any difference). Even for SATA
>> SSDs it likely will be hard to see a difference I think.
> 
> On a quick glance, there are some uses of REQ_FUA w/o REQ_PREFLUSH which
> indicates that there can be actual gains to be had. However, ext4 AFAICS
> always pairs PREFLUSH w/ FUA, so a lot of use cases won't see any gain while
> taking on the possible risk of being exposed to FUA commands.

Yes. Most FSes will do PREFLUSH | FUA. For the risk, see above.

>> Then we have applications using the drive block device file directly.
>> For these, it is hard to tell how much it matters. Enabling it by
>> default with a drive correctly supporting it will very much likely not
>> hurt though.
>>
>> Maciej,
>>
>> May be you did some experiments before asking for enabling FUA by
>> default ? Any interesting performance data you can share ?
>>
>>> * Do we know how widely FUA is used now? IOW, is windows using FUA by
>>>   default now? If so, do we know whether they have a blocklist?
>>
>> You mean "blacklist" ? I do not have any information about Windows, but
> 
> The PC thing to say now seems to be allowlist / blocklist instead of
> whiltelist / blacklist, not that I mind either way.

I was thinking "block == sector" :) yes, could patch the code to rename
blacklist to something like badlist. I find "block" confusing here given
that we are talking about block devices :)

>> I can try to find out, at least for my employer's devices. But that will
>> not be very useful as I know these drives behave correctly.
> 
> So, AFAIK, windows doesn't issue FUA for SATA devices, only SAS, but I could
> be wrong. It'd be really useful to find out.

Need to ping some people to see if I can find out.

>> More than Windows or the kernel, I think that looking at SAS HBAs is
>> more important here. SATA HDDs are the most widely used type of devices
>> with these, by far. These may have a SAT translating FUA scsi writes to
>> FUA NCQ FPDMA writes, resulting in FUA being extensively used. Modulo a
>> blacklist that results in the same as the kernel with a
>> flush/write/flush sequence. Hard to know as HBA's FW are not open. A bus
>> analyzer could tell us that though, but again I can look at that only
>> with the drives I have, which I know are working well with FUA.
>>
>> I am OK with attempting enabling FUA by default for the following reasons:
>> 1) The vast majority of drives in libata blacklist (all features) are
>> old models that are not sold anymore.
> 
> The context here is that we promptly found all of these devices struggle
> with FUA (like locking up and dropping off the bus) shortly after we enabled
> FUA by default, so the list is by no means exhaustive and is more an
> indication that there at least were a whole lot of devices which choke on
> FUA. On top, devices not sold anymore are even harder to debug and pay
> attention to while being able to cause a lot of pain to configurations which
> have been stable and happy for a long time.

Yes. Hence, again, the idea to limit this to recent drives. E.g ACS-4
(or 5) and above.

>> 2) We are restricting FUA support to drives that also support NCQ, that
>> is, modern-ish ones that are supposed to process the FUA NCQ read/write
>> commands correctly, per specs.
> 
> NCQ is really old now and our previous attempt at FUA was after NCQ was
> widely available, so I'm not sure this holds.
> 
>> 3) For HDDs, which is the vast majority of ATA devices out there these
>> days, all recent drives I have tested are OK. Even older ones with NCQ
>> support that I have access to are fine.
>> 4) We are at rc2, which gives us time to revert patch 7 if we see too
>> many bug reports.
> 
> This sort of problems especially if affecting mostly old devices can be very
> difficult to suss out and will definitely take way longer than a single
> release cycle.
> 
>> One thing we could add to the patch series is an additional restriction
>> to enabling FUA by default to drives that support a recent standard. Say
>> ACS-4 and above. That will restrict this to recent devices, thus
>> reducing the risk of hitting bad apples. Thoughts ?
> 
> Yeah, that'd help and also if SAS HBA SAT's have been issuing FUA's which
> would be a meaningful verification of the feature, at least for rotating
> hard disks.
> 
> I feel rather uneasy about enabling FUA by default given history. We can
> improve its chances by restricting it to newer devices and maybe even just
> hard disks, but it kinda comes back to the root question of why. Why would
> we want to do this? What are the benefits? Right now, there are a bunch of
> really tricky cons and not whole lot on the pro column.

OK. But again, why treat ATA devices differently from scsi/nvme/ufs ?
These have FUA used by default if it is supported.

We can take a big hammer here and start with enabling only ACS-5 and
above for now. That will represent the set of devices that are in
development right now, and only a few already released (I have some in
my test boxes and they are not even a few months old...).

Or simply remove patch 7 and let user choose to enable FUA themselves if
they are confident their devices are OK. That is the safest, but I am
not keen on keeping ATA subsystem in the 20th century...

> 
> Thanks.
> 

-- 
Damien Le Moal
Western Digital Research

