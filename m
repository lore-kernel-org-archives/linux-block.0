Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="g+Uoum7f"
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD3DD5C
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:47:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf88973da5so2509115ad.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 12:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700772459; x=1701377259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKHP9VRaHD/ldQ8PEGAzNfCbwDdbFraIBafTktG81qg=;
        b=g+Uoum7fcDuEY29VhHvq944TyyrrR+Pxzcwr4KBXSPovlHVYpFF/kD2xRAzrBHZiUe
         80tKhrkJ+ZEhKjvlIagf+TWpX+Odr9k79F5i323xzAz1tGjoNt29jTPAUpfHfr033Zb9
         6Zt5H5jdZGSG+xEP4msjc5QqcP519zP9vjQ0+qjnPWWTi4gfv5bt+99PErALsQNFZoje
         pzH6gjODnFMfSkd67a2h3wNOu8EfkUyQIXDlwN/pjSJmjkihfu/yVAfHpZuMo/QT24QW
         OFOU0sPwQczimI+Kee0VLoBT2zZa8IREIt8ISLw3bFu57TiuRZBa9FFOcpzr19g+UQow
         gZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700772459; x=1701377259;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKHP9VRaHD/ldQ8PEGAzNfCbwDdbFraIBafTktG81qg=;
        b=wfh9nqWcFcSAGlsslksYUA2osb5xd5iDcdRWGjzpQqJJo+tfnIDgphs3rG312XCWMB
         tsi3RH+J4Q+jo205i4hPWaDRTfVFvsn2h5OxtE2SqA5KQepVQoopbZsqNOUoiGrOZZOL
         TUOPKIbwJdW4X/wgfQbayxvwtnWlMUwbqNKqIJUkcdcGtF2ggCFvmX/HqkgZTBolGV+p
         KomLXkZw7Yb8aPi8u1iZhPkQ4XNZKWjdTQyWM/9VnQS2Dssnql+3BHHsGDJ/XLDFerYQ
         beEYOxfbEi78tJgr/l4N36redqkQfj7WKVfGHPl7/8z1Rr5bQIUX/oWOH+5iGkfKKomO
         ujmQ==
X-Gm-Message-State: AOJu0Yw6BPRmNI1/wJ+VVy4YsJhautiuHXNm+T/fPBtVX7M7vhjFQcl+
	GgI14/JURS6uxJzb7yBGEOzy1gykeVUu9q7789novQ==
X-Google-Smtp-Source: AGHT+IEz5/a9jQTiZgqCAAcFRy+OHHToB/aEzj84gL7Xnzfe7Ht9Zyb1u7qJEc9wVwNAZn814hOFZw==
X-Received: by 2002:a05:6a20:5499:b0:14e:2c56:7b02 with SMTP id i25-20020a056a20549900b0014e2c567b02mr983167pzk.0.1700772458906;
        Thu, 23 Nov 2023 12:47:38 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id fd39-20020a056a002ea700b006cb7b0c2503sm1659751pfb.95.2023.11.23.12.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 12:47:38 -0800 (PST)
Message-ID: <a27b66a6-7d3b-42f4-b25f-1dffc0d33a83@kernel.dk>
Date: Thu, 23 Nov 2023 13:47:36 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-next 0/2] Misc patches for RNBD
Content-Language: en-US
To: Haris Iqbal <haris.iqbal@ionos.com>, linux-block@vger.kernel.org
Cc: hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
 jinpu.wang@ionos.com
References: <20231115163749.715614-1-haris.iqbal@ionos.com>
 <CAJpMwyh-24qFt4U1L2Ki270oWis-GUBLRQVC+Lf4cG7EumkpPw@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAJpMwyh-24qFt4U1L2Ki270oWis-GUBLRQVC+Lf4cG7EumkpPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/22/23 7:52 AM, Haris Iqbal wrote:
> On Wed, Nov 15, 2023 at 5:37?PM Md Haris Iqbal <haris.iqbal@ionos.com> wrote:
>>
>> Hi Jens,
>>
>> Please consider to include following changes to the next merge window.
>>
>> Santosh Pradhan (1):
>>   block/rnbd: add support for REQ_OP_WRITE_ZEROES
>>
>> Supriti Singh (1):
>>   block/rnbd: use %pe to print errors
>>
>>  drivers/block/rnbd/rnbd-clt.c   | 13 ++++++++-----
>>  drivers/block/rnbd/rnbd-proto.h | 14 ++++++++++----
>>  drivers/block/rnbd/rnbd-srv.c   | 25 +++++++++++++------------
>>  3 files changed, 31 insertions(+), 21 deletions(-)
>>
>> --
>> 2.25.1
> 
> Gentle ping.

I'll queue them up now, but won't get pushed out post -rc3 to avoid too
many conflicts on the block side.

-- 
Jens Axboe

