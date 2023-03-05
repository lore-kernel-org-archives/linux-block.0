Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175F0C678DB
	for <linux-block@archiver.kernel.org>; Sun,  5 Mar 2023 03:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbjCEDGk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Mar 2023 22:06:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjCEDGj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Mar 2023 22:06:39 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A411E99
        for <linux-block@vger.kernel.org>; Sat,  4 Mar 2023 19:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677985597; x=1709521597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4sHgSFSdO5N7LHmIQ4SkzwwAHxAQ/XXht/nbleX0auY=;
  b=SLmlNW4ohuREogtIO/51PZx00UI99wCTES+oB36OfQHAJcCx3CnyjWc9
   UogYexOTJdk4bzW5Zm/LUtHIgfJODoOOurOJCvahRJklet8d7vuey2rLh
   cu0HYpy8yiT5pyOTPpvKK18drD11svEHjrUcaUzY7gvcvOP1TN6Hl2Kxe
   62rUyrlTfwoPJLjoCdBlxdnXX3vluJDe7UWefJocZi9Dcvm4U8h5dTpEE
   5yAxur3EV8dj6EbijJ7/XJGbw73r5jIBOOdjcqcIyfhSdr0+yu2A8y76z
   kWA6acOEGGR8wuF1KZTHHLHOEtiVnEidpFYcwUFV6nX1J74YycOslf12W
   w==;
X-IronPort-AV: E=Sophos;i="5.98,234,1673884800"; 
   d="scan'208";a="336802080"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2023 11:06:36 +0800
IronPort-SDR: xHy/ybAUBxccb0TjD7anV0K6U6JnJXefvMDXTSwSOQkLmQEB+64CFPu9cpfVrv3UpnBCEzFGxN
 8epo5BFxbKxqxWKXKtB14l9dQxmMimaeHcDVk1sbWJifNKouekbgd0Aq9nL0oTot9TVMZK5TKm
 xlweyUb8Meehgs7gd75FwJbKnElCVm9XFb7phurtqhHTysCX8c93W3MQ2aSweYUjiYQqSNxvUM
 wTGh6skq8jYl4Eb7N39675KWQFmFps+Wv4LPsjiB06cvLOWOgYZ0d477De32GpWJj1DfER44GG
 gKo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2023 18:23:19 -0800
IronPort-SDR: VpAKgbxWXBWvbeLy4WoVigEIlF5kOYZWYulCTxmIYFZ871k+xHzCURGdl3fYvKFIbDzKduAzfK
 GTXiSKb4uz0lU75ZSFa4AbjtHHmS13uh556Rm0orXDwVEbTq0JXiBUd/IAMTPYLZjWEh2/R3vn
 PNQrI7VyuLhi0+kGBhaz2yGP8ABQtM15gj/HmvvhW9QPJ84URu+Xeu9fioyPBP0HgqailPjQJE
 ZbQ2iH1Q370gGj8FcgAdbpefgS0W3p1OertGP/UmiXM8mP7SJ4CiVanxr27u3EfSATv4plvl0m
 1RQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2023 19:06:36 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PTmnm1mndz1RwtC
        for <linux-block@vger.kernel.org>; Sat,  4 Mar 2023 19:06:36 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1677985594; x=1680577595; bh=4sHgSFSdO5N7LHmIQ4SkzwwAHxAQ/XXht/n
        bleX0auY=; b=Vmwp9iSZzXgnPq3u7PukPbcVkENzd7IZ7drRQSF40ngNl4e6L15
        nH5qHszkfAPbbOMMkJtgs3naAsv6O7iOmnE/QS0gZGAPIoTeoggDG5NEqIOzUkjj
        xJsUYBaGhQ70ZBERU5FB5TZIY5tgtBJE3N1x41F6/eikHLjQhcwQrknD4ZNQ/BxH
        KwjbaJ1Es6WWPqwwfwFwCrPEq8JHc0WSwyjcr1MDAPZ13Ys2w4ldNc0Ad1WThQ+I
        mY1p9cOqg1K9CMvnfMvXZ+xufbCDAo1BrOaPiQ/10xsiaIIQwvY9o5uZw0K1fN5V
        jPJ0+Z2S9sa/ZUzD8s7LbRBnSw22b9FN9/Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nYnVj-sEa69p for <linux-block@vger.kernel.org>;
        Sat,  4 Mar 2023 19:06:34 -0800 (PST)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PTmnh6htNz1RvLy;
        Sat,  4 Mar 2023 19:06:32 -0800 (PST)
Message-ID: <9edd952e-d9b5-ed5f-29a2-981dfd9b10cd@opensource.wdc.com>
Date:   Sun, 5 Mar 2023 12:06:31 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <Y/7L74P6jSWwOvWt@mit.edu>
 <ZAFUYqAcPmRPLjET@kbusch-mbp.dhcp.thefacebook.com>
 <ZAFuSSZ5vZN7/UAa@casper.infradead.org>
 <ZAJqjM6qLrraFrrn@bombadil.infradead.org>
 <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
 <ZAN2HYXDI+hIsf6W@casper.infradead.org>
 <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
 <ZAOF3p+vqA6pd7px@casper.infradead.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <ZAOF3p+vqA6pd7px@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/5/23 02:54, Matthew Wilcox wrote:
> On Sat, Mar 04, 2023 at 06:17:35PM +0100, Hannes Reinecke wrote:
>> On 3/4/23 17:47, Matthew Wilcox wrote:
>>> On Sat, Mar 04, 2023 at 12:08:36PM +0100, Hannes Reinecke wrote:
>>>> We could implement a (virtual) zoned device, and expose each zone as a
>>>> block. That gives us the required large block characteristics, and with
>>>> a bit of luck we might be able to dial up to really large block sizes
>>>> like the 256M sizes on current SMR drives.
>>>> ublk might be a good starting point.
>>>
>>> Ummmm.  Is supporting 256MB block sizes really a desired goal?  I suggest
>>> that is far past the knee of the curve; if we can only write 256MB chunks
>>> as a single entity, we're looking more at a filesystem redesign than we
>>> are at making filesystems and the MM support 256MB size blocks.
>>>
>> Naa, not really. It _would_ be cool as we could get rid of all the cludges
>> which have nowadays re sequential writes.
>> And, remember, 256M is just a number someone thought to be a good
>> compromise. If we end up with a lower number (16M?) we might be able
>> to convince the powers that be to change their zone size.
>> Heck, with 16M block size there wouldn't be a _need_ for zones in
>> the first place.
>>
>> But yeah, 256M is excessive. Initially I would shoot for something
>> like 2M.
> 
> I think we're talking about different things (probably different storage
> vendors want different things, or even different people at the same
> storage vendor want different things).
> 
> Luis and I are talking about larger LBA sizes.  That is, the minimum
> read/write size from the block device is 16kB or 64kB or whatever.
> In this scenario, the minimum amount of space occupied by a file goes
> up from 512 bytes or 4kB to 64kB.  That's doable, even if somewhat
> suboptimal.

FYI, that is already out there, even though hidden from the host for backward
compatibility reasons. Example: WD SMR drives use 64K distributed sectors, which
is essentially 16 4KB sectors stripped together to achieve stronger ECC).

C.f. Distributed sector format (DSEC):
https://documents.westerndigital.com/content/dam/doc-library/en_us/assets/public/western-digital/collateral/tech-brief/tech-brief-ultrasmr-technology.pdf

This is hidden to the host though, and the LBA remains 512B or 4KB. This however
does result in measurable impact on IOPS with small reads as a sub-64K read
needs to be internally processed as a 64KB read to get the entire DSEC. The drop
in performance is not dramatic: about 5% lower IOPS compared to an equivalent
drive without DSEC. Still, that matters considering HDD IO density issues
(IOPS/TB) but in the case of SMR, that is part of the increased capacity trade-off.

So exposing the DSEC directly as the LBA size is not a stretch for the HDD FW,
as long as the host supports that. There are no plans to do so though, but we
could try experimenting.

For host side experimentation, something like qemu/nvme device emulation or
tcmu-runner for scsi devices, should be able to allow emulating large block size
fairly easily.

> 
> Your concern seems to be more around shingled devices (or their equivalent
> in SSD terms) where there are large zones which are append-only, but
> you can still random-read 512 byte LBAs.  I think there are different
> solutions to these problems, and people are working on both of these
> problems.

The above example does show that the device can generally implement emulation of
smaller LBA even with an internally larger read/write size unit. Having that
larger size unit advertised as the optimal IO size alignment (as it should) and
being more diligent in having FSes & mm use that may be a good approach too.

> 
> But if storage vendors are really pushing for 256MB LBAs, then that's
> going to need a third kind of solution, and I'm not aware of anyone
> working on that.

No we are not pushing for such crazy numbers :)
And for SMR case, smaller zone sizes are not desired as small zone size leads to
more real estate waste on the HDD platters, so lower total capacity (not desired
given that SMR is all about getting higher capacity "for free").


-- 
Damien Le Moal
Western Digital Research

