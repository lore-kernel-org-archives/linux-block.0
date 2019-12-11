Return-Path: <SRS0=X6jZ=2B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B4C43603
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DACA208C3
	for <linux-block@archiver.kernel.org>; Wed, 11 Dec 2019 11:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UujeKlbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfLKLwb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:52:31 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43162 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLwb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Dec 2019 06:52:31 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so1693034pfe.10;
        Wed, 11 Dec 2019 03:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=9TzCrnHA+PZn9B0VHl+C0w3viSNbDpi/JT9IW5C14J8=;
        b=UujeKlbA/oBu+duQfpkaL3iWHAaBqMPrF7H0W7jQ+M/FQL4G8ixiotVWbhuZwA6mje
         Kx9jOIhtvj/I2DcfkoMtR8dyzOO3+OnUz9MaH9Gf+2CTOpM/EmBjjs7i3p5ZuAiLz0Ea
         08BRxmfZ06lHEMLrJFwYdFLInSybAcbbSP79HbIPXp/jNwUqmTJQMhs1kJOSQvz9dPgx
         v8ocNEB/RvbIWTs+3dT10kmLBlKe//mmrJeEhqfBvfJgRwHK7fPPaHlfYEOqaKUYj8A0
         tzby5AOae+q83G01Pk6UoxEzeAAeSK/78cvydpBgx/IpBBS7yMDcDZ6OSN0cTCYKvdkH
         VAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=9TzCrnHA+PZn9B0VHl+C0w3viSNbDpi/JT9IW5C14J8=;
        b=L9osX1Er4IKj7XhkkrTP5xMYKa12hau28kHjrF/bufogp5rdO/htVLuBYMBr+Rcpjz
         ePGhwpDP0abVTOPOc/alDNR3qa6Uuk8a7swLYPhPSd0soFiarbFMLIc9sD3gLKYXmMfZ
         +JAvCEibV4YtAEYwz6CorJ/yll3ESTcU87/9qRsVbaQhn2dhGxc5M+3yIslJAsQKuzcD
         cxKOHxgS3g3GxjyGY3S/eANCJD861Tv1ERCfziE5hultzGm8QAM4m+Kg5AkSYRwo1gwB
         nVqmsFiMIj2V+osSfP4V0jD82pvwTnqVic0QK1rDn2IxWShIkmGzXWrkW6GiYFy4vIF9
         Vxcw==
X-Gm-Message-State: APjAAAXY9nRBCvrI4aGZ/KnWOB0Sro/82IClodf1EZU/RqwyfZw0xWbe
        VAsrxW6nklaiNFraIr5X7Pk=
X-Google-Smtp-Source: APXvYqyNHh8Lss6GwxUzuzRZ0u3f0WdVaw5JqFj3HHSzfVMHuFQva6NtQ4sf40djNyzLYKQO1ZtFJg==
X-Received: by 2002:a63:1c02:: with SMTP id c2mr3589205pgc.175.1576065150783;
        Wed, 11 Dec 2019 03:52:30 -0800 (PST)
Received: from localhost.localdomain ([12.176.148.120])
        by smtp.gmail.com with ESMTPSA id g18sm2921000pfi.80.2019.12.11.03.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Dec 2019 03:52:30 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Cc:     sjpark@amazon.com, axboe@kernel.dk, konrad.wilk@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        pdurrant@amazon.com, xen-devel@lists.xenproject.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: Re: [PATCH v5 1/2] xenbus/backend: Add memory pressure handler callback
Date:   Wed, 11 Dec 2019 12:52:08 +0100
Message-Id: <20191211115208.14583-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
In-Reply-To: <20191211105112.GK980@Air-de-Roger> (raw)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 11 Dec 2019 11:51:12 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:

> > On Tue, 10 Dec 2019 11:16:35 +0100 "Roger Pau Monné" <roger.pau@citrix.com> wrote:
> > > > diff --git a/include/xen/xenbus.h b/include/xen/xenbus.h
> > > > index 869c816d5f8c..cdb075e4182f 100644
> > > > --- a/include/xen/xenbus.h
> > > > +++ b/include/xen/xenbus.h
> > > > @@ -104,6 +104,7 @@ struct xenbus_driver {
> > > >  	struct device_driver driver;
> > > >  	int (*read_otherend_details)(struct xenbus_device *dev);
> > > >  	int (*is_ready)(struct xenbus_device *dev);
> > > > +	unsigned (*reclaim)(struct xenbus_device *dev);
> > > 
> > > ... hence I wonder why it's returning an unsigned when it's just
> > > ignored.
> > > 
> > > IMO it should return an int to signal errors, and the return should be
> > > ignored.
> > 
> > I first thought similarly and set the callback to return something.  However,
> > as this callback is called to simply notify the memory pressure and ask the
> > driver to free its memory as many as possible, I couldn't easily imagine what
> > kind of errors that need to be handled by its caller can occur in the callback,
> > especially because current blkback's callback implementation has no such error.
> > So, if you and others agree, I would like to simply set the return type to
> > 'void' for now and defer the error handling to a future change.
> 
> Yes, I also wondered the same, but seeing you returned an integer I
> assumed there was interest in returning some kind of value. If there's
> nothing to return let's just make it void.
> 
> > > 
> > > Also, I think it would preferable for this function to take an extra
> > > parameter to describe the resource the driver should attempt to free
> > > (ie: memory or interrupts for example). I'm however not able to find
> > > any existing Linux type to describe such resources.
> > 
> > Yes, such extention would be the right direction.  However, because there is no
> > existing Linux type to describe the type of resources to reclaim as you also
> > mentioned, there could be many different opinions about its implementation
> > detail.  In my opinion, it could be also possible to simply add another
> > callback for another resource type.  That said, because currently we have an
> > use case and an implementation for the memory pressure only, I would like to
> > let it as is for now and defer the extension as a future work, if you and
> > others have no objection.
> 
> Ack, can I please ask the callback to be named reclaim_memory or some
> such then?

Yes, I will change the name.


Thanks,
SeongJae Park

> 
> Thanks, Roger.
> 
