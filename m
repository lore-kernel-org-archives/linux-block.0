Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3EC43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C41EE2173E
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 02:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="trZgffbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfLLCjA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 21:39:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45633 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfLLCi7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 21:38:59 -0500
Received: by mail-pg1-f195.google.com with SMTP id b9so324482pgk.12
        for <linux-block@vger.kernel.org>; Wed, 11 Dec 2019 18:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=01GgsUaNcyRwO3k+GyWSjY6KGpQcOqatQZUk+Ajithc=;
        b=trZgffbqjkURsXUYXxMm3jYKaMrbMZW38hSJT/UPviKy84yDzYgXSzcnMC8RGdglk/
         7zGUibew1mhMd0qR8kTY0qfce8X9mFFoSrAAoOZLlVfEBZlxenZ7FoYFuUcOHpcNTc2K
         Ln5iH0oM40SRpli3ciTVAYQ+fuTz+qOSeW7J7gs6f7KovKueRaAb3yvKGN0Br5mFEhG8
         83oJUMT+Iwk8TO/iPe+vNVKuVeRUeVuRNPyon9J9LrrFTc+byoXSjyqRgFG/q75VrzAM
         ZvMfVA6lBsL4lqtXYFpZJJ+aGAvQLVX0LHAaWiPNsvWLHi97j6rzuoPICDo+i6jqnWR2
         SAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01GgsUaNcyRwO3k+GyWSjY6KGpQcOqatQZUk+Ajithc=;
        b=erBl7A2Z8Dq3gBRnX/5h1FN8I4T7uHjkJbF2CoFPcCqR1WDPpejyxI90s8XYO9SqaK
         fHjgAT+POrWmCUMkncGnWOqNqbboCDX5kBbrJx/HSb9tZF2cImB9DQuAWvPnqdN6JdJw
         rtWGNiyRy9PRWKBbBF8rosJA90k2xoucadxaP/HFO+T45qJMkH85F3lLyRdIWv1oBNmF
         pm4uvTEfzn5j2l/6So4y0hRlHNkC0epBSEmhOsLr1B093r55udoeB2F8GIovODCowMUF
         8321XYlnRrfsh+A0yRrtaglF1oNOgNHLuEOWDKYgr9Jf0bTjlg6wO1E7jf3jWnpsIvaN
         bBXA==
X-Gm-Message-State: APjAAAXIlKLgPm6o86tzj0tm0PGmMmEo6GcxSaRL5A245u5q5QK14BU1
        0mj+FLiA2P7paFnmMSOQgC3r8A==
X-Google-Smtp-Source: APXvYqwe/Bd+rMaHYLrn8alwGVoil0g0wm0EcnCYa8dkFYiQA1xf7NCuqkGKl/1J3tGSKHHN2WyU7g==
X-Received: by 2002:a63:541e:: with SMTP id i30mr7679631pgb.183.1576118338884;
        Wed, 11 Dec 2019 18:38:58 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1082? ([2620:10d:c090:180::628a])
        by smtp.gmail.com with ESMTPSA id g9sm4810073pfm.150.2019.12.11.18.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 18:38:57 -0800 (PST)
Subject: Re: [PATCHSET v3 0/5] Support for RWF_UNCACHED
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20191211152943.2933-1-axboe@kernel.dk>
 <CAHk-=wjz3LE1kznro1dozhk9i9Dr4pCnkj7Fuccn2xdWeGHawQ@mail.gmail.com>
 <d0adcde2-3106-4fea-c047-4d17111bab70@kernel.dk>
 <e43a2700-8625-e136-dc9d-d0d2da5d96ac@kernel.dk>
 <CAHk-=wje8i3DVcO=fMC4tzKTS5+eHv0anrVZa_JENQt08T=qCQ@mail.gmail.com>
 <0d4e3954-c467-30a7-5a8e-7c4180275533@kernel.dk>
 <CAHk-=whk4bcVPvtAv5OmHiW5z6AXgCLFhO4YrXD7o0XC+K-aHw@mail.gmail.com>
 <fef996ca-a4ed-9633-1f79-91292a984a20@kernel.dk>
 <e7fc6b37-8106-4fe2-479c-05c3f2b1c1f1@kernel.dk>
 <00a5c8b7-215a-7615-156d-d8f3dbb1cd3a@kernel.dk>
 <20191212022155.GQ32169@bombadil.infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9269b4e0-829c-8b95-61ff-f3922c6380f6@kernel.dk>
Date:   Wed, 11 Dec 2019 19:38:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191212022155.GQ32169@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/19 7:21 PM, Matthew Wilcox wrote:
> On Wed, Dec 11, 2019 at 07:03:40PM -0700, Jens Axboe wrote:
>> Tested and cleaned a bit, and added truncate protection through
>> inode_dio_begin()/inode_dio_end().
>>
>> https://git.kernel.dk/cgit/linux-block/commit/?h=buffered-uncached&id=6dac80bc340dabdcbfb4230b9331e52510acca87
>>
>> This is much faster than the previous page cache dance, and I _think_
>> we're ok as long as we block truncate and hole punching.
> 
> What about races between UNCACHED and regular buffered IO?  Seems like
> we might end up sending overlapping writes to the device?

The UNCACHED out-of-page-cache IO is just for reads, it's not writes. The
write part is still using the same approach as earlier, though now I bet
it looks kinda slow compared to the read side...

-- 
Jens Axboe

