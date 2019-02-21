Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92183C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4842083B
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 17:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0AofjwWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBURnx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 12:43:53 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:45339 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBURnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 12:43:53 -0500
Received: by mail-pl1-f181.google.com with SMTP id r14so14510007pls.12
        for <linux-block@vger.kernel.org>; Thu, 21 Feb 2019 09:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ibz/jFxTUYsL5oHtqCKowg6kM7v4mtkhvR2/j3+AOks=;
        b=0AofjwWC5nEyU9Qb3yvMVFvhb0sm+R5TWGGsD3n4Z+swTW/jRU5bgGeTgbg20eslL3
         V5BeGAfoc0iq6cVcfEDPN7r2FBtwPvjNAgtjHwMgnk/DiJdOQjVdIk85JdmCZoD2mPiI
         lNtA/hrYp9kTmPTj+zmVxhhUPRbf7DV5bPw1bneNHndLyhluEFBXxWUPaT/Wjj6Ni7df
         aPaZjArbY5QNte4h9yeB+GaAPi10qmCi5UJ4LHxBi4yCFGq3rnP5jAur1PVctvUOsRDI
         rTk5LfU1dLOinpKzaTvYnM3Vnc+P67+W5v7Ab0FldDOS8Y1hBDfGcq2XktYB2PBnwHya
         WXtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ibz/jFxTUYsL5oHtqCKowg6kM7v4mtkhvR2/j3+AOks=;
        b=g4HYDXG7xDn1Z+TbxeCBw1+qzkT7bo5fb+QkmqCEVQzq0YZt4KpwvZJJ0fn0SdfR15
         8YeZoe5B30uSuB9wUFlj0xXCIdyABopGd13gU7txLheOBInXtRTSaXWz00aFiXMWkz7V
         xn3yR8MRo3GxeM5v1b+1ijHx5KyU+lgffmdc9nF9hOSshTimYBbILXintui0a2Y2YYbn
         7X8R/6kvw3hWkeUZWErH4JTFDt47xyOK5V/PCtrAk8xPcjPAxSUPnculPGtERJWu0sfP
         gE2x4rlM8YG5g5uCoAbmC4/BGEPm4hmezaTV75L+aKbf/8u5XOymXR3evHAArgEIS8By
         TqrQ==
X-Gm-Message-State: AHQUAuaN/x3bUbTjXhT/YPJ7JcH6Ec4GIeJ0V5xipjNS8VIEhba0xRRg
        zZnPwFlZXGkibm9XzKQhpC61wg==
X-Google-Smtp-Source: AHgI3IbzEyj8rviIlO9lpkZf0hNjleVekMdCJJaOC7l1CPDbYHGHLk+WCu5BRGc1P7xAJkfGyV5m0Q==
X-Received: by 2002:a17:902:9a98:: with SMTP id w24mr40305685plp.247.1550771032554;
        Thu, 21 Feb 2019 09:43:52 -0800 (PST)
Received: from [172.20.1.194] (71-95-160-189.static.mtpk.ca.charter.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id b197sm43691452pga.89.2019.02.21.09.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 09:43:51 -0800 (PST)
Subject: Re: [GIT PULL] nvme updates for 5.1
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20190221154919.GA19128@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3f3c7ef6-a218-63bd-3c8b-972d29e736f0@kernel.dk>
Date:   Thu, 21 Feb 2019 10:43:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221154919.GA19128@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/21/19 8:49 AM, Christoph Hellwig wrote:
> The following changes since commit 49b1f22b567ba1d7d8174950be4398a69d0effb7:
> 
>   block: avoid to READ fields of null bio (2019-02-19 09:19:06 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.1

Pulled, thanks.

-- 
Jens Axboe

