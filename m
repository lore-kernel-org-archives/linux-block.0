Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C28FC433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 16:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0050204FD
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 16:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GTjj+zFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgHFQhB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgHFQfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 12:35:44 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC16C002143
        for <linux-block@vger.kernel.org>; Thu,  6 Aug 2020 09:26:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id b22so17460608oic.8
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=pxu3Wm2r5flCQF4ajF0ZQOQr9hhuPoaoinV7EW0aq9E=;
        b=GTjj+zFzoQZmBwTymYpv21TWX3X1mPMVhYZYpml3lzqF66dRI9FLoY4OyWywaV9lrk
         UYCjrudBk2SHIj92TS/Pk2H1caFBjfXCyzrlt1iA5shtbtylSfRorxusYKmCUfleHSxp
         3fYqJu+Lxe5Jv1d4ipoi91YDs9ffcPHNNEtko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=pxu3Wm2r5flCQF4ajF0ZQOQr9hhuPoaoinV7EW0aq9E=;
        b=es4zuih67ghZIjsHmaAbU7cMM8nY62LpXYyHIlAlwHeH8FPZPM11HNOwKSs4W2KdGm
         XGvvQdobKwBG+o1jcQPo2NXfgKsbigerhR9BwBJudWjUGYGRmwb1qDhggQdP1E67qdJa
         PqTyE0sySEldZQcNQqUsPiB5h4gSxS109ZLG9glqNMCzC2tvtJIHjtOQzHnQ+xQNtOl8
         Ky9jgUki4CXwhmGcR2IehbJIQsBFpWlfxcPSTW/2WBTJrf9wKyn970gzlHzkDLGAKikH
         f8BRNflGjuLeYSnZ5mUVbPjr4YKLJCJvkaC/QCMmXRU0qD5f4bnmsFLXfe9iAI2OEnnj
         +8xQ==
X-Gm-Message-State: AOAM531XofKn3b50KdAegUdFMGUQ0NSSftTKsJm9iDRWfIf+kz5swA5S
        e/v7lqX6ctWvgJIqYeM71xJC9QRF+AHz5NhkfQn4yZn7Hfg=
X-Google-Smtp-Source: ABdhPJzsu4+74unJwtfEF/ze3oQ7KrBdkPFX6BkXCd5uVPO+3TnTHDiRsh1vvpROH4ElAbCB7gVogQKaHJuNG8ljioY=
X-Received: by 2002:aca:b988:: with SMTP id j130mr2741951oif.87.1596731178760;
 Thu, 06 Aug 2020 09:26:18 -0700 (PDT)
From:   Muneendra Kumar M <muneendra.kumar@broadcom.com>
References: <1596507196-27417-1-git-send-email-muneendra.kumar@broadcom.com>
 <1596507196-27417-17-git-send-email-muneendra.kumar@broadcom.com>
 <61d2fd75-84ea-798b-aee9-b07957ac8f1b@suse.de> <08b9825b-6abb-c077-ac0d-bd63f10f2ac2@broadcom.com>
 <aa595605c2f776148e03a8e5dd69168a@mail.gmail.com> <227c5ba1-8a9c-3ec9-5a0f-662a4736c66f@redhat.com>
In-Reply-To: <227c5ba1-8a9c-3ec9-5a0f-662a4736c66f@redhat.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
thread-index: AQIDyhmBPqdmqCKUdNTZliBUbPkt/AI5BKetAom9APICL6c0jAMHD3TmAjtZC5OobtwMkA==
Date:   Thu, 6 Aug 2020 21:56:16 +0530
Message-ID: <b3350b999d5500ddef49a25aafee2ea6@mail.gmail.com>
Subject: RE: [RFC 16/16] lpfc: vmid: Introducing vmid in io path.
To:     Paolo Bonzini <pbonzini@redhat.com>,
        James Smart <james.smart@broadcom.com>,
        Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     emilne@redhat.com, mkumar@redhat.com,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        James Smart <jsmart2021@gmail.com>,
        Ming Lei <tom.leiming@gmail.com>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Paolo,

>3.As part of this interface user/deamon will provide the details of VM such
> as UUID,PID on VM creation to the transport .
>The VM process, or the container process, is likely to be unprivileged and
>cannot obtain the permissions needed to do this; therefore, you need to
>cope with the situation where there is no PID yet in the cgroup, because
>the tool >that created the VM or container might be initializing the
>cgroup, but it might not have started the VM yet.  In that case there would
>be no PID.

Agreed.A
small doubt. If the VM is started (running)then we can have the PID and   we
can use the  PID?

>Would it be possible to pass a file descriptor for the cgroup directory in
>sysfs, instead of the PID?
Yes we can do that.
>Also what would the kernel API look like for this?  Would it have to be
>driver-specific?

The API should be generic and it should not be driver-specific.


Regards,
Muneendra.
