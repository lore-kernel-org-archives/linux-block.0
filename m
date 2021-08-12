Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2DC4338F
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 17:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C41AC6023D
	for <linux-block@archiver.kernel.org>; Thu, 12 Aug 2021 17:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbhHLRvx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Aug 2021 13:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLRvx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Aug 2021 13:51:53 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99281C061756
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:51:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id w6so1255705plg.9
        for <linux-block@vger.kernel.org>; Thu, 12 Aug 2021 10:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wGEAHEKYrtOJrXzeFGGKYZztKgQYv9DCEEL/obPElAA=;
        b=gB0g6EvNQwFjmW4sUTQifzSjGB0jQJkIa6wd/d0ia6dxDG/V8Lvii+r8RkYihDkzJj
         SXt17ULMSFtTLn1S9b26soljV+AstuwBda+2MCUICy6M47DZTODzHyoVxSuDewYUr4OK
         2/rGtOmK6wmTEOHmvae/sQieRdtHrCaHlCkPLy3s6HWp+/CLV5/zmS6I1ER1eWvULmDN
         mraojDlehK3N2KHiicGfvGliSd6lCsfC0ev5S+a7zOJlHKoqvm869vkqOeQSBhsopB7h
         zEESR3NCKTks1ABD5Afd4xGmm4s/TgooQcmbJKZTMIFkQD2mXoLljog024zvEOcYBmZE
         RjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=wGEAHEKYrtOJrXzeFGGKYZztKgQYv9DCEEL/obPElAA=;
        b=c8bqzMYt+SEyKcqpE/GMGqJfye5ys0h8+YSetn0fKR2GS03N1crYtjqnRmD+9IsAGC
         mCleiGTxdGO2BJet+4sILK58yT92KSNZWsrY4TOgQAfkfJYJf5z9TjzfBX1b9sl9vVwG
         F6+vkDdTyENrutHeEocqMXwbUFfch9++CBAbINxG02lziV/DZ//vU0dqzXBoYD1Em/Go
         zaa85ykOPfAWglHUQtFqeMhsglnOf8J5cXGS4xz9SlnvTybyYr8faDFqltxq8G9YAtvz
         rQ3H6ky5UuzaG0UvnM4NnNLEe99aNVM3NL2XvHAOtiLHcdGM9SXvLcuraeJX10cjQmCl
         EhbA==
X-Gm-Message-State: AOAM533yuMN5NYxaCttmhtjHhJErXpMTUEUJEZXezZaHtPW634EYxppu
        Q0eE6DQkgGNP9SlL4R//hvI=
X-Google-Smtp-Source: ABdhPJxPaaAQYpEc5ygF97L3OTaz4pdkao2MeTKzDTDsRanNlKpSZDo2PXQ6qtYBL/VHoG08JxLHIg==
X-Received: by 2002:a17:90b:1950:: with SMTP id nk16mr5432835pjb.11.1628790686980;
        Thu, 12 Aug 2021 10:51:26 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:90ad])
        by smtp.gmail.com with ESMTPSA id 143sm4199446pfx.1.2021.08.12.10.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 10:51:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 Aug 2021 07:51:21 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRVfmWnOyPYl/okx@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
 <YRQhlPBqAlkJdowG@mtj.duckdns.org>
 <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e13a7b-6009-a9d7-41ba-aae82f5813de@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 11, 2021 at 01:22:20PM -0700, Bart Van Assche wrote:
> On 8/11/21 12:14 PM, Tejun Heo wrote:
> > On Wed, Aug 11, 2021 at 11:49:10AM -0700, Bart Van Assche wrote:
> > > You write that this isn't the right way to collect per cgroup stats. What is
> > > the "right way"? Has this been documented somewhere?
> > 
> > Well, there's nothing specific to mq-deadline or any other elevator or
> > controller about the stats that your patch collected and showed. That
> > seems like a pretty straight forward sign that it likely doens't
> > belong there.
> 
> Do you perhaps want these statistics to be reported via read-only cgroup
> attributes of a new cgroup policy that is independent of any particular I/O
> scheduler?

There's an almost fundamental conflict between ioprio and cgroup IO
control. bfq layers it so that ioprio classes define the global
priority above weights and then ioprio modifies the weights within
each class. mq-deadline isn't cgroup aware and who knows what kind of
priority inversions it's creating when its ioprio enforcement is
interacting with other cgroup controllers.

The problem is that as currently used, they're specifying the same
things - how IO should be distributed globally in the system, and
there's no right way to make the two configuration configuration
regimes agree on what should happen on the system.

I can see two paths forward:

1. Accept that ioprio isn't something which makes senes with cgroup IO
   control in a generic manner and approach it in per-configuration
   manner, either by doing whatever the specific combination decided
   to do with ioprio or ignoring it.

2. The only generic way to integrate ioprio and cgroup IO control
   would be nesting ioprio inside cgroup IO control, so that ioprio
   can express per-process priority within each cgroup. While this
   makes semantic sense and can be useful in certain scenarios, this
   is also a departure from how people have been using ioprio and it'd
   be involve quite a bit of effort and complexity, likely too much to
   be justified by its inherent usefulness.

Jens, what do you think?

Thanks.

-- 
tejun
