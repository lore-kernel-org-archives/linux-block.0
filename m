Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE11C432BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AFA56054F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhHKTO6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhHKTO5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:14:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18589C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:14:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nt11so5117734pjb.2
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mI0xCA0y14IHzP6QYohNKLdzsHPCu7+sFrB2dsN2C3I=;
        b=Pf7fC8h7/nwlROoUridTyS354Y46+UwuCtod9/T6ASDU/Ib7OpwrL1Hcqkpbc10uw2
         eX19tni/8LToEgLCMr90GfVzG4q2D9vDKvo+QWOUHAmFnliSjS1oaqrjml8pSlRqebEC
         mLxPWXKirVG/QzB7u7BVKD69id9mZJOrh2VtVpKVULkybjAHaariQcM8Q0pP4nESDcks
         O4yBMGp9X2HiKZEUviDL06gMDjhTWVNaDY+n7zcHRwVDB6ukM5i8DRW7pfpx+rOE3AYT
         pfrncaxt4AmhZnmMWk7YDEFt43tCbmfil4TkZZ5sceJfTCl0tFbhLkbE+bUxGYORkFPC
         Tbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mI0xCA0y14IHzP6QYohNKLdzsHPCu7+sFrB2dsN2C3I=;
        b=Re4F0q8MQDv65smHgYBOcA1biWqC5OhnaKixQW3sedb4X/+dHdWMKXvXKlbu+A5AUp
         pHeFYbpGaWk8rKEuYlMwbNhraCVI92bozVsUNiPnpAVe+au5UBux0pJ+U2GHPEkH3LKe
         fEsPxE3i41H7YHtFEdoj5MRbj+V4K48MRR1P6cOEDK2hbscDOvIcg9j4l0DLl5FON2Pi
         ox/NX9ryOeJjbT8gyosD8Qv/BmeOTOCh1F8xKvggaWLAodNRljrvJwohZ0fI7CRg3znr
         nGWuapaoPox71uanq6Il2tRM7w4TVMjNlc0tKJE8XkN+G3IHFx+FoHYJnodTvofeRntb
         9i7A==
X-Gm-Message-State: AOAM532WklBjP4cvKft2dycHnC7pwHWBbeL8pQh+g2bkotsmpCnbKG9w
        rIHRyJ+NmCndhqQxT/sbVwQ=
X-Google-Smtp-Source: ABdhPJxsSuAKa1EpP5R25R8jpfH1z8EBthr6OQh3O+MOeEUHt0Gb2kGHfu8G/Gca2pnIoPhytMT6lg==
X-Received: by 2002:a17:90b:903:: with SMTP id bo3mr72773pjb.103.1628709273453;
        Wed, 11 Aug 2021 12:14:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:69c0])
        by smtp.gmail.com with ESMTPSA id u3sm310665pfn.76.2021.08.11.12.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:14:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 11 Aug 2021 09:14:28 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH block-5.14] Revert "block/mq-deadline: Add cgroup support"
Message-ID: <YRQhlPBqAlkJdowG@mtj.duckdns.org>
References: <YRQL2dlLsQ6mGNtz@slm.duckdns.org>
 <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <035f8334-3b69-667d-be91-92dcab9dc887@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Bart.

On Wed, Aug 11, 2021 at 11:49:10AM -0700, Bart Van Assche wrote:
> Agreed that I should have Cc-ed you on the cgroup patches. But where were
> you while my mq-deadline patch series was out for review? The first version
> of that patch series was published on May 27 and the patch series was merged
> on June 21 so there was almost one month time to post review feedback.

Regardless of where I've been, I can't really review things which
don't show up in my radar. The patches didn't even cc cgroups mailing
list. How would I know that I needed to review the patches?

> Additionally, the above description is not very helpful. If it is not
> allowed to add custom elements by adding more pd_stat_fn callbacks, why does
> that callback even exist? Why does the cgroup core not complain if a new
> policy is registered that defines a pd_stat_fn callback?

That part of the comment was on the specific fomatting that you used.
cgroup interface files follow a few styles to stay consistent and ease
parsing. Please refer to Documentation/admin-guide/cgroup-v2.rst.

> You write that this isn't the right way to collect per cgroup stats. What is
> the "right way"? Has this been documented somewhere?

Well, there's nothing specific to mq-deadline or any other elevator or
controller about the stats that your patch collected and showed. That
seems like a pretty straight forward sign that it likely doens't
belong there.

Thanks.

-- 
tejun
