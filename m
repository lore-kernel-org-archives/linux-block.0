Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B035FC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AC0214C6
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 03:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aa1tLiSU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbfAIDuv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 22:50:51 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:42117 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbfAIDuv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 22:50:51 -0500
Received: by mail-pf1-f174.google.com with SMTP id 64so2965281pfr.9
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 19:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4vn7CzcDB26W7TBlaGhppXhuR1mc3Gjd8NV0dhUXsRA=;
        b=aa1tLiSU/eW1fXURSM+xgPR/Cfgx9FO7J89vaXFNXcnO02DYWQ1upYtczeRbqzEmkm
         KVA8NKB9UkhlH0hBVu+KEuImLgmKnIoOHQ+ALtTNbx1wQR3G7HV3BkOrls366qV6nROv
         uwErT+3WKd9XpPEzdDTTfoGetH9DLd+a0ZBza5jlgKtvGiVyO68A/z8uCHnZu+EvvCWH
         t3uKVgYexKNYpoWuCRlz744rTSObZ1Uv3iCUuUeBJHDw1jU3b+D48JyGs5BUolbpMFnN
         Gp7+WBbyjXN5ZLDDmea2s8Mu2b9bVMwPMgB3If7qt3e4J6IzvZe0TBh8piRAOkQztbma
         WeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4vn7CzcDB26W7TBlaGhppXhuR1mc3Gjd8NV0dhUXsRA=;
        b=fxPoWd/0p4xMRQc3j/WYr+EqY4rZ6RyUBwoI6lcKqaGMpJLdme0PswfMLGEUwNkeCy
         gNWTdekqWLlQHIRUhbPbELzy7ib36kmJErWMMUboHWpyK+Z/XFyUpeZaqZR/vcVedlAm
         CMSIpMZPQtUanE2Zt8i6R+7O7o2kGoP+ASiTm6i72UdYEGAKfjviKWHOutfTp/jXpkkD
         +VjUec9LxypOMybdyrNPMfGAtMd9Qns8gFujAGTYbsgxtix+KM45VIPgp9H6/Z6h9+0x
         CxdhCqlXskP+zEJ8uPrk1H47A0Uu0A/AWs3KrJI2rqJYtOdWGQ9X770usP2ZH5d3+Trv
         wu3g==
X-Gm-Message-State: AJcUukc5yiuTzf6HXE5vPPt8Fh4nItFWsU13roKEdC4iIWT+ucCtI2DY
        wRpjWRsXKf7idBKUv8QKSOsoKjWZ/WfSfA==
X-Google-Smtp-Source: ALg8bN5my4qt/qz+LSttqk0rRRoYUtFwaRbQlQzKSemhgxS7Ub5JrpRv+0Aba4NUKv2qBp0BFFfrXw==
X-Received: by 2002:a62:6e07:: with SMTP id j7mr4492667pfc.135.1547005850220;
        Tue, 08 Jan 2019 19:50:50 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g185sm99231079pfc.174.2019.01.08.19.50.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 19:50:49 -0800 (PST)
Subject: Re: [patch] block: clarify documentation for blk_{start|finish}_plug
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org
References: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <de3d3d0a-4d44-bb1b-133b-feabb281e467@kernel.dk>
Date:   Tue, 8 Jan 2019 20:50:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <x49a7ka7qy9.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/8/19 2:57 PM, Jeff Moyer wrote:
> There was some confusion about what these functions did.  Make it clear
> that this is a hint for upper layers to pass to the block layer, and
> that it does not guarantee that I/O will not be submitted between a
> start and finish plug.

Thanks Jeff, that's definitely an improvement, I like how it's phrased
as intent, there are no guarantees and we can change things down the
line as well (the auto-unplug threshold is a good example of that).

Applied for 5.0.

-- 
Jens Axboe

