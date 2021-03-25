Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DCBC433DB
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 02:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55BE261A21
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 02:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbhCYCKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 22:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhCYCJz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 22:09:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA793C06174A
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 19:09:55 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l1so270508pgb.5
        for <linux-block@vger.kernel.org>; Wed, 24 Mar 2021 19:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GnPkrUWVHgQAkE7X9Q+gS1Rm0hw8IZfxa51KQLQaH2w=;
        b=APFhGsnvbabBnyPJKGOX/84vrQW9EE5xS06+iv5qV4t5nvQXqDViUjmAOjrVJiQj2J
         Cwk+AkMAfN0PR8vAIY4ARrwsy01cSc8001Z/eiEnv4CMGx1Sle1hJjyRaI5MwvmcdUV+
         jwb7leeD0C8/Dncxzlsp3Qip4Xy8WCg9HhV5axzjsXIFNNB4xxz0AYT4sI6EUrK95bKy
         FUnkX3OT5sJJBF0Uaz23lAJeBGJ1hD5XM+icNGNHkdOR8RHuOtovNLF3Veas4WXp2QNv
         HMQTB85iKg+HFOq4gS2TQCnMWMAG9ebH2mUWblX3DMNFJdLP/T/HOxkoReTfwUpKQVH8
         /97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GnPkrUWVHgQAkE7X9Q+gS1Rm0hw8IZfxa51KQLQaH2w=;
        b=fYNvKVJRWHt+ELazMgz95cmQ9w1qyFAZsfFNRfF41Uqr6TM4PZhLt3MCVdK9anHday
         +kzaR3l4jJZjWtzZSoLEopRqbA03x2WoEpubH1sCFSovyZyBXe3SvwhuRc0XnrdXLHTg
         tNPsMuMKNZw3dfhFvW3PvXU2SS0mIjcqAFRLj1XVNMP+m1CIzX+jb9JXdj1aM7cDrNzw
         r2sCx8PsaAWFpGVfYRIBOgN3GTSvMS+EqDvAidOarX0CFrtI7D6GVnBxU5DufxQBQgqR
         HXWuVVV6ZEtiyz8kOUsjJEG51cwbQJKTgrqL1zWJrQCyWk4PIQH5mwA3cRiA/GvHYlEq
         pP9Q==
X-Gm-Message-State: AOAM533gw0C/iV4+cPSRZiPnHNQiL347ktpoUGidT4DyH4TGdU3GrUNl
        jPMrnx0TmFX4mb0DLwF5oRTN7jp+/gTpCw==
X-Google-Smtp-Source: ABdhPJxU2KB058XE51CYUcSMipnPvf0Qk5VzTZS8EsUwLZjX4qc3Y6n8xujrzD2lZFufpuw3Huu37w==
X-Received: by 2002:a17:902:d4cc:b029:e4:9cd9:f189 with SMTP id o12-20020a170902d4ccb02900e49cd9f189mr6587626plg.53.1616638194758;
        Wed, 24 Mar 2021 19:09:54 -0700 (PDT)
Received: from localhost ([58.127.46.74])
        by smtp.gmail.com with ESMTPSA id i8sm3706537pjl.32.2021.03.24.19.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 19:09:54 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:09:51 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V6 1/2] nvme: enable char device per namespace
Message-ID: <20210325020951.GA2105@localhost>
References: <20210301192452.16770-1-javier.gonz@samsung.com>
 <20210301192452.16770-2-javier.gonz@samsung.com>
 <YFswq8pgzg9y00GO@x1-carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFswq8pgzg9y00GO@x1-carbon.lan>
User-Agent: Mutt/1.11.4 (2019-03-13)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 21-03-24 12:29:32, Niklas Cassel wrote:
> On Mon, Mar 01, 2021 at 08:24:51PM +0100, javier@javigon.com wrote:
> > From: Javier González <javier.gonz@samsung.com>
> > 
> > Create a char device per NVMe namespace. This char device is always
> > initialized, independently of whether the features implemented by the
> > device are supported by the kernel. User-space can therefore always
> > issue IOCTLs to the NVMe driver using the char device.
> > 
> > The char device is presented as /dev/nvme-generic-XcYnZ. This naming
> > scheme follows the convention of the hidden device (nvmeXcYnZ). Support
> > for multipath will follow.
> > 
> 
> Hello all,
> 
> Looking at the discussion that led up to the current design:
> https://lore.kernel.org/linux-block/20201102185851.GA21349@lst.de/
> 
> Keith initially suggested:
> 
> a) Set up the existing controller character device with a generic
>    disk-less request_queue to the IO queues accepting IO commands to
>    arbitrary NSIDs.
> 
> However Christoph replied:
> 
> The problem with a) is that it can't be used to give users or groups
> access to just one namespaces, so it causes a real access control
> nightmare.
> 
> c) Each namespace gets its own character device, period.

Thanks for summarizing this up!

> However, testing this patch series out:
> 
> crw------- 1 root root 249,   0 Mar 24 11:32 /dev/nvme-generic-0c0n1
> crw------- 1 root root 249,   1 Mar 24 11:32 /dev/nvme-generic-0c0n2
> crw------- 1 root root 250,   0 Mar 24 11:32 /dev/nvme0
> brw-rw---- 1 root disk 259,   1 Mar 24 11:32 /dev/nvme0n2
> 
> NSID1 has been rejected (because of ZNS ZOC, which kernel does not support).
> 
> However, if I use the new char device for NSID1, but specify NSID2 to nvme-cli:
> 
> sudo nvme write-zeroes -s 0 -c 0 --namespace-id=2 /dev/nvme-generic-0c0n1
> 
> I was still allowed to write to NSID2:
> 
> sudo nvme zns report-zones -d 1 /dev/nvme0n2
> SLBA: 0x0        WP: 0x1        Cap: 0x3e000    State: IMP_OPENED   Type: SEQWRITE_REQ   Attrs: 0x0
> 
> Should this really be allowed?

I think this should not be allowed at all.  Thanks for the testing!

> 
> I was under the impression that Christoph's argument for implementing per
> namespace char devices, was that you should be able to do access control.
> Doesn't that mean that for the new char devices, we need to reject ioctls
> that specify a nvme_passthru_cmd.nsid != the NSID that the char device
> represents?
> 
> 
> Although, this is not really something new, as we already have the same
> behavior when it comes ioctls and the block devices. Perhaps we want to
> add the same verification there?

I think there should be verifications.

> 
> Regardless if we want to add a verification for block devices or not,
> it just seemed to me that the whole argument for introducing new char
> devices was to allow access control per namespace, which doesn't seem
> to have been taken into account, but perhaps I'm missing something.

Any other points that you think it's not been taken account?  I think it
should map to previous blkdev operations, but with some verfications
there.  It would be great if you can share any other points supposed to
be supported here :)

> Kind regards,
> Niklas
