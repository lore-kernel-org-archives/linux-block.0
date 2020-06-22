Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D7BC433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E74206D7
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 13:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbgFVNJJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:09:09 -0400
Received: from ms.lwn.net ([45.79.88.28]:37444 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbgFVNJJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 09:09:09 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ADE672C8;
        Mon, 22 Jun 2020 13:09:08 +0000 (UTC)
Date:   Mon, 22 Jun 2020 07:09:07 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, rdunlap@infradead.org,
        dongli.zhang@oracle.com
Subject: Re: [PATCH v4] docs: block: Create blk-mq documentation
Message-ID: <20200622070907.3d2bb187@lwn.net>
In-Reply-To: <d7b3b500-cb3c-1348-61c9-9e14767fa4ac@kernel.dk>
References: <20200620002036.113000-1-andrealmeid@collabora.com>
        <d7b3b500-cb3c-1348-61c9-9e14767fa4ac@kernel.dk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 20 Jun 2020 15:21:05 -0600
Jens Axboe <axboe@kernel.dk> wrote:

> On 6/19/20 6:20 PM, André Almeida wrote:
> > Create a documentation providing a background and explanation around the
> > operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
> > 
> > The reference for writing this documentation was the source code and
> > "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
> > Systems", by Axboe et al.  
> 
> This looks fine to me now - Jon, would you care to queue it up?
> You can add my:
> 
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Done.

Thanks,

jon
