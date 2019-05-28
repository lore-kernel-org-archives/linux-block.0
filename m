Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFEAC04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66CBF21721
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="uzWeB+uG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbfE1Qy2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 12:54:28 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41993 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfE1Qy1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 12:54:27 -0400
Received: by mail-vs1-f66.google.com with SMTP id z11so630156vsq.9
        for <linux-block@vger.kernel.org>; Tue, 28 May 2019 09:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQt9C+mDH/TUYn5kg6jHMMxiwsbiOA+Z5/e525L3AMA=;
        b=uzWeB+uGT3cAPGvt3ADTuyydh02gLjz+m42TrKNuu1mZ1XPtAAgf+ygS4izSAfMYso
         W/Zg+95lTcBcr0PNRoeVVxeZUU5CVuqpjygraX8eNiqPjzXwhQgf4VnAgw89sB3Si+jG
         9rwcfY4d8v6APQDB7tDD+TEGPBKBvXlN2PXrLHOZskAXc1VWyWJdIg6K24A9VjC08QD8
         FUiqa3dFymS6kadeHhfhd9hyRe7emM2wO179JH17TY4M9oOHCgnz22Zoc6Lnooxqnx66
         RadD87A/8ZoeYU4AejspEwfkEJrTgE1rO9/xe54mmpYbXb9l3FEJfHGs8nbWueLyT6d/
         KfuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQt9C+mDH/TUYn5kg6jHMMxiwsbiOA+Z5/e525L3AMA=;
        b=DRVwg6vV788J9DikxP17Tqtn0csfa/HoJeFcZTK7En2t4chCFdQzZzYQR+fxO7WdY7
         4dVbWxoCbIKoxnC1bMJn3XW2b1684Jw33pwEb/7OeJl1T1intxiukxQvk9sMV7IBmo7g
         2pVA38Ccv+udyYsPFB4y61heCGr37WZ2HFCAv9QmOsIYwcYAML8DnwKOs6cJ/Tps5sRK
         PFNM3xafkOnChtxs9OAzRRBnYx8UDKP9znLRLtDfGXe3/0kMnlZAQWywLaQPGchp0LWf
         IWSIb2kxlUUY9uqUqYvsPw3PLv6ymC7yUBpiC4Nq7FIZE1e+/joTCdIPobh3lYj4NwXi
         37BA==
X-Gm-Message-State: APjAAAX1JStYTqLPRBkO5O+vSWKrLZQ9RXJB5cEKVb8mS2CkXYzNa5fK
        s2cPwuywOExPlOniTYJDbWBmZg==
X-Google-Smtp-Source: APXvYqwdJmGwGTLqzuJ7olkBPW5dFT/6v5cSbIfig8dbCcNljaCg8IpJEPeP1RBcQYr4sbUkhsNNLw==
X-Received: by 2002:a67:3052:: with SMTP id w79mr57705721vsw.68.1559062466594;
        Tue, 28 May 2019 09:54:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6684])
        by smtp.gmail.com with ESMTPSA id e76sm16361362vke.54.2019.05.28.09.54.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:54:25 -0700 (PDT)
Date:   Tue, 28 May 2019 12:54:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nbd: notify userland even if nbd has already
 disconnected
Message-ID: <20190528165422.bi27p6czm477bxsg@MacBook-Pro-91.local>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-2-git-send-email-yotta.liu@ucloud.cn>
 <20190524130856.zod5agp7hk74pcnr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527182323.GB20702@192-168-150-246.7~>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527182323.GB20702@192-168-150-246.7~>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 28, 2019 at 02:23:23AM +0800, Yao Liu wrote:
> On Fri, May 24, 2019 at 09:08:58AM -0400, Josef Bacik wrote:
> > On Fri, May 24, 2019 at 05:43:55PM +0800, Yao Liu wrote:
> > > Some nbd client implementations have a userland's daemon, so we should
> > > inform client daemon to clean up and exit.
> > > 
> > > Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> > 
> > Except the nbd_disconnected() check is for the case that the client told us
> > specifically to disconnect, so we don't want to send the notification to
> > re-connect because we've already been told we want to tear everything down.
> > Nack to this as well.  Thanks,
> > 
> > Josef
> > 
> 
> But in userland, client daemon process and process which send disconnect
> command are not same process, so they are not clear to each other, so
> client daemon expect driver inform it to exit.
> In addition, client daemon will get nbd status with nbd_genl_status interface
> after it get notified and it should not re-connect if status connected == 0

Right this is the point.  The daemon is dumb, if it gets a disconnected message
it'll try to reconnect, so we don't want to send a disconnected message if we
were specifically told to disconnect.  We don't want to rely on userspace to try
and manage this weird state machine.  If you want userland to know its time to
disconnect then have your implementation handle being told to disconnect and
handle all the things.  Thanks,

Josef
