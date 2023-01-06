Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C8C54EBD
	for <linux-block@archiver.kernel.org>; Fri,  6 Jan 2023 18:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAFStq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Jan 2023 13:49:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236081AbjAFSti (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Jan 2023 13:49:38 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F8276235
        for <linux-block@vger.kernel.org>; Fri,  6 Jan 2023 10:49:36 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y2so1425824ily.5
        for <linux-block@vger.kernel.org>; Fri, 06 Jan 2023 10:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MnPFQI0zQH+ufIe4NpG7uds9d7bqyUhTRB750/CIDaE=;
        b=ypF+eMOtz+SHom6Ti/j0q7w3SNGMZCKJRqKCZZ7QLmnAIgrMP81UcjQ2R4RR+4s4/J
         sUghcfcmHZt3j4sJJ1K+RSkbg1i7eJKZqs5s5bQZiKx9gocGK/jX8RClIZCB3bz2SHzm
         21MTouPINFuSJ0pnLqIdZfVFyuJm2fOPDNttlBB9G82xejAr24r1/3Ag6aCq3SphYgW9
         T+kOFgnDhWhKWlFD330pqxqSyRIeNsb/tILZNvWuioCl8cz/mj40jzVVZ0xyif95mp6w
         waG7HPLbUc8g/BXdGfh2V43aU0fPlcm3i9BjENEHYPk9ACAjwudLrha3H66wsUvuMvpu
         1VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MnPFQI0zQH+ufIe4NpG7uds9d7bqyUhTRB750/CIDaE=;
        b=5velh2/fGgbvMeRneMIzupXmH391MRKjqaJ5lsQWcrpL25an+11TlaKcdvM7nHb+U5
         XlJESYUuyn0okh7m+mEIma31HAegvJkdk4k6/7HBeS5Oi0OjJMgeR83ZltLUJWUqOeh/
         3FdAkZzQELAvooDW6rnoFqH1EDlcdPfgJXzI07BH45eEulyRdoMqKp4lGFTLdRZzuJxK
         qd1gp0u7L3NQh8EH85TopxGCQ0VQwDfCd4wSUYYV33uoD+UW6X+OpUcfVyJ5pR1Om2pf
         W+489vXmuAbe5s7wEkerptQZOrP04+hN/eIYGUTSolbyhAHtSPGEEbOZeT18vtlo3HuV
         sRzQ==
X-Gm-Message-State: AFqh2kp5xU7YAnYeVXFBVU3vaio2Z5CO6eOsDLujIve6nLUuwV9E8p5H
        dJIY5rlbnojuadD+wotM9eq29Q==
X-Google-Smtp-Source: AMrXdXsD6V6/w0NcDSDdpMWHoU4dkXEqhrgGvI7CuZrztJscRGU7CxpCZqMRdEbt2l+uLXFyNMjXvw==
X-Received: by 2002:a92:d28f:0:b0:30b:d89f:35b2 with SMTP id p15-20020a92d28f000000b0030bd89f35b2mr6332449ilp.3.1673030976190;
        Fri, 06 Jan 2023 10:49:36 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r13-20020a92d98d000000b0030d6e5a28c6sm563402iln.60.2023.01.06.10.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 10:49:35 -0800 (PST)
Message-ID: <9ac3390c-055b-546c-f1f4-68350dfe04f8@kernel.dk>
Date:   Fri, 6 Jan 2023 11:49:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [bug report] memcontrol: schedule throttling if we are congested
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>, Dan Carpenter <error27@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y7g3L6fntnTtOm63@kili> <Y7hbYPSdLqW++y/p@slm.duckdns.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y7hbYPSdLqW++y/p@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/6/23 10:33 AM, Tejun Heo wrote:
> Hello,
> 
> (cc'ing Luis, Christoph and Jens and quoting whole body)
> 
> On Fri, Jan 06, 2023 at 05:58:55PM +0300, Dan Carpenter wrote:
>> Hello Tejun Heo,
>>
>> The patch 2cf855837b89: "memcontrol: schedule throttling if we are
>> congested" from Jul 3, 2018, leads to the following Smatch static
>> checker warning:
>>
>> block/blk-cgroup.c:1863 blkcg_schedule_throttle() warn: sleeping in atomic context
>>
>> The call tree looks like:
>>
>> ioc_rqos_merge() <- disables preempt
>> __cgroup_throttle_swaprate() <- disables preempt
>> -> blkcg_schedule_throttle()
>>
>> Here is one of the callers:
>> mm/swapfile.c
>>   3657          spin_lock(&swap_avail_lock);
>>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> Takes spin lock.
>>
>>   3658          plist_for_each_entry_safe(si, next, &swap_avail_heads[nid],
>>   3659                                    avail_lists[nid]) {
>>   3660                  if (si->bdev) {
>>   3661                          blkcg_schedule_throttle(si->bdev->bd_disk, true);
>>                                 ^^^^^^^^^^^^^^^^^^^^^^^
>> Calls blkcg_schedule_throttle().
>>
>>   3662                          break;
>>   3663                  }
>>   3664          }
>>
>> block/blk-cgroup.c
>>   1851  void blkcg_schedule_throttle(struct gendisk *disk, bool use_memdelay)
>>   1852  {
>>   1853          struct request_queue *q = disk->queue;
>>   1854  
>>   1855          if (unlikely(current->flags & PF_KTHREAD))
>>   1856                  return;
>>   1857  
>>   1858          if (current->throttle_queue != q) {
>>   1859                  if (!blk_get_queue(q))
>>   1860                          return;
>>   1861  
>>   1862                  if (current->throttle_queue)
>>   1863                          blk_put_queue(current->throttle_queue);
>>                                 ^^^^^^^^^^^^^^
>> Sleeps.
>>
>>   1864                  current->throttle_queue = q;
>>   1865          }
>>   1866  
>>   1867          if (use_memdelay)
>>   1868                  current->use_memdelay = use_memdelay;
>>   1869          set_notify_resume(current);
>>   1870  }
> 
> In general, it's quite unusual for a put operation to require a sleepable
> context and I could be missing sth but the actual put / release paths don't
> seem to actually need might_sleep(). It seems sprious.
> 
> The might_sleep() in put was added by Christoph's 63f93fd6fa57 ("block: mark
> blk_put_queue as potentially blocking") which promoted it from release to
> put cuz the caller usually can't tell whether its put is the last put.
> 
> And that put in release was added by Luis in e8c7d14ac6c3 ("block: revert
> back to synchronous request_queue removal") while making the release path
> synchronous, the rationale being that releasing asynchronously makes dynamic
> device removal / readdition behaviors unpredictable and it also seems to
> note that might_sleep() is no longer needed but still kept, which seems a
> bit odd to me.
> 
> Here's my take on it:
> 
> * Let's please not require a sleepable context in a put operation. It's
>   unusual, inconvenient and error-prone, and likely to cause its users to
>   implement multiple copies of async mechanisms around it.
> 
> * A better way to deal with removal / readdition race is flushing release
>   operaitons either at the end of removal or before trying to add something
>   (you can get fancy w/ flushing only if there's name collision too), not
>   making a put path synchronously call release which needs to sleep.
> 
> * If might_sleep() is currently not needed, let's please drop it. It just
>   makes people scratch their head when reading the code.

I looked over the call path, and I don't think anything in there sleeps.
So should be fine to remove the might_sleep().

-- 
Jens Axboe


