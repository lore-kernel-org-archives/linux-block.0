Return-Path: <SRS0=VRLd=OT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B962C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205592082F
	for <linux-block@archiver.kernel.org>; Mon, 10 Dec 2018 16:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 205592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeLJQRH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:17:07 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44841 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeLJQRH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 11:17:07 -0500
Received: by mail-qt1-f193.google.com with SMTP id n32so12856923qte.11
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 08:17:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLCZ/dfizqcpzJOJ82nnvzaSVI6NoLk/H1vjEmCHydg=;
        b=tx38AFrHHZZ3NFEs6dEuDcx75JShP1W1JKK851lx6sFn/1Tz2gp3vQqMAdC33S6z/C
         ezpQkt1FOCfv1nkhc/MkGZAUzIzDRpa4NtFiBovWyGWcRc3zMpSCR3aYYQkGNlKDl20H
         rdZQw4dFBA74FUS4wDisckcGl3OARtRmVp3L/CSvCeO3/dwRK2Vjh7gt4hg7DbUcFX/U
         qjxnkMSMcnPvnGTDwbOyNBMtU4AQFpzSa9ru+FqzkmPet6fFP1Jnzq388Dmz+XekJ93i
         hwCEosj7hOQ3Vwq4WvgUraiSP+9+FCO+f7H0hkFgaYg0JTOlfW++OD1T8UDsP0TpzbFo
         X2uA==
X-Gm-Message-State: AA+aEWZGShhyNW34QlmGwluwfwDvUgcpA8Hb9nDlQEjf9ssOFxw9XTR1
        Y6A4EZUlO1yu4KhIQcD//DJnFA==
X-Google-Smtp-Source: AFSGD/VOAdKHjcH0i0WGdeOC6hAlPNdTwIKKVSZp1PXxsCv00LV54VVkhUO4twe+B77KpAn8Rw1/XA==
X-Received: by 2002:a0c:f74c:: with SMTP id e12mr12195090qvo.26.1544458626309;
        Mon, 10 Dec 2018 08:17:06 -0800 (PST)
Received: from loberhel74 (035-134-022-126.static.chtrptr.net. [35.134.22.126])
        by smtp.gmail.com with ESMTPSA id b20sm8162852qkb.17.2018.12.10.08.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 08:17:05 -0800 (PST)
Message-ID: <1544458624.18488.2.camel@redhat.com>
Subject: Re: [PATCH] block: Restore tape support
From:   Laurence Oberman <loberman@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Todd Aiken <taiken@mvtech.ca>, stable@vger.kernel.org
Date:   Mon, 10 Dec 2018 11:17:04 -0500
In-Reply-To: <93112026-a6b3-6db4-0c74-afbbbf6ca493@kernel.dk>
References: <20181210030814.13235-1-bvanassche@acm.org>
         <20181210153230.GB25206@localhost.localdomain>
         <93112026-a6b3-6db4-0c74-afbbbf6ca493@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 2018-12-10 at 08:36 -0700, Jens Axboe wrote:
> On 12/10/18 8:32 AM, Keith Busch wrote:
> > On Sun, Dec 09, 2018 at 07:08:14PM -0800, Bart Van Assche wrote:
> > > According to what I found in
> > > https://bugzilla.kernel.org/show_bug.cgi?id=201935 patch "block:
> > > Clear
> > > kernel memory before copying to user" broke tape access. Hence
> > > revert
> > > that patch.
> > 
> > Instead of reverting back to the leaking arbitrary kernel memory,
> > why
> > not just make a fix on top of it? This should do it:
> > 
> > ---
> > diff --git a/block/bio.c b/block/bio.c
> > index c4ef8aa46452..55a5386fd431 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1262,7 +1262,8 @@ struct bio *bio_copy_user_iov(struct
> > request_queue *q,
> >  		if (ret)
> >  			goto cleanup;
> >  	} else {
> > -		zero_fill_bio(bio);
> > +		if (bmd->is_our_pages)
> > +			zero_fill_bio(bio);
> >  		iov_iter_advance(iter, bio->bi_iter.bi_size);
> >  	}
> >  
> 
> That should be fine, the other case is user mapped memory anyway.
> 

OK, I will test this today
Thanks folks!!
Laurence
