Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538BC43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E802077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLIREh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 12:04:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52794 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfLIREh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Dec 2019 12:04:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so76868wmc.2;
        Mon, 09 Dec 2019 09:04:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:references:cc:from:autocrypt:reply-to:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gH9b/JKQN180XqrOwZv5Ek0ujBJf+ota8Io7VWO3t8A=;
        b=TKS0XMEP6XtszZCthM7zYEAOiHd1NMxLIygzRZr+n/0HNnlbXxXnU2knumBxhllgAG
         JmeaTyZIebdcbj1GFnwK5YxgIl7QvcLmPYRiF3Fcg0X4Kt4/C0lTYn08YA8I+Rd+kjkX
         yMPacLNuNBfNzko58K6HTRAyJ10juizpOkdv6hSBkZMwCRQ0Iej3IYMCqo+qNPRY/Rod
         wNCT1o1GAQM0KJ2sWa/W9ZN5N0jSOErVwqgwHi1kVLCxrfOT6ewTMhNN/lTP7GmQWtR4
         9ZYknFF0TTLnDnQoem/+sjpterz349/R8CT83Na+StjcP40qYmCMdE9JyyUzsCeBkixG
         d2vw==
X-Gm-Message-State: APjAAAU1K+7HZH7/pLwsZrsVWBEUGNi194KVi0rk60z3ZQytrYfPmU/V
        yLvWeK/WbHs5xNRcDGNEW5s=
X-Google-Smtp-Source: APXvYqyFYU773WMNNJyQ09xiDsraIbzd4UTdegtqUSUbm6mlpN5SiIh/h54Jvu5difSpG5tbZ7ABTQ==
X-Received: by 2002:a05:600c:54b:: with SMTP id k11mr11719wmc.63.1575911074229;
        Mon, 09 Dec 2019 09:04:34 -0800 (PST)
Received: from [10.10.2.174] (bran.ispras.ru. [83.149.199.196])
        by smtp.gmail.com with ESMTPSA id r6sm49671wrq.92.2019.12.09.09.04.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 09:04:33 -0800 (PST)
To:     "Philip K." <philip@warpmail.net>
References: <20191208194534.32270-1-moritzm.mueller@posteo.de>
 <d3f0613c-6c3a-8efc-1c27-a6b75c34972f@gmail.com> <87h82ajzqd.fsf@bulbul>
Cc:     moritzm.mueller@posteo.de, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@i4.cs.fau.de
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=yefremov.denis@gmail.com; keydata=
 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
 ST/KYQ==
Reply-To: efremov@linux.com
Subject: Re: [PATCH] floppy: hide invalid floppy disk types
Message-ID: <04f0dfb9-d25a-d9a3-74cd-538165a8bfa2@linux.com>
Date:   Mon, 9 Dec 2019 20:04:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87h82ajzqd.fsf@bulbul>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/9/19 12:04 AM, Philip K. wrote:
> Denis Efremov <yefremov.denis@gmail.com> writes:
> 
>> Hi,
>>
>> On 08.12.2019 22:45, Moritz Müller wrote:
>>> In some cases floppy disks are being indexed, even though no actual
>>> device exists. In our case this was caused by the CMOS-RAM having a few
>>> peculiar bits. This caused a non-existent floppy disk of the type 13 to
>>> be registered as an possibly mountable device, even though it could not
>>> be mounted by any user.
>>>
>>> We believe this to be an instance of this bug, as we had similar logs
>>> and issues:
>>>
>>>  https://bugzilla.kernel.org/show_bug.cgi?id=13486
>>>  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/384579

Well, this is a ten years old bug. It seems like that time it was decided
to fix the problem either by blacklisting the driver or by disabling the
BIOS option. I doubt that many people are facing this problem since then.
I think that more-or-less modern motherboards don't have this issue.

>>>
>>> This patch adds the option FLOPPY_ALLOW_UNKNOWN_TYPES to prevent the
>>> additional check that fixed the issue on our reference system, and
>>> increases the startup time of affected systems by over a minute.
>>
>> Does driver blacklisting solves your problem? Or you have real floppy drives in
>> your system along with these "spurious" ones?
> 
> No there were not, and blacklisting would solve the bug too. We just
> thought that fixing the bug this way would prevent the issue from
> appearing in the first place on systems that have the floppy module
> enabled, in the first place.

Hmm, I would say that driver blacklisting is a more proper solution in
this case. I doubt there are people with this issue and real floppy drives
in their setup. Altering the default driver's initialization scheme seems
superfluous to me. This will force users (if there are ones) who depends on this
behavior to rebuild the kernel. blacklisting doesn't require kernel rebuild.

> 
>>> Co-developed-by: Philip K. <philip@warpmail.net>
>>> Signed-off-by: Philip K. <philip@warpmail.net>
>>> Signed-off-by: Moritz Müller <moritzm.mueller@posteo.de>
>>> ---
>>>  drivers/block/Kconfig  | 10 ++++++++++
>>>  drivers/block/floppy.c |  6 ++++++
>>>  2 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
>>> index 1bb8ec575352..9e6b32c50b67 100644
>>> --- a/drivers/block/Kconfig
>>> +++ b/drivers/block/Kconfig
>>> @@ -72,6 +72,16 @@ config AMIGA_Z2RAM
>>>  	  To compile this driver as a module, choose M here: the
>>>  	  module will be called z2ram.
>>>  
>>> +config FLOPPY_ALLOW_UNKNOWN_TYPES
>>> +	bool "Allow floppy disks of unknown type to be registered."
>>> +	default n
>>> +	help
>>> +	  Select this option if you want the Kernel to register floppy
>>> +	  disks of an unknown type.
>>> +
>>> +	  This should usually not be enabled, because of cases where the
>>> +	  system falsely recognizes a non-existent floppy disk as mountable.
>>> +
>>>  config CDROM
>>>  	tristate
>>>  	select BLK_SCSI_REQUEST
>>> diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
>>> index 485865fd0412..9439444d46d0 100644
>>> --- a/drivers/block/floppy.c
>>> +++ b/drivers/block/floppy.c
>>> @@ -3949,7 +3949,9 @@ static void __init config_types(void)
>>>  			} else
>>>  				allowed_drive_mask &= ~(1 << drive);
>>>  		} else {
>>> +#ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
>>>  			params = &default_drive_params[0].params;
>>> +#endif
>>
>> You can't just skip it with ifdef. This will result in uninitialized
>> pointer dereference down the code.
>>
>> 		struct floppy_drive_params *params;
>> 		...
>>
>> 		if (type < ARRAY_SIZE(default_drive_params)) {
>> 			...
>> 		} else {
>> #ifdef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
>> 			params = &default_drive_params[0].params;
>> #endif
>> 			...
>> 		}
>> 		...
>> 		*UDP = *params; // << HERE
> 
> Oops, you're right, will fix.
> 
>>>  			snprintf(temparea, sizeof(temparea),
>>>  				 "unknown type %d (usb?)", type);
>>>  			name = temparea;
>>> @@ -4518,6 +4520,10 @@ static bool floppy_available(int drive)
>>>  		return false;
>>>  	if (fdc_state[FDC(drive)].version == FDC_NONE)
>>>  		return false;
>>> +#ifndef CONFIG_FLOPPY_ALLOW_UNKNOWN_TYPES
>>> +	if (type >= ARRAY_SIZE(default_drive_params))
>>> +		return false;
>>> +#endif
>>>  	return true;
>>>  }
>>>  
>>>
>>
>> Thanks,
>> Denis
> 

