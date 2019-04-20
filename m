Return-Path: <SRS0=gurp=SW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208AC282E2
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 13:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29B218A6
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 13:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfDTNUq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:20:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:36742 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725920AbfDTNUq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 09:20:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 028EAAEA0;
        Sat, 20 Apr 2019 13:20:44 +0000 (UTC)
Subject: Re: [RFC PATCH v2 13/16] bcache: fix fifo index swapping condition in
 btree_flush_write()
To:     Sasha Levin <sashal@kernel.org>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, stable@vger.kernel.org
References: <20190419160509.66298-14-colyli@suse.de>
 <20190419231642.90AB82171F@mail.kernel.org>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Labs
Message-ID: <9100e2d9-16bb-3632-c931-890f2ee0f5d4@suse.de>
Date:   Sat, 20 Apr 2019 21:20:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419231642.90AB82171F@mail.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/4/20 7:16 上午, Sasha Levin wrote:
> Hi,
> 
> [This is an automated email]
> 
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
> 
> The bot has tested the following trees: v5.0.8, v4.19.35, v4.14.112, v4.9.169, v4.4.178, v3.18.138.
> 
> v5.0.8: Build OK!
> v4.19.35: Build OK!
> v4.14.112: Failed to apply! Possible dependencies:
>     a728eacbbdd2 ("bcache: add journal statistic")
>     c4dc2497d50d ("bcache: fix high CPU occupancy during journal")
> 
> v4.9.169: Failed to apply! Possible dependencies:
>     a728eacbbdd2 ("bcache: add journal statistic")
>     c4dc2497d50d ("bcache: fix high CPU occupancy during journal")
> 
> v4.4.178: Failed to apply! Possible dependencies:
>     a728eacbbdd2 ("bcache: add journal statistic")
>     c4dc2497d50d ("bcache: fix high CPU occupancy during journal")
> 
> v3.18.138: Failed to apply! Possible dependencies:
>     a728eacbbdd2 ("bcache: add journal statistic")
>     c4dc2497d50d ("bcache: fix high CPU occupancy during journal")
> 
> 
> How should we proceed with this patch?

This patch will go into Linux v5.2. We can have them in stable after
they being upstream.

Thanks.

-- 

Coly Li
