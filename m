Return-Path: <SRS0=MN5j=QT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EAAC169C4
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C775214DA
	for <linux-block@archiver.kernel.org>; Tue, 12 Feb 2019 02:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="O8kssaSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBLCzc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:55:32 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46824 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLCzc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 21:55:32 -0500
Received: by mail-pf1-f196.google.com with SMTP id g6so526175pfh.13
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 18:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x4dno1yZK6/nf3TcDTURx8ChtQfp4NfvV74/2EpqdLQ=;
        b=O8kssaSn5Ny3BTRDvgQHLAvGflAxDiws0REDOoCdKEmXjB5B8/oJJ38w5pfriigf2K
         Jof2VjFuJsHTBr73KQVun6Pzs8+qTDG2QQh1Ku7G60d2zQFZp8pBjhp5EOpnpaHHFi8e
         3XcGfS5hOv1qVsqm/muGBWk5UxDpasbjaDyIsSOw39aRAJkbBSPt7eoomwDH18qauXto
         d4IGtYtR5EfmOe+INFrx2reUpvLBlTMxcN45ycU0JoZCTtmdOQN0zK9F5NWA22oNvfFo
         xKNVrwtmJmi9o2ydusDBdmubRnpcNAcgMXyvz6u2IJiWWDXxWUwtOJm1odcbD/L0NYUk
         eddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x4dno1yZK6/nf3TcDTURx8ChtQfp4NfvV74/2EpqdLQ=;
        b=lKPRk5Is+u5HOFjl36heHO79+rssubC7wN+9W/Jx+hxGgZS9FMI0cJEUz64fn6O4Aj
         bsQlMCyKBxLfAv3KiqEiEqOHPNylw/ThXw8y0fL93pcNTouuaXQDme/EAdWySc0HWDZa
         kL0DTE9Ve6eA27SXfkGONoySX9umYZAIH2/kgCPjfn9I3TlcNAsLzMaZuqVKiPxYn/m1
         RoK3I65A0K0ybQNEBAqhQ5DxJMs0s1+0Rz2qnuOL+xeoBF6N6Is1AyIHezPfK07GNfW4
         ujjSwyLcbT2zQKSaSK18kXPg5OM/2z5woirHGTtWc38BqzjCgvttkdW1v3nphffe1Pz5
         3mxQ==
X-Gm-Message-State: AHQUAuYPqxF3sqEl48LUa39Tfg+jJQSHTmiLuipQUcvXFkxKe/dBpgv0
        m0Y95WbCQocotPcF/G7PxBKPWLEgqHKM/w==
X-Google-Smtp-Source: AHgI3IbH0S3Ru2xIQ6ToQCf7l9TOHrvoc940YOlehDHhGL3Ky1IXrPbhjOl7U0Li5TklBwIHGtElkQ==
X-Received: by 2002:a65:6290:: with SMTP id f16mr1548243pgv.106.1549940131401;
        Mon, 11 Feb 2019 18:55:31 -0800 (PST)
Received: from ?IPv6:2600:380:4a5b:8858:a8b3:edff:f3de:ccc1? ([2600:380:4a5b:8858:a8b3:edff:f3de:ccc1])
        by smtp.gmail.com with ESMTPSA id d16sm13249578pgj.21.2019.02.11.18.55.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 18:55:30 -0800 (PST)
Subject: Re: [PATCH v3] nullb: Prevent use of legacy request queue mode
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
Cc:     Matias Bjorling <matias.bjorling@wdc.com>
References: <20190211234716.18816-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a27e13e6-93a3-e7f7-cc67-a7169c8a44ad@kernel.dk>
Date:   Mon, 11 Feb 2019 19:55:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190211234716.18816-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/11/19 4:47 PM, Damien Le Moal wrote:
> When null_blk queue mode is specified together with modprobe/insmod, a
> check to prevent setting the nullb device queue mode to 1 (NULL_Q_RQ) is
> done. However, the same check is not performed when setting up a nullb
> device through configfs, resulting in a oops (NULL pointer dereference
> for the device request queue).
> 
> Fix this problem by checking for an invalid queue mode value in
> null_validate_conf(), propagating -EINVAL to null_add_dev() if the queue
> mode is NULL_Q_RQ. While at it, also fix the propagation to user space
> of null_add_dev() return value when a nullb device is created through
> the power attribute of configfs.
> 
> Finally, remove the "1=rq" value from the list of possible values of
> the queue_mode module argument to make it clear that this is no longer
> a valid setting.

I actually left that in there on purpose, to avoid breaking test
scripts. It's not the perfect solution, but I viewed it as the
lesser of two evils. Maybe we're fine now, I think blktests has
been fixed a while back?

-- 
Jens Axboe

