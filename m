Return-Path: <SRS0=Ukdl=Y7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15483C5DF60
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 18:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D10218AE
	for <linux-block@archiver.kernel.org>; Thu,  7 Nov 2019 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573150588;
	bh=H4aBotvTCrik0Rabs8iQWvH7K8xaJTtQ0dRfRu44CuY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z9FGsIJTeFE0Tgo+uXCkZawtkOeUnQrFwsbJzWCtuSKrGIlAHHTuRSPr4ld3VhLtT
	 5JUMt8wcqE93PBwipGjskeuTv6omBQPQOW6VdSAOT7MxW/YoHKPQuyESjaF6HxUzgW
	 iaPQryNIYVVJt8fmfjTe2d1ws3uIIIrS/9nB63Zg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbfKGSQ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbfKGSQ1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Nov 2019 13:16:27 -0500
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3FA2222C5
        for <linux-block@vger.kernel.org>; Thu,  7 Nov 2019 18:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573150586;
        bh=H4aBotvTCrik0Rabs8iQWvH7K8xaJTtQ0dRfRu44CuY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p4UcAioPEe71t/aPpiAyPpP4uaKeCN1fPc0/emJwxDVmQLiZgnuloPp3Xh3U6jrx7
         8W6CD9uzzV09ebXOQpvPhjsPvVQLggBE989PGI6eO8oYzm5zTAFWryGT5JAO+AAYLg
         5SoAdqSbbGkr8rAJ6H+e5oFLPnXc8AP/R6XCbQ5M=
Received: by mail-wr1-f41.google.com with SMTP id p4so4130674wrm.8
        for <linux-block@vger.kernel.org>; Thu, 07 Nov 2019 10:16:25 -0800 (PST)
X-Gm-Message-State: APjAAAVLhmYr0cl3odL1JeDiJudJWFS2OqCGOWWWbaXiFAeYhm16xkfw
        eisyEMzWhsCngdeY8rUMu4FTGG6gVE60+/E5jGySDg==
X-Google-Smtp-Source: APXvYqwLtGjY6ZkTJhI0Sr43dvJLSVSp97ERd6U9abpQWD2zv5w6C7Aei5pvq7FP+EbxNuTelpmDn87aLW93/QUhwBA=
X-Received: by 2002:adf:f342:: with SMTP id e2mr4483203wrp.61.1573150584414;
 Thu, 07 Nov 2019 10:16:24 -0800 (PST)
MIME-Version: 1.0
References: <157313371694.29677.15388731274912671071.stgit@warthog.procyon.org.uk>
 <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
In-Reply-To: <157313375678.29677.15875689548927466028.stgit@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 Nov 2019 10:16:13 -0800
X-Gmail-Original-Message-ID: <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com>
Message-ID: <CALCETrUka9KaOKFbNKUXcA6XvoFxiXPftctSHtN4DL35Cay61w@mail.gmail.com>
Subject: Re: [RFC PATCH 04/14] pipe: Add O_NOTIFICATION_PIPE [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, raven@themaw.net,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Nov 7, 2019 at 5:39 AM David Howells <dhowells@redhat.com> wrote:
>
> Add an O_NOTIFICATION_PIPE flag that can be passed to pipe2() to indicate
> that the pipe being created is going to be used for notifications.  This
> suppresses the use of splice(), vmsplice(), tee() and sendfile() on the
> pipe as calling iov_iter_revert() on a pipe when a kernel notification
> message has been inserted into the middle of a multi-buffer splice will be
> messy.

How messy?  And is there some way to make it impossible for this to
happen?  Adding a new flag to pipe2() to avoid messy kernel code seems
like a poor tradeoff.
