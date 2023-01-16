Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F6C54EBE
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 23:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbjAPXfM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 18:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235529AbjAPXex (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 18:34:53 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F31D90A
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673911961; x=1705447961;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fpa6If5z8gNwdZ6N8yMP49PoqfWu8Cr3FlsfdmaqgHo=;
  b=a/hJwQcFSYCs0a4WyFCMreQz5DsS0UA1GKdGu7nn7JyXAVLwBGdKoKgf
   CVi/nATcy+4lketlgB9JtnIbaBG28QgOmVYJDLpINK1+kFl1HnW5sxg/A
   Mw0peW7GbOycSeZywOSzAlCcDJiGMNvIOfM+1g5jKFUTktlPkw+1PJOqq
   +jPCMpjegMK9GS2RbGdWkujh1m1CEEckQCTD85dv6UY2koA7kr/EZguiV
   MMd/tKi1vKmBuoeHVZUO6WbBuGtGd/htU3i4XEkSsLm0x6oV9saN39N96
   RXHF7tafWfhYTq60m7huReiPYHhhtnJP74mh3oxRcVlTJWWzJT//CJmS+
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220789411"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 07:32:41 +0800
IronPort-SDR: Phy63Vt8xzHlQMeJ6J1sUYVbXZIeoCJbxg5fYUZEuu+YY3XuXPdDNQezGzMkwzBl4aDJA7ZHiq
 Q++4tUNunZ+x9totp8QVK0hGtc28WHPJo5m7pt7i9HOWkMRIRhUAJrelKVGskUeqHvetJro2Jg
 /GUz2BEYz7THWExRODeog1QdbFNi9aInt+NQaMLK+MnIBfTF25RvB0L1euD7vUx429nE7p4V8B
 raLp9O/YmSkyrJR7PJItZ96f8oiJeOeArvwLdmBtKoMcbvUaEwkoESHZYMpnRhY+6aNoTMInh+
 2NM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 14:44:38 -0800
IronPort-SDR: +ZVaUmayME+MOYsfpxEuduixesP+ftCwqbXtLBW2yhHHGoiXM/X4F8DKrATV3GH7DILAyXwabS
 tuDtH7SqODKFk6wf1RXQxt8w8p8MjaY/GDSWxdisUio66Joye9rc00Bu7rO/Gth+UH4gN+OQfL
 WuzyGivbOVOo0O3xROvr0kfJv+iz3DY3/C6oMmAlal3BwqlKWfZsNaZvPBcj4O/oLx9cNhb718
 upNtlz44nrHyBQb9819/xJ7RSkBfUDWEyA0L8YLPjdxT3kLuR5v2DU+m1yLIC3VRoX9gYFXUfJ
 B6g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 15:32:42 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwpGd1qjQz1Rwrq
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 15:32:41 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673911960; x=1676503961; bh=fpa6If5z8gNwdZ6N8yMP49PoqfWu8Cr3Fls
        fdmaqgHo=; b=olObt5L9MKjHcwdRL3iXNMndGEyXiC3z9g+BuZWDqLjXrrhcTa6
        jZPBz+Ule/agklg5vayoXdVybyEdL18VJ+8vrJaxzng8wrkSHZs7pPnsMRmppXgo
        8dJip6LBbksXMtUNtNkg4Hw9znEUPYjhitFU4za3Kw7/u41kAlUq26bTvO4VqGL8
        bxiXFp8USBiIWZP31zV44sMNMuyRFzamUeNWOSy+6w+7L30nCeIioQd+7iiESzM0
        vP9B6B2C73xwsZ/eMfVFYj9/D5HD+ed11AEa3M9H7lsku3IafW7zU8ZuYc424sZq
        yLx5uCRyY2/OoXM3BPwcpEJutwZ9VA9JH+w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id acfa1Jc3SaZ2 for <linux-block@vger.kernel.org>;
        Mon, 16 Jan 2023 15:32:40 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwpGb5xFbz1RvLy;
        Mon, 16 Jan 2023 15:32:39 -0800 (PST)
Message-ID: <b77ae47c-a17e-4536-cecc-23a089f35be7@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 08:32:38 +0900
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
 <1e2c9225-4d29-051e-e1f5-e0948d7889e3@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1e2c9225-4d29-051e-e1f5-e0948d7889e3@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 08:29, Jens Axboe wrote:
> On 1/16/23 4:28?PM, Jens Axboe wrote:
>> On 1/16/23 4:20?PM, Damien Le Moal wrote:
>>> On 1/17/23 06:06, Jens Axboe wrote:
>>>> If we're doing a large IO request which needs to be split into multiple
>>>> bios for issue, then we can run into the same situation as the below
>>>> marked commit fixes - parts will complete just fine, one or more parts
>>>> will fail to allocate a request. This will result in a partially
>>>> completed read or write request, where the caller gets EAGAIN even though
>>>> parts of the IO completed just fine.
>>>>
>>>> Do the same for large bios as we do for splits - fail a NOWAIT request
>>>> with EAGAIN. This isn't technically fixing an issue in the below marked
>>>> patch, but for stable purposes, we should have either none of them or
>>>> both.
>>>>
>>>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL return")
>>>>
>>>> Cc: stable@vger.kernel.org # 5.15+
>>>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
>>>> Link: https://github.com/axboe/liburing/issues/766
>>>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> ---
>>>>
>>>> Since v1: catch this at submit time instead, since we can have various
>>>> valid cases where the number of single page segments will not take a
>>>> bio segment (page merging, huge pages).
>>>>
>>>> diff --git a/block/fops.c b/block/fops.c
>>>> index 50d245e8c913..d2e6be4e3d1c 100644
>>>> --- a/block/fops.c
>>>> +++ b/block/fops.c
>>>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>>>>  			bio_endio(bio);
>>>>  			break;
>>>>  		}
>>>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>>>> +			/*
>>>> +			 * This is nonblocking IO, and we need to allocate
>>>> +			 * another bio if we have data left to map. As we
>>>> +			 * cannot guarantee that one of the sub bios will not
>>>> +			 * fail getting issued FOR NOWAIT and as error results
>>>> +			 * are coalesced across all of them, be safe and ask for
>>>> +			 * a retry of this from blocking context.
>>>> +			 */
>>>> +			if (unlikely(iov_iter_count(iter))) {
>>>> +				bio_release_pages(bio, false);
>>>> +				bio_clear_flag(bio, BIO_REFFED);
>>>> +				bio_put(bio);
>>>> +				blk_finish_plug(&plug);
>>>> +				return -EAGAIN;
>>>
>>> Doesn't this mean that for a really very large IO request that has 100%
>>> chance of being split, the user will always get -EAGAIN ? Not that I mind,
>>> doing super large IOs with NOWAIT is not a smart thing to do in the first
>>> place... But as a user interface, it seems that this will prevent any
>>> forward progress for such really large NOWAIT IOs. Is that OK ?
>>
>> Right, if you asked for NOWAIT, then it would not necessarily succeed if
>> it:
>>
>> 1) Needs multiple bios
>> 2) Needs splitting
>>
>> You're expected to attempt blocking issue at that point. Reasoning is
>> explained in this (and the previous commit related to the issue),
>> otherwise you end up with potentially various amounts of the request
>> being written to disk or read from disk, but EAGAIN being returned for
>> the request as a whole.
> 
> BTW, this is no different than eg doing a buffered read and needing to
> read in the data. You'd get EAGAIN, and no amount of repeated retries
> would change that. You need to either block for the IO at that point, or
> otherwise start it so it will become available directly at some later
> point (eg readahead).

Indeed.

-- 
Damien Le Moal
Western Digital Research

