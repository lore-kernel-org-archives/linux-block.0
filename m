Return-Path: <SRS0=03jz=XI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B95CC4CECA
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 19:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573CC206A5
	for <linux-block@archiver.kernel.org>; Fri, 13 Sep 2019 19:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390165AbfIMTQJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Sep 2019 15:16:09 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:38881 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390163AbfIMTQJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Sep 2019 15:16:09 -0400
X-Greylist: delayed 445 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 15:16:08 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 836868122D6B
        for <linux-block@vger.kernel.org>; Fri, 13 Sep 2019 19:08:44 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 9F01A83777ED;
        Fri, 13 Sep 2019 19:08:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: debt02_68f1b9ca37a41
X-Filterd-Recvd-Size: 1986
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Sep 2019 19:08:41 +0000 (UTC)
Message-ID: <3028cb117886ccc40f160500bd712f005ff6d5f3.camel@perches.com>
Subject: Re: [PATCH 4/4] coding-style: add explanation about pr_fmt macro
From:   Joe Perches <joe@perches.com>
To:     =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, axboe@kernel.dk, kernel@collabora.com,
        krisman@collabora.com
Date:   Fri, 13 Sep 2019 12:08:39 -0700
In-Reply-To: <20190913185746.337429-5-andrealmeid@collabora.com>
References: <20190913185746.337429-1-andrealmeid@collabora.com>
         <20190913185746.337429-5-andrealmeid@collabora.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-09-13 at 15:57 -0300, André Almeida wrote:
> The pr_fmt macro is useful to format log messages printed by pr_XXXX()
> functions. Add text to explain the purpose of it, how to use and an
> example.
[]
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
[]
> @@ -819,7 +819,15 @@ which you should use to make sure messages are matched to the right device
>  and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>  dev_info(), and so forth.  For messages that aren't associated with a
>  particular device, <linux/printk.h> defines pr_notice(), pr_info(),
> -pr_warn(), pr_err(), etc.
> +pr_warn(), pr_err(), etc. It's possible to format pr_XXX() messages using the
> +macro pr_fmt() to prevent rewriting the style of messages. It should be
> +defined before including ``include/printk.h``, to avoid compiler warning about

Please make this '#include <linux/kernel.h>'

printk.h should normally not be #included.


