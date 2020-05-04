Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916DC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 16:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B743520721
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 16:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="zt4m8qjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgEDQXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 12:23:55 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:48398 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728158AbgEDQXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 12:23:55 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 5F9BF2E0B11;
        Mon,  4 May 2020 19:23:52 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1o.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id jZLbaWK4CF-NpbW5JEh;
        Mon, 04 May 2020 19:23:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588609432; bh=no6TW68O+atJXPBJd9FkxYcBR+RL32lyRAIoHBava80=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=zt4m8qjEBFXYYgR7FHl3xaXs0x6JYyFGFIdvDGK0YYRJyp7DnQmBeKyP7Z3UsNg5h
         8BPAJcBiULiqqB6agjJ/F3rkeoBeg2MpWa4p5UfEWfhZ5Et2MoPa9yGPUjvlPNSLCi
         XpEWUZlpousukGejujQgcf3mX9lAMHFcPYWDIkO8=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id c71R8gaCcF-NpW8weO5;
        Mon, 04 May 2020 19:23:51 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH RFC 1/2] fs/iomap/direct-io: pass NOWAIT to bio flags
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
References: <158860769311.32485.8003552176738816448.stgit@buzz>
 <20200504160052.GA8625@infradead.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <94ec1b65-5f4c-6b56-5a47-ca186615d978@yandex-team.ru>
Date:   Mon, 4 May 2020 19:23:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504160052.GA8625@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/05/2020 19.00, Christoph Hellwig wrote:
> On Mon, May 04, 2020 at 06:54:53PM +0300, Konstantin Khlebnikov wrote:
>> This is required to avoid waiting in lower layers.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> 
> This looks sensible.  Did you run this through xfstests?
> 

Nope. It seems xfstests has one trivial test for NOWAIT - generic/471
It tests only write with/without extent, nothing about contention.

I've added nowait into fio and played with it a little.
https://github.com/axboe/fio/pull/972

With these patches I see EAGAINs when queue is flooded.
