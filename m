Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out1.zte.com.cn ([202.103.147.172]:47460 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753469AbeDMDeC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Apr 2018 23:34:02 -0400
From: tang.junhui@zte.com.cn
To: colyli@suse.de
Cc: kent.overstreet@gmail.com, mlyle@lyle.org,
        linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        tang.junhui@zte.com.cn
Subject: Re: [PATCH 2/4] bcache: calculate the number of incremental GC nodesaccording to the total of btree nodes
Date: Fri, 13 Apr 2018 11:34:12 +0800
Message-Id: <1523590452-23136-1-git-send-email-tang.junhui@zte.com.cn>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Coly

>Hi Junhui,
>
>>                  btree_node_prefetch(b, k);
>> +                /*
>> +                 * initiallize c->gc_stats.nodes
>> +                 * for incremental GC
>> +                 */
>> +                b->c->gc_stats.nodes++;
>                                       
>I don't get the point why increase gc_stats.nodes here. Could you please
>explain a bit more ? 
 
We get gc_stats.nodes here, because we need to know the total btree nodes 
to caculate how much btree nodes we could do incremental GC in the first
time. If we don't get it, it would be zero in the first GC time, and we
can't caculate how much btree nodes in incremental GC correctly in the
first GC time.

Though the count is not accurate (since after we get gc_stats.nodes, journal
replay, I/O writes may happend, so the real nodes count may be changed), but
we only use it to estimate how much btree nodes we could GC each time, so it
doesn't matter.
                                     
Thanks.                                                                      
Tang Junhui                             
     
