Return-Path: <SRS0=7FI7=SR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561D6C282DA
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 11:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 279062147C
	for <linux-block@archiver.kernel.org>; Mon, 15 Apr 2019 11:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555329015;
	bh=xEYxlZIHqkYUSHSoNuuCiESnzqvtdmnyRYw6ZNFUU3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kguOiQ+M115kK0b40mbHRbXULbUmzTbIbOQM0Hu9ouwaHJ7fkjFlD+boDT2Eb+qDL
	 v5LmZJeXsxLGkik41Lc8X/I43lwUy6mQOZh8TA0KbeceIhm4tyxJ0aD2iq59igchSO
	 P7T/Zzkzsihp2T04Snm5NlXV5FgTZS4gbhet9YZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfDOLuO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfDOLuO (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Apr 2019 07:50:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35AA82073F;
        Mon, 15 Apr 2019 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555329013;
        bh=xEYxlZIHqkYUSHSoNuuCiESnzqvtdmnyRYw6ZNFUU3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DlLIq0IXgKSb1BJQo7H3r0gL6snhkY9FWeDbbu4DLkbh8NmlYtOgqVZFJpSspdWxX
         /mrU/P7N/LMVyOoVUTMlU7FAwcjx+QP0wWehggojAamfX3e/9daiNMaWOWsHjvXIhW
         epu76Qi1jw/2a8iP2I0j0GJJE9L1Da8mzGED7HsE=
Date:   Mon, 15 Apr 2019 13:50:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tian Xianting <xianting_tian@126.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] block: convert kmalloc_node to kzalloc_node
Message-ID: <20190415115010.GA25077@kroah.com>
References: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554734902-8295-1-git-send-email-xianting_tian@126.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 08, 2019 at 10:48:22AM -0400, Tian Xianting wrote:
> Use kzalloc_node to zero allocated buffer, as deadline and cfq I/O
> scheduler initialization function (deadline_init_queue, cfq_init_queue)
> did.
> 
> Signed-off-by: Tian Xianting <xianting_tian@126.com>
> ---
>  block/noop-iosched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
