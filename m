Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3261DC636D6
	for <linux-block@archiver.kernel.org>; Thu, 23 Feb 2023 19:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjBWTeu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Feb 2023 14:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjBWTet (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Feb 2023 14:34:49 -0500
Received: from mail-oa1-x64.google.com (mail-oa1-x64.google.com [IPv6:2001:4860:4864:20::64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369945192F
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 11:34:48 -0800 (PST)
Received: by mail-oa1-x64.google.com with SMTP id 586e51a60fabf-17227cba608so14169556fac.3
        for <linux-block@vger.kernel.org>; Thu, 23 Feb 2023 11:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b+c2IfHe67RI0XefnY3u42o+VPQ002zoityzko4BWLI=;
        b=A5Qap+J+qWCH04ogi8psUOwMo7Gk8HSTKonJwwVKQ93HUYla4mSQONJLz2UpeviQqp
         aT2qV7JuZPAE6UWEnxYxso75MxL0OkiZPZHNpZuxEJnx9tZqMB6blENHMnbNGv1P31Dv
         Riq8jtcmvHfQ8C6NFICLcaHCalhb9qxZzA9BPJ3ZOT0k4n+jvIYMaAxvNh+VxhPM7n/5
         l/NKZmvV/Exbs+IIozLq+sIrX5OtjmvRQNCbxlui5yKIipiVHFNgilPP+A7W4S5wa2sp
         h450AhG47BXV4sLQpruzvnX7sZOp76fl3aDcw6RgCyljanS9pJoKvpWgHth3JnWKfTWt
         M5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b+c2IfHe67RI0XefnY3u42o+VPQ002zoityzko4BWLI=;
        b=ftlHKzO4FoN0k0Bf6KPs6PvZOih5Ms4/Y5ZxBVv0mvp6IyQemaxMxyJJvsaYjrzn5P
         VBEPEdaMfeC+/humnCRpE1KvdtblXEpY4PcIGsDKfTJoFlMDcBGwP8mH26nGf60oGH6Z
         wnIhaBOC8R3QLejpvJBumsxShifMw9xkoHHdKIwvosX3B2ibClHJilH84hX0VuHR96S3
         OtJ+EsWlfriCMIeREH9PW/gvVPEHcFKM8cQdTukMp4xLeGfy1IThyZCLRfa/h6KuHkTK
         nxwGngzAs94DTwdx7Mriy6a9mkX7ZrjLnEGx8mrUP3nW79OUTbs4SS7xbuFATH6Pm4Vs
         P7Ww==
X-Gm-Message-State: AO0yUKXGZOFptAaui5nugnkVFzchTyu8yKM8t/WC4e6mKd6LQaw8KWOM
        NaxHmsfD1mqxBKQqifVRXkLA0mUf57jzO8xy9MaFZdUEs6oG0ov6r9UvRfki3rB/cw==
X-Google-Smtp-Source: AK7set9PnjCf3GmfWDCQz9R/1hGHmAu9w8Sm4q1irgE0/9e5vH/L0rOTLxgVJMt8XfRFT85U1rogPS2Hiyi7
X-Received: by 2002:a05:6871:10f:b0:169:bcbb:77b0 with SMTP id y15-20020a056871010f00b00169bcbb77b0mr9828238oab.25.1677180887488;
        Thu, 23 Feb 2023 11:34:47 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id w21-20020a056870a2d500b0017280f7d61asm253278oak.18.2023.02.23.11.34.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:34:47 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id CF3F020B59;
        Thu, 23 Feb 2023 12:34:46 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id CB2FCE41429; Thu, 23 Feb 2023 12:34:46 -0700 (MST)
Date:   Thu, 23 Feb 2023 12:34:46 -0700
From:   Uday Shankar <ushankar@purestorage.com>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <20230223193446.GA2719882@dev-ushankar.dev.purestorage.com>
References: <20230222185224.2484590-1-ushankar@purestorage.com>
 <Y/Zp8lb3yUiPUNBv@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/Zp8lb3yUiPUNBv@kbusch-mbp.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 22, 2023 at 12:16:02PM -0700, Keith Busch wrote:
> On Wed, Feb 22, 2023 at 11:52:25AM -0700, Uday Shankar wrote:
> >  static inline unsigned int blk_rq_get_max_segments(struct request *rq)
> >  {
> > -	if (req_op(rq) == REQ_OP_DISCARD)
> > -		return queue_max_discard_segments(rq->q);
> > -	return queue_max_segments(rq->q);
> > +	return blk_queue_get_max_segments(rq->q, req_op(rq));
> >  }
> 
> I think you should just move this function to blk.h instead of
> introducing a new one.

I chose to add blk_queue_get_max_segments as a public function because
it parallels blk_queue_get_max_sectors. If you don't want two functions,
I could manually inline the (2) uses of blk_rq_get_max_segments(rq),
converting them to blk_queue_get_max_segments(rq->q, req_op(rq)).
