Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03FC43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FF621670
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JgrmLDtk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfEAMfg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 08:35:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39009 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfEAMfg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 08:35:36 -0400
Received: by mail-pg1-f193.google.com with SMTP id l18so8253501pgj.6
        for <linux-block@vger.kernel.org>; Wed, 01 May 2019 05:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kUaJWRb5jS6ZrUZXOphNsgHvkCpcxEGyaGwJKiM3a1k=;
        b=JgrmLDtko45TBfT/JhPCXxPdDbJYbcBNmhJE/GOo1C7M4mfjtYxZLResjbC+yGFv8s
         0cStFvBmKyNzy86Qx2j0L8lKdwevPzntBQvThyhuxJ7Eh1cyhl3/I/ZCa6sIGTLK1ZUW
         1qwoFwJUtqNHoyPBDqBbIGyULhEaUM6C5DFL3B07Ezs3gbeSb2JO9sad2xubj33jNXuO
         Bqj6afjsuUop/2a8nnT5/w/gftYBRJ09dlH9Ae8qKL3NqSUlMfSsJA/mIR2OsGTnsnPk
         ZvTPTAR7396EwP9xC6Jk0lcYO54Zl1iPQ51JHn/AuL7Pem0aaySVwEMgB3Frf2AaJxsT
         VL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kUaJWRb5jS6ZrUZXOphNsgHvkCpcxEGyaGwJKiM3a1k=;
        b=Edg4H0VBmbkgcgEzQvcps1G3bgcWxVSBJ0su9JEgrXhjWOhaE0BVepoBIME3EUIHTg
         su6yOrOY34JsbjYw7Uubcs1PKsNOr8TIxctTlz743qFkDnn9kPZbES9+tVLyUBDRxi94
         LoukNE5OaCI2mV+Qdah4H2oKPlpVq+8xDnaDuQhukgLBMOzq0eLmLQGZ3dczhOaN80ZX
         B+p31T+nMBgYD8u8/PwUNdeVm+r6eNNI6cBpACOdcnbfm7NzLYCzjJlqhiq+V9z9g233
         eblKZgoGq/5/tDP0fN1jQQWHMj7U1SrGbkzxAotR5ZY0kRspo4lmnt3uctObH2WZc0Hq
         6n/A==
X-Gm-Message-State: APjAAAXhTL6PuDV9/Z8ahNbfsHRKoipyTOFswZt/LU0sik4QQaIr+ubq
        4E0jSA7/Y/jMY9ISjE7jY+VRRQ==
X-Google-Smtp-Source: APXvYqzud9uzajCSxSbcc+YCDIjgeqJeSECGQzHPHFkvFG+Df5FzLmmxozpDTgDAZT5v860gCToZdQ==
X-Received: by 2002:a63:cf:: with SMTP id 198mr70726689pga.228.1556714134626;
        Wed, 01 May 2019 05:35:34 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id i129sm59619675pfc.163.2019.05.01.05.35.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 05:35:33 -0700 (PDT)
Subject: Re: [PATCH] bcache: remove redundant LIST_HEAD(journal) from
 run_cache_set()
To:     Coly Li <colyli@suse.de>
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        juha.aatrokoski@aalto.fi, shhuiw@foxmail.com
References: <20190430140225.21642-1-colyli@suse.de>
 <0ded62e9-6135-6da1-312d-1ceb6160c93b@suse.de>
 <54478019-5427-266e-42c2-0d606c6e5ec3@kernel.dk>
 <b9036b88-9bd9-a96b-a7ed-96bd45708267@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <87f49306-4b2e-111f-d6e3-e2929027f66d@kernel.dk>
Date:   Wed, 1 May 2019 06:35:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b9036b88-9bd9-a96b-a7ed-96bd45708267@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/1/19 12:43 AM, Coly Li wrote:
> On 2019/4/30 10:20 下午, Jens Axboe wrote:
>> On 4/30/19 8:05 AM, Coly Li wrote:
>>> On 2019/4/30 10:02 下午, Coly Li wrote:
>>>> Commit 95f18c9d1310 ("bcache: avoid potential memleak of list of
>>>> journal_replay(s) in the CACHE_SYNC branch of run_cache_set") forgets
>>>> to remove the original define of LIST_HEAD(journal), which makes
>>>> the change no take effect. This patch removes redundant variable
>>>> LIST_HEAD(journal) from run_cache_set(), to make Shenghui's fix
>>>> working.
>>>>
>>>> Reported-by: Juha Aatrokoski <juha.aatrokoski@aalto.fi>
>>>> Cc: Shenghui Wang <shhuiw@foxmail.com>
>>>> Signed-off-by: Coly Li <colyli@suse.de>
>>>> ---
>>>>  drivers/md/bcache/super.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
>>>> index 0ffe9acee9d8..1b63ac876169 100644
>>>> --- a/drivers/md/bcache/super.c
>>>> +++ b/drivers/md/bcache/super.c
>>>> @@ -1800,7 +1800,6 @@ static int run_cache_set(struct cache_set *c)
>>>>  	set_gc_sectors(c);
>>>>  
>>>>  	if (CACHE_SYNC(&c->sb)) {
>>>> -		LIST_HEAD(journal);
>>>>  		struct bkey *k;
>>>>  		struct jset *j;
>>>>  
>>>>
>>>
>>> Hi Jens,
>>>
>>> Please take this fix for the Linux v5.2 bcache series. It fixes a
>>> problem from
>>> [PATCH 18/18] bcache: avoid potential memleak of list of
>>> journal_replay(s) in the CACHE_SYNC branch of run_cache_set
>>> which is already in your for-next branch.
>>>
>>> Thanks to Juha for cache this bug, and thank you in advance for taking
>>> care of this.
>>
>> Applied, but please add Fixes: lines patches like that, it's not enough
>> to simply mention it in the commit message.
>>
> 
> I just re-send a V2 patch with adding the Fixes: line, thanks for taking
> care of this.

As I wrote, I already applied it and added the Fixes tag. Just a note
for future patches.

-- 
Jens Axboe

