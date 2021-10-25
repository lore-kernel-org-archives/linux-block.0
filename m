Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39338C433F5
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6C660EBC
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 16:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbhJYQ53 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhJYQ53 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 12:57:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E407AC061745;
        Mon, 25 Oct 2021 09:55:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id na16-20020a17090b4c1000b0019f5bb661f9so546475pjb.0;
        Mon, 25 Oct 2021 09:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34KqGsADswDnjonTJQq114bRqQgkKcPCrw08YN12k1U=;
        b=ArdZ9P7fyJ7zJHFYx1+AQE02HbDLJAUvr4erZl2mwbBhtH4+TimE4u+ugqvNFdwh8d
         3/k33Em4/TsoIsweBaglse1QZQgHs7wcFn8ECUkcngi4ODPtbQO4Nm9N6HsFFQgfLYjO
         RePbywXUgZ4jXqcZxI7CJfFNDy98/HjjX5D5DC2BF8G+I/IOB9VG5SIpJ3tDITv0dJRl
         sUJ6d+ibD4KBuChDdczeAcIBzNl30xwnxblX9PJBRPoGnixLoKyw7+/sPO6a5ErIzVMp
         go4JYUYLmAuef1oHBLR/IOfONu/74SlIlF3dwUs57Wqyht+Hr5rXw+CnNSGJhGpEkKIr
         iTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=34KqGsADswDnjonTJQq114bRqQgkKcPCrw08YN12k1U=;
        b=CiJ6GG+pu9UK887u3phNe8COOXM+5lAJsfq8W27MTaqdekM2fv3fFNaCUEbMSlzK0o
         wnJRyM615aS7Uyo96rQhbI23V0k6zsi5+HyaqPXFOx3pmXjnsFNddnovC0eplJMKE7O+
         CQeIR3fjr+8Bq9iYJheyEZpFn9lgjgUcWSEt7disXt8d2YLEBolVIBEX0sFL1TQXkFlQ
         Z8w0XAfQjlcu4H0yb9sqo5TeZAeLJlLXI82PevMag0ridM9442KPhNpw+SEGrIju16Yx
         uDhxLaOWb17oMtKp3LIpHTu6Y4gykSIyA8mx8B5eIhx7DYBtG30RQB7rJhKG542XKYNX
         G0rQ==
X-Gm-Message-State: AOAM532q2W3u/6lDgGL0tft501b0Mppeq/0/ZyOzrSPjOhkLS3VfR9nN
        96BX5RSObXs0tXCMWuN5fus=
X-Google-Smtp-Source: ABdhPJwnOC5S77AdBEAZhaiGNLZ1LAMQYdWuNPBpW15141iALB0JrDnj2gFivuKTGQtzXuB/cou/UQ==
X-Received: by 2002:a17:90b:1b49:: with SMTP id nv9mr21773068pjb.134.1635180906379;
        Mon, 25 Oct 2021 09:55:06 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:676:677c:1b95:77a5])
        by smtp.gmail.com with ESMTPSA id c15sm9853456pfv.66.2021.10.25.09.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 09:55:05 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 25 Oct 2021 09:55:04 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, geoff@infradead.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, jim@jtan.com,
        ngupta@vflare.org, senozhatsky@chromium.org, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com, ira.weiny@intel.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/13] zram: add error handling support for add_disk()
Message-ID: <YXbhaO5QAOi96E8j@google.com>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
 <20211015235219.2191207-9-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015235219.2191207-9-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 15, 2021 at 04:52:14PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>
