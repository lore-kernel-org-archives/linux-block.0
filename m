Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503E2C46467
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 02:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbjAQCRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 21:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjAQCRN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 21:17:13 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9FB42330E
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 18:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673921831; x=1705457831;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nKzpArQja9Ws17FksvNAhKOoAP6jevRg+/gbbgzzA1A=;
  b=Q4gzQmDWwewHDze6EIuYn9YuFcVqo0UrbbJuwWLiHVH1tmh61cCB7fK7
   9kYwOxtrpuqzN2SWnfk568MsnfH1VWoIzvva7eE1TQDwFbwUd0Sc0VBXk
   VPoziF6/n3g70leU5aJoK2Is1w9+T+zPiAOOSZY6lu+fDYaj8MTSePdl5
   6y3bslCvxApeCq3fZl9LO7EjR7J+40aYhElHHiMdG/7LB6kRD0h3zWhgj
   SheRhFAIIMm2+CzMovzsMpFQmBYJjnOPR/QiG2cyVWzhNZ3ZL0gjyTcgK
   0Qx4T7umKcvvGYyUXqkc3hSb5cab8u4Qlb2EU1d8joUwnbONnDi3EqzEh
   A==;
X-IronPort-AV: E=Sophos;i="5.97,222,1669046400"; 
   d="scan'208";a="220798748"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jan 2023 10:17:11 +0800
IronPort-SDR: i6LkX5ISpMtXL+1TqluRkG5uRk/N2oWWBqdFyR4xQNmwlZRFqbSXUVrnsF2KoEWzB4ntrRfFrn
 VCrAiVD+DzLqt3iu3A6hQySB6x0ZuP0SyUXv5aPup0KlX669gEhfxw0lkfrnwhCFKNbIyK4jy/
 vMRVNh/Om2rcyUW/y0GXXT9ZK5ts0io5u309GidqiIuJ65xAz/c8ST0YQKbXr4PVNaTXOui5IJ
 lGq+vGPb7bKzDA5XoEq3lehwk2oYJ1XrT0QDiP30h3+zLRSJlS2zp8xGWng8gH4E5DhGQza3cO
 tJ0=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 17:29:08 -0800
IronPort-SDR: bxv8xgnaStfdesQyzOaSOrgE7TR+NBnF9uiM5pWJNGTZS36LaJWj+bE0MS769B+Yrz41qvxBtZ
 D48TMJOC2T5KFZhSGBsBdA2Uw708nvTiIM8Y9n4FQI6/l9seHCL8njIML4b6j5oVqER3gLEOK+
 D1BPJ/y3pP80xCMyy2kdRb+txSg069JMS0PpUJgKKhZ4FSDciHkKqf5jmxllyp3jTccPuu1BWF
 c/Ols2DoYfeS3eYhrgqlTpkuHqVfrXRT7AWvMQ4n/XmUsJx0kr4Oz/oHhJZd23IRiZQlt0777n
 76k=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Jan 2023 18:17:11 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NwswQ6Fy9z1Rwrq
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 18:17:10 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1673921830; x=1676513831; bh=nKzpArQja9Ws17FksvNAhKOoAP6jevRg+/g
        bbgzzA1A=; b=IeG+yQHNct+FOnUDgMkrFw3uT1jVoDR0bcI/YyWgcOxHReup/ZU
        GpP7jH8Sdq3jebi9eSdm8aJIBmT0Jx7dYaLdmMoXu/txhM/Qtd8+qRWeBjUTpaGO
        81SUWfDFb03mCs3cLCRmBtcxT2GXfzSj7z16Ffb8NrM+sK/mtKh4tzJ+SdWySuSG
        HqaJkODQpjoFUPIhi1+heISgILNmKxZ+Tbl7JjQNlqF237zOtTEuP2PlKiLo/Yvi
        5m6mlS6AgPNF9XRMs1CTBFlHKifz38LFzbPN+ippupWTz1h2zdvSTA3KLBh2lEbO
        SzYTnrUFEAss4sjL3gTv2XOIJiwlHY7Xn3w==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cAD3Nfynn6jw for <linux-block@vger.kernel.org>;
        Mon, 16 Jan 2023 18:17:10 -0800 (PST)
Received: from [10.225.163.30] (unknown [10.225.163.30])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NwswP2rt2z1RvLy;
        Mon, 16 Jan 2023 18:17:09 -0800 (PST)
Message-ID: <98177e37-7abd-c319-8017-d9303fc8abd9@opensource.wdc.com>
Date:   Tue, 17 Jan 2023 11:17:07 +0900
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
 <88d454ab-97bf-f5a9-7645-5fb89c4bc0e0@opensource.wdc.com>
 <da64245b-4127-f6be-76e4-a9c9546c8226@kernel.dk>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <da64245b-4127-f6be-76e4-a9c9546c8226@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/17/23 08:39, Jens Axboe wrote:
> On 1/16/23 4:31=E2=80=AFPM, Damien Le Moal wrote:
>> On 1/17/23 08:28, Jens Axboe wrote:
>>> On 1/16/23 4:20?PM, Damien Le Moal wrote:
>>>> On 1/17/23 06:06, Jens Axboe wrote:
>>>>> If we're doing a large IO request which needs to be split into mult=
iple
>>>>> bios for issue, then we can run into the same situation as the belo=
w
>>>>> marked commit fixes - parts will complete just fine, one or more pa=
rts
>>>>> will fail to allocate a request. This will result in a partially
>>>>> completed read or write request, where the caller gets EAGAIN even =
though
>>>>> parts of the IO completed just fine.
>>>>>
>>>>> Do the same for large bios as we do for splits - fail a NOWAIT requ=
est
>>>>> with EAGAIN. This isn't technically fixing an issue in the below ma=
rked
>>>>> patch, but for stable purposes, we should have either none of them =
or
>>>>> both.
>>>>>
>>>>> This depends on: 613b14884b85 ("block: handle bio_split_to_limits()=
 NULL return")
>>>>>
>>>>> Cc: stable@vger.kernel.org # 5.15+
>>>>> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT =
bio")
>>>>> Link: https://github.com/axboe/liburing/issues/766
>>>>> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>>
>>>>> ---
>>>>>
>>>>> Since v1: catch this at submit time instead, since we can have vari=
ous
>>>>> valid cases where the number of single page segments will not take =
a
>>>>> bio segment (page merging, huge pages).
>>>>>
>>>>> diff --git a/block/fops.c b/block/fops.c
>>>>> index 50d245e8c913..d2e6be4e3d1c 100644
>>>>> --- a/block/fops.c
>>>>> +++ b/block/fops.c
>>>>> @@ -221,6 +221,24 @@ static ssize_t __blkdev_direct_IO(struct kiocb=
 *iocb, struct iov_iter *iter,
>>>>>  			bio_endio(bio);
>>>>>  			break;
>>>>>  		}
>>>>> +		if (iocb->ki_flags & IOCB_NOWAIT) {
>>>>> +			/*
>>>>> +			 * This is nonblocking IO, and we need to allocate
>>>>> +			 * another bio if we have data left to map. As we
>>>>> +			 * cannot guarantee that one of the sub bios will not
>>>>> +			 * fail getting issued FOR NOWAIT and as error results
>>>>> +			 * are coalesced across all of them, be safe and ask for
>>>>> +			 * a retry of this from blocking context.
>>>>> +			 */
>>>>> +			if (unlikely(iov_iter_count(iter))) {
>>>>> +				bio_release_pages(bio, false);
>>>>> +				bio_clear_flag(bio, BIO_REFFED);
>>>>> +				bio_put(bio);
>>>>> +				blk_finish_plug(&plug);
>>>>> +				return -EAGAIN;
>>>>
>>>> Doesn't this mean that for a really very large IO request that has 1=
00%
>>>> chance of being split, the user will always get -EAGAIN ? Not that I=
 mind,
>>>> doing super large IOs with NOWAIT is not a smart thing to do in the =
first
>>>> place... But as a user interface, it seems that this will prevent an=
y
>>>> forward progress for such really large NOWAIT IOs. Is that OK ?
>>>
>>> Right, if you asked for NOWAIT, then it would not necessarily succeed=
 if
>>> it:
>>>
>>> 1) Needs multiple bios
>>> 2) Needs splitting
>>>
>>> You're expected to attempt blocking issue at that point. Reasoning is
>>> explained in this (and the previous commit related to the issue),
>>> otherwise you end up with potentially various amounts of the request
>>> being written to disk or read from disk, but EAGAIN being returned fo=
r
>>> the request as a whole.
>>
>> Yes, I understood all that and completely agree with it.
>>
>> I was only wondering if this change may not surprise some (bad) usersp=
ace
>> stuff. Do we need to update some man page or other doc, mentioning tha=
t
>> there are no guarantees that a NOWAIT IO may actually be executed if i=
t
>> too large (e.g. larger than max_sectors_kb) ?
>=20
> We can certainly add it to the man pages talking about RWF_NOWAIT. But
> there's never been a guarantee that any EAGAIN will later succeed
> under the same conditions, and honestly there are various conditions
> where this is already not true. And those same cases would spuriously
> yield EAGAIN before already, it's not a new condition for those sizes
> of IOs.

OK. Thanks.

--=20
Damien Le Moal
Western Digital Research

