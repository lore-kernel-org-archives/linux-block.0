Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE7C433FE
	for <linux-block@archiver.kernel.org>; Mon, 28 Nov 2022 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiK1Pm4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Nov 2022 10:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiK1Pmz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Nov 2022 10:42:55 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAC0DFA4
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:42:54 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id h33so5294694pgm.9
        for <linux-block@vger.kernel.org>; Mon, 28 Nov 2022 07:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ikwtuVAChvrOqHqA+XhFG3V1RBdB0rFmyOatV701UIQ=;
        b=Fwu3Ja3YaAsN1OEWkHKqkrg51PQ/MJYssqHid6c8J9kVpUsh/EPYMERU9XC+dWZVAI
         ks0ZTd8F7YD+QSiUkNIBTBXm6mUVz0xZ7ujFZUwBEvWiCJLHZYHttV2R3YtRwQu1fTIt
         FKtOo2nTXLcr1pMLGN2f6GTbBwbi8dkQz2tBJR2pNIxnwwKkg1RVnp0namd7dn/AGi71
         VBNyq+X7/RujQC4vRW946mpIw4ISIOUor89aiBelXseDzT9pXv8ZIA9+vw3PHyXUqLHs
         5lu0fXvF24H8xOd39b4l3YMxtatKl98TuPL7LTELlGg5CXB08V/YousK8YV4jnIy2//3
         rL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ikwtuVAChvrOqHqA+XhFG3V1RBdB0rFmyOatV701UIQ=;
        b=pczVZaS1ObFh5lFsfegLLXGFtCjC4/ZAkEHSiGiGOdvA5K6KCYu4OIGkEUbwZTFU4R
         Fw4SUJSGJgIXaDAhH8S2FoCxEN9fIAvh7rcOsLIaWcrCfJVoSgWdfuoVagBToUgYBlAj
         j+B/7S66PQyL+aUcmDhMsXHEBHEDb/AwwSeZAm5uiozZTmHqaqKy/NmOm0Mb9DrVA0dD
         39ixTRcc4ep0O4dgnJhEW5bAg1AzApYBkC+8SvfAhnYzV5jtpv7V9HJ2UOG89AFncN5P
         T4E0Yr/cDo1UZAx8xPW1ZQn6N+7I2MHUUKh6yk4TYRmRyGXUSoxZ9t74pGCK0LgoDcXO
         FE7A==
X-Gm-Message-State: ANoB5pmH/Gs/D+wYxKpYAtpzHnXXLuQss8+nVkIU0FRCqIBqMBWZV1r1
        jr3Y9UZrRS5qN8Z+zcujCVwRCw==
X-Google-Smtp-Source: AA0mqf4wEmIZpoxGWShkzohjjpRxAUi4xk7sxsisjm4pxGnReSUtgiJpl2DJCqKtMSu1edz+qeHdBw==
X-Received: by 2002:a63:5014:0:b0:477:2ac3:1b1f with SMTP id e20-20020a635014000000b004772ac31b1fmr43233091pgb.146.1669650173473;
        Mon, 28 Nov 2022 07:42:53 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id x129-20020a628687000000b0056baebf23e7sm8489147pfd.141.2022.11.28.07.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 07:42:52 -0800 (PST)
Message-ID: <786aacda-b25d-67f6-bad3-0030b0e2637e@kernel.dk>
Date:   Mon, 28 Nov 2022 08:42:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH-block] blk-cgroup: Use css_tryget() in
 blkcg_destroy_blkgs()
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>, Yi Zhang <yi.zhang@redhat.com>
References: <20221128033057.1279383-1-longman@redhat.com>
 <427068db-6695-a1e2-4aa2-033220680eb9@kernel.dk>
 <b9018641-d39f-ff74-8cfb-ba597f5ee0c2@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b9018641-d39f-ff74-8cfb-ba597f5ee0c2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/22 8:38?AM, Waiman Long wrote:
> On 11/28/22 09:14, Jens Axboe wrote:
>> On 11/27/22 8:30?PM, Waiman Long wrote:
>>> Commit 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction
>>> path") incorrectly assumes that css_get() will always succeed. That may
>>> not be true if there is no blkg associated with the blkcg. If css_get()
>>> fails, the subsequent css_put() call may lead to data corruption as
>>> was illustrated in a test system that it crashed on bootup when that
>>> commit was included. Also blkcg may be freed at any time leading to
>>> use-after-free. Fix it by using css_tryget() instead and bail out if
>>> the tryget fails.
>>>
>>> Fixes: 951d1e94801f ("blk-cgroup: Flush stats at blkgs destruction path")
>>> Reported-by: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Waiman Long <longman@redhat.com>
>>> ---
>>> ? block/blk-cgroup.c | 7 ++++++-
>>> ? 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index 57941d2a8ba3..74fefc8cbcdf 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -1088,7 +1088,12 @@ static void blkcg_destroy_blkgs(struct blkcg *blkcg)
>>> ? ????? might_sleep();
>>> ? -??? css_get(&blkcg->css);
>>> +??? /*
>>> +???? * If css_tryget() fails, there is no blkg to destroy.
>>> +???? */
>>> +??? if (!css_tryget(&blkcg->css))
>>> +??????? return;
>>> +
>>> ????? spin_lock_irq(&blkcg->lock);
>>> ????? while (!hlist_empty(&blkcg->blkg_list)) {
>>> ????????? struct blkcg_gq *blkg = hlist_entry(blkcg->blkg_list.first,
>> This doesn't seem safe to me, but maybe I'm missing something. A tryget
>> operation can be fine if we're under RCU lock and the entity is freed
>> appropriately, but what makes it safe here? Could blkcg already be gone
>> at this point?
> 
> The actual freeing of the blkcg structure is under RCU protection. So
> the structure won't be freed immediately even if css_tryget() fails. I
> suspect what Michal found may be the root cause of this problem. If
> so, this is an existing bug which gets exposed by my patch.

But what prevents it from going away here since you're not under RCU
lock for the tryget? Doesn't help that the freeing side is done in an
RCU safe manner, if the ref attempt is not.

-- 
Jens Axboe
