Return-Path: <SRS0=KmMx=6F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF790C54FCC
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 18:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F859206D9
	for <linux-block@archiver.kernel.org>; Tue, 21 Apr 2020 18:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fR+VW0xX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgDUSgk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:36:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726741AbgDUSgj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Apr 2020 14:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587494198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+egMlziICIn0HZu55lHO2iyEJMLClNgk/sWJCpumsI=;
        b=fR+VW0xXZV4EeMGa3ewMTB+q8eq9ynt6s0J4FfJl8JXAf4jksSb0N/uP1jQxxDVKpIILsY
        AP+2F0R/Rr3N8drHeZKO/j349USJAr954kXotP58en0zA/Hl/Da2R5HRyekrJm4ynxtWcv
        dlNJqCA1m/LIbwZMYzmz55bgmYaIBJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-xKU0VjHEOtivNHFtjVy3Tw-1; Tue, 21 Apr 2020 14:36:36 -0400
X-MC-Unique: xKU0VjHEOtivNHFtjVy3Tw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A827A107ACC7;
        Tue, 21 Apr 2020 18:36:33 +0000 (UTC)
Received: from llong.remote.csb (ovpn-114-241.rdu2.redhat.com [10.10.114.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 768595DA7C;
        Tue, 21 Apr 2020 18:36:29 +0000 (UTC)
Subject: Re: [PATCH] blk-iocost: Fix systemtap error on iocost_ioc_vrate_adj
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20200421130755.18370-1-longman@redhat.com>
 <20200421105948.4f5a36f5@gandalf.local.home>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <22ccb042-7d6f-3717-4024-9ec094b2f363@redhat.com>
Date:   Tue, 21 Apr 2020 14:36:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200421105948.4f5a36f5@gandalf.local.home>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/20 10:59 AM, Steven Rostedt wrote:
> On Tue, 21 Apr 2020 09:07:55 -0400
> Waiman Long <longman@redhat.com> wrote:
>
>> diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
>> index 7ecaa65b7106..c2f580fd371b 100644
>> --- a/include/trace/events/iocost.h
>> +++ b/include/trace/events/iocost.h
>> @@ -130,7 +130,7 @@ DEFINE_EVENT(iocg_inuse_update, iocost_inuse_reset,
>>  
>>  TRACE_EVENT(iocost_ioc_vrate_adj,
>>  
>> -	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 (*missed_ppm)[2],
>> +	TP_PROTO(struct ioc *ioc, u64 new_vrate, u32 *missed_ppm,
>>  		u32 rq_wait_pct, int nr_lagging, int nr_shortages,
>>  		int nr_surpluses),
>>  
>> @@ -155,8 +155,8 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
>>  		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
>>  		__entry->new_vrate = new_vrate;
>>  		__entry->busy_level = ioc->busy_level;
>> -		__entry->read_missed_ppm = (*missed_ppm)[READ];
>> -		__entry->write_missed_ppm = (*missed_ppm)[WRITE];
>> +		__entry->read_missed_ppm = missed_ppm[READ];
>> +		__entry->write_missed_ppm = missed_ppm[WRITE];
>>  		__entry->rq_wait_pct = rq_wait_pct;
>>  		__entry->nr_lagging = nr_lagging;
>>  		__entry->nr_shortages = nr_shortages;
> Regardless if this helps systemtap or not, I like the patch because the
> current code is rather ugly, and this patch makes it more readable.
>
> Suggestion: change the topic to remove systemtap, as that's not going to be
> the true reason for acceptance of this patch. It should just be about
> cleaning up the trace event itself.
>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> -- Steve
>
OK, will send a v2 patch to update the commit log. Thanks for the review.

Cheers,
Longman

