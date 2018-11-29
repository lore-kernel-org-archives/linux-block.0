Return-Path: <SRS0=Gm8i=OI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F4C43441
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EED208E7
	for <linux-block@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=scylladb-com.20150623.gappssmtp.com header.i=@scylladb-com.20150623.gappssmtp.com header.b="WAYPGIZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EED208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=scylladb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeK3BQE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:16:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39725 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK3BQE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Nov 2018 20:16:04 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so2046347wra.6
        for <linux-block@vger.kernel.org>; Thu, 29 Nov 2018 06:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=scylladb-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+lLFbF6pgf2k8lMd0Tku3OF/FqnaiVFLUlj1jJHnFkw=;
        b=WAYPGIZ1Gti4yYnwtE7awZQ/Hh9DteJ7bHayGNlOrO0/Cs40Q7Sw1jXL+yHVyRIDN5
         0nEbBOg3jkK3BZeuk8xwLdwUI1MWuvBiW1GGi6UAoRNALR44IINsWtTer0QY0HtkfVzq
         OxIKTaeBkikyhVgPNFsjQeMhWxRXpUk1+4Q//1zTN5q/ZFKZZUUQDX6C3sVwsFx3egFW
         xaEaseubBUbyjOZtY5MCJBJkJDL74W0bgH3FEphGYhf+oMQQDr54vGgUd8ACvIW86sMt
         aoNWC9MmR5KfQkILvnI7cKUPdu2Lf6g+qw9IKIFIoR+KA+Qmk7Jj3wktmKYpd84t4DvP
         /rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+lLFbF6pgf2k8lMd0Tku3OF/FqnaiVFLUlj1jJHnFkw=;
        b=XgJZGbhc5QeeVTsA+GahEU5P6qSVpgL6jfUFpJMYlUrlK8U67fwUuXjV6xzt87hp1J
         AZTcGfNg9dtaoECStcx5huQEJF20UF5W4VrNMa5dUEXWrx9ZIBAmo7M4uw80Mo3/B0Pk
         RElt53Jww0cl/lejDiW/tVeRkM9UxNiMddp+XWgAYN+yQz3p6rWJJkamep3OHBu8nTRi
         e3J1tBd6Ug8Vwg8UDhHwxBgSEDzF8x8oGUvp/8tnHwgV/4vHYQWUs6M2XI6e6d/P5Jg0
         IoUlio/FeupsMrrDRaGx6tLREHYFmXKDAJ0JJcEC7n8OFPy4wIDMCsTwmkXR6sYc1PYt
         TsmA==
X-Gm-Message-State: AA+aEWYMOvyWv+7Qzt5ENB2rJ0C7Es2zqxTU4s9mrEuxyHr071pi+dnD
        +2fBE2IGBu0lbru4k2HAoD2CuA==
X-Google-Smtp-Source: AFSGD/UaLWFbSpU8O8QKNKhXxQGJJa92R6bGkriGqQCav8LLwmZalEzan0wTb7492ANB9kT5K7j48g==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr1635889wrw.34.1543500633687;
        Thu, 29 Nov 2018 06:10:33 -0800 (PST)
Received: from bhalevy-lt (system.cloudius-systems.com. [199.203.229.89])
        by smtp.gmail.com with ESMTPSA id l3sm4583028wma.44.2018.11.29.06.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 06:10:32 -0800 (PST)
Message-ID: <1b49f7958c437878c5fc02cfb82c4ede1064bc08.camel@scylladb.com>
Subject: Re: [PATCH 17/20] aio: support for IO polling
From:   Benny Halevy <bhalevy@scylladb.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Thu, 29 Nov 2018 16:10:30 +0200
In-Reply-To: <c4fbcb50-edc2-2411-dfd4-fd4d05cf8c40@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
         <20181126164544.5699-18-axboe@kernel.dk>
         <69acea804eaf71f2d05b6ab649ecbf9bfd026447.camel@scylladb.com>
         <a58a7fd3-7994-0e30-40f7-f990a162205f@kernel.dk>
         <1b282e42a1573bbcba31bd628860b31ce9b60e5c.camel@scylladb.com>
         <c4fbcb50-edc2-2411-dfd4-fd4d05cf8c40@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 2018-11-28 at 11:50 -0700, Jens Axboe wrote:
> On 11/28/18 2:33 AM, Benny Halevy wrote:
> > > I don't see how we can get there with it being larger than already,
> > > that would be a big bug if we fill more events than userspace asked
> > > for.
> > > 
> > 
> > Currently we indeed can't, but if the code changes in the future and
> > we do, this will reduce the damage - hence being safer (and it costs
> > nothing in terms of performance).
> 
> The thing is, if we're ever over max, we have potentially corrupted user
> space memory by copying back too many events. So if anything, it should
> be a BUG() condition, not just a check.
> 

Agreed.


