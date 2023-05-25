Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD467C77B7E
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 15:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjEYP0D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 11:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbjEYP0C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 11:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7552A3
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 08:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685028315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fMrxhWgLyOUzKMB1Tal5g/FIIXS1y2NZ/71A12nEoZg=;
        b=HmXFFEgrsHtf/HXuzZBojg52yL4eNp+MT+sPwecb7cyWHZMFTFCubruJQcl0+Y+wfwwpNk
        664cRy6MWw0DyTw8/jndvNeN7aCK69WydrwaLChmJuzxnGqniIGiOBQkwiF59GdA5wG7vs
        SZ3j8X+9uuz8IAacZtHh8Uvx0CZOtEM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-297-XCMsCKYJOO6W5oEI60bWgw-1; Thu, 25 May 2023 11:25:08 -0400
X-MC-Unique: XCMsCKYJOO6W5oEI60bWgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 48370282CCAC;
        Thu, 25 May 2023 15:25:06 +0000 (UTC)
Received: from [10.22.34.46] (unknown [10.22.34.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 742B11121314;
        Thu, 25 May 2023 15:25:05 +0000 (UTC)
Message-ID: <8f56f60f-8dd3-d798-3d81-6ccbb185465d@redhat.com>
Date:   Thu, 25 May 2023 11:25:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] blk-cgroup: Flush stats before releasing blkcg_gq
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Ming Lei <ming.lei@redhat.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Linux-MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>
References: <20230524011935.719659-1-ming.lei@redhat.com>
 <CAJD7tkZkbro4H-QC=RJx_dfCdGQ5c=4NJhbFrcEmQSidaaMOmg@mail.gmail.com>
 <ZG14VnHl20lt9jLc@ovpn-8-17.pek2.redhat.com>
 <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <3ej42djuuzwx36yf2yeo5ggyrvogeaguos5jtve2bvuaejnwff@fak3yjwe2fbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/25/23 10:11, Michal Koutný wrote:
> On Wed, May 24, 2023 at 10:37:10AM +0800, Ming Lei <ming.lei@redhat.com> wrote:
>>> I am not at all familiar with blkcg, but does calling
>>> cgroup_rstat_flush() in offline_css() fix the problem?
>> Except for offline, this list needs to be flushed after the associated disk
>> is deleted.
> Why the second flush trigger?
> a) To break another ref-dependency cycle (like on the blkcg side)?
> b) To avoid stale data upon device removal?
>
> (Because b) should be unnecessary, a future reader would flush when
> needed.)

Since the percpu blkg_iostat_set's that are linked in the lockless list 
will be freed if the corresponding blkcg_gq is freed, we need to flush 
the lockless list to avoid potential use-after-free in a future 
cgroup_rstat_flush*() call.

Cheers,
Longman

