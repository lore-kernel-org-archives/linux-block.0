Return-Path: <SRS0=l92v=WJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF38EC32750
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 15:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBEB205F4
	for <linux-block@archiver.kernel.org>; Tue, 13 Aug 2019 15:45:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfHMPp5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:45:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46154 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbfHMPp4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Aug 2019 11:45:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED2753098434;
        Tue, 13 Aug 2019 15:45:55 +0000 (UTC)
Received: from [10.10.122.147] (ovpn-122-147.rdu2.redhat.com [10.10.122.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9115310A301F;
        Tue, 13 Aug 2019 15:45:55 +0000 (UTC)
Subject: Re: [PATCH 4/4] nbd: fix zero cmd timeout handling
To:     Josef Bacik <josef@toxicpanda.com>
References: <20190809212610.19412-1-mchristi@redhat.com>
 <20190809212610.19412-5-mchristi@redhat.com>
 <20190813131357.dpyd5mqbfubqhiaa@MacBook-Pro-91.local>
Cc:     linux-block@vger.kernel.org
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5D52DB33.8070307@redhat.com>
Date:   Tue, 13 Aug 2019 10:45:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190813131357.dpyd5mqbfubqhiaa@MacBook-Pro-91.local>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 13 Aug 2019 15:45:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/13/2019 08:13 AM, Josef Bacik wrote:
> On Fri, Aug 09, 2019 at 04:26:10PM -0500, Mike Christie wrote:
>> This fixes a regression added in 4.9 with commit:
>>
>> commit 0eadf37afc2500e1162c9040ec26a705b9af8d47
>> Author: Josef Bacik <jbacik@fb.com>
>> Date:   Thu Sep 8 12:33:40 2016 -0700
>>
>>     nbd: allow block mq to deal with timeouts
>>
>> where before the patch userspace would set the timeout to 0 to disable
>> it. With the above patch, a zero timeout tells the block layer to use
>> the default value of 30 seconds. For setups where commands can take a
>> long time or experience transient issues like network disruptions this
>> then results in IO errors being sent to the application.
>>
>> To fix this, the patch still uses the common block layer timeout
>> framework, but if zero is set, nbd just logs a message and then resets
>> the timer when it expires.
>>
>> Josef,
>>
>> I did not cc stable, but I think we want to port the patches to some
>> releases. We originally hit this with users using the longterm kernels
>> with ceph. The patch does not apply anywhere cleanly with older ones
>> like 4.9, so I was not sure how we wanted to handle it.
>>
> 
> I assume you tested this?  IIRC there was a problem where 0 really meant 0 and

Yes.

> commands would insta-timeout.  But my memory is foggy here, so I'm not sure if
> it was setting the tag_set timeout to 0 that made things go wrong, or what.  Or
> I could be making it all up, who knows.

Yes, if you call blk_queue_rq_timeout with 0, then the command will
timeout almost immediately. I added a check for this in the first patch.

If blk_mq_tag_set.timeout is 0, blk_mq_init_allocated_queue uses the
default 30 second value.

So with the patch if the user sets the timeout to 0, then we will just
log a message every 30 seconds that the command is stuck.

> 
> There's a blktest that just runs fio on a normal device with no timeouts or
> anything, that's where I would see the problem since it was a little racy.
> Basically have the timeout set to 0 and put load on the disk and eventually
> you'd start seeing timeouts.  If that all goes fine then you can add
> 
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 

Ok.

