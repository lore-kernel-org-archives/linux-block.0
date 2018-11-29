Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82834C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5590D21019
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5590D21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbeK3GzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:55:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37262 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeK3GzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 01:55:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so3399052qtq.4;
        Thu, 29 Nov 2018 11:48:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BR56+qJQYht+c/UF3lXH9JqG/9VgcGgo2mEFNDQ2gN4=;
        b=TVocFVkUGDUdkLL8Nz6/vqgKYr1mTVG1ee0CunqJpVqRMOYYyldCCDqcG6hebrBTz/
         oogZPFQgAcptRLn3rKm3ZMGHTwADhudWF0rpNLBDyQUUUM6824opeAvSogm939ytJGCE
         /opRtlW0Ss4aa/Ylp9udgIilNmfSlOOe4MIWJvgBmXwK9ZvXVpj/vX5R99M9ZLCPnmGH
         JgHMlIZG2+QhH+rSZj6O79oL034KA9wDRkVdqIRXdsGXUsBfU7Zuan+vqD3XEaQPtxpK
         SbM3AmkAj2p+FGeKBHRmea6My/DzdUMs6oOLImk66Bxmbml+4Bf5eXmJlm8peJYCWbd9
         zsZg==
X-Gm-Message-State: AA+aEWbVC+3fs+kUGTaIUEbj+z5L9h6Bc9Ib8bqHUdI1ThY3Zuc+DLgz
        9evsdWlM+26JtWWYus57ivI=
X-Google-Smtp-Source: AFSGD/UkHNU984FKR0oBXA0OxFcpZuleLdTqrLk/NkRxekKYQae8r1R/Xtwi2CJDbbGtzk+jrUnzew==
X-Received: by 2002:aed:202e:: with SMTP id 43mr2831430qta.27.1543520913295;
        Thu, 29 Nov 2018 11:48:33 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:3dcb])
        by smtp.gmail.com with ESMTPSA id m49sm1714135qtb.40.2018.11.29.11.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:48:32 -0800 (PST)
Date:   Thu, 29 Nov 2018 14:48:29 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] blkcg: introduce common blkg association logic
Message-ID: <20181129194829.GA95415@dennisz-mbp.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-5-dennis@kernel.org>
 <20181129154917.GD2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129154917.GD2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 07:49:17AM -0800, Tejun Heo wrote:
> On Mon, Nov 26, 2018 at 04:19:37PM -0500, Dennis Zhou wrote:
> > There are 3 ways blkg association can happen: association with the
> > current css, with the page css (swap), or from the wbc css (writeback).
> > 
> > This patch handles how association is done for the first case where we
> > are associating bsaed on the current css. If there is already a blkg
> > associated, the css will be reused and association will be redone as the
> > request_queue may have changed.
> > 
> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> A minor nit below.
> 
> > +/**
> > + * bio_associate_blkg - associate a bio with a blkg from q
> > + * @bio: target bio
> > + *
> > + * Associate @bio with the blkg found from the bio's css and request_queue.
> > + * If one is not found, bio_lookup_blkg() creates the blkg.  If a blkg is
> > + * already associated, the css is reused and association redone as the
> > + * request_queue may have changed.
> > + */
> > +void bio_associate_blkg(struct bio *bio)
> > +{
> > +	struct request_queue *q;
> > +	struct blkcg *blkcg;
> > +	struct blkcg_gq *blkg;
> > +
> > +	if (!bio_has_queue(bio))
> > +		return;
> 
> So, this isn't actually necessary cuz we don't stack with
> request_queues but it might be more consistent to call disassociate
> before returning above so that even if sth like that happens the
> function always guarantees that the blkg and bio agree.

Ah. That makes sense. I've changed bio_has_queue() to be
bio_blkg_association_check(). This calls disassociate and should handle
the case a bio transfers from a request_queue device to a bio driven
device. It changes the future patches slightly as we have to remember
the css before doing the check in case we want to reassociate with the
same css.

Thanks,
Dennis
