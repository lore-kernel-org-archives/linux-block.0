Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C4FC4363D
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 01:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB320702
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 01:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXAEdPoi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgIXBOw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 21:14:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbgIXBOt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 21:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600910088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iLPgQGmbsi3dRQl4vR2+yVWsGwwYnOOutjgSUnEufxw=;
        b=XXAEdPoigw/KaWKhND0J7031YW+YeVx2Yc2avOFqaJbpXg1vXh6jEeHUXllUAyEsLjbecD
        9D8zvspltYZOf2m85ZBYyLgIpbRql7ymePWIUPutT1c5RUcmyZvhpsD9Yg6bg09SFo6RRa
        YpJ4yVm5MIPOkyjt/S0++rkyfKW1uHI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-nERBH4F-NZWTHHtTbvA6LA-1; Wed, 23 Sep 2020 21:14:44 -0400
X-MC-Unique: nERBH4F-NZWTHHtTbvA6LA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D671910066FE;
        Thu, 24 Sep 2020 01:14:42 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A419873692;
        Thu, 24 Sep 2020 01:14:39 +0000 (UTC)
Date:   Wed, 23 Sep 2020 21:14:39 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924011438.GD10500@redhat.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200922003255.GC32959@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922003255.GC32959@sol.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 21 2020 at  8:32pm -0400,
Eric Biggers <ebiggers@kernel.org> wrote:

> On Wed, Sep 09, 2020 at 11:44:21PM +0000, Satya Tangirala wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Update the device-mapper core to support exposing the inline crypto
> > support of the underlying device(s) through the device-mapper device.
> > 
> > This works by creating a "passthrough keyslot manager" for the dm
> > device, which declares support for encryption settings which all
> > underlying devices support.  When a supported setting is used, the bio
> > cloning code handles cloning the crypto context to the bios for all the
> > underlying devices.  When an unsupported setting is used, the blk-crypto
> > fallback is used as usual.
> > 
> > Crypto support on each underlying device is ignored unless the
> > corresponding dm target opts into exposing it.  This is needed because
> > for inline crypto to semantically operate on the original bio, the data
> > must not be transformed by the dm target.  Thus, targets like dm-linear
> > can expose crypto support of the underlying device, but targets like
> > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > 
> > When a key is evicted from the dm device, it is evicted from all
> > underlying devices.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Co-developed-by: Satya Tangirala <satyat@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> Looks good as far as Satya's changes from my original patch are concerned.
> 
> Can the device-mapper maintainers take a look at this?

In general it looks like these changes were implemented very carefully
and are reasonable if we _really_ want to enable passing through inline
crypto.

I do have concerns about the inability to handle changes at runtime (due
to a table reload that introduces new devices without the encryption
settings the existing devices in the table are using).  But the fallback
mechanism saves it from being a complete non-starter.

Can you help me better understand the expected consumer of this code?
If you have something _real_ please be explicit.  It makes justifying
supporting niche code like this more tolerable.

Thanks,
Mike

