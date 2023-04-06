Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC9C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236739AbjDFVX3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjDFVX2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:23:28 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB2EE69
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:23:27 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-627fe5dea6dso41313b3a.2
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKAYGOdfmeNfpOOil34EKQMJPRMN3JpiYxhBbAs9PCw=;
        b=V+KiMmKLMlL557ZA8iYvsCDpzJGkLgb/8lKNEDxnQIhvd7VhhdyUS+qMSIKDJzvJYP
         7tfK8nXyYifXaez6JFtR+DJB9X/xlU1JbYZT/l9Kfj009UlHBQ2R9b4IGqb1pFrD56fC
         NI+qk6eALFSdRtLd3DQuSbO8LB8iIwqPH6JMPrDYLc4L2Lrd7fbXA73/tseB2u8KiyJ1
         cXKSH/2UTZThXpxtspbIwCGbrWQMAOQvgWYr9R7vLRNAsI9u8/dsQ+iz2PCVVbKgnv6G
         mfHhaRUg1yMtCn3p7XuzEAC++OCHFZRtXcn1zeqL0ZWVag0OM/DatIOZJn+0X6n7iVqB
         jTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oKAYGOdfmeNfpOOil34EKQMJPRMN3JpiYxhBbAs9PCw=;
        b=xzZ55Yy7lEWoS+JJFS9ir8Q7I0HEfkP2m9dDz/FsxPrzVy600rmCquSAEURU5fDgS+
         1O11HLEV8S7hU7t45zEwRuOFhY7M13nXJQpAbB6wuF6OdL9LJJyLNB3cOV96PG7MuU/6
         tUDg0F7H7s+cdBrZMJU38o31yKi2CRdBeQ71ybnG8nC3a+gCWiXT9zPDc5vTZ9rs8XAQ
         vmbrRp1+WNGK494RszUy2O7bjubJgCm3tFxBssf+ASnPgSwYhLD3Hh/rvRCMuWcICqQ7
         llisQoqFp9lJYzAUBSecD+YSJARNqjCOadvVqLbRc5k0dTLB46i1Ls+e6Ast8MTLXzXI
         HeCA==
X-Gm-Message-State: AAQBX9edOb9rEUbQUlcwAHPAI0oayC+b8WVtNj+TtWW37f4wrRUOwwnA
        booQiY0xZlx7t6P8raYmi+o=
X-Google-Smtp-Source: AKy350YHKvSG+5P0PT/8kB42nmvZaUTUfWMjP+44tjJQdisYXD6NCpjTQ9bjRk7TB63VzRoaTa4Yxw==
X-Received: by 2002:aa7:980a:0:b0:627:fc3b:4cb4 with SMTP id e10-20020aa7980a000000b00627fc3b4cb4mr239877pfl.19.1680816207258;
        Thu, 06 Apr 2023 14:23:27 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b00627ed4e23e0sm1786024pfm.101.2023.04.06.14.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:23:26 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:23:24 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/16] zram: pass a page to read_from_bdev
Message-ID: <ZC84TI10OycFuFHK@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:59PM +0200, Christoph Hellwig wrote:
> read_from_bdev always reads a whole page, so pass a page to it instead
> of the bvec and remove the now pointless zram_bvec_read_from_bdev
> wrapper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
