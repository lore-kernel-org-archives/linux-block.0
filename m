Return-Path: <SRS0=kfbW=75=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB7C433DF
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F15F2071A
	for <linux-block@archiver.kernel.org>; Tue, 16 Jun 2020 02:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I35/37/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgFPCOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:14:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35415 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725978AbgFPCOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Jun 2020 22:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592273659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4RUZeodzwBkQbYZ2EaGfF5zzJQ7eWVo6NMQM8bMmyMI=;
        b=I35/37/Y3wwgcSOqg9lJ/pQst6SYqvUba1qW2aZF7By8IXKc5y8faCSDNHKn9lUSowfVJN
        aFSkxTf7gCunZtVlKSsbknBGUz/NuQvdiu2/Uf3bp9dRQ4CfQez9znrW5vKkImTJCRIfdX
        DFR/DYPGdPqE8Xa4Pp7DLLDMO+yYtYE=
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-55Q_EJoUPLCqOuZGcNBAWw-1; Mon, 15 Jun 2020 22:14:17 -0400
X-MC-Unique: 55Q_EJoUPLCqOuZGcNBAWw-1
Received: by mail-vk1-f200.google.com with SMTP id b10so4681162vkn.22
        for <linux-block@vger.kernel.org>; Mon, 15 Jun 2020 19:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RUZeodzwBkQbYZ2EaGfF5zzJQ7eWVo6NMQM8bMmyMI=;
        b=QDumvA3vicgoOFlJ1vpmFaZcUktjQ4VEoAWbmkRCd46O0caCJYcm+pkI8PxkpgnIsB
         VGEDoMU1wbmi7WcWtfCKJ72XAa/VfMNwxNkbq9AhcEwf7QAeJmx3rQPP+BnWD8dKYzSZ
         +4m3rXti+JJQM2+gX47kWDZBMbrnwUuB1Lh4e65IAiUNFAF1UOPDd88SbZYyc4cv90Je
         dyXUdq5sJ1ohTmb3ykzGJ3hQkmadgIokaHNsrv2rlF3Ie4BPq8YtxoyiP1sx7865ae2k
         p3n44VUp/NRGWrkRC5MB0+aLhmKe7oin4WqARhvN89E2bgotaQeml6Pgcxw5iRhgfif7
         DUaA==
X-Gm-Message-State: AOAM533I19CxhuH715qm0IyuG5RXVR17H8OZrzQSs0FL3cqjJdv3i++c
        BGjUQQT+Wq3Gu/bDY/3yshN7YQqhZ8/OytO+YSp2fwHUAWno86UgZxnFqDnqiZTU1Q6aBqadwRZ
        MPQwtAhLUHAwJaOzi4IVgTPAKDqgRjutl0NQPfcA=
X-Received: by 2002:a1f:930f:: with SMTP id v15mr66326vkd.63.1592273657282;
        Mon, 15 Jun 2020 19:14:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvm+pMqMQ9xAIih8To65kBLnL/G5bpsjaUOKlsjls+XbFBrfJXayN8h3oB3cg8tlHVIKFYh2+kH4rbad5XfaU=
X-Received: by 2002:a1f:930f:: with SMTP id v15mr66319vkd.63.1592273657050;
 Mon, 15 Jun 2020 19:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
In-Reply-To: <20200616005633.172804-1-harshadshirwadkar@gmail.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Mon, 15 Jun 2020 22:14:05 -0400
Message-ID: <CAMeeMh9X0zNSmyxaHCJCXT0m3eaeTzdJ=NZREXUgRmsfM1crsQ@mail.gmail.com>
Subject: Re: [PATCH] block: add split_alignment for request queue
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-block@vger.kernel.org, tytso@mit.edu,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

3 minor suggestions, and a larger question:

1) struct queue_limits already contains some alignment information;
e.g. discard_alignment, io_opt; perhaps this would better belong there
instead of in struct request_queue. (This would also move the
Documentation to Documentation/ABI/testing/sysfs-block)
2) Perhaps in parallel to discard_alignment this should be called io_alignment.
3) Documentation has consistent typo 'requeust'->request

Reading through this change, split_alignment appears similar in my
mind to limits->io_opt. But it does not actually appear to be factored
into bio splitting, although it's described as "A properly aligned
multiple of optimal_io_size is the preferred request size for
workloads where sustained throughput is desired"... probably I don't
understand the intended use of limits->io_opt, but it makes me wonder
if perhaps io_opt should be factored into bio splitting instead of
adding a new parameter? I am not very familiar with this area, and I'd
love to know more about what io_opt is for and how this proposal is
different.

Thanks!

John Dorminy

