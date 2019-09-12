Return-Path: <SRS0=MetK=XH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CAC4CEC5
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B2B20678
	for <linux-block@archiver.kernel.org>; Thu, 12 Sep 2019 15:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733037AbfILPr0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Sep 2019 11:47:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45012 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732739AbfILPrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Sep 2019 11:47:25 -0400
Received: from [IPv6:2001:8a0:6c2f:b301:66f4:e6a0:633:7a5e] (unknown [IPv6:2001:8a0:6c2f:b301:66f4:e6a0:633:7a5e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ezequiel)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2AF1928E9ED;
        Thu, 12 Sep 2019 16:47:24 +0100 (BST)
Message-ID: <a02d9e6d9c13a607bc08b71a5d5f6c2039f1c279.camel@collabora.com>
Subject: Re: [PATCH 2/3] null_blk: fix module name at log message
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, m@bjorling.me,
        kernel@collabora.com, krisman@collabora.com
Date:   Thu, 12 Sep 2019 16:47:20 +0100
In-Reply-To: <20190911144636.226945-2-andrealmeid@collabora.com>
References: <20190911144636.226945-1-andrealmeid@collabora.com>
         <20190911144636.226945-2-andrealmeid@collabora.com>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi André, Jens,

On Wed, 2019-09-11 at 11:46 -0300, André Almeida wrote:
> The name of the module is "null_blk", not "null". Make `pr_info()` follow
> the pattern of `pr_err()` log messages.
> 

Instead of doing these fixes manually, it's more consistent and smarter
to use pr_fmt. There are many examples of drivers doing that.

I don't know if this patch can be dropped, and replaced with one used pr_fmt
or if doesn't worth the trouble.

It would be even better to also patch Documentation/process/coding-style.rst,
in particular the printing section, making a mention to pr_fmt.

Thanks,
Ezequiel

