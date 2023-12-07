Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AClklTSB"
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA8F1713
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 13:01:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7b70c2422a8so1925639f.0
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 13:01:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701982881; x=1702587681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q6Fp/wqhBijCeQ5cLv/4BaF91Kq6qXDM32lTdt2+N0U=;
        b=AClklTSBNAwPWCrTElkUUB75A2eg6Or8ULf+iC+onQYXNxI25c2ZnYUfck14mhzwei
         XtWq2bpTDYAI3QZ1Aqn+kJScPphexiOagwVq6cY4C3lY5NHKQRqh43vYixH1JDANBLjO
         yessNuw3eYlVKMYZkGN2oL6EM8eqq+g1Zl4xFJikVRaWSQ62ZeWTwy/Ff+TnHKp7mCYT
         zXCb47S16PWyalAdrziXNxJsywBDaSCkf86C/7JzPyIQTiRMuUYIwx/dAS+D2FyFtMWq
         J8RgAYfRMfWBY5slhVZHQyKEIDNMYfGe1nmgownopwJofXoWxVC7kKOB18LXGkY3h8of
         Ii2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701982881; x=1702587681;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q6Fp/wqhBijCeQ5cLv/4BaF91Kq6qXDM32lTdt2+N0U=;
        b=CL6TkIWK5DfggKHYFsMCQyxDfMXAgPXwIsY33psGSTXvS7arH2mImB4Wd9vQUcBoSi
         1nxsljRF9S91FZfhxX5jn04pEcykGl4UZf3RNlMH6kZ6q6ffGouLJnvsZUqowJOFRykP
         28ejCnVN+v5B3IHUobCo2W2r2ndKdDC2ux9sloUIk2JynWL+oVD3HT2XuoPdaZyZob+P
         /0QoUY1y1bgGKWdf7lvbfgKxlZewa43uM2C2GRaKcWaYBb5l2sNQLPEmSn9if2ZMpa6q
         TEwTasL60RqslSjHf4V0ypucA+5OMJ2R+PLshWYa7auWDbWz8uB4TOgPTBCWFZkWOxw4
         nzlA==
X-Gm-Message-State: AOJu0YzNV1YFjOOxkm/yr+KPftzTSimBOuIg+HG0Xo8baV8cM57CV71E
	UGpm2hq7lcyEP2u5q6t/YKXp2Q==
X-Google-Smtp-Source: AGHT+IHeZzJNslv7A5O/7zscVCU58ii6FYbYuGG5CROd6F76LkGHLA5IDXMcXczQYafYC4p2CiAu0g==
X-Received: by 2002:a05:6602:645:b0:7b6:e8b7:621b with SMTP id d5-20020a056602064500b007b6e8b7621bmr5112769iox.2.1701982881180;
        Thu, 07 Dec 2023 13:01:21 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w14-20020a02cf8e000000b00468e80fa254sm116390jar.148.2023.12.07.13.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 13:01:20 -0800 (PST)
Message-ID: <4aef0190-8749-4e04-b061-03b8407b8954@kernel.dk>
Date: Thu, 7 Dec 2023 14:01:19 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
 <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
 <ZXIx/FVRYb8E5r37@casper.infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZXIx/FVRYb8E5r37@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 1:58 PM, Matthew Wilcox wrote:
> On Wed, Dec 06, 2023 at 03:40:38PM -0700, Jens Axboe wrote:
>> On 12/6/23 2:34 PM, Kent Overstreet wrote:
>>> On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
>>>> This patch reworks bio_for_each_segment_all() to be more inline with how
>>>> the other bio iterators work:
>>>>
>>>>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>>>>    one in the iterator and pass a pointer to it - bad. This way makes it
>>>>    clearer what's a constructed value vs. a reference to something
>>>>    pre-existing, and it also will help with cleaning up and
>>>>    consolidating code with bio_for_each_folio_all().
>>>>
>>>>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>>>>    this makes their code clearer.
>>>
>>> Jens, can we _please_ get this series merged so bcachefs isn't reaching
>>> into bio/bvec internals?
>>
>> Haven't gotten around to review it fully yet, and nobody else has either
>> fwiw. Would be nice with some reviews.
> 
> Could you apply this conflicting patch first, so it's easier to
> backport>
> 
> https://lore.kernel.org/linux-block/20230814144100.596749-1-willy@infradead.org/

Yep I guess we should... Doesn't apply directly though anymore. I'll
check later today why, or just send a refreshed version and we can get
that stashed away.

-- 
Jens Axboe

