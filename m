Return-Path: <SRS0=uopx=OM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF55EC04EB9
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D9F2145D
	for <linux-block@archiver.kernel.org>; Mon,  3 Dec 2018 22:52:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D9F2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbeLCWw0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:52:26 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37306 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeLCWw0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Dec 2018 17:52:26 -0500
Received: by mail-yw1-f68.google.com with SMTP id h193so6141919ywc.4;
        Mon, 03 Dec 2018 14:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qlsB2qxyDXoJ5/gKi66gGtq+F1sMq5v1Kd3Slw2sXdQ=;
        b=DrSgxjU+UXNHPRpWBMltuCpFSuTxFP9D1G13cMWIXmGzhMyDiw8LsuBbDCs5yUln3d
         d1xFves/r6aXIB/9M1aztxwjGF4CTmEaJ3UxzSlPymFspejMYkoJ58FfUgvQ/pQtVHiy
         WnoXYzPHYd5n9hbvgIjfxvvJqFq+ajG0zk7TsR+PX0aV2BT+Yl81J90tcD1+fe5ceyh/
         MzZ8CiORT/PQsjQmE7OKAVOHSXUMGFvvI0bCt+9CaCsaOpNVpL1xt1ty189VKY2RhUJx
         yrUurcefp2PmNultMEZGBruKwOXROrB7w5STxBa1/2YPwzwNab6Xr0nHvUML0NB0ewY+
         bvWQ==
X-Gm-Message-State: AA+aEWYYp/n8/6tnB2hj1KWRE7WuNrbLfzy11OPsMgP7M5k0tusHjJDu
        LVXJewLK1vEDDggGm9V9hQ8=
X-Google-Smtp-Source: AFSGD/V6kXmUFNr7zrmHRtYx7Wb/p1MnSkGVNctNAK3f2pLhKbCX/kVIaCJKqNZqiHG9j2VHkIS+0w==
X-Received: by 2002:a81:3184:: with SMTP id x126mr17920910ywx.448.1543877545496;
        Mon, 03 Dec 2018 14:52:25 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:e729])
        by smtp.gmail.com with ESMTPSA id p3sm4763471ywc.14.2018.12.03.14.52.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 14:52:24 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:52:22 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] blkcg: associate blkg when associating a device
Message-ID: <20181203225222.GA3801@dennisz-mbp.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-6-dennis@kernel.org>
 <20181130095426.GB17103@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181130095426.GB17103@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Nov 30, 2018 at 01:54:26AM -0800, Christoph Hellwig wrote:
> > diff --git a/include/linux/bio.h b/include/linux/bio.h
> > index 62715a5a4f32..8bc9d9b29fd3 100644
> > --- a/include/linux/bio.h
> > +++ b/include/linux/bio.h
> > @@ -486,6 +486,12 @@ extern unsigned int bvec_nr_vecs(unsigned short idx);
> >  extern const char *bio_devname(struct bio *bio, char *buffer);
> >  
> >  #define bio_set_dev(bio, bdev) 			\
> > +do {						\
> > +	bio_set_dev_only(bio, bdev);		\
> > +	bio_associate_blkg(bio);		\
> > +} while (0)
> > +
> > +#define bio_set_dev_only(bio, bdev)		\
> 
> This lacks any explanation on when you would use bio_set_dev_only or
> bio_set_dev.  Please document why we need both and why you'd choose or
> the other.

I realized after thinking about this more and checking more use cases
that it isn't as simple as swapping macro uses because many of the
callers share common bio allocation paths. I think the simplest way
forward is to have writeback and swap do reassociation and split out bio
init code in a future series. So in v5, there is only bio_set_dev().

Thanks,
Dennis
