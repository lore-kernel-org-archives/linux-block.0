Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EC1EB64DB
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbjFOBan (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237006AbjFOBal (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 21:30:41 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001F32125
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-55b2fb308bbso927896eaf.1
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686792639; x=1689384639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqTJGy1pP+37M23cEv9MnGAr7eJIKEBvtZw/Ram/MfI=;
        b=OQlly79gtFjEuGauGHsbJ315q4qG6PgFUovF0wRl1/ibOrpOs7xMRQEx6wnUVX8eqH
         5GA2VmYqzZmjXYLA1WfVDeNE3KPC0kYsmXGqUMQpQysyqc3gseUC7jQ2VxvriDMQ0Txr
         VcwfU7eZRZaOvA0Aa8Rb3z5isaR+Q0qa0jxGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686792639; x=1689384639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqTJGy1pP+37M23cEv9MnGAr7eJIKEBvtZw/Ram/MfI=;
        b=ZnQsydpmIic5SgE5wP7Rwq5ihjFl0Wu6pNX2aXTHNtS9sjRQIW7hDf8udGWkAzQHmy
         EwJCs8tiebNuq18HOmelOxePv+LTKUsOc2KGC/rh+H05bns6xLZULPhztLLGMyyCDwk+
         0cwH1pUv2HLu2NWH3OaboCzTkp0cmfeQ26xabOLd3Pvtu0A9jauD/8vXDLUBUeJb4gL7
         G8LwOsQs0fiwuB9q0IXkkDW4gfN2uqMTiyFHhEuWJHVLxeQilTceF3XtaEPMV4ljkD40
         suxaHsYMoH8oBN2edJ8IyvXrBv6nJSzU6LCzeE0Zrpo1yn2TcO0sUFUCOGzNDyYxkBBb
         Fk6Q==
X-Gm-Message-State: AC+VfDxE69t5sP+VNUlZkkjWiQ0xTi0imPC31i1XwTOqb/keAhFrQvvr
        CPUZYGTxJLTz0lwralrVlXdiSw==
X-Google-Smtp-Source: ACHHUZ4rHxRNcRyejiJWzUKFbQsjRt6L83CuzA68ynRIGlPyDfAZlE1xaWh7moM4leJgwDqpB3cwXQ==
X-Received: by 2002:a05:6358:f1d:b0:12b:d5bf:5a99 with SMTP id b29-20020a0563580f1d00b0012bd5bf5a99mr3420625rwj.10.1686792639186;
        Wed, 14 Jun 2023 18:30:39 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d36-20020a634f24000000b0050fa6546a45sm11755234pgb.6.2023.06.14.18.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 18:30:38 -0700 (PDT)
Date:   Thu, 15 Jun 2023 10:30:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [PATCH] zram: further limit recompression threshold
Message-ID: <20230615013033.GA1488555@google.com>
References: <20230614141338.3480029-1-senozhatsky@chromium.org>
 <20230614125210.3c6b5c1e34e18fbca7f59dae@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614125210.3c6b5c1e34e18fbca7f59dae@linux-foundation.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/06/14 12:52), Andrew Morton wrote:
> On Wed, 14 Jun 2023 23:13:12 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > Recompression threshold should be below huge-size-class
> > watermark.
> 
> The changelog explains what the code does, but not why it does it?

Good point. Let me send out a V2 quickly.
