Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6771A3161
	for <linux-block@vger.kernel.org>; Sat, 26 Apr 2025 05:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745644993; cv=none; b=KEY1XXN56MG38Cw/L2GazsYvbyPEIgRi5pTUVHs4cD5wkyOmxx4QCUP6FI6SmiM9iX27396NDXSTE604Z3Wm2iue2td7Ecqq2ikuN8UPlhyHqXjkJdQyi0651XNejPgOyODnGA4iwYrrrowBwnldGcGJuFoJWbtVTdFFm+xhCxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745644993; c=relaxed/simple;
	bh=BIfhBLGcJnbdsDdXfw3ZF/aHVFjnxifj1ZDRpnZLl9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdE9hunj4Hr4OnGyhTq3L1r2XiFMLx95xNdYweR2K53zzBETPdW0B6NidMgRHDqfrGo6PRVrDrhXpCieR9X8BDHSnTm/yAkRy3fbTN0J1q+8Imvtc1L3bPZ8YtiJjxI0ZEKC/ylg5K/hlflato4SbQlMYoqntZ0WuiXkm4qBv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YlAw626W; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YlAw626W"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so5189886d6.3
        for <linux-block@vger.kernel.org>; Fri, 25 Apr 2025 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745644990; x=1746249790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVadqEPdp/e84xV25n6o7wokbtAabn+EHDeUNuX6gbY=;
        b=YlAw626WkuCDLLcvEsg2mQlp+z10U5cFqulSZ6rVlXE30xi8/lgR/g8EV8+KsFtzEl
         3jGWypY2Ge22EM8bxkTmr8Qx6EACJVJ4U9cp1rxQnYWaL5+iWpiyEOnepOt+5z9NI0PE
         UvyLGuZe2rcPkDKzEIq0aaJSvlg4VTbeIYh639iRxQPX09PufGJckACYHjjN6CnAhnUM
         kXY6uUpWeDSEuuwQHHjwxDKi4R8Jpg4yYg5LbwtnhUAvRLK798S1apMswj/Tx8EEJuWJ
         kEaIRNq7IsNsmVS5qGtONy9LPy/F/OR14JqUfE3xGAqXLm+A0DRCEOK7sV/EOwwOUb47
         92kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745644990; x=1746249790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVadqEPdp/e84xV25n6o7wokbtAabn+EHDeUNuX6gbY=;
        b=V81kp9lvaCWFvuYEbmAcJjYcVdYE95PBdLLnH3UoFn8ZMr7VKICTyl3EZKIx/DiIfj
         ni6Or2cH8maHonupxiAtdBK+nvkScs2StK7hJkcNyVhnf6o+URM/2W0fwIXfkU7w1sHv
         O0QEQDjNizw7CdBFWBGHvsFPvUGoqScG74jT8Nfliu6PD6rVIWrTO0m8+B80SYD71P6X
         RtWip3XQ3gTsTZrE9GirivOfmdyWzGiTgsYknhprnULQplSkNRO+PDrotlnGxjaWlEp5
         eAnV3dtC5MSL5Wl/W8Xrf69cW9wG6yYwGws6/NZhEVdSbhtFKNIKlPnV6CUZudRHX/3j
         E6GA==
X-Forwarded-Encrypted: i=1; AJvYcCWygulZ9VKJfLcZraIDKLWr6tZ8UoD0MKAN7AJ+80dDtSPFaS2p3NbtoV4hQt4IHelGNwmAnzmk/rGHJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvSRepqwkSceOU5sWmapq5ZfwfIlxjfljT9hla9TS1mczVfEdx
	wvBmgDj61bqB7PTfviXHjqo7iMb+HK48lZYbFGjwH+jWVxMcTw8ix7Eod0nS
X-Gm-Gg: ASbGncuzIqrUPe7W5lNHkpP6tzk8AuAsd3RbYTH4iSXZM41tVl4ST/cpqUnKVH5cFTp
	XyQHBjAlOhoEEgQ13N1jtYumtDUY/Gmz1sJBDz4EyCXNq2OTih/zm62+jFB3H6DBoIts/zKAvv9
	NIYVqtwhaSrU91VrceNek6Voc/Wj588dkmI10uLFHWxfgfJZ+Xk9zp17bHo6ZjpiyjeJhh7lZ9U
	kRyyVfnfGj1ZepbWDp8+blrAKScdp+pYvMQlQdVW+RHsJdjL77YE/XRFRuhbALR2ItAUj30N6FM
	Rdkzd//0KccyR2Pct360O+ir1l/DvPpJCe+omBo92giFHgCXo7AnmTqQNe1Frx9hwPvO2W4E2hH
	gcbBuLSM7aaP5z62w
X-Google-Smtp-Source: AGHT+IEtk64oRJy3raLokL4h3BwfhgYNozhtVCWL3OyhDcEwsyXUQwXwV4X8mpZCgbtHIIpBAkOlcw==
X-Received: by 2002:a05:620a:244a:b0:7c0:b43c:b36c with SMTP id af79cd13be357-7c9606f5841mr313763985a.6.1745644990332;
        Fri, 25 Apr 2025 22:23:10 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-176-137.washdc.fios.verizon.net. [108.48.176.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c94880sm309077785a.14.2025.04.25.22.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 22:23:09 -0700 (PDT)
Message-ID: <8d8fa127-3bf8-c6b2-71e6-90ce5abcc3df@gmail.com>
Date: Sat, 26 Apr 2025 01:23:08 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] zbd/005: Limit block size to zone length
Content-Language: en-US
To: "hch@infradead.org" <hch@infradead.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20250423164957.2293594-1-seanga2@gmail.com>
 <aAnxqAv41Quh66Q1@infradead.org>
 <jzrhzy3qdj7tt2tlmoayo7pi367etl3furcbk3yvuh4zru2q7q@ikekotau7jvl>
 <d683d1fe-7817-f692-addc-93d2fdab39db@gmail.com>
 <aApFcW-fsdUP4Ztj@infradead.org>
 <e94e55a6-a93d-2c7b-2c3b-8829ab53848b@gmail.com>
 <aApJWu1KLw7607Vz@infradead.org>
 <790260c8-09b4-96b3-310f-f9c5a93ef7ff@gmail.com>
 <aAuSYhnxwpJns5Cs@infradead.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <aAuSYhnxwpJns5Cs@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/25 09:47, hch@infradead.org wrote:
> On Fri, Apr 25, 2025 at 12:04:39AM -0400, Sean Anderson wrote:
>> and in userspace that assumes 512-byte granularity. But there is no
>> such deeply-ingrained assumption for zones. You just have to set the
>> parameter correctly.
> 
> There are everywhere in software actually using zones.  You still
> haven't answered whay your intended use case is, btw.

I'm working on testing... I thought I would send a few bug fixes upstream in advance...

who knew I would get such a hostile response

>> Plus, smaller zones are more efficient at reducing write amplification,
>> in the same way as smaller block sizes.
> 
> No, they aren't.  If you zones are only a few kb you will waste a lot
> of effort to actually track their state.

The state is perhaps 4-8 bytes at most? And in any case it's proportional to
the number of zones. If you have a smaller drive you will naturally have smaller zones.

--Sean
