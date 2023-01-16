Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCEC54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbjAPXfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:35:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235515AbjAPXev (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:34:51 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EA29E0C
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673911917; x=1705447917;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AWy+sFg7dsIyAT85GW0B6MmtlIPZ/5f3Zkm6/gXaQf0=;
  b=R5ASq9DToAPXk2yr4cJ3s1jTOsSNWV/RvZIx1nn46N8H6zdoDnqqkhNu
   GZRcRa7q/FQ/TCNbviBm8Qi5YGHW8FyiNawGAH9iLLyJv8fTF9WGegHBh
   2HylDDgrNufv4EDK66Ipkf1LDlKAipGG84wmQUEbPROp0o/xkVnVgfSxl
   NM8SF//rqHx7px88UbgUrwoKIW7vU2B30rpHc8SxXa9eJ9+HVzlOiZ62f
   c7CwiBhn3tQ1XKhSnLE/pL1onMPWVxN/qCEsWBpLUzLiunNRMPACw83jp
   Lp8OEUFzoVpX6VX/yBZQh04885hcRozG3qPL9so7KEkpFI9jusYrp2cEa
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220789375"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 07:31:57 +0800
IronPort-SDR: Gei+nxnjOrwzvtGDgp2U4t8zPmLPaahqJbXJ2ZzsnBSu/0BVF2zU7SzpJS0mxTwUYukQU574U9
 tHTlcpNA0CSi9BRBdo6xuH3xol5DIBLl9dRIPQPtvg+rj1yqgItOfetrSFwgDeeG7aBHibwzu4
 zKmsXjApyDPiJ+cR5ST2v4bk7IXRjtjvjUyYez7uoZgihP6ISrwAS5qB9cQ8Rq3x/fg3vXfsEp
 kfhW6XGjgHYr8jDv8rq25D87ew04pAcXRPWAZYwFK073IcoIz9Ja82+J4kWHm2kbRU00H1C30s
 /70=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 14:43:54 -0800
IronPort-SDR: wsbVDxODSP1YdUMQ5o1SyUb/4BjRyOEyy+gxI0RhY/zjlZDdsZHS39VU0M43TZNOWTxbRy+zH2
 t9K0AnmktM6Yqto3UW/7s52gyxDtoFW8bfcSy9OCTMAizPGii8s/lRJrCJuhtyj7xTwPPcqIwr
 uEgaSt22OWt3bcZSxHxEfDBIZQQ2TFH2TETC9jVfi/6fM55EiQqzVxP1jjGjLSVEYwsysORozu
 m1DkZahw5RVrDkOOyNz5+2gj1eTWWGR59O48u4pxNLFi8SoOn1k0M0Pq+oli4dUpruawC/7mr8
 6Ps=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 15:31:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwpFn0Tlqz1Rwrq
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:31:57 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673911916; x=1676503917; bh=AWy+sFg7dsIyAT85GW0B6MmtlIPZ/5f3Zkm
        6/gXaQf0=; b=ciDXSAA3WTdC31Kauna1OIvCEMj8pOVRrfpfrFaj5tc+DOX/hjX
        PdERbRabQeu9p4s7VfGN6kFRp91sEFwPBlj5ayYRQ3EUfUWl/EZ4kIW2iYRsp/q2
        AzRfmsiNA4Dx+9EcH3GGZG01sVe0bm4j8DF4IYCDu2J8neHgohdNCFQAO7mzun/T
        A8VAsd9+JTboA6ATtkzBjLsEP/+pkmjvOfmACZ/hQcoOSsog08bvZwHd1VBoKOta
        fqZ0VFAjIFgw67qyvSpcSs+MSLjjXjpRDv1Aon+A9jryrJXEBQgJnfJSBKLXjRw5
        WWF7yRlNbb1T4tSMIufODXMI2v1fIyinhzw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oAf1Q23M0QV2 for <linux-block@vger.kernel.org>;
        Mon, 16 Jan 2023 15:31:56 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwpFl4JbQz1RvLy;
        Mon, 16 Jan 2023 15:31:55 -0800 (PST)
Message-ID: <88d454ab-97bf-f5a9-7645-5fb89c4bc0e0@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 08:31:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] block: don't allow multiple bios for IOCB_NOWAIT issue
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Michael Kelley <mikelley@microsoft.com>
References: <1ce71005-c81b-374d-5bcf-e3b7e7c48d0d@kernel.dk>
 <7c69e3b5-c81b-a3ba-9588-9a59c32c45b7@opensource.wdc.com>
 <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4ed4090b-7bff-dd43-da23-915f269bd759@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 08:28, Jens Axboe wrote:
> On 1/16/23 4:20?PM, Damien Le Moal wrote:
>> On 1/17/23 06:06, Jens Axboe wrote:
>>> If we're doing a large IO request which needs to be split into multiple
>>> bios for issue, then we can run into the same situation as the below
>>> marked commit fixes - parts will complete just fine, one or more parts
>>> will fail to allocate a request. This will result in a partially
>>> completed read or write request, where the caller gets EAGAIN even though
>>> parts of the IO completed just fine.
>>>
>>> Do the same for large bios as we do for splits - fail a NOWAIT request
>>> with EAGAIN. This isn't technically fixing an issue in the below marked
>>> patch, but for stable purposes, we should have either none of them or
>>> both.
>>>
>>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>>
>>> Cc: stable@vger.kernel.org # 5.15+
>>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>>> Link: https://github.com/axboe/liburing/issues/766
>>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> ---
>>>
>>> Since v1: catch this at submit time instead, since we can have various
>>> valid cases where the number of single page segments will not take a
>>> bio segment (page merging, huge pages).
>>>
>>> diff --git a/block/fops.c b/block/fops.c
>>> index 50d245e8c913..d2e6be4e3d1c 100644
>>> --- a/block/fops.c
>>> +++ b/block/fops.c
>>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>  			bio_endio(bio);
>>>  			break;
>>>  		}
>>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>>> +			/*
>>> +			 * This is nonblocking IO, and we need to allocate
>>> +			 * another bio if we have data left to map. As we
>>> +			 * cannot guarantee that one of the sub bios will not
>>> +			 * fail getting issued FOR NOWAIT and as error results
>>> +			 * are coalesced across all of them, be safe and ask for
>>> +			 * a retry of this from blocking context.
>>> +			 */
>>> +			if (unlikely(iov_iter_count(iter))) {
>>> +				bio_release_pages(bio, false);
>>> +				bio_clear_flag(bio, BIO_REFFED);
>>> +				bio_put(bio);
>>> +				blk_finish_plug(&plug);
>>> +				return -EAGAIN;
>>
>> Doesn't this mean that for a really very large IO request that has 100%
>> chance of being split, the user will always get -EAGAIN ? Not that I mind,
>> doing super large IOs with NOWAIT is not a smart thing to do in the first
>> place... But as a user interface, it seems that this will prevent any
>> forward progress for such really large NOWAIT IOs. Is that OK ?
> 
> Right, if you asked for NOWAIT, then it would not necessarily succeed if
> it:
> 
> 1) Needs multiple bios
> 2) Needs splitting
> 
> You're expected to attempt blocking issue at that point. Reasoning is
> explained in this (and the previous commit related to the issue),
> otherwise you end up with potentially various amounts of the request
> being written to disk or read from disk, but EAGAIN being returned for
> the request as a whole.

Yes, I understood all that and completely agree with it.

I was only wondering if this change may not surprise some (bad) userspace
stuff. Do we need to update some man page or other doc, mentioning that
there are no guarantees that a NOWAIT IO may actually be executed if it
too large (e.g. larger than max_sectors_kb) ?

-- 
Damien Le Moal
Western Digital Research

