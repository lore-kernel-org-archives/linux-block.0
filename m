Return-Path: <SRS0=7Y8O=O4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7680DC43387
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C68218A6
	for <linux-block@archiver.kernel.org>; Wed, 19 Dec 2018 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545248599;
	bh=83hFgoMpmrBI/TKxtchrnY/kyVj6bwBOrtIBQPIakSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nD2/y79YyBIGff+jl+e1C46RLv/CDdl4ulWHn8bgeLO3GBrfqOV3FCV1SD5c1d2sm
	 /PcVn9ZnBw2QbVGBFkCycq9zJYdaQDevmawyopZZ3RJtLYLTCZLNxwqtFPCVeHK9Uu
	 ZKTqsXWwmIJoTsg8KsG0r0faETSGYtOmyHlSqg0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbeLSTnS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Dec 2018 14:43:18 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:42824 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727790AbeLSTnS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Dec 2018 14:43:18 -0500
Received: by mail-qk1-f181.google.com with SMTP id 68so12380458qke.9
        for <linux-block@vger.kernel.org>; Wed, 19 Dec 2018 11:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0lRKyTqTE25A2YzS20XddHzuE+AM89ylvKP+t2QgBiY=;
        b=kJM6OawAL+Hcg0tG7ElLKr7nDDVOfyspYCwgYkgwiEzbgIlcZm2liOtFTPlAVTQlYK
         6Io81ZXbQ6aKlySYZ9jblOdKaMFtz68ta/1PXQeRP3cxbRiCqHb1sKg2+VEzIgGssCLw
         Mhe8Yr9baBXHeQd3oy7wfT/+iK4aJb4RO6HYpsB/naWRnbhEfsXhs+twHv5k9o+Kvq0x
         4Ea2ZUB/3J4d33NcVNEUQVPBIwH5vwrXWZGdHURqb6pjY0rtF4ppDKJDKPFlJrnPAq5i
         HAYj5kZtrjAGNBG71ftUTw9CoY6rqBV0w1iDzqWer0yGJ63MlLhl3Ym4iNYdOR+z5mU0
         Qdhw==
X-Gm-Message-State: AA+aEWY+KipNC5I9LZv1KtXy8U7ELrg/ksPvMr/kTmlugBdx/laAp2F/
        Ux+vyqQiCNPBmCYtwNcxcVs=
X-Google-Smtp-Source: AFSGD/XBXdsndeollVSA6s1bcPGA48F5IY9QbMyClF7Fax3M8ob0A7d9qOiSxfYDf2Up0nXwwlFEzw==
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr21569824qkl.70.1545248596092;
        Wed, 19 Dec 2018 11:43:16 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:180::1:5938])
        by smtp.gmail.com with ESMTPSA id f19sm2990375qtf.1.2018.12.19.11.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 11:43:15 -0800 (PST)
Date:   Wed, 19 Dec 2018 13:43:11 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Dennis Zhou <dennis@kernel.org>
Subject: Re: dm: don't reuse bio for flushes
Message-ID: <20181219194311.GA11497@dennisz-mbp.dhcp.thefacebook.com>
References: <a7e97e4b-0dd8-3a54-23b7-a0f27b17fde8@kernel.dk>
 <20181219161157.GA29426@redhat.com>
 <20181219161347.GB29426@redhat.com>
 <0f27031a-fcc1-c308-1127-7fa1404643b8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f27031a-fcc1-c308-1127-7fa1404643b8@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 19, 2018 at 09:14:25AM -0700, Jens Axboe wrote:
> On 12/19/18 9:13 AM, Mike Snitzer wrote:
> > On Wed, Dec 19 2018 at 11:11am -0500,
> > Mike Snitzer <snitzer@redhat.com> wrote:
> > 
> >> On Wed, Dec 19 2018 at 10:50am -0500,
> >> Jens Axboe <axboe@kernel.dk> wrote:
> >>
> >>> DM currently has a statically allocated bio that it uses to issue empty
> >>> flushes. It doesn't submit this bio, it just uses it for maintaining
> >>> state while setting up clones. Multiple users can access this bio at the
> >>> same time. This wasn't previously an issue, even if it was a bit iffy,
> >>> but with the blkg associations it can become one.
> >>>
> >>> We setup the blkg association, then clone bio's and submit, then remove
> >>> the blkg assocation again. But since we can have multiple tasks doing
> >>> this at the same time, against multiple blkg's, then we can either lose
> >>> references to a blkg, or put it twice. The latter causes complaints on
> >>> the percpu ref being <= 0 when released, and can cause use-after-free as
> >>> well. Ming reports that xfstest generic/475 triggers this:
> >>>
> >>> ------------[ cut here ]------------
> >>> percpu ref (blkg_release) <= 0 (0) after switching to atomic
> >>> WARNING: CPU: 13 PID: 0 at lib/percpu-refcount.c:155 percpu_ref_switch_to_atomic_rcu+0x2c9/0x4a0
> >>>
> >>> Switch to just using an on-stack bio for this, and get rid of the
> >>> embedded bio.
> >>>
> >>> Fixes: 5cdf2e3fea5e ("blkcg: associate blkg when associating a device")
> >>> Reported-by: Ming Lei <ming.lei@redhat.com>
> >>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >>
> >> Thanks for sorting this one out, definitely wasn't happy with how
> >> exposed DM was left with the recent blkg changes.  This is clearly
> >> better.
> >>
> >> Acked-by: Mike Snitzer <snitzer@redhat.com>
> > 
> > Please upgrade this to:
> > 
> > Reviewed-by: Mike Snitzer <snitzer@redhat.com>
> 
> Done, thanks Mike.
> 
> -- 
> Jens Axboe
> 

Thanks all of you for helping fix this issue! Apologies for introducing
with the initial change to dm.

Thanks,
Dennis
