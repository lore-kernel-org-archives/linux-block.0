Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600C4C41604
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 16:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A8B20789
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 16:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V0u49emA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgJGQOI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 12:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42506 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726388AbgJGQOI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 7 Oct 2020 12:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602087246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tfkJfyc5VsN8uURZcR756j/GzbkrCjs03kIDnTtcdsE=;
        b=V0u49emARbFOIp2C0bWvDvTtcI1OK3U/YGSwIfVe9ZYeVZWwennkq3wZeDLn5+WvcYDIIO
        n4rsqTuTbEGyz0VJbKNDzpaCUJoTHb4wO550Uzppk9Yjlkb6Me0mnTkIfmLwv128Z3fhEf
        vSs9DnBviswczUBGgiByW4y9sx3+P2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-KQ_ypRxNNRSQ_XGJid0Mnw-1; Wed, 07 Oct 2020 12:14:04 -0400
X-MC-Unique: KQ_ypRxNNRSQ_XGJid0Mnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05B90196C900;
        Wed,  7 Oct 2020 16:14:03 +0000 (UTC)
Received: from gondolin (ovpn-112-246.ams2.redhat.com [10.36.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 747AB5D9DD;
        Wed,  7 Oct 2020 16:14:00 +0000 (UTC)
Date:   Wed, 7 Oct 2020 18:13:57 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com, vneethv@linux.ibm.com
Subject: Re: [PATCH 02/10] s390/cio: Provide Endpoint-Security Mode per CU
Message-ID: <20201007181357.7550dcb1.cohuck@redhat.com>
In-Reply-To: <3b721a6b-202e-d7e4-d4f2-2a3954f74609@linux.ibm.com>
References: <20201002193940.24012-1-sth@linux.ibm.com>
        <20201002193940.24012-3-sth@linux.ibm.com>
        <20201006164646.5b586679.cohuck@redhat.com>
        <3b721a6b-202e-d7e4-d4f2-2a3954f74609@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 7 Oct 2020 16:24:06 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Am 06.10.20 um 16:46 schrieb Cornelia Huck:
> > On Fri,  2 Oct 2020 21:39:32 +0200
> > Stefan Haberland <sth@linux.ibm.com> wrote:
> >  
> >> From: Vineeth Vijayan <vneethv@linux.ibm.com>
> >>
> >> Add an interface in the CIO layer to retrieve the information about the
> >> Endpoint-Security Mode (ESM) of the specified CU. The ESM values are
> >> defined as 0-None, 1-Authenticated or 2, 3-Encrypted.
> >>
> >> Reference-ID: IO1812
> >> Signed-off-by: Sebastian Ott <sebott@linux.ibm.com>
> >> [vneethv@linux.ibm.com: cleaned-up and modified description]
> >> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> >> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> >> Acked-by: Vasily Gorbik <gor@linux.ibm.com>
> >> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> >> ---
> >>  arch/s390/include/asm/cio.h |  1 +
> >>  drivers/s390/cio/chsc.c     | 83 +++++++++++++++++++++++++++++++++++++
> >>  2 files changed, 84 insertions(+)  
> >  
> > (...)
> >  
> >> +/**
> >> + * chsc_scud() - Store control-unit description.
> >> + * @cu:		number of the control-unit
> >> + * @esm:	8 1-byte endpoint security mode values
> >> + * @esm_valid:	validity mask for @esm
> >> + *
> >> + * Interface to retrieve information about the endpoint security
> >> + * modes for up to 8 paths of a control unit.
> >> + *
> >> + * Returns 0 on success.
> >> + */
> >> +int chsc_scud(u16 cu, u64 *esm, u8 *esm_valid)
> >> +{
> >> +	struct chsc_scud *scud = chsc_page;
> >> +	int ret;
> >> +  
> > I'm wondering if it would make sense to check in the chsc
> > characteristics whether that chsc is actually installed (if there's
> > actually a bit for it, although I'd expect so). Some existing chscs
> > check for bits in the characteristics, others don't. (Don't know
> > whether QEMU is the only platform that doesn't provide this chsc.)  
> 
> I don't see any benefit in checking upfront if the CHSC is supported -
> we'll get
> a corresponding CHSC response code and since no error message is logged
> for this
> case, the outcome would be the same as if we checked for the
> characteristics bit
> beforehand.

Yes, that's probably fine, then.

> 
> 
> >> +	spin_lock_irq(&chsc_page_lock);
> >> +	memset(chsc_page, 0, PAGE_SIZE);
> >> +	scud->request.length = SCUD_REQ_LEN;
> >> +	scud->request.code = SCUD_REQ_CMD;
> >> +	scud->fmt = 0;
> >> +	scud->cssid = 0;
> >> +	scud->first_cu = cu;
> >> +	scud->last_cu = cu;
> >> +
> >> +	ret = chsc(scud);
> >> +	if (!ret)
> >> +		ret = chsc_error_from_response(scud->response.code);
> >> +
> >> +	if (!ret && (scud->response.length <= 8 || scud->fmt_resp != 0
> >> +			|| !(scud->cudb[0].flags & 0x80)
> >> +			|| scud->cudb[0].cu != cu)) {
> >> +
> >> +		CIO_MSG_EVENT(2, "chsc: scud failed rc=%04x, L2=%04x "
> >> +			"FMT=%04x, cudb.flags=%02x, cudb.cu=%04x",
> >> +			scud->response.code, scud->response.length,
> >> +			scud->fmt_resp, scud->cudb[0].flags, scud->cudb[0].cu);
> >> +		ret = -EINVAL;
> >> +	}
> >> +
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	memcpy(esm, scud->cudb[0].esm, sizeof(*esm));
> >> +	*esm_valid = scud->cudb[0].esm_valid;
> >> +out:
> >> +	spin_unlock_irq(&chsc_page_lock);
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(chsc_scud);  
> 

FWIW,
Acked-by: Cornelia Huck <cohuck@redhat.com>

