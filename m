Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C27C25B07
	for <linux-block@archiver.kernel.org>; Wed, 10 Aug 2022 19:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbiHJTOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Aug 2022 15:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbiHJTOT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Aug 2022 15:14:19 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912EB1E4
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660158857; x=1691694857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gYs2N/Wznfe3hlI62W4thC972nT2hghgh16QaFZ50J8=;
  b=W7WWHst+iRco8iNccQy7YfRTk1bTRC1agw0cVeGBXheSu440qceaJSjZ
   iiJA5cXROvLF8+SO090QlZCV/cQBpOFMA7oyi++8XxLHvFNDw+yvreNGE
   h9JFlAds0lYjRiFeyDPS+UZ2kYG3wWhVH1lUqo99hLpEUXyLWsyNpL4zV
   Crwt3ekXe4FnXNt93+S6hWwTfSEstZqwu8p6S9ztwVEmdbxtEUwjbSRpC
   HeuErFF8iwuya7/FoJUgukGgRemc5VYSDjJ+GhUOYeVg8KMMfrYYfDGcd
   sFvIMm+XwepmoRWxRDldoNuZXxBSCb9+vjbRhy4xyMYTAZzMNoPJCfTLd
   w==;
X-IronPort-AV: E=Sophos;i="5.93,228,1654531200"; 
   d="scan'208";a="208372763"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 03:14:15 +0800
IronPort-SDR: 5K6kgTNI4cO/2LZpDGRKGSESyzN8zqSOO2uFRblwJpo2RxvZ8xqiiCz8mFenDZ29IMLLqgLHQS
 ykVMEXxJEWFP33y/Gl6PNnaLSY90TeauIMWvAB1ExMZT1s/SL2njkaM2DMtIEbaOJBTSLo9B1L
 rw7DZm9yQVpad6OxOXG1EySFw82Rjw/OVX7CX+dLMyix5Ej14BPG6yT1M8QCxkZL4PeX9wQrvl
 Tm0XL4THuAjVNJSwchbansL0+m/HSQ4ZFdFPbYP1B7WXVQnwgFcHdlG6MnzoQb5Hs+5I6mNWZi
 m4f0I6NDullUsQT7H3dc0gBS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 11:29:52 -0700
IronPort-SDR: b45+YH9l8oTDmt/JTkDTVFlUzI9d7EGNqX4wXDKaU5t8ztJLWwQc1FOAcFeWrDEkXkYPgHUM3V
 e6TQY/sXBBHQ3Z55sbeJFzpKWGH4FmudusVQb7hmK6OLUnXtRuS+6HQ61K8OMpmb47d9D8CE0s
 mL/Gjm/TCvecoXFyk0gf/rECGefRBc3SE9RK1uF0u5aT6tlM6vGSEJCZI4O0P0Q7rEOBKqrbO7
 PSsbIm9q8WcMm3oaLecNTlKW20/ySMG7Oum7WD1fiZ3y8mhjQMnYFSqHixz8cSVjA+jb1UscOh
 09M=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 12:14:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M303r4Z7Nz1RwqM
        for <linux-block@vger.kernel.org>; Wed, 10 Aug 2022 12:14:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1660158855; x=1662750856; bh=gYs2N/Wznfe3hlI62W4thC972nT2hghgh16
        QaFZ50J8=; b=b4uhH+5wdpEN2z/jmylzewLZG09cHbzZ5SgpxD3KsNwLEm3EH5H
        2d+jIgCLis0xw3HyhRMWmu/zCVWPtkRtzV1zPLC+GElWyMKOqP1rBZ2AmG8wdyLt
        H31joYQ+n8qz16K/emic50ItcbU4M4XzacUb+f4Kzhav7MgAk0AJy+ds2HvgfvuE
        rmZRKbMJrq1wczDgXsVfUky1HlgaP3pGBo6oU5VBJPmahiR0b/AgF8fpTGYgeBlQ
        U+wc2e7Ziuc9ckJPku3FUtoo1vGjeI1HrZJ7/PeuukzjyeITJXcIqjE/MzX46E2h
        2eBti17CSS9lJEjaDW8Z2fk0sS3hq6Z8HeQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QnwGwB2eiQfh for <linux-block@vger.kernel.org>;
        Wed, 10 Aug 2022 12:14:15 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M303q5mpcz1RtVk;
        Wed, 10 Aug 2022 12:14:15 -0700 (PDT)
Message-ID: <27eed02c-fd92-6f99-b213-1be70193b37d@opensource.wdc.com>
Date:   Wed, 10 Aug 2022 12:14:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: fs/zonefs/./trace.h:22:1: sparse: sparse: cast to restricted
 blk_opf_t
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <202208061533.YBqXyzHm-lkp@intel.com>
 <affa6eee-3b7c-105a-8f4a-35f1ed81f0cd@opensource.wdc.com>
 <b3a6b038-ba0c-2242-3a29-5bcadcaa9d71@acm.org>
 <24b7e027-e098-269b-ccf7-b14deb499c33@opensource.wdc.com>
 <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <8aa0e7a4-265c-21f4-bdb4-57641d15b7b9@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2022/08/10 11:08, Bart Van Assche wrote:
> On 8/10/22 07:36, Damien Le Moal wrote:
>> On 2022/08/08 8:37, Bart Van Assche wrote:
>>> Thanks for having taken a look. Please help with verifying whether the
>>> following patch is sufficient to fix the reported warning: "[PATCH]
>>> tracing: Suppress sparse warnings triggered by is_signed_type()"
>>> (https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).
>>
>> With the current Linus tree, I do not see this sparse warning. However, applying
>> the above patch, "make M=fs/zonefs C=1" generates a lot of warnings:
> 
> That doesn't make sense to me. My patch reduces the number of sparse 
> warnings that are reported.
> 
>> make -j64 M=fs/zonefs C=1
>>    CC [M]  fs/zonefs/super.o
>>    CC [M]  fs/zonefs/sysfs.o
>>    CHECK   fs/zonefs/sysfs.c
>>    CHECK   fs/zonefs/super.c
>> fs/zonefs/sysfs.c: note: in included file (through include/linux/bitops.h,
>> include/linux/kernel.h, arch/x86/include/asm/percpu.h,
>> arch/x86/include/asm/preempt.h, include/linux/preempt.h,
>> include/linux/spinlock.h, ...):
>> ./arch/x86/include/asm/bitops.h:66:1: warning: unreplaced symbol 'return'
> 
> I think that you are hitting a bug in sparse. See also 
> https://lore.kernel.org/all/e91d351c-3c16-e48d-7e9d-9f096c4acbc9@debian.org/T/. 
> I also see the above warnings if I use the sparse binary from Debian 
> testing. I do not see these sparse warnings if I download the sparse 
> source code and compile that source code myself.

Good point. I was using Fedora 36 sparse package. Using sparse compiled from
source, I now see again the warnings without the patch and no warnings with the
patch applied. So the patch looks good. Are you going to send it as a fix for
6.0-rc1 ?

Cheers.


-- 
Damien Le Moal
Western Digital Research
