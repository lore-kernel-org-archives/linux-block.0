Return-Path: <SRS0=imFw=XJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2BEC4CEC7
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 07:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17FE20830
	for <linux-block@archiver.kernel.org>; Sat, 14 Sep 2019 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfINHIP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 14 Sep 2019 03:08:15 -0400
Received: from ms.lwn.net ([45.79.88.28]:35526 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfINHIP (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 14 Sep 2019 03:08:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AF5172CC;
        Sat, 14 Sep 2019 07:08:12 +0000 (UTC)
Date:   Sat, 14 Sep 2019 01:08:08 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     =?UTF-8?B?QW5kcsOp?= Almeida <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        kernel@collabora.com, krisman@collabora.com
Subject: Re: [PATCH 4/4] coding-style: add explanation about pr_fmt macro
Message-ID: <20190914010808.7003db2e@lwn.net>
In-Reply-To: <125475bd-ca6d-5d2a-712d-9cb37a4b8164@acm.org>
References: <20190913185746.337429-1-andrealmeid@collabora.com>
        <20190913185746.337429-5-andrealmeid@collabora.com>
        <125475bd-ca6d-5d2a-712d-9cb37a4b8164@acm.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 13 Sep 2019 13:22:18 -0700
Bart Van Assche <bvanassche@acm.org> wrote:

> On 9/13/19 11:57 AM, André Almeida wrote:
> > The pr_fmt macro is useful to format log messages printed by pr_XXXX()
> > functions. Add text to explain the purpose of it, how to use and an
> > example.
> > 
> > Signed-off-by: André Almeida <andrealmeid@collabora.com>  
> 
> Since Jonathan Corbet is documentation maintainer, shouldn't he be Cc'ed 
> explicitly for documentation patches? See also the MAINTAINERS file.

...and indeed I was CC'd on the patch - and your response :)

Thanks,

jon
