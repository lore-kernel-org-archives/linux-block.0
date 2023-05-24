Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BED7C7EE23
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 04:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjEXELm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 00:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEXELm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 00:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F32DC1
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684901459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jjXC8nEHxswkc61Y0uyyoGWYpO1Pad3VdwaQeUusRw=;
        b=Z/1lLEL4bHQc1bXDWh3DKM4Duq/gTAbMPIUaK3KPNfJQY2w+CsGMzDPXZKOCssS2E6vaGV
        cEuhOcAiG6kJ8jB88qciZXa/PGKGT8UslfTa5/CYdbHx409zpUA6Qu75ZrriXtzWL505CO
        B4vFRAMbgkmXl6HURcHEHOu7wNRD0mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-UCW2gKqMPgaKCCBtYR6dqA-1; Wed, 24 May 2023 00:10:57 -0400
X-MC-Unique: UCW2gKqMPgaKCCBtYR6dqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A416101A52C;
        Wed, 24 May 2023 04:10:56 +0000 (UTC)
Received: from [10.22.8.64] (unknown [10.22.8.64])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFB23140E95D;
        Wed, 24 May 2023 04:10:55 +0000 (UTC)
Message-ID: <cfef97ec-bb77-4ccb-a0b2-8f1eb66afeb6@redhat.com>
Date:   Wed, 24 May 2023 00:10:55 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>, Yosry Ahmed <yosryahmed@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        mkoutny@suse.com
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/23/23 22:37, Ming Lei wrote:
> Hi Yosry,
>
> On Tue, May 23, 2023 at 07:06:38PM -0700, Yosry Ahmed wrote:
>> Hi Ming,
>>
>> On Tue, May 23, 2023 at 6:21 PM Ming Lei <ming.lei@redhat.com> wrote:
>>> As noted by Michal, the blkg_iostat_set's in the lockless list
>>> hold reference to blkg's to protect against their removal. Those
>>> blkg's hold reference to blkcg. When a cgroup is being destroyed,
>>> cgroup_rstat_flush() is only called at css_release_work_fn() which
>>> is called when the blkcg reference count reaches 0. This circular
>>> dependency will prevent blkcg and some blkgs from being freed after
>>> they are made offline.
>> I am not at all familiar with blkcg, but does calling
>> cgroup_rstat_flush() in offline_css() fix the problem?
> Except for offline, this list needs to be flushed after the associated disk
> is deleted.
>
>> or can items be
>> added to the lockless list(s) after the blkcg is offlined?
> Yeah.
>
> percpu_ref_*get(&blkg->refcnt) still can succeed after the percpu refcnt
> is killed in blkg_destroy() which is called from both offline css and
> removing disk.

As suggested by Tejun, we can use percpu_ref_tryget(&blkg->refcnt) to 
make sure that we can only take a reference when the blkg is online. I 
think it is a bit safer to take a percpu refcnt to avoid use after free. 
My other concern about your patch is that the per cpu list iterations 
will be done multiple times when a blkcg is destroyed if many blkgs are 
attached to the blkcg. I still prefer to do it once in 
blkcg_destroy_blkgs(). I am going to post an updated version tomorrow 
after some more testings.

Cheers,
Longman

