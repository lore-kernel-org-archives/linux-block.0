Return-Path: <SRS0=FzxQ=5P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0411C43331
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 10:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75F920732
	for <linux-block@archiver.kernel.org>; Mon, 30 Mar 2020 10:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="VQHbi9zX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgC3KMN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:12:13 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40089 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbgC3KMM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Mar 2020 06:12:12 -0400
Received: by mail-io1-f67.google.com with SMTP id k9so17131964iov.7
        for <linux-block@vger.kernel.org>; Mon, 30 Mar 2020 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UCRav7GgrcqxbKA+bkkvE0NHFZyJUCyRM124ao2KOc=;
        b=VQHbi9zX6v2tgR3F4FbwxOPzjsF0FFhEELvhGotVCxdIrK/VsF0VqvyB8bAAonLx71
         0/7hOeVqkX2wO/G8v4+7SVRxz+BlP8S10+EFsMdiHX0Rw9eVIvD5t0aTx7z21JWzIdzw
         Wstca7pWtndZ0EXxDhan6vWbu5FC6ScdolzK9ZYMcVsrSH7q4Twst5HVGcsd0j2aLAQW
         mnTrdJzV89HgUmJwatM7aLY0AZkh/o+2yTNKxaU9IZm+M/EfX513qaxcb0qSY+E993qN
         5gcJGk2AabpIKt7SISUlliLUAYKHnRM/x7CF/7Hj7Zz5CJrFlHehjB4uNZrNEBOg0P3g
         3hfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UCRav7GgrcqxbKA+bkkvE0NHFZyJUCyRM124ao2KOc=;
        b=L2F91QcmK/P6JiYsOGfkRMryj7uVN1fAntIMe0J9W51eWhgSW7auV0zERZp3GDNTaC
         qCh8ZQ2oHWkL6W0xgUxNOGzjbJI/gSd3h6ItEBhThyS3YmksIc8oXdnGfZMLkbBeS4RA
         qHpobKc9shQx4Nsg+BiOJBfIGrbGmSymFMNIGKjsoEmqCazUgVsR66WwCbxctJnSwDWX
         DPNVEJgRXpGHiatPFwsUkUagsbEoqBdpJAGT2HulhZFOklAApFwFQyFiDnuIUze9Cm6x
         qNOr8UUi9w49glkAv0MbN2IzxIkShdNmKDjjwaLJbeZV0NnVff+IJoVAkC/tlVR6mu4j
         9jZA==
X-Gm-Message-State: ANhLgQ38av+XZmlGoTSsrNZPbWLWH2t3A+pt4FK8XOg/Xqs5fr1N/CUe
        5+6RYmNsA787RP3zn4WJIJovDL9u5TBGpCtY5YRA
X-Google-Smtp-Source: ADFU+vtT/GzRj1IXMIIpOT0PCASeot7yQEOEIH9W1EjB22I3LJCML5DIXJ3AjRS1iId3GK6kSKro03O/3YFC1zRgFxQ=
X-Received: by 2002:a02:3842:: with SMTP id v2mr10268615jae.9.1585563131996;
 Mon, 30 Mar 2020 03:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
 <20200320121657.1165-27-jinpu.wang@cloud.ionos.com> <7e9a4b85-1062-da29-db8e-9298dc71719d@acm.org>
In-Reply-To: <7e9a4b85-1062-da29-db8e-9298dc71719d@acm.org>
From:   Danil Kipnis <danil.kipnis@cloud.ionos.com>
Date:   Mon, 30 Mar 2020 12:12:01 +0200
Message-ID: <CAHg0HuyU_WiwJD6+9=ZG_5pKNsjBXBtv7SnRxYdW4RjtKPwXHw@mail.gmail.com>
Subject: Re: [PATCH v11 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS modules
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jack Wang <jinpu.wang@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Mar 28, 2020 at 8:40 PM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 2020-03-20 05:16, Jack Wang wrote:
> > Danil and I will maintain RNBD/RTRS modules.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Thanks.
