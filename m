Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE1C54EAA
	for <linux-block@archiver.kernel.org>; Fri, 27 Jan 2023 00:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjA0AUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Jan 2023 19:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjA0ATz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Jan 2023 19:19:55 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6ADA7579C
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 16:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674778749; x=1706314749;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Dl33qZ2NMd80jSjRhMGYNurwfaUC2jL2dxyNCoKSqO8=;
  b=fl6w1EFp8/QpACNOeXWQLB6oICNhzrI87wYj0P1Rk+etpzecvDoKH7Ob
   9Uyd2EB/8rWFtvLlXuiQViYaBqHnCmVGa5WRkc9Yc75I4RQF0hCKeU7ZW
   NLjhpTJrBj9bZhejT36gtrHN6x1mNtosQ3MW8WBQX2suTMw0IdHk+2XJM
   hPvbFm03XZMLRgqEX09pUXZ2J5x0bP24e3zKkBXEPD2HsB/yMEC6r6XS4
   NcmAqU8docTiTIayTEmleqNJmvjzzPhffqY0tDMir+Qz1zE695KZq+aVX
   6Bbtb7+aFQffJFiFav7TFHU5Ek11s5yC2p7PTPUy3Fm3dfQCof69bUFcJ
   A==;
X-IronPort-AV: E=Sophos;i="5.97,249,1669046400"; 
   d="scan'208";a="221913466"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2023 08:18:14 +0800
IronPort-SDR: nhC4w/Yn7QDiYbqTIIiksOw2yWUG0O53e4002Zraca2hLi2pkUeDdoXts7CrCfy+AfMs4GyksZ
 wOMx4SLVAqVfDjo4pIQ7IU7Kg+fh1xYN5M1nVtmljnQOVJ+APa2C3/A2SUlKu0PdAxxhaDD82l
 u0wZ3DEjMvAvVHA0N/x8STDnoKuiPn+5wDCdIpWYLpXSHWNGxLksBWLFShBaeapxiSLBsmc36R
 BOzztaKgQDMFE759c9VZdrPBccwsMY78BYAfT38wOlrdxfbQRTFV9AqhZoEtuWqlYa06zIf3D5
 cig=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2023 15:35:44 -0800
IronPort-SDR: C4XEsFaDKDF+BHSkRU9E7tVgbGQRkp/YVGH0t0AaOHCNfMy1fZ2NVhF8+FlanqrpH3GhBlCeaT
 15ecWT46YGP9Sovxota67zj3/Fz6/5ARuu+MarClk3SF8yhwuiwlqmVDud6jWwO8Omi1Z3okeT
 iNqRD9A2p/v+YG5QGIDMRtom4NL4U7YldrbtYJn9Ws+FTUIga3f/p2P+0SEE6WR2e/lIa0x5pa
 m3tsSEA+zUkm9XERbEUr95yEsmyx0hKDX3ajsNEVanCJKf5B2TrxKAMzPlF96HyKmq36RZt5fh
 D3U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2023 16:18:14 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4P2ypZ28H6z1Rwt8
        for <linux-block@vger.kernel.org>; Thu, 26 Jan 2023 16:18:14 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1674778692; x=1677370693; bh=Dl33qZ2NMd80jSjRhMGYNurwfaUC2jL2dxy
        NCoKSqO8=; b=l9ITvW71QUkeNE27Jbti0dh4ezQyCpKlO8TVat2mIEdZ4nB3lux
        KphBQcfeW5svJGnu3ZMkW+lqTFtsp7vkztxqt149PdIo+OjlAhiQIih/g1AEau6p
        AMlkqGkju9a7O1J1M5Ry4ESkmqPE8UVmqzj/++8MjVvtSMcIdgrME5+59b0gP0yt
        cB9FO9zguExW8v7FtV7ocDXZLc9RGL/Oc2lWw+3Ruhe25Go4NrhmoPqb5rcf3xiw
        ZcUVTZR5B3wHM/kp42c6FCqU6JFeQv0UQshkTnEiNNJV8Ym7PXrfYUnlZHijWjep
        zbChx0vRFNZjU2ejcw97l5byJVzqNGWo1Ig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XrbKaV1wJu4L for <linux-block@vger.kernel.org>;
        Thu, 26 Jan 2023 16:18:12 -0800 (PST)
Received: from [10.225.163.63] (unknown [10.225.163.63])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4P2ypW46PPz1RvLy;
        Thu, 26 Jan 2023 16:18:11 -0800 (PST)
Message-ID: <29b50dbd-76e9-cdce-4227-a22223850c9a@opensource.wdc.com>
Date:   Fri, 27 Jan 2023 09:18:10 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 01/18] block: introduce duration-limits priority class
To:     Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.de>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20230124190308.127318-2-niklas.cassel@wdc.com>
 <bd0ce7ad-cf9e-a647-9b1e-cb36e7bbe30f@acm.org>
 <731aeacc-74c0-396b-efa0-f9ae950566d8@opensource.wdc.com>
 <873e0213-94b5-0d81-a8aa-4671241e198c@acm.org>
 <4c345d8b-7efa-85c9-fe1c-1124ea5d9de6@opensource.wdc.com>
 <5066441f-e265-ed64-fa39-f77a931ab998@acm.org>
 <275993f1-f9e8-e7a8-e901-2f7d3a6bb501@opensource.wdc.com>
 <e8324901-7c18-153f-b47f-112a394832bd@acm.org> <Y9Gd0eI1t8V61yzO@x1-carbon>
 <86de1e78-0ff2-be70-f592-673bce76e5ac@opensource.wdc.com>
 <Y9KF5z/v0Qp5E4sI@x1-carbon> <7f0a2464-673a-f64a-4ebb-e599c3123a24@acm.org>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <7f0a2464-673a-f64a-4ebb-e599c3123a24@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/27/23 02:33, Bart Van Assche wrote:
> On 1/26/23 05:53, Niklas Cassel wrote:
>> On Thu, Jan 26, 2023 at 09:24:12AM +0900, Damien Le Moal wrote:
>>> But again, the difficulty with this overloading is that we *cannot* implement a
>>> solid level-based scheduling in IO schedulers because ordering the CDLs in a
>>> meaningful way is impossible. So BFQ handling of the RT class would likely not
>>> result in the most ideal scheduling (that would depend heavily on how the CDL
>>> descriptors are defined on the drive). Hence my reluctance to overload the RT
>>> class for CDL.
>>
>> Well, if CDL were to reuse IOPRIO_CLASS_RT, then the user would either have to
>> disable the IO scheduler, so that lower classdata levels wouldn't be prioritized
>> over higher classdata levels, or simply use an IO scheduler that does not care
>> about the classdata level, e.g. mq-deadline.
> 
> How about making the information about whether or not CDL has been 
> enabled available to the scheduler such that the scheduler can include 
> that information in its decisions?

Sure, that is easy to do. But as I mentioned before, I think that is
something we can do after this initial support series.

>> However, for CDL, things are not as simple as setting a single bit in the
>> command, because of all the different descriptors, so we must let the classdata
>> represent the device side priority level, and not the host side priority level
>> (as we cannot have both, and I agree with you, it is very hard define an order
>> between the descriptors.. e.g. should a 20 ms policy 0xf descriptor be ranked
>> higher or lower than a 20 ms policy 0xd descriptor?).
> 
> How about only supporting a subset of the standard such that it becomes 
> easy to map CDLs to host side priority levels?

I am opposed to this, for several reasons:

1) We are seeing different use cases from users that cover a wide range of
use of CDL descriptors with various definitions.

2) Passthrough commands can be used by a user to change a drive CDL
descriptors without the kernel knowing about it, unless we spend our time
revalidating the CDL descriptor log page(s)...

3) CDL standard as is is actually very sensible and not overloaded with
stuff that is only useful in niche use cases. For each CDL descriptor, you
have:
 * The active time limit, which is a clean way to specify how much time
you allow a drive to deal with bad sectors (mostly read case). A typical
HDD will try very hard to recover data from a sector, always. As a result,
the HDD may spend up to several seconds reading a sector again and again
applying different signal processing techniques until it gets the sector
ECC checked to return valid data. That of course can hugely increase an IO
latency seen by the host. In applications such as erasure coded
distributed object stores, maximum latency for an object access can thus
be kept low using this limit without compromising the data since the
object can always be rebuilt from the erasure codes if one HDD is slow to
respond. This limit is also interesting for video streaming/playback to
avoid video buffer underflow (at the expense of may be some block noise
depending on the codec).
 * The inactive time limit can be used to tell the drive how long it is
allowed to let a command stand in the drive internal queue before
processing. This is thus a parameter that allows a host to tune the drive
RPO optimization (rotational positioning optimization, e.g. HDD internal
command scheduling based on angular sector position on tracks withe the
head current position). This is a neat way to control max IOPS vs tail
latency since drives tend to privilege maximizing IOPS over lowering max
tail latency.
 * The duration guideline limit defines an overall time limit for a
command without distinguishing between active and inactive time. It is the
easiest to use (the easiest one to understand from a beginner user point
of view). This is a neat way to define an intelligent IO prioritization in
fact, way better than RT class scheduling on the host or the use of ATA
NCQ high priority, as it provides more information to the drive about the
urgency of a particular command. That allows the drive to still perform
RPO to maximize IOPS without long tail latencies. Chaining such limit with
an active+inactive time limit descriptor using the "next limit" policy
(0x1 policy) can also finely define what the drive should if the guideline
limit is exceeded (as the next descriptor can define what to do based on
the reason for the limit being exceeded: long internal queueing vs bad
sector long access time).

> If users really need the ability to use all standardized CDL features 
> and if there is no easy way to map CDL levels to an I/O priority, is the 
> I/O priority mechanism really the best basis for a user space interface 
> for CDLs?

As you can see above, yes, we need everything and should not attempt
restricting CDL use. The IO priority interface is a perfect fit for CDL in
the sense that all we need to pass along from user to device is one
number: the CDL index to use for a command. So creating a different
interface for this while the IO priority interface exactly does that
sounds silly to me.

One compromise we could do is: have the IO schedulers completely ignore
CDL prio class for now, that is, have them assume that no IO prio
class/level was specified. Given that they are not tuned to handle CDL
well anyway, this is probably the best thing to do for now.

We still need to have the block layer prevent merging of requests with
different CDL descriptors though, which is another reason to reuse the IO
prio interface as the block layer already does this. Less code, which is
always a good thing.

> 
> Thanks,
> 
> Bart.

-- 
Damien Le Moal
Western Digital Research

