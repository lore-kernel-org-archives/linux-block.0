Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079503043DE
	for <linux-block@vger.kernel.org>; Tue,  1 Sep 2026 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788228164; cv=none; b=irQIsmzbJSk5dFCW9Kc6lxt3Owz7xNwKCQqhR6TFTSbhcsmCi5g7/yNPu0ej2Ilu6NBl7r6Nkt+y3f1to9sdP/seZd4XD7Tq3cs3BbXXmIB52Oi80DcGdRYMZncQ1HYIYgjQXtrq2OhuNtIsx9xp2p4N1dgbLj++uMNMWt5/a5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788228164; c=relaxed/simple;
	bh=DKAZQ4HB8RVRyPINtHAlvihaYgNW2N0m1l6ppV9ct0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG1Wuf5XusbAQV7DVKPqrxL/oMoYzF6YX4me2fLp3TVgz0Hvli1U5x+SxPbbYT7aPtSB+Jmn6V4EJYIiMHq7oV9X/rRNMOwTer3yDHiJuv7R8yFHzHnYcEWFKbUtJadukQricipqVpzHWZ65156h7Z+F6ieLz6mk+CM0SfTWb7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m3ypPjrY; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3ypPjrY"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbe827e3cb4so4550836a12.3
        for <linux-block@vger.kernel.org>; Mon, 31 Aug 2026 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788228148; x=1788832948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xndijz6hV8q9in3RSA1ablFs8VlKyT94mnXwH4oGlXE=;
        b=m3ypPjrYii6n/6JqvApbVSBQwf8fPWfJqr5KrTxkCaHfpDrNumXOJkTKe87EZmT5u9
         IFVhRFkYDnKN58EWJ8zfCc+GHPPiNXfFWEinFk3sIYoCK/C1eoKS0FNX8qGIw0Z5bDd5
         ivUOg7CqLSC03SLe53kynnVI8AilnfyBraZBwMkxVCFFUpHLFHyefp9qfRqAG6A/jb2g
         k5Sv0eg5pZsZivr+0WDiBHbZnC304OTSOwa5WHh38xNyRSAFrrPWSzqysoqJ8EEedmRM
         6gEJigwdlumWYiEmU2qGy244xRLLir7TrHpd+BjZ7coUA+BbvZeB4N+GGRDQcbhq6wOK
         1mZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788228148; x=1788832948;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xndijz6hV8q9in3RSA1ablFs8VlKyT94mnXwH4oGlXE=;
        b=ZXK01TrkBB2aabTb9I/wXH+Nau+8+WYPCz4V1Asu535YT+XVLUxdY0fFOwD2vTZitq
         ZPD9GdJ8/f2kPHGBeYMAeGhV5Sy/6DDzkOUHOntV6lkL9yi9q2BhJw8K/nZlSyxg6WFF
         OwyR+nXsyg7iFEABgezSfMC3Q67YLDuulXyFjMYB1M5Xjpk0jfd5y27efr+ULqD4/Uq5
         JQPlyxwuNSPEybVpz0HIv840lxWL4YOFWk3t5Eqq9o0jwNOkwwrzHEhl/2dl+M3DRTAt
         ap17Mcykvrj3v6JC/zybjiOkvtZUdAS9EgpUMoRMPGwknuBAMiJCow4R94AP8fuv5Gx6
         Zk5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoJXidKiz8AyiRFossyC36uAt4kkaB9i9jzl7rWI3LpOr8xZc4BPVYD+Q/Wjt4I70XMT92ADZUAH/biYw==@vger.kernel.org
X-Gm-Message-State: AFuF++mlT+gn0xIXPvdjWtnCnD3LSTrIW4cQZwj2DikVdYWBNS5xMIK2
	xhZO4Ont8TJ7G+M/YIJdSw4TbiRG9IffJ6yoDHFyT6lRN1yAm/v8RFFj
X-Gm-Gg: AR+sD12D19TTeWFlRYEgysaIwfziDG42LU17mV0nJNJfu7PRHsoplCZYMv9h+/D9UtB
	EPgA1p9DBK6h/hpGOgd1zbeWTSXFFhH3xP0q66Cj8xGljyK0KU+mzErIV+W8mpdor7EyETLSG2t
	skkzYKdtOw4mHN4aCeOYLpD0tFpaQyIL2LyxyWm12YQd64eivm7dMik6NYST+0nxlTiQImHdriu
	mhe7bY21xpJ0JFPypANl6yS8uQw/xz1eVK3/Ojz8CANFLuNmmeag4jkeEJEOVFccAQqaQ23opqD
	fNlkcXDFrP7TFCyLkSLNU4MDCaBgnaIcrIb3tWufmNimc1mY1hiF0IuExMTkqqsGYg2a/2qj6+G
	X6XtLJ3kO1q8+hdPpthZbxTBA23eHhBdIMXxaK02nIq9hlMdBPQV+vmp5QPTwBbK/LM0D5PPumP
	RjfDtu5n25GShcNgZK2KwtTwqppWPDeb0uSKq16LcghhrQ0tZXI4KFz+f6bO0OjT+hqMtCHplrY
	aqPfUdq
X-Received: by 2002:a05:6a20:d502:b0:3d3:aec2:4dc8 with SMTP id adf61e73a8af0-3d7b0548a7cmr8045683637.20.1788228148286;
        Mon, 31 Aug 2026 19:02:28 -0700 (PDT)
Received: from [10.240.116.157] ([122.11.210.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f36e8ee6sm5115496a12.26.2026.08.31.19.02.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 19:02:27 -0700 (PDT)
Message-ID: <7b007eef-2f6d-c86a-065b-85eb85b5ee0f@gmail.com>
Date: Tue, 1 Sep 2026 10:02:20 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, minchan@kernel.org,
 axboe@kernel.dk, bgeffon@google.com, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
 <20260828102446.3eb7f3dc779753b831e33fe6@linux-foundation.org>
 <apT-ocFYDmU6iC-j@google.com>
 <c961850c-09d0-3366-73e0-1932c1dc00e5@gmail.com>
 <apVK4g2ikVJe_Hcg@google.com>
From: Hao Jia <jiahao.kernel@gmail.com>
In-Reply-To: <apVK4g2ikVJe_Hcg@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/8/31 17:38, Sergey Senozhatsky wrote:
> On (26/08/31 16:37), Hao Jia wrote:
>> On 2026/8/31 12:15, Sergey Senozhatsky wrote:
>>> On (26/08/28 10:24), Andrew Morton wrote:
>>>> On Fri, 28 Aug 2026 16:31:49 +0800 Hao Jia <jiahao.kernel@gmail.com> wrote:
>>> [..]
>>>>
>>>> Thanks.  Sashiko asked a couple of questions about this change:
>>>> 	https://sashiko.dev/#/patchset/20260828083149.45760-1-jiahao.kernel@gmail.com
>>>
>>>
>>>> Does this early return prevent marking valid boot-time pages as idle?
>>>> When a page is accessed during the first second of system boot, its ac_time
>>>> would be 0.
>>>
>>> There is no possibility for zram to hold pages during first second of
>>> system boot, regardless of whether zram was configured as a swap device
>>> or as a block device (mount-ed with real filesystem).
>>>
>>>
>>>> Can the early return above bypass this zram device initialization check?
>>>
>>> We already do that, e.g. when kstrtouint(buf, 0, &age_sec) fails.  Apart
>>> from that, that's not how one checks if device was initialized.  We may
>>> want to consolidate those checks, just for symmetry.
>>
>> Agreed on both points -- the early return is not a new "bypass", and
>> the write() return value was never a way to probe init state.
>>
>> How about moving the init_done() check to the top, so all the early
>> returns sit behind the same device-state check?
> 
> Yeah, I don't know...  Moving it under device lock doesn't buy us
> anything.  We don't need device lock to validate integer rangers,
> etc.  There are validations that we need to do under device lock
> because those require a consistent device state.  But things like
> "is system uptime less than supplied sysfs data" don't logically
> require a device lock.

Thanks for the clarification. The current patch is enough, so no change 
is needed.

Thanks,
Hao
