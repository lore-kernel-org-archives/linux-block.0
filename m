Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96578C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 06:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjDFG2k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjDFG2g (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 02:28:36 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFD48A68
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 23:28:26 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x37so23151441pga.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 23:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680762506; x=1683354506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/pl8ZnYxhKAfZziy0v5C4FSNYAGvVfMzIoeRbVCnPDY=;
        b=K+ReXbVAw8kVAXZ59nrKaCZdHN76327m03/S0//fIIgnwmw/Qie/G2WcYe1UUfUB3n
         inOnV+cziGTpuWiP7pLTOOxem5sz8dEoNak8VrlkbACT0qepZ+R7qNN6aCIjDGxZBK1s
         5ADvB8CRQDWeB0EvjRx76FP8lsBtqm4uYv3Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680762506; x=1683354506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/pl8ZnYxhKAfZziy0v5C4FSNYAGvVfMzIoeRbVCnPDY=;
        b=E0TdGVT9IBymemeGYQCy8FDMkadolZMIQ6/JFGn7t3ht3jRsYyYjwv/AZ0aZt9YYnu
         ucMbXJILUIeYHUrfahfem5u9/gT8zgBntpBi9osGlTCh8svTvfSk0nqvKW4lN/FTm//k
         csuoWqPd+i4qVLIU64nxc1KKjVR+9ScC//WzrmrrQUshwj86Mx6cD/xwjW6M1CZrVBuz
         LPw87rYIbIkqvw+E6N/jC5sCAHRe5KLcNuC8G20tyJpNgCboD+zTAJfWY+ibOQ3BR3dT
         hQy3ZWUwJM1/Xy6uvjaWImmfC0OMm1GwhmprlXEcFDyWgo6XqOvOMz0LxpTXBwTfZZUA
         1JFQ==
X-Gm-Message-State: AAQBX9cK334cjVSUSvpftdtEAFSKdU5Yc1ORVGtFnw3MeeDbk60CQtfK
        60qGPW/+6sF1xOUg3adjpqSLQQ==
X-Google-Smtp-Source: AKy350ZFopS5UQlsu8UiztgJCpo1DGQPyh2/2/byEmnchk9UcQr0ucE+TZQcub1FOAKllszJ7sMlrg==
X-Received: by 2002:a62:1847:0:b0:628:f0:51d4 with SMTP id 68-20020a621847000000b0062800f051d4mr8353168pfy.11.1680762505996;
        Wed, 05 Apr 2023 23:28:25 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id s21-20020aa78295000000b0058bacd6c4e8sm439575pfm.207.2023.04.05.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 23:28:25 -0700 (PDT)
Date:   Thu, 6 Apr 2023 15:28:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 01/16] zram: remove valid_io_request
Message-ID: <20230406062822.GF10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-2-hch@lst.de>
 <20230406014449.GM12892@google.com>
 <ZC5bL4aCGfylPZmn@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC5bL4aCGfylPZmn@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/05 22:39), Christoph Hellwig wrote:
> On Thu, Apr 06, 2023 at 10:44:49AM +0900, Sergey Senozhatsky wrote:
> > On (23/04/04 17:05), Christoph Hellwig wrote:
> > > All bios hande to drivers from the block layer are checked against the
> > > device size and for logical block alignment already, so don't duplicate
> > > those checks.
> > 
> > Has this changed "recently"? I can trace that valid_io() function back
> > to initial zram commit 306b0c957f3f0e7 (Staging: virtual block device
> > driver (ramzswap)). Was that check always redundant?
> 
> It was always redundant.

OK, thanks.

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
