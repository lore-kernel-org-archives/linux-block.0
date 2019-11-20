Return-Path: <SRS0=usZV=ZM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6329C43215
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 21:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742B420672
	for <linux-block@archiver.kernel.org>; Wed, 20 Nov 2019 21:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QtCd1255"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKTV6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Nov 2019 16:58:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46876 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKTV6n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Nov 2019 16:58:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so1765813wrs.13
        for <linux-block@vger.kernel.org>; Wed, 20 Nov 2019 13:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:mime-version:thread-index:date:message-id:subject:to:cc;
        bh=p8LCe9JWGcvpS2ewyZOiDIpe5TyhQwLY0HM6jhprWQw=;
        b=QtCd1255MUFcdBLBBfNmjNjzGPGgAfsCixZsPaR4oYW+L0msGLFHRvtAlW4HuEU8mO
         GJWCZfSIztiQNh94q5zlOaOQEjSHj/D9W3RVY9znxUBSlQKjHgFxCGMiQPyz9Z9kozhU
         X4Me1HPZ64r285gtMVmbHufCRm11UFI1X2LEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:thread-index:date:message-id
         :subject:to:cc;
        bh=p8LCe9JWGcvpS2ewyZOiDIpe5TyhQwLY0HM6jhprWQw=;
        b=SNSqATzrNSONA4G06GJjEhld4xMRuJ4c3Ir3vMorYc8ub3F7fpIg4C/ECP/7bKcFjY
         N7HijvnUmP7v/psvet1JiPDg/RPd0I98dRK1cmzmOv8JQShtXDWigYFwzV794Nyc+sn/
         6kFP1Io/xftg/kX5X6j9344bEzaDG0K11FTGngFBQx0DUXe0fcKAYrCbHxs4Uye2YcU/
         ss0I46O4mktSOib8IxhWxgypi1vIBi090FxWQS3mSJ1S96bWuDsnp/YsVHlHALgR2NzQ
         9pXhtUfkpL+1/vluS8uzaJah6AzeYx+ANq163NWG3mR0NyC9pOnlAlau0NWbfWSeh2o/
         Mbrw==
X-Gm-Message-State: APjAAAVh1Dwewy/l79aB4lCZnioQI++Nu+EqZIRiwbyjPEi/r0RiHfOZ
        gVhvp2JDNTqTPMKcRMoWGSEJy0GXDO3UoxcWvFjNEg==
X-Google-Smtp-Source: APXvYqzSWKnd2Ge6i6FzlvK3By3OqKebKKjL+WI9yB2uVL4o+4QIYjH2ELHEzEHQfn14hxHtyyXdJ7+SdO+YwZ8AR/w=
X-Received: by 2002:adf:eecc:: with SMTP id a12mr6143155wrp.363.1574287121644;
 Wed, 20 Nov 2019 13:58:41 -0800 (PST)
From:   Sumanesh Samanta <sumanesh.samanta@broadcom.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdWf7SRsTAXNfNyfSv6Y9At6URzH3g==
Date:   Wed, 20 Nov 2019 14:58:40 -0700
Message-ID: <c7c78e42173ad8bc6e8c775bf6e98f54@mail.gmail.com>
Subject: Re: [PATCH 4/4] scsi: core: don't limit per-LUN queue depth for SSD
To:     emilne@redhat.com
Cc:     axboe@kernel.dk, bart.vanassche@wdc.com, hare@suse.de, hch@lst.de,
        jejb@linux.ibm.com, kashyap.desai@broadcom.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com,
        sathya.prakash@broadcom.com,
        shivasharan.srikanteshwara@broadcom.com,
        suganath-prabu.subramani@broadcom.com, sumit.saxena@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>Ordinarily I'd prefer a host template attribute as Sumanesh proposed,
>but I dislike wrapping the examination of that and the queue flag in
>a macro that makes it not obvious how the behavior is affected.

I think we can have a host template attribute and discard this check
altogether, that is not check device_busy for both SDD and HDDs.

As both you and Hannes mentioned, this change affects high end controllers
most, and most of them have some storage IO size limit. Also, for HDD
sequential IO is almost always large and
touch the controller max IO size limit. Thus, I am not sure merge matters
for these kind of controllers. Database use REDO log and small sequential
IO, but those are targeted to SSDs, where latency and IOPs are far more
important than IO merging.
If this patch is opt-in for drivers, so any LLD that cannot take advantage
of the flag need not set it, and would work as-is


Thanks,
Sumanesh
