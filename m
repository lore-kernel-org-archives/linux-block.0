Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E622C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 09:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3627A2177E
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 09:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="Mkc6KrhC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfA2Jme (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:42:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfA2Jme (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 04:42:34 -0500
Received: by mail-wr1-f67.google.com with SMTP id 96so21274061wrb.2
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 01:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2Egnq9ngobzM8WF4zpWb1uknJJq7nzRKi8Y170uTDA=;
        b=Mkc6KrhC37fpkEc1cjdGSc4prGRcAu+EXzaOB+JwK4KB0dJgTi0PCMQ/KAmXIirj1y
         /PVJsANQVQFeAnlxFYFGEX/TQu7OyQKi06qs6k/WDC6Qg6WSCKuxHfdM5AimiJvnrPmu
         Tyk3jjE7X7Fz9aoOOJA/hHO9Xzm25ynS52zb9lldvTIZo0XOU7jlSToPu7ytV4Araae9
         KaNIOR/aNplYDncNt9J5rPKvZO077y7qnBrNj2InLp158vLxzXt1p/5fX+RYT0TR0MmF
         0vruTpnNuxWyW3a/+r0rgtiVcR+P7bnIj/bzo1gbXSFeIQR0VamrRsKaGwwqrXEZcTp8
         Smtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2Egnq9ngobzM8WF4zpWb1uknJJq7nzRKi8Y170uTDA=;
        b=GS204wrkHzJpkopCekf8G1gYy1hloVTeXukjr6/HQaxazcI8cCv2SrybGwYLKOV5D2
         e7lHHvVvtBg5GDCio2VVX09lhxJiO/bfPnZdyAKGlToNTW3AsHEOWoHu1akMMvub1LtK
         jCgNKAK3tsVSLiffoi/6g2UxeAnxaRJvrof1sH4my149ErjITUSGDcImUlu2/zLtKWSD
         iFagdh7G+gqWrAcIIpFRhfUqDreFwzm4lJlY9eweVpcBje5Vw7L6PDjfqc7pO72OiNmw
         GEgQblHcC8sBEosnvEWdqXV/3Kt6Roha7QoyTST9H4sgorxDpqZWkkB/nVNpx1To8DDy
         I20w==
X-Gm-Message-State: AJcUuke6dUphRQ0xIib9IQ5cjdWu33W5c1hoItI6MM5IaWOLubERxZ6h
        v4ie+jI2ICJFtP+FeJ7m135j7A==
X-Google-Smtp-Source: ALg8bN7oMLYGldESo7Z7HTbVai65yGyAp0Ba8wqgiWMFahT02R8f1Vyiy4J30GK/Or0OaWqhoVvOug==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr25895841wrs.279.1548754952786;
        Tue, 29 Jan 2019 01:42:32 -0800 (PST)
Received: from localhost (213-47-144-126.static.upcbusiness.at. [213.47.144.126])
        by smtp.gmail.com with ESMTPSA id z17sm87962125wrv.2.2019.01.29.01.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 01:42:31 -0800 (PST)
Date:   Tue, 29 Jan 2019 10:42:31 +0100
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH] block: Mark expected switch fall-throughs
Message-ID: <20190129094230.ezjzpfwf5xx47luu@rck.sh>
References: <20190123064501.GA26147@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123064501.GA26147@embeddedor>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jan 23, 2019 at 12:45:01AM -0600, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/block/drbd/drbd_int.h      | 2 +-
>  drivers/block/drbd/drbd_receiver.c | 4 ++--
>  drivers/block/drbd/drbd_req.c      | 2 +-
>  drivers/block/rsxx/core.c          | 1 +
>  4 files changed, 5 insertions(+), 4 deletions(-)
> 

Hi Gustavo,

as also discussed with Lars in person, obviously OK for the DRBD part.

Acked-by: Roland Kammerer <roland.kammerer@linbit.com>

Best, rck
