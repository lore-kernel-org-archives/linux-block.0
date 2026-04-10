Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257E2315D50
	for <linux-block@vger.kernel.org>; Fri, 10 Apr 2026 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775783678; cv=none; b=QOPS6CL5O+m9XPKwXWeytcaLHVlu2xWxBlocswRptEBlSXaeZkGuzvdn/Hi6wspUD4VkmN1QGV2n3H2S5q6udssyyeUL8/csuJfkZuZyID3LffuPZCByeHsoKii0Um9y4NIfm2U59gJ98y7ptvzQmUZmjnVoYx0xxocLwiu+vCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775783678; c=relaxed/simple;
	bh=Fz0Ie/fLQ7NC8c8S6jwUgJBk98jnjIjnGedk34Ydxvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tB4vVgTtX2bEOmXeefozbvEhUgPHkvsRT+zIx/f3FrgOm477jNHrpDy5/S/6yTq1scNO8pJO2WC+bVJeVBafz2xpUGUHYEwOgZS7gSSOmzYPX4dLpytBnjqnQ6Rxgc3WlfNQsmOD0DMqDvu2qZsTisAdW/FHvmTALgYzpJRfLiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=AN3Q7BI5; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="AN3Q7BI5"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ba895adfeaso1483761eec.0
        for <linux-block@vger.kernel.org>; Thu, 09 Apr 2026 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775783676; x=1776388476; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hX2F5vH0vhGHSEsyxW1VmGmKOMoX7KwT4uNWvZ8qcRo=;
        b=AN3Q7BI5ZZue7xDTW2juya11ekPPGbtNSHhgW5J8sNXNkp+gNNokCCnS85Wh/+ap47
         g0nsXFNmw5cEIRI4nSJkW1JL9qDGQKmcdb3IxzX3CC+wajcTqAEhcW09hlhFdJD5Z5PP
         QTJukJzy9atpnIZInx0TQiA8azP7SchuzXcecVyD/PWxOSc4k1alLAqg2hfDllJxeLzp
         FGzP2Ii2+TJ3YqSvrJ+tcEEH5w+Ie25O6B9f/d0vSo3qQ0Xs4TCo5u6uv13y///1sk+s
         nCIFQO6XEAr0S7seVz7jJLA7pQvGS8DkS0KGxlYMJpIQe8LGFRG9StZQuOzqVC6nyBh6
         hhUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775783676; x=1776388476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hX2F5vH0vhGHSEsyxW1VmGmKOMoX7KwT4uNWvZ8qcRo=;
        b=bp/tpmw2UUYPDmVaC3u8Laube0D4BcPzy8ap3yY/1ZwEaBx6jwn60nNwkZIhGo73O6
         XY5YDe8jUVgJNQ4ew6q14JkKf6138l33wFBGEGLroS0B43END35sOc6bFeBl+s++gNu6
         QyTIrW3mwcWXvaE5LUopfmachmkoptTwJE6kLqAwe7Fzk3lceUn5OgSg/GwD+2P5ug69
         diyrWJ9U3WrviwizCpNUf6dDHtElOqfudI/bQ0ESVZKZa0KU+lfTSVkv5sOX/JkN0luc
         CeI9lJfoxblOwjnzIWsGpwLLp8Vp5ov6ScxwF1h6UdWlv1b5QMQsjLinqu+6/AhJeZ/N
         eAvw==
X-Forwarded-Encrypted: i=1; AJvYcCX+qWr4OPRcTHImDBNfZ1JsxtuNf0pw7Q+MdkouX+PeCT+S9baZRnXUNBWm5SDZHM29GL6kjNOX9Osc3g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwuRhZoRH7cWlAQR1XNa55xLTAo3p//7L+a6IdEOw5nVinzaaV6
	PojP8bSZquEKteEOB14+J08YcRLqCQopNtOtbdh108S5h3eKrW8H5rsfFblhVJ8rAio=
X-Gm-Gg: AeBDievjVjZtugwATEvHOk/NrEnyPW/agpKHfpIFnz17jw4bh+AHBRPSehwSB6snUeo
	inSm0StUq5jUuSduVj0rXnrCs8aIkQPd+RJODnGE7uSthGaNpnx4zOemMUYvaEMzT/T+rwv/jJ5
	PIVnY+j7BnbcH0snz8kmC7/v5Uiur1fD5etpENVMnzda7YhpZqCf3bO7jIgjTjj/8d5HTCFJfwL
	TrCMSZgkccwMaqMenoZ7hEyMJkXcNp+Zx/AQbxoShyeI4eYsfSc59wFUH2SwzLGtXWPMUWT7NzX
	XflzqyPmkK56RmoJttzRkXYBWI4aaZxmNy8ZEibfOVVK000La2iUuhMVjuWp5S9mf6iLDAf6TMv
	3pXfJgdpgkPbNKYb/lbw7Flkr1wUvSgKgT2mvIm3FjcCyRhJH9DTvviw3V95U1VC2oU9Pfk760P
	VToSjkCA6O0GhhqgSx1HgFSpBvp5+4+DySd87BfZOCqGT/luwEqiekFe//Yp8e+cP84uxKpQcey
	mBmKh0YABW1YSXeyxWgG+rM1VCaYKSXCOJxYlMqC/2WPHvvIurLt8k=
X-Received: by 2002:a05:7300:bc10:b0:2c8:1d56:340c with SMTP id 5a478bee46e88-2d58946284amr593276eec.23.1775783676253;
        Thu, 09 Apr 2026 18:14:36 -0700 (PDT)
Received: from ?IPV6:2600:380:873e:380f:e9e5:ea98:a905:9cbb? ([2600:380:873e:380f:e9e5:ea98:a905:9cbb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561bde68bsm2097787eec.17.2026.04.09.18.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 18:14:35 -0700 (PDT)
Message-ID: <0cf7c152-a341-40e3-8359-23a633c812c6@kernel.dk>
Date: Thu, 9 Apr 2026 19:14:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/20] DRBD 9 rework
To: Christoph Hellwig <hch@infradead.org>
Cc: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
 drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, linux-block@vger.kernel.org
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
 <ecf00b4b-c3f8-4161-a97d-3d23b423cabf@kernel.dk>
 <adXk_m3SbRcWTOIC@infradead.org>
 <c92d5318-8c8e-434f-835e-61cf1fae4edf@kernel.dk>
 <addJ6uTc8Zo4GKpW@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <addJ6uTc8Zo4GKpW@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/26 12:40 AM, Christoph Hellwig wrote:
> First an apology, I thought it was in your tree, but it looks like
> the drbd branch just has minor fixes.  So a lot less urgency.

No worries, figured you hadn't seen the previous discussion.

> On Wed, Apr 08, 2026 at 06:58:58AM -0600, Jens Axboe wrote:
>> See the previous discussion,
> 
> Do you have a pointer to that discussion?  I can't remember one.

I'm on pretty poor connectivity right now, but find some of my complaining
on linux-block in response to a previous Christian email.

>> the goal is to sync the two drbd code
>> bases. It's followed the "usual" pattern of the in-kernel driver being
>> neglected and development and users pushed to the out-of-tree one,
>> which is highly annoying.
> 
> I don't think that's a a usual pattern.  Also the new version looks
> like a complete rewrite and not something incremental:
> 
>  45 files changed, 45891 insertions(+), 16264 deletions(-)
> 
> For a code base that is "29482 total".
> 
> I think reviewing it would be easier by just adding an new drbd9 driver
> and then steering people toward it carefully, as that is actually
> reviewable compared to non-bisectable patches changing large chunks
> of code in a non-atomic way.

That is another approach we could take, but I don't think that would
make it any easier to review, to be honest. Nobody reviews a full
driver, their eyes just kind of gloss over.

Heads up - OOO for 1 week, will prep merge window stuff to the best
of my abilities, but won't be super responsive outside of that. As
this particular driver isn't going anywhere right now, there's no
urgency on that side of things.

-- 
Jens Axboe

