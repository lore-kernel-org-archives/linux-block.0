Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF48B1AC8BF;
	Mon,  9 Sep 2024 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877237; cv=none; b=uKn50GPM9ycBkq5jblacHxDeHQ/xDbcKoDcJLYwg6k71aIB1feUzXwLIuRcC9sV+wLA/LHxM1f5re6gqEtxS7FWPxFrA4Lb1DJpNsoGuJwToVJh+mPEz/UVHcqEB1W9oFQ9X3YKweShm/VlKdFgqiEUBemxixBpwGR7EbTeXBl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877237; c=relaxed/simple;
	bh=Kq25RLAno8aXZmniDwbQJZfY/cwwpscIS991weREbgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoAIXvtLX/JTwJ/FK5tZUnLGc4T65V5fbU1SErvgYTVCk0eXQVypy5UeFZC4AgtehYfmeUqVH15laI0jjDbjQKjoJ/ergFsmO+sDJzhC6lI13sRHBzEWoYjL7l+bFD/cpZJiVbtjkAGf8gWE8zrnriQVPalQQoK4J7ymqc30x/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJbb1KU5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJbb1KU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E5CC4CEC8;
	Mon,  9 Sep 2024 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725877236;
	bh=Kq25RLAno8aXZmniDwbQJZfY/cwwpscIS991weREbgo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XJbb1KU5868WjsjULo326asarA9meQg8yw11LeDoT+p44FiV7A1oHFEDfn5N2d0Ll
	 md/cIMHb3Rp/nM7iiYU0YO5pJ53Bc16Sx3gjHwyVR6TVwcbD69LM4XwIc+/wGVjyo/
	 dZ7IF3FUIxvoblezEzMPCt6twPd5e0x1f/KUu2PoMlR0rHFqQfO+YS9DT7H25gnZPc
	 wWr4DFJfsRyPUrtIGDlNP5gelLk6nwco+GwSeRtgsmb/4mbWvhjsCYF9dOSyWOkZ3v
	 eCRw4gUUZyq+u6lTanVVO6QhPpiFFX6c12qPfI1w4JJXrK30ezuDDVkGJGEIS5Vw3z
	 WOP+Yr1mWy/qQ==
Message-ID: <c969880d-02b8-4b53-b364-04adcd31cb4b@kernel.org>
Date: Mon, 9 Sep 2024 19:20:33 +0900
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Fix validation of ioprio level
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: axboe@kernel.dk, niklas.cassel@wdc.com, hare@suse.de,
 martin.petersen@oracle.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexey.makhalov@broadcom.com,
 vasavi.sirnapalli@broadcom.com, vamsi-krishna.brahmajosyula@broadcom.com
References: <1724833695-22194-1-git-send-email-ajay.kaher@broadcom.com>
 <a5609ba3-cc35-41c5-98f1-52063f8a6eec@kernel.org>
 <CAD2QZ9Z_rpDAyeJGBDxx8vqq7nSAuiktTTCxYHUu1QtA42afew@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CAD2QZ9Z_rpDAyeJGBDxx8vqq7nSAuiktTTCxYHUu1QtA42afew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/24 17:59, Ajay Kaher wrote:
> On Wed, Aug 28, 2024 at 2:15 PM Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 8/28/24 17:28, Ajay Kaher wrote:
>>> The commit eca2040972b4 introduced a backward compatibility issue in
>>> the function ioprio_check_cap.
>>>
>>> Before the change, if ioprio contains a level greater than 0x7, it was
>>> treated as -EINVAL:
>>>
>>>     data = ioprio & 0x1FFF
>>>     if data >= 0x7, return -EINVAL
>>>
>>> Since the change, if ioprio contains a level greater than 0x7 say 0x8
>>> it is calculated as 0x0:
>>>
>>>     level = ioprio & 0x7
>>>
>>> To maintain backward compatibility the kernel should return -EINVAL in
>>> the above case as well.
>>>
>>> Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")
>>> Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
>>> ---
>>>  block/ioprio.c | 11 ++++++++++-
>>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/ioprio.c b/block/ioprio.c
>>> index 73301a2..f08e76b 100644
>>> --- a/block/ioprio.c
>>> +++ b/block/ioprio.c
>>> @@ -30,6 +30,15 @@
>>>  #include <linux/security.h>
>>>  #include <linux/pid_namespace.h>
>>>
>>> +static inline int ioprio_check_level(int ioprio, int max_level)
>>> +{
>>> +     int data = IOPRIO_PRIO_DATA(ioprio);
>>> +
>>> +     if (IOPRIO_BAD_VALUE(data, max_level))
>>> +             return -EINVAL;
>>
>> No, this cannot possibly work correctly because the prio level part of the prio
>> data is only 3 bits, so 0 to 7. The remaining 10 bits of the prio data are used
>> for priority hints (IOPRIO_HINT_XXX).
>>
>> Your change will thus return an error for cases where the prio data has a level
>> AND also a hint (e.g. for command duration limits). This change would break
>> command duration limits. So NACK.
>>
>> The userspace header file has the ioprio_value() that a user should use to
>> construct an ioprio. Bad values are checked in that function and errors will be
>> returned if an invalid level is passed.
>>
> 
> OK. Thanks for the detailed explanation.
> 
> I agree, to use unused bits, functionality (return value in this case)
> will be changed. If applications are built using Kernel headers of
> v6.1 (doesn't include eca2040972b4) and later only upgrading Kernel to
> v6.6, because of the changes in return values applications may have
> some sort of regression.

Which would mean that the application was not first fixed to handle the error
return, and so it would still being doing the wrong thing on 6.6 as well as on
6.1. So I do not see any regression here...

> To make the software backward compatible I believe, unused bits should
> always be ignored. So that if in future someone uses it, it should not
> change the behaviour (return values) of existing software.

There are no unused bits anymore since kernel 6.5: hints = 10 bits, level = 3
bits, and class = 3 bits, for a total of 16-bits for the entire ioprio.

So if an application attempt to set an invalid level that uses more than 3-bits,
the extra bits will be ignored in the kernel and such bad level value can be
caught only if the application uses the ioprio_value() helper defined in
include/uapi/linux/ioprio.h.

And note that before 6.5, checking the prio level was also far from perfect: if
the user tried to set the prio level to a value using more than 13-bits, the
extra bits would be ignored too and the bad value would NOT necessarily cause an
error (e.g. using 1 << 13 = 8192 as the level would result in the kernel seeing
level = 0 and not throw an error). The introduction of ioprio_value() allows
catching these issues, if the application use it.

-- 
Damien Le Moal
Western Digital Research

