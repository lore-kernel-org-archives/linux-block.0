Return-Path: <SRS0=GQ+f=AQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6320BC433DF
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 20:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B70A2074F
	for <linux-block@archiver.kernel.org>; Sun,  5 Jul 2020 20:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGEUWD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGEUWC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 5 Jul 2020 16:22:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95BAC061794;
        Sun,  5 Jul 2020 13:22:02 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0DF09739;
        Sun,  5 Jul 2020 20:22:02 +0000 (UTC)
Date:   Sun, 5 Jul 2020 14:22:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, mchehab+samsung@kernel.org,
        drbd-dev@lists.linbit.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: DRBD driver
Message-ID: <20200705142200.2154779f@lwn.net>
In-Reply-To: <20200627103111.71771-1-grandmaster@al2klimov.de>
References: <20200627103111.71771-1-grandmaster@al2klimov.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 27 Jun 2020 12:31:11 +0200
"Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

So I've applied this but...
> ---
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/admin-guide/blockdev/drbd/index.rst | 2 +-
>  Documentation/admin-guide/blockdev/floppy.rst     | 6 +++---
>  drivers/block/drbd/Kconfig                        | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/blockdev/drbd/index.rst b/Documentation/admin-guide/blockdev/drbd/index.rst
> index 68ecd5c113e9..561fd1e35917 100644
> --- a/Documentation/admin-guide/blockdev/drbd/index.rst
> +++ b/Documentation/admin-guide/blockdev/drbd/index.rst
> @@ -10,7 +10,7 @@ Description
>    clusters and in this context, is a "drop-in" replacement for shared
>    storage. Simplistically, you could see it as a network RAID 1.
>  
> -  Please visit http://www.drbd.org to find out more.
> +  Please visit https://www.drbd.org to find out more.

This link redirects to a somewhat commercial page and may not be what was
intended back then.

>  
>  .. toctree::
>     :maxdepth: 1
> diff --git a/Documentation/admin-guide/blockdev/floppy.rst b/Documentation/admin-guide/blockdev/floppy.rst
> index 4a8f31cf4139..0328438ebe2c 100644
> --- a/Documentation/admin-guide/blockdev/floppy.rst
> +++ b/Documentation/admin-guide/blockdev/floppy.rst
> @@ -6,7 +6,7 @@ FAQ list:
>  =========
>  
>  A FAQ list may be found in the fdutils package (see below), and also
> -at <http://fdutils.linux.lu/faq.html>.
> +at <https://fdutils.linux.lu/faq.html>.

This page hasn't been updated in 15 years, and may be of limited utility.
The document itself talks about LILO on a 2.6.9 kernel, PS/2 floppies, and
other such bleeding-edge things.  It sure needs more help than this.

>  
>  
>  LILO configuration options (Thinkpad users, read this)
> @@ -220,11 +220,11 @@ It also contains additional documentation about the floppy driver.
>  
>  The latest version can be found at fdutils homepage:
>  
> - http://fdutils.linux.lu
> + https://fdutils.linux.lu
>  
>  The fdutils releases can be found at:
>  
> - http://fdutils.linux.lu/download.html
> + https://fdutils.linux.lu/download.html
>  
>   http://www.tux.org/pub/knaff/fdutils/

That link is completely dead and should just come out.

But at least we have some HTTPS links.  

jon
