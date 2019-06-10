Return-Path: <SRS0=HnxX=UJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB74C282DD
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 10:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DFF2085A
	for <linux-block@archiver.kernel.org>; Mon, 10 Jun 2019 10:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HES4OQU6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfFJKPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:15:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34857 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388734AbfFJKPl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jun 2019 06:15:41 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so7778845otq.2
        for <linux-block@vger.kernel.org>; Mon, 10 Jun 2019 03:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L/Fpx5ax3FSv1vsl05RpWDU1kFWGRR0oLTZTCT52Dhg=;
        b=HES4OQU6huVUOA8Ypw9ptPG1nA4Uv6pn+9wG7iiwr56eddgvTzzs3o9ps7OsWmaP14
         UTn7CHT2bxh23YDWcQQ5iNP86lLzVVowr7xycaDWtMEDPsgm6D90NnQLpU9P/A4O05Yt
         fJYtzCMhSUhbPaNw/LJVCirw/kDfJE8aGx/f8pwn6ZAlbtIUEJCl3kjglikLJ1uoBGu2
         Sxj3mBGpoJhvGUMIPPtVChaWR2IZhm3YotXjeSUCkgZdDFVSCCSbJOH6i1WNZeF0vr3E
         faV0/pf5dStZadFTxuauD1ss2lMlSOqIYqJDc3zTZt69o49fOuLZGgYpdT8AB+JyLVBT
         z9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L/Fpx5ax3FSv1vsl05RpWDU1kFWGRR0oLTZTCT52Dhg=;
        b=JgEW75DLzjel291MrHxZknZz91H9QBM8vHxEjdCdq5ScwL2v5y/kgCwJzKPnhr5h0+
         NCwGQPsE/H3Pl9KL6V+8Rhy1pDg58OvQuEfOJt6GSv4P7fRYp5ke/lVOUubRGz+5WQfV
         c4+I/vezNMTxA9Yat+VgcK1TEx3+euzzJLRZsbAVUdaymqfCTDbBgx2cYneyL1BAKbaJ
         Uziz9rfSmZFPz887+Rm6WA4H9EvDr4U71e+XGBfeGHzSR/whs5hAm41vEPrlACJ8UBmg
         VLLm3lIl1GIkog25j43lxZrVIC5DxaaCnw8hf7K17RW6W9uAmCFpNGSikVEmYMDBEI+Z
         hT7g==
X-Gm-Message-State: APjAAAVfQStJK/lfV2J2bze/ndHpymOCV1VfBMP1UViVqUxQ+WW5RiSj
        mkBxWKJqDz65L35wSs5d+it3yduYlkDob1jq
X-Google-Smtp-Source: APXvYqzefV6s2avYclwY/dRUQ6u5/mzLFwhhu2cqT8UGXIzxrCAhLCkIh+G/dVqv/C5VOJ/tssOSUw==
X-Received: by 2002:a05:6830:1050:: with SMTP id b16mr13768724otp.228.1560161740167;
        Mon, 10 Jun 2019 03:15:40 -0700 (PDT)
Received: from [172.20.10.3] (mobile-107-92-56-198.mycingular.net. [107.92.56.198])
        by smtp.gmail.com with ESMTPSA id v18sm1091554otn.17.2019.06.10.03.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 03:15:38 -0700 (PDT)
Subject: Re: [GIT PULL] Block fixes for 5.2-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <4f801c9b-4ab6-9a11-536c-ff509df8aa56@kernel.dk>
 <CAHk-=whXfPjCtc5+471x83WApJxvxzvSfdzj_9hrdkj-iamA=g@mail.gmail.com>
 <52daccae-3228-13a1-c609-157ab7e30564@kernel.dk>
 <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebfb27a3-23e2-3ad5-a6b3-5f8262fb9ecb@kernel.dk>
Date:   Mon, 10 Jun 2019 04:15:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whca9riMqYn6WoQpuq9ehQ5KfBvBb4iVZ314JSfvcgy9Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/9/19 10:06 AM, Linus Torvalds wrote:
> On Sat, Jun 8, 2019 at 11:00 PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> FWIW, the concept/idea goes back a few months and was discussed with
>> the cgroup folks. But I totally agree that the implementation could
>> have been cleaner, especially at this point in time.
>>
>> I'm fine with you reverting those two patches for 5.2 if you want to,
>> and the BFQ folks can do this more cleanly for 5.3.
> 
> I don't think the code is _broken_, and I don't think the link_name
> thing is wrong. So no point in reverting unless we see more issues.
> 
> I just wish it had been done differently, both from the patch details
> standpoint, but also in making sure the cgroup people were aware (and
> maybe they were, but it certainly didn't show up in the commit).
> 
> So I think an incremental patch like the attached would make the code
> easier to understand (I really do mis-like random boolean flags being
> passed around that change behavior in undocumented and non-obvious
> ways), but I'd also want to make sure that Tejun & co are all on board
> and know about it..
> 
> I'm sure this happens a lot, but during the rc series I just end up
> *looking* at details like this a lot more, when I see changes outside
> of a subsystem directory.
> 
> Tejun&co, we're talking about commit 54b7b868e826 ("cgroup: let a
> symlink too be created with a cftype file") which didn't have any sign
> of you guys being aware of it or having acked it.

I talked to Tejun about this offline, and he's not a huge fan of the
symlink. So let's revert this for now, and Paolo can do this properly
for 5.3 instead.

Sorry for the confusion! Please pull the below.


  git://git.kernel.dk/linux-block.git tags/for-linus-20190610


----------------------------------------------------------------
Jens Axboe (1):
      cgroup/bfq: revert bfq.weight symlink change

 block/bfq-cgroup.c          |  6 ++----
 include/linux/cgroup-defs.h |  3 ---
 kernel/cgroup/cgroup.c      | 33 ++++-----------------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

-- 
Jens Axboe

