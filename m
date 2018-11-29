Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF5CC43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CDF2145D
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 19:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CDF2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeK3HAp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 02:00:45 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44386 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeK3HAp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 02:00:45 -0500
Received: by mail-yw1-f65.google.com with SMTP id i22so973024ywa.11;
        Thu, 29 Nov 2018 11:54:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJ5okLZf6zf5iLP8VBExp3x933pXCM86os+NEW1YCCs=;
        b=X2a3aOYSot0rj75VGUd6zOKLsRlazknYvolDgvmMcmwRTDEboxwHEoD+NB5QhJbKbC
         9M4mv8mHvbTyVTSCXp5luIukDPGJwFpoOJeKZwYp76+10E4TGFAXyapuy+HJg1Za2lmB
         yUBzSgELFAv82ETOInR6lpvBDL2t5eU67kJF7LopjsGkomTxkHpG6cgQm1ZVnNPeXFb0
         EDbk8abku+rK/joEaBSl9xCHy4ia7oDh7SxPejyZhAq7hr+a3FOVNioe50NHs2aGtZMG
         WveEu1YiM/N9bf02u9ftMT65aCbbTnVlrzWptiMWykYEa3ByF2N2b3T6cKXiRdE6Sxvw
         eoLQ==
X-Gm-Message-State: AA+aEWbo3YZoUcY3c5F19DA+krbGRHCRqth4Lky7bK/deOEpvbPs9937
        uM37xhXyLj+iSkIcEb8DxNU=
X-Google-Smtp-Source: AFSGD/UbcAQDjikaE00QePAp71HHjg5SSE/JVdwgaHk2609/209gW1pnCDytxVLADqSHY0cFtqh1dg==
X-Received: by 2002:a81:7102:: with SMTP id m2mr2789225ywc.235.1543521250770;
        Thu, 29 Nov 2018 11:54:10 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::7:3dcb])
        by smtp.gmail.com with ESMTPSA id m66sm682997ywc.37.2018.11.29.11.54.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 11:54:10 -0800 (PST)
Date:   Thu, 29 Nov 2018 14:54:07 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] blkcg: associate blkg when associating a device
Message-ID: <20181129195407.GB95415@dennisz-mbp.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-6-dennis@kernel.org>
 <20181129155333.GE2509588@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129155333.GE2509588@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 29, 2018 at 07:53:33AM -0800, Tejun Heo wrote:
> On Mon, Nov 26, 2018 at 04:19:38PM -0500, Dennis Zhou wrote:
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
> >  do {						\
> >  	if ((bio)->bi_disk != (bdev)->bd_disk)	\
> >  		bio_clear_flag(bio, BIO_THROTTLED);\
> 
> Generally looks okay to me but I'm not sure about bio_set_dev_only().
> Maybe sth more explicit like bio_set_dev_without_blkg()?  Also, can
> you please add comments explaining which should be used when?
> 

I've switched it to bio_set_dev_without_blkg() and added the comment
below and added a comment in the use cases. Let me know if the wording
is fine below.

+/*
+ * Bio device setters.  A blkg represents the relationship between a blkcg
+ * and a request_queue.  When the device is set for a bio, it becomes possible
+ * to do blkg association.  Importantly, a blkg also holds a pointer back to
+ * the request_queue.  In general, bio_set_dev() should be used to keep
+ * bio->bi_disk->queue and bio->bi_blkg->q consistent.  If blkg association
+ * will be done explicitly or is a bio based device, use
+ * bio_set_dev_without_blkg().
+ */

Thanks,
Dennis
