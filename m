Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033D280333
	for <linux-block@vger.kernel.org>; Tue,  6 May 2025 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746539857; cv=none; b=f6we/1ElT46DgWmwoPbXZpuOXds4vdQ/qfWHsXzBo1Br2dhRg7TNFRhbKYQg8Zoy6OC2ealLoB6QsZoZaX3qUtuPsx4AbVpPLqn8yd6IALE82aat0fxJG6I7IvirlJLrU/aWPkwC9JneA/P8HpjoVtQF87VjWP+ipM0NLiTLX2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746539857; c=relaxed/simple;
	bh=Fil+R73Wiw+omvXV+6cMFVTenJVdVu+mcI/PvhHwv+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBogboO6QNsmf68/tzxD9m+pjdzyIgWjdxuOIU1brcyBer4Kavaq9IJyaUFLUJhfBulzf3TuaER0VLNmwAI8sG7mr3d0/8axzciqPZshygt39GuQTgQF1Rh6JbRJQgG21TwfUGvu5ZUa1Ls68OEnwp+xVnmO0vNlXjt3EFptBsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=nz1LJDKj; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="nz1LJDKj"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86192b6946eso145235639f.1
        for <linux-block@vger.kernel.org>; Tue, 06 May 2025 06:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746539855; x=1747144655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkFYa+2DMptP6p1W4aYKMut0q4IFVNtRlb0KQyBXTgk=;
        b=nz1LJDKjDr+353YnbWzz/96+eBVa/TOP9S+cwkYviaTpcdpqsdmCdXvXq8BxJh1CRn
         bjvqBWcRuUrhpS14u4xKEdoc32AjnCzDhpD+5pgf+dTbOwVHrKvXamujlAQp3ibIsJZd
         1QYHSPOvjUFAbXDFXxvNUrbGo14cf1ffZZ6BsJ7YAMacnx52xuvXEfdCZ+/JVL6TrKHA
         B5HVwZKZkpjdKmc9qKIxsjhwqjvGmrIobx70v6EzGWKRHEKSNh0MZGEixCg8SA1FBWm+
         pB4JfpDqf6lbi3Xbi2s+8wEgR9iIy0QJEz6J64IrC42C4SAopbrFaK6MRJoW6NM+Srdj
         ZPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746539855; x=1747144655;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkFYa+2DMptP6p1W4aYKMut0q4IFVNtRlb0KQyBXTgk=;
        b=igutEtBfwZ1pOZcon3KLFPQjDuSAhEr7jwaCU3XgJLK6yq5VR3I33dpix6fuMjDjdK
         8506EKmaHzYomvZusetvkajyXz1UrRgL2GVb3fxW/EZ0fnKumQGa5LzttuQfWpKWznef
         vbeL/z4q/b11p8G/phLAfFLi5wnDy6rpwH4uP8IJJf4aZL2LK35uKtV31YuWbtD6TWF9
         4lo6sz+umxKuzinrnJjJlapsI5o3UPzBi7l070Fth4Xe4QDFiq8EodkMk/FCOjvALlui
         gHPr/p6znC7+YczLKcQusZoGBn/oTHI2QtNc87niVa66ahjghaGxt3RShDhqm9Nc3lUe
         M6OA==
X-Gm-Message-State: AOJu0Yy8imAtnvffVE7FK/zNPw2xL0cBWRaBZXSAXxOJb3aSCXyWZxLr
	iNWSSqqHdP9tdw6w2i2TV+jEcPy7orfILyKlDCuqnTnfnrsot9Yda8Nw9feUJz0=
X-Gm-Gg: ASbGnctDNVL66V3h/icDrUpe2Q3xBAkTVgb8oBfgophXldcjb0iargHX7bOVhrFLZKb
	wwoKJYOLL9b28c8TIPovfJLBKOO6lUliEtUnntFEgYqIYChx63Icsq9jxjr8kiX3N75hOZLYfKz
	UfUkPWwkkNLLyNbFwKaE8bN71T70X82+Awd2PSsgWutC2NMYUMbOpS8HwxvcGcvTQ4s3lGB5LfX
	UpHtRcMTJsVaS9OqqvLUkZIPSly6Mowzbqi9QIn986ajbqi9XLSmi8rrC38uNSKQI1x6fEuglJg
	VvAtaaJnbY3oe/RPDcGUYx2UjEdd7qE9fwnU
X-Google-Smtp-Source: AGHT+IGMBuFZ9FLvWxdgw/ft9xCWwgvH5xzzSRjMkT/D9c7xst61wWHioiZbS6u2pO7yVpKIy2rcig==
X-Received: by 2002:a05:6602:2c0d:b0:85b:b82f:965b with SMTP id ca18e2360f4ac-86713ba73f3mr1289855739f.12.1746539855279;
        Tue, 06 May 2025 06:57:35 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-864aa3297c8sm223689239f.25.2025.05.06.06.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 06:57:34 -0700 (PDT)
Message-ID: <86337907-45ec-4e75-8b5c-7b7f13099db2@kernel.dk>
Date: Tue, 6 May 2025 07:57:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Port to 6.14-stable - ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
To: Ming Lei <ming.lei@redhat.com>, Jared Holzman <jholzman@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <9a10100c-9d76-4522-9f6c-d0a6ad32ca81@nvidia.com>
 <aBlwTtmeZErD4gnH@fedora> <df889108-6b11-4cb7-b77e-8d27922cbbc7@nvidia.com>
 <aBoRMF7Wy4Ff2JV-@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aBoRMF7Wy4Ff2JV-@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 7:40 AM, Ming Lei wrote:
> On Tue, May 06, 2025 at 04:16:25PM +0300, Jared Holzman wrote:
>> On 06/05/2025 5:13, Ming Lei wrote:
>>> On Mon, May 05, 2025 at 07:06:37PM +0300, Jared Holzman wrote:
>>>> Hi Ming,
>>>>
>>>> I'm attempting to back port the fix for this issue to the 6.14-stable branch.
>>>>
>>>> Greg Kroah-Hartman has already applied d6aa0c178bf8 - "ublk: call ublk_dispatch_req() for handling UBLK_U_IO_NEED_GET_DATA",
>>>> but was unable to apply f40139fde527 cleanly.
>>>>
>>>> I created the patch below. It applies and compiles, but when I rerun the scenario I get several hung tasks waiting on the ub->mutex
>>>> which is being held by the following task:
>>>
>>> Hi Jared,
>>>
>>> You need to pull in the following patchset too:
>>>
>>> https://lore.kernel.org/linux-block/20250416035444.99569-1-ming.lei@redhat.com/
>>>
>>> which avoids ub->mutex in error handling code path.
>>>
>>> I just picked them in the following tree:
>>>
>>> https://github.com/ming1/linux/commits/linux-6.14.y/
>>>
>>> Please test and see if they work for you.
>>>
>>>
>>> Thanks,
>>> Ming
>>>
>>
>> Hi Ming,
>>
>> Tested. It works great!
>>
>> Will you be sending a pull request to Greg or should I send him the patches?
> 
> Hi Jared,
> 
> Please make a PR and send to Greg since I didn't test & verify it on 6.14-y
> tree yet.
> 
> And please Cc me, I will give one double review.

Don't do a PR for stable, send a patch series instead.

-- 
Jens Axboe

