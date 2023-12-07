Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Di0ZgM10"
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8710E7
	for <linux-block@vger.kernel.org>; Thu,  7 Dec 2023 10:26:47 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35d559a71d8so489105ab.1
        for <linux-block@vger.kernel.org>; Thu, 07 Dec 2023 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701973607; x=1702578407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5g7CNH34VqbzLQupXgIr89+ZD51KZdQHMd+YNpo8S6c=;
        b=Di0ZgM101Ev/TShVEjgLgQbmkbAKxuHTs/UYVN0kwRlwCWI1YcztLzmitqOhweRdAK
         kyimPZUAZx0bFDDweYAjCDmgJILimMhQin3muhrNEHoQ5qoGqEQVQoxiecTEfuf1nf28
         lmJlI2hXd6J71f2m18XdMiO8nLDj9pShp4LH3Yg1i5XcQecuuMeKW9vb43agN/dwOMsV
         BEDtEPTeVa+Ci8HSQ+WhkFwHknNAyVLW38sP1m+WJMivkBEGcCAV01heZ2DZb5DJonFg
         tCCmwjRHDZD+jaZopE4zjl8DFMwvP9naJMdhCxkDbpgyQwJAgz9BxS4K4S2NOcsy6LWI
         cwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701973607; x=1702578407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5g7CNH34VqbzLQupXgIr89+ZD51KZdQHMd+YNpo8S6c=;
        b=CSba+WdiLlB0tKMRlaXA+w5NC5+JPlY9RHJ+PUSrYrXv5Sy5Dj9cPC60QYnz0ffs2C
         mcpAWxT3WrDNK6j6iK4fzaPJGX7EdQVoceCWLWLqvTRjdM4SHr+YXZWZ4OirwuAjeE8J
         xe5ckHIXz2FXhgYd+PNjmzraFIedZ10EU8lQ0lGnZHR+jWVWPUqnxTfm8fYAaPPorqNq
         BmHcfQxFcBA/VyIrqWcjTYn0PU8VBOTe/f09u4kfCQzm0znhN9NA9CTeGXN/oInNz6c1
         K5fJKyGrAyY9KzB45tqpjQ6qhTgF1V1y4arKZB/uxjY1TTEhea7Eor6RnkJJ45h2+gut
         T6uA==
X-Gm-Message-State: AOJu0YwJkJXUyCuXrDiJ+v9IJBVWvJsWs2MqjeVePNqZhLrPNo+TM98Y
	029FObbQjMdtFlFHHz9HhZi7Dg==
X-Google-Smtp-Source: AGHT+IE9J06BGKgi95jcW8z5zYhyD8JWIZs4BwpI/tnqWASHQCoQYjmIsmdbMLeyEo7YWiW2gij/yg==
X-Received: by 2002:a05:6e02:1baa:b0:35d:692c:5968 with SMTP id n10-20020a056e021baa00b0035d692c5968mr7020804ili.3.1701973607260;
        Thu, 07 Dec 2023 10:26:47 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id o18-20020a056e02093200b0035c06da6d05sm46940ilt.52.2023.12.07.10.26.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 10:26:46 -0800 (PST)
Message-ID: <0ecb3016-537d-4962-b237-c1879aeced67@kernel.dk>
Date: Thu, 7 Dec 2023 11:26:46 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Content-Language: en-US
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, Phillip Lougher <phillip@squashfs.org.uk>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
 <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
 <20231206232724.hitl4u7ih7juzxev@moria.home.lan>
 <4d8504f9-9136-40b1-b625-52981764bd69@kernel.dk>
 <20231207180654.xh27mtjbt5kudta4@moria.home.lan>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231207180654.xh27mtjbt5kudta4@moria.home.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 11:06 AM, Kent Overstreet wrote:
> On Thu, Dec 07, 2023 at 10:57:25AM -0700, Jens Axboe wrote:
>> On 12/6/23 4:27 PM, Kent Overstreet wrote:
>>> On Wed, Dec 06, 2023 at 03:40:38PM -0700, Jens Axboe wrote:
>>>> On 12/6/23 2:34 PM, Kent Overstreet wrote:
>>>>> On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
>>>>>> This patch reworks bio_for_each_segment_all() to be more inline with how
>>>>>> the other bio iterators work:
>>>>>>
>>>>>>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
>>>>>>    one in the iterator and pass a pointer to it - bad. This way makes it
>>>>>>    clearer what's a constructed value vs. a reference to something
>>>>>>    pre-existing, and it also will help with cleaning up and
>>>>>>    consolidating code with bio_for_each_folio_all().
>>>>>>
>>>>>>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
>>>>>>    this makes their code clearer.
>>>>>
>>>>> Jens, can we _please_ get this series merged so bcachefs isn't reaching
>>>>> into bio/bvec internals?
>>>>
>>>> Haven't gotten around to review it fully yet, and nobody else has either
>>>> fwiw. Would be nice with some reviews.
>>>
>>> Well, there was quite a bit of back and forth before, mainly over code
>>> size - which was addressed; and the only tricky parts were to squashfs
>>> which Phillip looked at and tested.
>>
>> Would be nice to have that reflected in the commit, and would also be
>> really nice to have the ext4 and iomap folks at least take a gander at
>> patch 2 as well and ack it.
> 
> I've tested it thoroughly and those changes were purely mechanical.

That's great, but it would still be prudent to ensure they've seen it.
And adding the review/whatever from Phillip.

-- 
Jens Axboe

