Return-Path: <SRS0=Dgp+=T4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACA2C04AB6
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7171121734
	for <linux-block@archiver.kernel.org>; Tue, 28 May 2019 16:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="wyDZHKhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfE1Q6D (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 May 2019 12:58:03 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:33071 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbfE1Q6C (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 May 2019 12:58:02 -0400
Received: by mail-vk1-f196.google.com with SMTP id v69so4887117vke.0
        for <linux-block@vger.kernel.org>; Tue, 28 May 2019 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WD86kLDybsdQfA1DtayTKwNMqVa0rLyy2f7nqyQw8qg=;
        b=wyDZHKhr+yVm9KgPE6tQTdgA4iwGqTCmFL3YfnKUlBYX+v412GOR3Icm138K9DM5IT
         lrs1WADr98GngDUa6SfbkIi5Liqqdw/2YUmApufncRkJE1U1WavhpViIXri52MGyzhZa
         ojrqbwXHuUfcn5tjm/RZFEOOM+/iOM4qhIBY/qTcZJv+nyYjUv6l/us1HHQcX42+d8yl
         EAAbDs+dSrkRTVippz8RiF/K/NiCjclAmkIVpgc6iK2kwUczFAsUGOaWbv6lYGvnatr+
         DjHkDZ8+sGH3kl+5QVV8IhkYbazSmKBS73iq9xW20Dn7pKWtlrQFjklnF8+BApRMnxWe
         NuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WD86kLDybsdQfA1DtayTKwNMqVa0rLyy2f7nqyQw8qg=;
        b=VNo3wArV1sVoJaa9mdkI76ZngRk788WGPKTNoVnfeQQgL1Svs/5ik+TYjRJOAxBdWr
         ZFq/w/beV4BWLnjPgmGF0CBwf76Ql66TV+kbd9+ub/TLtCEMmrKU/VhS9gORe5PiFkE0
         gm6IjaoV5+zrqMXomUx+s6dB6FV0lQSbBwJ9DKDUlVwczLjWlZcxRn0PkDkKrEfBFTx+
         1+kPOT/bFiD8osqOUqiwwwWuiaN1E7RizMBJpL97xKcfQyxy+U60xYDxcaC0lsJ3n653
         wZnEqBbAzbBZCWqFG14S8DJ8CqGSfxEvA7LJdxq1ckj5kgYi5mCAzkdrk59fuSAd/Y7H
         ygEw==
X-Gm-Message-State: APjAAAVJAjAviql+gn7ygv4OL1ezSBAVSbDhJKGuFQtHrvjat2qzGtFG
        76ddtKS2DaYncg9YOMi0IAuJhg==
X-Google-Smtp-Source: APXvYqxGHJzU2EIExSGCni1Bo00y0u7bjA2lt0NXX3c7EB/S+zgm2olMG6Lm1XLAplqz0qJCaQCkAg==
X-Received: by 2002:a1f:9746:: with SMTP id z67mr20863502vkd.19.1559062681555;
        Tue, 28 May 2019 09:58:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::6684])
        by smtp.gmail.com with ESMTPSA id d7sm6182567uae.6.2019.05.28.09.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 09:58:00 -0700 (PDT)
Date:   Tue, 28 May 2019 12:57:59 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        nbd <nbd@other.debian.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] nbd: fix connection timed out error after
 reconnecting to server
Message-ID: <20190528165758.zxfrv6fum4vwcv4e@MacBook-Pro-91.local>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <20190524130740.zfypc2j3q5e3gryr@MacBook-Pro-91.local.dhcp.thefacebook.com>
 <20190527180743.GA20702@192-168-150-246.7~>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527180743.GA20702@192-168-150-246.7~>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 28, 2019 at 02:07:43AM +0800, Yao Liu wrote:
> On Fri, May 24, 2019 at 09:07:42AM -0400, Josef Bacik wrote:
> > On Fri, May 24, 2019 at 05:43:54PM +0800, Yao Liu wrote:
> > > Some I/O requests that have been sent succussfully but have not yet been
> > > replied won't be resubmitted after reconnecting because of server restart,
> > > so we add a list to track them.
> > > 
> > > Signed-off-by: Yao Liu <yotta.liu@ucloud.cn>
> > 
> > Nack, this is what the timeout stuff is supposed to handle.  The commands will
> > timeout and we'll resubmit them if we have alive sockets.  Thanks,
> > 
> > Josef
> > 
> 
> On the one hand, if num_connections == 1 and the only sock has dead,
> then we do nbd_genl_reconfigure to reconnect within dead_conn_timeout,
> nbd_xmit_timeout will not resubmit commands that have been sent
> succussfully but have not yet been replied. The log is as follows:
>  
> [270551.108746] block nbd0: Receive control failed (result -104)
> [270551.108747] block nbd0: Send control failed (result -32)
> [270551.108750] block nbd0: Request send failed, requeueing
> [270551.116207] block nbd0: Attempted send on invalid socket
> [270556.119584] block nbd0: reconnected socket
> [270581.161751] block nbd0: Connection timed out
> [270581.165038] block nbd0: shutting down sockets
> [270581.165041] print_req_error: I/O error, dev nbd0, sector 5123224 flags 8801
> [270581.165149] print_req_error: I/O error, dev nbd0, sector 5123232 flags 8801
> [270581.165580] block nbd0: Connection timed out
> [270581.165587] print_req_error: I/O error, dev nbd0, sector 844680 flags 8801
> [270581.166184] print_req_error: I/O error, dev nbd0, sector 5123240 flags 8801
> [270581.166554] block nbd0: Connection timed out
> [270581.166576] print_req_error: I/O error, dev nbd0, sector 844688 flags 8801
> [270581.167124] print_req_error: I/O error, dev nbd0, sector 5123248 flags 8801
> [270581.167590] block nbd0: Connection timed out
> [270581.167597] print_req_error: I/O error, dev nbd0, sector 844696 flags 8801
> [270581.168021] print_req_error: I/O error, dev nbd0, sector 5123256 flags 8801
> [270581.168487] block nbd0: Connection timed out
> [270581.168493] print_req_error: I/O error, dev nbd0, sector 844704 flags 8801
> [270581.170183] print_req_error: I/O error, dev nbd0, sector 5123264 flags 8801
> [270581.170540] block nbd0: Connection timed out
> [270581.173333] block nbd0: Connection timed out
> [270581.173728] block nbd0: Connection timed out
> [270581.174135] block nbd0: Connection timed out
>  
> On the other hand, if we wait nbd_xmit_timeout to handle resubmission,
> the I/O requests will have a big delay. For example, if timeout time is 30s,
> and from sock dead to nbd_genl_reconfigure returned OK we only spend
> 2s, the I/O requests will still be handled by nbd_xmit_timeout after 30s.

We have to wait for the full timeout anyway to know that the socket went down,
so it'll be re-submitted right away and then we'll wait on the new connection.

Now we could definitely have requests that were submitted well after the first
thing that failed, so their timeout would be longer than simply retrying them,
but we have no idea of knowing which ones timed out and which ones didn't.  This
way lies pain, because we have to matchup tags with handles.  This is why we
rely on the generic timeout infrastructure, so everything is handled correctly
without ending up with duplicate submissions/replies.  Thanks,

Josef
