Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BF0C433FE
	for <linux-block@archiver.kernel.org>; Fri, 20 May 2022 03:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiETDmE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 23:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiETDmD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 23:42:03 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B123C1EF1
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 20:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653018122; x=1684554122;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vsP9rR0bmsdYi/b/kU26DDrdo3eIaFFijAIs7ZCN7N4=;
  b=ZnxQKA7eICsLBJC/Bn9FPoMXDC49oDaLTI2fLUgpC/DMOpygde6uPo9P
   8o8TaQ5efl34ipeICndxhqxoR/T+b71baJbV/HscmgYBelxliO09MebdE
   ygFE8KZITnOJzczAaUNAsQkPF9vITxHpYf2K12mwO+edpRtelW0331znQ
   9lT1oYe9ydhoStqPlwDAXC4ppy/PlZFOzNZo8+/mbyEH9rCduTCj2EOa8
   N3tS15TBPBoW7i0PEn0bOK11eLKOOQja43uKqe3Koe4Q4eEh90fC0fVV0
   RBmIyYemA6luqeAmNt237eQ83LqM7T4nqOkhhx6H7VSWrU8SYHd3cZhqY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,238,1647273600"; 
   d="scan'208";a="312850101"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 20 May 2022 11:42:01 +0800
IronPort-SDR: piVJCNAg3I1Ec7M9S06Fq3cb7UbJVc/L5/CuqTAH/jc/Q2h4gpTiX88BjfO+jX4ghJTG90Rr6C
 WhJY/Fo58zZFkJWgMq+nIYchKDSbWTNU/FZBlkEjCy+QFBnulF/z9GjJy0lGsIK8OUILGTqKwx
 zdXqCEr0MPgPSykTsNoPP2dbvXvveHOcEtoq/pSfhqYRWH6/SheXkgIF0x5ROcbe6FQnQPQvFM
 OdM+ymePxXfci+3M4fyHXdsy6rj217WJe0ShQbVaa5lcIJPam1XPCYy2JQ3GYASFmH8hNIvLO1
 AuI8iHut6fqdruzgM6uqayE/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:04:52 -0700
IronPort-SDR: 0TAPPHXo3hFA6Nbsl/EGaYv3lsrS/M/wPHDRh96rlsYIornTXvWezKHYP8dZawyHcUEASHeNcl
 9odzK4b2NGx5DnzShPKagZn0ypV2cnSeEpYxPOm4UNOgcJFFmORd11gueZfKydf5siZuaDxFiE
 Dq2aXPVvmOcl0D/FL9wP6G1jzi3HwsojACYFnrMLwgaobKusJKoCBME1yqbeWoK8hrnAXCJmM+
 pCLYk6b3X9I322L5XzsQAUDzL08MmwFdAN2gAWjhW4aoeZ3azjjZVmzXZ4xbCHBDrKFYD6iqMY
 87U=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 May 2022 20:41:54 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L4CFs4d3Nz1SVp3
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 20:41:53 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653018112; x=1655610113; bh=vsP9rR0bmsdYi/b/kU26DDrdo3eIaFFijAI
        s7ZCN7N4=; b=TOOPyIZkc/aHTy2wEvoXXElTfusvRXNu1QsteanVuHg5bqU7wWO
        mwbjBiXuQbiTRw7xOyeeg1G9XUUTu1p7ojInIix0A20JmYpba9eWGV64Io5bxJAX
        YM2UKPXaoFkpFvWRoEEF3xbTnSWhxN0Ur4ew39qYPlfCIPZoRhPdEn1d6JvvFvnC
        vaxvAvp50cS5sqgaHhkvG+W+GB7GOB7JDE7zHiORzahyLnZEifUqJ8UnvoCDbblp
        QQPrHhnakW49nTbPvFpfzOrvstlSaJp7ilas6c1UXq+ywivUEYDpx3eIHWuHMhuE
        a2qqGH20HOi7zag1S+AceVtOJ8x2SsAWXPQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 56hXLDgAm5jc for <linux-block@vger.kernel.org>;
        Thu, 19 May 2022 20:41:52 -0700 (PDT)
Received: from [10.225.163.45] (unknown [10.225.163.45])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L4CFp71jmz1Rvlc;
        Thu, 19 May 2022 20:41:50 -0700 (PDT)
Message-ID: <e4b57864-a685-d7a4-b8dd-1078547f7b0b@opensource.wdc.com>
Date:   Fri, 20 May 2022 12:41:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Content-Language: en-US
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org
References: <20220518171131.3525293-4-kbusch@fb.com>
 <YoWL+T8JiIO5Ln3h@sol.localdomain>
 <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com>
 <YoWjBxmKDQC1mCIz@sol.localdomain>
 <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com>
 <YoWmi0mvoIk3CfQN@sol.localdomain>
 <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com>
 <YoW5Iy+Vbk4Rv3zT@sol.localdomain>
 <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
 <283d37e8-868a-990b-e953-4b7bb940135c@opensource.wdc.com>
 <YoZ8OKDXZBiNd9XB@sol.localdomain>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <YoZ8OKDXZBiNd9XB@sol.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/20/22 02:19, Eric Biggers wrote:
> On Thu, May 19, 2022 at 08:45:55AM +0200, Damien Le Moal wrote:
>> On 2022/05/19 6:56, Keith Busch wrote:
>>> On Wed, May 18, 2022 at 08:27:31PM -0700, Eric Biggers wrote:
>>>>
>>>> So the bio ends up with a total length that is a multiple of the logical block
>>>> size, but the lengths of the individual bvecs in the bio are *not* necessarily
>>>> multiples of the logical block size.  That's the problem.
>>>
>>> I'm surely missing something here. I know the bvecs are not necessarily lbs
>>> aligned, but why does that matter? Is there some driver that can only take
>>> exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
>>> queue limit into account, but I am not sure that we need to.
>>
>> For direct IO, the first bvec will always be aligned to a logical block size.
>> See __blkdev_direct_IO() and __blkdev_direct_IO_simple():
>>
>>         if ((pos | iov_iter_alignment(iter)) &
>>             (bdev_logical_block_size(bdev) - 1))
>>                 return -EINVAL;
>>
>> And given that, all bvecs should also be LBA aligned since the LBA size is
>> always a divisor of the page size. Since splitting is always done on an LBA
>> boundary, I do not see how we can ever get bvecs that are not LBA aligned.
>> Or I am missing something too...
>>
> 
> You're looking at the current upstream code.  This patch changes that to:
> 
> 	if ((pos | iov_iter_count(iter)) & (bdev_logical_block_size(bdev) - 1))
> 		return -EINVAL;
> 	if (iov_iter_alignment(iter) & bdev_dma_alignment(bdev))
> 		return -EINVAL;
> 
> So, if this patch is accepted, then the file position and total I/O length will
> need to be logical block aligned (as before), but the memory address and length
> of each individual iovec will no longer need to be logical block aligned.  How
> the iovecs get turned into bios (and thus bvecs) is a little complicated, but
> the result is that logical blocks will be able to span bvecs.

Indeed. I missed that change in patch 3. Got it.

> 
> - Eric


-- 
Damien Le Moal
Western Digital Research
