Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE65C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B192146E
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 22:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550700398;
	bh=GajvTTBZrZGrWvvL+tf1V1WMJlBA6HmDvbul/1yeJEc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=vWHP5l7im1T7iF37+e0kS04de5cK7UbP1yW8xDj+S8FdzL2zafYMnpT5dAnCMnqxN
	 jTwZRQa/96VVVwdj0lT7NgNVl/oUC8mGTAu8WjoRji7P54osp3wsoAnmOGT2UMzD2p
	 RSmVjQ0n7iU0OrZ6ARaStsVuxD5TzhprlCeTGtjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfBTWGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 17:06:37 -0500
Received: from mail-yw1-f54.google.com ([209.85.161.54]:37313 "EHLO
        mail-yw1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbfBTWGh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 17:06:37 -0500
Received: by mail-yw1-f54.google.com with SMTP id k14so9847146ywe.4;
        Wed, 20 Feb 2019 14:06:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GajvTTBZrZGrWvvL+tf1V1WMJlBA6HmDvbul/1yeJEc=;
        b=Z7wWUahDV++wqqCajGMpuqBJSYTouo2uwgl+ohjG3aNudZ2PGzyM4v/DhyrlSbfQnC
         ZzHN6XsMYipW+vXDmE4b09Gm8om+AgR2oENEBOVSJOT3pK6Y5wMtChGsKsTRcuubbHw9
         tR6D0LSc9QPFys4pb1c9Fm3remUzMcAAzdwdm9JsEMXhN2tCseYGP1qIw/etUy/frXeN
         ugXUNkbrGrRgYOaGcy2vOJlIHqaT/zwBsm4c2dBs9a1JbF6gRp1/l4Plfp9aJVJb5Wby
         QRp/Cb/4LTbuq6Up/IxininjzERl8teussafV764mN35xu03sP65qMZ7sEBq2AZ2b8JB
         NkVw==
X-Gm-Message-State: AHQUAuaUPfhrza7ISSYRJzQRdW7pAUYmCCAI2OsG/4+Vvfd5sVyHIVKE
        zPHjcrStdne+IxkOiX1OB6M=
X-Google-Smtp-Source: AHgI3IagzPVRIbsGCiEqC/3VeS/FvVqn16mOoVs8Z/3x61ChpRhTO6YwvKHEZaveTaAD2clmBB4h7A==
X-Received: by 2002:a81:3154:: with SMTP id x81mr28745722ywx.29.1550700396823;
        Wed, 20 Feb 2019 14:06:36 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:200::6:9179])
        by smtp.gmail.com with ESMTPSA id n67sm14351165ywn.1.2019.02.20.14.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 14:06:35 -0800 (PST)
Date:   Wed, 20 Feb 2019 17:06:33 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     kernel-team@fb.com, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [LSF/MM TOPIC] A little TLC for Discard
Message-ID: <20190220220633.GA98019@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi everyone,

Ric proposed a similar topic already [1], but I'd like to just add a
little more to that discussion with a broader proposal for discussing
discard.

Proposal:
Discard is a topic that seems to need a little bit of TLC from the
kernel side. The two main approaches with discard are either to enable
it as a mount option or to periodically run fstrim. At Facebook, we've
seen performance wins with both enabling discard and disabling discard
in favor of fstrim. I would like to find a middle ground where we don't
have to have application developers performance tune for the hardware.

XFS has had async discard support, but it has been problematic for our
fleet. We were seeing bursts of large discard requests caused by async
discard in XFS. This resulted in degraded drive performance increasing
latency for dependent services.

An alternative to discard is a filesystem level choice of reusing
blocks. Rather than immediately issuing a discard, we can choose to
reuse a block which will cause the underlying FTL to invalidate a block
that we would have discarded. This saves the work done by the initial
discard. There will have to be a balance here though with saving discard
with hopes of reusing it and eventually issuing the discards.

Another issue is each drive has its own proprietary FTL which introduces
a wide variability of performance with discard. Some drives don't need
discard to perform well and others need discard enabled. There is also a
class of drives where discard is so not performant that it locks up the
drive. I would like to discuss how we can quantify this and help tune
discard within the kernel.

In summary, I'd like to explore discard more and understand how we can
build a more balanced discard experience where end users don't have to
be super cognizant of the implications on their applications.

[1] https://lore.kernel.org/linux-fsdevel/92ab41f7-35bc-0f56-056f-ed88526b8ea4@gmail.com/

Thanks,
Dennis
