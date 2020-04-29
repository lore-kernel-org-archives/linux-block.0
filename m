Return-Path: <SRS0=GTSZ=6N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF9DC83000
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B8E120B1F
	for <linux-block@archiver.kernel.org>; Wed, 29 Apr 2020 17:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FgzmRv1K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgD2RSr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgD2RSr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Apr 2020 13:18:47 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B24DC035493
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 10:18:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 71so2478595qtc.12
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2020 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KIRyEJq6A4uPsjQUVds8C6PhV05GC07IiHWYIwTUTkQ=;
        b=FgzmRv1Kuvo2vn1vCYW4YPwtJm3hs8WnRuGrtdY/aIO51wTMOl161yndlFfVefRL3x
         YtAU73SQEjdRJrBhpfZETMBEgXIRWk7gGS9+UVq66TyCF5WB8HSQiK02C2gLSCHLnc4u
         OBAcaZ3IfTFk1TmDIbj3Qb8xVwAwG1RxpGCx7FAuM7SH7z3nLKXegQXG70Q5ytKYVddn
         PZ1GpZtmOQykXikov3gkBPAkvOPlf8TzypltlCEudSOm5Iq3GJVfKWn+7Eb5+yVxxgjd
         ivQg0Yy/zRqrjrXbEjCgLKQNLJNebHHxSYVctGxlZc0iBKxV0UbzLfRiXlqoS6VcQB7F
         SlWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KIRyEJq6A4uPsjQUVds8C6PhV05GC07IiHWYIwTUTkQ=;
        b=gBz4palbpQSKeCH0kYfNNNQuPHSL3yJfZqIEKvsUtbK7duSj6puu9i7DswY6j3nTt4
         S0Yv+n5zSndMtxXXrztFyyoS+O8ThReHOpaDhO3ixeD02CwGxRbYdVbNXnYTOskiSG3u
         w5a42/yWz6go9dtpf2lUd5ucVQyHv4hWEeJW8g86DVBo9UX/RyBEkVnp5TggSUmk5wHC
         EdXRrPRsGlzefFDz0W6Vts7XEJshlQVNCpHmEE3s2KBfHsa7X+4s03ltCH8kVAUI07Wc
         Xliiqs1Gh+7i+eto9rh5xv/oDpwvTGTcG8WFaO2E9YKFfh4DccMoXpWC9RpOroegBO7I
         o+xw==
X-Gm-Message-State: AGi0PubNIyCHh1dY4wa374zhwnkArT5zLuF1Z2lkekkfAwN/RIBBd49e
        7YU4tbis+W9uTGVw/o3bmjbrRQ==
X-Google-Smtp-Source: APiQypJUaXgz0vdsOO647OEZziodcK8+yrvNAucF2ipuBxcxfQvECD+2sGhZsyW4SBfAcB7qimxedQ==
X-Received: by 2002:aed:2666:: with SMTP id z93mr34114456qtc.203.1588180726423;
        Wed, 29 Apr 2020 10:18:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p80sm16014726qke.96.2020.04.29.10.18.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 10:18:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jTqM9-0000O3-IX; Wed, 29 Apr 2020 14:18:45 -0300
Date:   Wed, 29 Apr 2020 14:18:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jinpu.wang@cloud.ionos.com, pankaj.gupta@cloud.ionos.com
Subject: Re: [PATCH v13 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS
 modules
Message-ID: <20200429171845.GF26002@ziepe.ca>
References: <20200427141020.655-1-danil.kipnis@cloud.ionos.com>
 <20200427141020.655-26-danil.kipnis@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427141020.655-26-danil.kipnis@cloud.ionos.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Apr 27, 2020 at 04:10:20PM +0200, Danil Kipnis wrote:
> From: Jack Wang <jinpu.wang@cloud.ionos.com>
> 
> Danil and I will maintain RNBD/RTRS modules.
> 
> Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
> Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>  MAINTAINERS | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26f281d9f32a..b22672f6d22d 100644
> +++ b/MAINTAINERS
> @@ -14459,6 +14459,13 @@ F:	arch/riscv/
>  N:	riscv
>  K:	riscv
>  
> +RNBD BLOCK DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-block@vger.kernel.org
> +S:	Maintained
> +F:	drivers/block/rnbd/
> +
>  ROCCAT DRIVERS
>  M:	Stefan Achatz <erazor_de@users.sourceforge.net>
>  S:	Maintained
> @@ -14587,6 +14594,13 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-devel
>  F:	drivers/net/wireless/realtek/rtl8xxxu/
>  
> +RTRS TRANSPORT DRIVERS
> +M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
> +M:	Jack Wang <jinpu.wang@cloud.ionos.com>
> +L:	linux-rdma@vger.kernel.org
> +S:	Maintained
> +F:	drivers/infiniband/ulp/rtrs/

Make sure you follow the sorting rules here too, I catually don't know
what they are :\

Jason
