Received: from secgw2.intern.tuwien.ac.at (secgw2.intern.tuwien.ac.at [128.130.30.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58A1662EF;
	Thu, 27 Feb 2025 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.130.30.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740657559; cv=none; b=h7q9AmVnTlR14VRLFBXNUaRU1c3J23L4LPgiaPrrczPkFXaGCX2/xE9+EDBWvSpsKVvObeGnBTsoCdVl/dtAqvOTvswE8IRqTSzXYuiOrc3UgBKCdZwwRB258qmCDj5uMEctEFNAUFSlMh1xl5flyKvKvo3XbtZnvDx8W5E6Fi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740657559; c=relaxed/simple;
	bh=rQ7Ss53NQhp6xE+NKnBfX0JGooA10Y0BSgs1MEpceyg=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gZ0lcqy3TNcWHduJ8YBW++GYib+LossxCmvmGRGVkBtt34opZiUFm0GsyxNiiLU4q0tUkh72jCtUs5EBo/+6bmWpEMoe68KWz+zjaud+5eP2HcFiHPpN992Unu4j7CRnNqPqZ0dL5+r9HOHxRdycUQnkS172I3yXe+WIFeQk5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at; spf=pass smtp.mailfrom=tuwien.ac.at; arc=none smtp.client-ip=128.130.30.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tuwien.ac.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuwien.ac.at
Received: from Kiteworks (kwmta2.intern.tuwien.ac.at [128.130.30.92])
	by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 51RBqln4002249;
	Thu, 27 Feb 2025 12:52:47 +0100
Received: from secgw2.intern.tuwien.ac.at ([128.130.30.72])
          by totemomail.intern.tuwien.ac.at (Totemo SMTP Server) with SMTP ID 339;
          Thu, 27 Feb 2025 11:52:47 +0000 (GMT)
Received: from edge19a.intern.tuwien.ac.at (edge19a.intern.tuwien.ac.at [IPv6:2001:629:1005:30::45])
	by secgw2.intern.tuwien.ac.at (8.14.7/8.14.7) with ESMTP id 51RBqjCr002221
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 27 Feb 2025 12:52:46 +0100
Received: from mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82) by
 edge19a.intern.tuwien.ac.at (2001:629:1005:30::45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 12:52:45 +0100
Received: from [2001:629:3800:12:60df:cde0:d4ed:3659]
 (2001:629:3800:12:60df:cde0:d4ed:3659) by mbx19b.intern.tuwien.ac.at
 (2001:629:1005:30::82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 12:52:45 +0100
Date: Thu, 27 Feb 2025 12:52:57 +0100
From: Thomas Haschka <thomas.haschka@tuwien.ac.at>
To: Ricky WU <ricky_wu@realtek.com>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Thomas Haschka
	<thomas.haschka@tuwien.ac.at>,
        Bart Van Assche <bvanassche@acm.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>,
        "martin.peterson@oracle.com"
	<martin.peterson@oracle.com>
Subject: RE: mmc0: error -95 doing runtime resume
In-Reply-To: <4e7162dfccbe44468f6a452896110cc8@realtek.com>
Message-ID: <aebf263c-570a-ed4b-bb37-22ab6596fbb3@tuwien.ac.at>
References: <c2f50eac-3270-8dfa-2440-4c737c366b17@tuwien.ac.at> <8fd7f1d9-fc0d-4fa7-81be-378a3fc47d2a@acm.org> <CAPDyKFpwZt9rezBhBbe9FeUX1BycD2br6RRTttvAVS_C99=TiQ@mail.gmail.com> <4e7162dfccbe44468f6a452896110cc8@realtek.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
X-ClientProxiedBy: mbx19a.intern.tuwien.ac.at (2001:629:1005:30::81) To
 mbx19b.intern.tuwien.ac.at (2001:629:1005:30::82)

Hello Ricky,

yes [1] and this issue are the same. As I only have a Surface GO 2
at hand I can not speak for other effected systems, though I guess it is
reasonable that others are effected.
It probably works for some use cases, as it only fails if I read a
lot of files, like opening emacs or firefox ( from the SD Card ). Which then
causes symptoms as outlined
here: https://bugzilla.kernel.org/show_bug.cgi?id=218821

Hello Uffe,
I will try to see what I can do with MMC_CAP_AGGRESSIVE_PM.

All the best,
- Thomas


On Thu, 27 Feb 2025, Ricky WU wrote:

>> + Ricky
>>
>> On Fri, 21 Feb 2025 at 18:20, Bart Van Assche <bvanassche@acm.org> wrote:
>>>
>>>
>>> On 2/21/25 7:41 AM, Thomas Haschka wrote:
>>>> Bug Fix: block: Improve stability of SD cards in Microsoft Surface GO 2 and
>>>>               possibly other devices.
>>>>
>>>>
>>>> The commit 65a558f66c308
>>>>      block: Improve performance for BLK_MQ_F_BLOCKING drivers
>>>>
>>>> basically made the use of SD cards in my Microsoft Surface GO 2
>> impossible.
>>>> The cards do stop functioning after about 15 minutes. Mostly at io
>>>> intensive tasks.
>>>>
>>>> As outlined in https://bugzilla.kernel.org/show_bug.cgi?id=218821
>>>> i bisected the problem that yielded an unstable operation of the
>>>> cardreader on my Surface GO 2.
>>>> I successfully reversed the commit 65a558f66c308 in 6.12.16 using
>>>> the attached patch. As I suppose the bug introduced with this commit
>>>> might hit other users of sd-cards in similar hardware I suggest this
>>>> commit shall be reversed, even if the improved performance might be
>> gone.
>>>
>>> Thank you for having bisected this issue and for having shared the
>>> result of the bisection process. This is very useful information.
>>>
>>> Since the commit mentioned above is about 1.5 years old and has not
>>> caused any issues for anyone who is not using an SD card reader, that
>>> commit is probably not the root cause of the reported behavior. Are SD
>>> cards controlled by the MMC driver? If so, I think the next step is to
>>> take a close look at the MMC driver. I have Cc-ed the MMC driver
>> maintainer.
>>
>> There was another thread [1] where I tried to loop in Ricky Wu, but there was
>> no response. I have added him to this tread too.
>>
> Hi Ulf,
> Because I was waiting for the result that revert 101bd907b424 ("misc: rtsx: judge ASPM Mode to set PETXCFG Reg")
> Can fix this issue or not, but I did not see any response...
>
> Hi Thomas,
> This issue(this mail thread) and [1] are the same issue?
> And this issue only can reproduce on surface go 2?
> If so, I need to find correct platform to reproduce this issue on my hand
>
>
>> For the record, I agree, even if reverting 65a558f66c308 solves the issue, it's
>> not the correct fix.
>>
>> Unless we can get some help from Ricky, we can try to drop assigning
>> "MMC_CAP_AGGRESSIVE_PM" in realtek_init_host() to see if that solves the
>> problem. Or if debugfs is enabled, we can disable
>> MMC_CAP_AGGRESSIVE_PM for the mmc host via the "caps" debugfs-node.
>>
>> Thomas can you try to drop MMC_CAP_AGGRESSIVE_PM and see if that solves
>> the problem?
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://lore.kernel.org/all/CAPDyKFq4-fL3oHeT9phThWQJqzicKeA447WBJUbtc
>> KPhdZ2d1A@mail.gmail.com/
>
