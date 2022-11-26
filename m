Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35170C43217
	for <linux-block@archiver.kernel.org>; Sat, 26 Nov 2022 22:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiKZWz2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Nov 2022 17:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKZWz1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Nov 2022 17:55:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0889C14033
        for <linux-block@vger.kernel.org>; Sat, 26 Nov 2022 14:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669503271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2WTLzOFPBPiw+/ohTkcvkZA562oHRz01D7Pp1Ajw1s=;
        b=K6azEdOu4oFFVvWkaGSvFdyLxwrmZJgxbTJOBA/toLIczGTw86ia2EiHYDCXouw3IZZ+Xs
        uMCEr+Kw8GrIPfDurZb+idI8pEb4JhFIXfTNrvbQeBcu3FcT0fhGFKlHNgRw1rtDayEkuu
        Fu8ulSYPq80seRCd6D10F3/C3P16hwU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-D9tCPqFXOFSXrGFgy1y2lA-1; Sat, 26 Nov 2022 17:54:29 -0500
X-MC-Unique: D9tCPqFXOFSXrGFgy1y2lA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 847F829AB3E8;
        Sat, 26 Nov 2022 22:54:29 +0000 (UTC)
Received: from [10.22.8.121] (unknown [10.22.8.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46E8B492B06;
        Sat, 26 Nov 2022 22:54:29 +0000 (UTC)
Message-ID: <43d93aa6-4846-bf03-e7b0-bcab6ba8a49e@redhat.com>
Date:   Sat, 26 Nov 2022 17:54:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [bisected]kernel BUG at lib/list_debug.c:30! (list_add
 corruption. prev->next should be nex)
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        CKI Project <cki-project@redhat.com>,
        Bruno Goncalves <bgoncalv@redhat.com>
References: <CA+QYu4oxiRKC6hJ7F27whXy-PRBx=Tvb+-7TQTONN8qTtV3aDA@mail.gmail.com>
 <2e5f0ed1-4771-1b24-e6da-b63393506e47@kernel.dk>
 <CA+QYu4qDcYJf3WKAmuFcFGX273t4Yi0WG+eF6oQGiRyKeXejWw@mail.gmail.com>
 <CAHj4cs9uLczHhbO+SRmbBGPu3WZ_HntiCi4sxettXCnjuV8ZXQ@mail.gmail.com>
 <CAHj4cs-1mH-FKtU8_uq4H4o6K+JKVwgvN7Yk3e8LOc+-u=YhMw@mail.gmail.com>
 <3f346cf0-1a3a-b884-5a21-f0508d02981d@kernel.dk>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3f346cf0-1a3a-b884-5a21-f0508d02981d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 11/26/22 10:53, Jens Axboe wrote:
> On 11/26/22 7:29 AM, Yi Zhang wrote:
>> Hi Jens
>> Sorry for the delay as I couldn't reproduce it with the original
>> for-6.2/block branch.
>> Finally, I rebased the for-6.2/block branch on 6.1-rc6 and was able to
>> bisect it：
>>
>>
>> 951d1e94801f95a3fc1c75ff342431c9f519dd14 is the first bad commit
>> commit 951d1e94801f95a3fc1c75ff342431c9f519dd14
>> Author: Waiman Long <longman@redhat.com>
>> Date:   Fri Nov 4 20:59:02 2022 -0400
>>
>>      blk-cgroup: Flush stats at blkgs destruction path
>>
>>      As noted by Michal, the blkg_iostat_set's in the lockless list
>>      hold reference to blkg's to protect against their removal. Those
>>      blkg's hold reference to blkcg. When a cgroup is being destroyed,
>>      cgroup_rstat_flush() is only called at css_release_work_fn() which is
>>      called when the blkcg reference count reaches 0. This circular dependency
>>      will prevent blkcg from being freed until some other events cause
>>      cgroup_rstat_flush() to be called to flush out the pending blkcg stats.
>>
>>      To prevent this delayed blkcg removal, add a new cgroup_rstat_css_flush()
>>      function to flush stats for a given css and cpu and call it at the blkgs
>>      destruction path, blkcg_destroy_blkgs(), whenever there are still some
>>      pending stats to be flushed. This will ensure that blkcg reference
>>      count can reach 0 ASAP.
>>
>>      Signed-off-by: Waiman Long <longman@redhat.com>
>>      Acked-by: Tejun Heo <tj@kernel.org>
>>      Link: https://lore.kernel.org/r/20221105005902.407297-4-longman@redhat.com
>>      Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Waiman, let me know if you have an idea what is going on here and can
> send in a fix, or if I need to revert this one. From looking at the
> lists of commits after these reports came in, I did suspect this
> commit. But I don't know enough about this area to render an opinion
> on a fix without spending more time on it.
>
Sure. I will take a closer look at that. Will let you know my 
investigation result ASAP.

Thanks,
Longman

