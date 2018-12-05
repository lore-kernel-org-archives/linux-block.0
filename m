Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8198C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7519B208E7
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 18:18:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7519B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeLESSg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54302 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727564AbeLESSg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Dec 2018 13:18:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 937D330820EE;
        Wed,  5 Dec 2018 18:18:36 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD5260565;
        Wed,  5 Dec 2018 18:18:33 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:18:33 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mikulas Patocka <mpatocka@redhat.com>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 4/6] block: switch to per-cpu in-flight counters
Message-ID: <20181205181832.GA10058@redhat.com>
References: <20181130222226.77216-1-snitzer@redhat.com>
 <20181130222226.77216-5-snitzer@redhat.com>
 <d6a741cd-ea75-19d0-13e3-eb1321e617b4@kernel.dk>
 <20181205174942.GA9838@redhat.com>
 <eb184c39-9d60-0fa3-0d27-7af2f78d601e@kernel.dk>
 <20181205180347.GA9966@redhat.com>
 <779ca97e-3353-5fd0-9899-73de8a0b2cad@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <779ca97e-3353-5fd0-9899-73de8a0b2cad@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 05 Dec 2018 18:18:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 05 2018 at  1:04pm -0500,
Jens Axboe <axboe@kernel.dk> wrote:

> On 12/5/18 11:03 AM, Mike Snitzer wrote:
> > On Wed, Dec 05 2018 at 12:54pm -0500,
> > Jens Axboe <axboe@kernel.dk> wrote:
> > 
> >> On 12/5/18 10:49 AM, Mike Snitzer wrote:
> >>> On Wed, Dec 05 2018 at 12:30pm -0500,
> >>> Jens Axboe <axboe@kernel.dk> wrote:
> >>>
> >>>> There's also no need to pass in the cpu, if we're not running with
> >>>> preempt disabled already we have a problem. 
> >>>
> >>> Why should this be any different than the part_stat_* interfaces?
> >>> __part_stat_add(), part_stat_read(), etc also use
> >>> per_cpu_ptr((part)->dkstats, (cpu) accessors.
> >>
> >> Maybe audit which ones actually need it? To answer the specific question,
> >> it's silly to pass in the cpu, if we're pinned already. That's true
> >> both programatically, but also for someone reading the code.
> > 
> > I understand you'd like to avoid excess interface baggage.  But seems to
> > me we'd be better off being consistent, when extending the percpu
> > portion of block core stats, and then do an incremental to clean it all
> > up.
> 
> The incremental should be done first in that case, it'd be silly to
> introduce something only to do a cleanup right after.

OK, all existing code for these percpu stats should follow the pattern:

  int cpu = part_stat_lock();

  <do percpu diskstats stuff>

  part_stat_unlock();

part_stat_lock() calls get_cpu() which does preempt_disable().  So to
your point: yes we have preempt disabled.  And yes we _could_ just use
smp_processor_id() in callers rather than pass 'cpu' to them.

Is that what you want to see?

Mike
