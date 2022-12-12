Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9ACC4332F
	for <linux-block@archiver.kernel.org>; Mon, 12 Dec 2022 14:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbiLLO7b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 09:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbiLLO73 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 09:59:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E459FB1E4
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 06:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670857117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GkbQCXweWiVyxQliOP1BrMo+NMG+D0texQS/7HCzGIk=;
        b=OVbyBpYdn3v1uk5ECkg/XI4Sg8cAxQlpWQdTGJuFwKrvlJVouC2ucYJrUK2sGYDDoWt4Za
        5NyzzGx2/Bey3n3+54Bil6F7V9J/0JpL6Vxu0jyYUOW1sOPfP+eHZgSjXtouB5effzR5Y5
        IpFzA3xRXemx//WVC0YA5EmVAFREZI0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-7kbTmcn2MbORoJ9Q6BS7PQ-1; Mon, 12 Dec 2022 09:58:30 -0500
X-MC-Unique: 7kbTmcn2MbORoJ9Q6BS7PQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0C3CA29AB409;
        Mon, 12 Dec 2022 14:58:30 +0000 (UTC)
Received: from [10.22.34.84] (unknown [10.22.34.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46545C15BAD;
        Mon, 12 Dec 2022 14:58:29 +0000 (UTC)
Message-ID: <ac3ec28b-929d-59e3-49c3-f7a548b01ebe@redhat.com>
Date:   Mon, 12 Dec 2022 09:58:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH-block v2 2/3] blk-cgroup: Don't flush a blkg if destroyed
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
References: <20221211222058.2946830-1-longman@redhat.com>
 <20221211222058.2946830-3-longman@redhat.com>
 <20221212125953.GE16456@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20221212125953.GE16456@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 12/12/22 07:59, Michal Koutný wrote:
> Hello.
>
> On Sun, Dec 11, 2022 at 05:20:57PM -0500, Waiman Long <longman@redhat.com> wrote:
>> Before commit 3b8cc6298724 ("blk-cgroup: Optimize blkcg_rstat_flush()"),
>> blkg's stats is only flushed if they are online.
> I'm not sure I follow -- css_release_work_fn/cgroup_rstat_flush may be
> called on an offlined blkcg (offlined!=released). There's no invariant
> ensuring offlined blkcg won't be flushed. (There is only current
> situation when there is no reader of io data that'd need them flushed
> [1].)
The original cgroup_rstat_flush() iterates the list of blkg's in the 
blkg_list. A blkg will be removed from the list when it is offlined. 
This patch just reverts its behavior to that previous behavior.
>
>> In addition, the stat flushing of blkgs in blkcg_rstat_flush()
>> includes propagating the rstat data to its parent. However, if a blkg
>> has been destroyed (offline), the validity of its parent may be
>> questionable.
> Parents won't be freed (neither offlined) before children (see
> css_killed_work_fn). It should be regularly OK to pass data into a
> parent of an offlined blkcg.
I guess it is likely to be safe to flush an offline blkg. I am just 
being conservative in case there is any corner case where it may be a 
problem which I haven't foreseen.
>
>> For safety, revert back to the old behavior by ignoring offline
>> blkg's.
> I don't know if this is a good reasoning. If you argue that offlined
> children needn't be taken into parent's account, then I think it's more
> efficient to exclude the offlined blkcgs from update. (With the caveat I
> have in [1].)

It is possible that a blkg may be updated before it becomes offline, but 
the flush isn't done in time before that happens. The next patch will 
catch some of that.

Cheers,
Longman

