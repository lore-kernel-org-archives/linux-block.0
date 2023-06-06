Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91002C7EE24
	for <linux-block@archiver.kernel.org>; Tue,  6 Jun 2023 16:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238073AbjFFQPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjFFQPP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Jun 2023 12:15:15 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7530E1732
        for <linux-block@vger.kernel.org>; Tue,  6 Jun 2023 09:14:09 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-62b68ce199bso3451846d6.0
        for <linux-block@vger.kernel.org>; Tue, 06 Jun 2023 09:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068021; x=1688660021;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvoMJuSZUTE86J2NoS1R2Wk8beN5EcZS9dtT2PpXBBE=;
        b=bq5dp93SP8Y3ddIyiO3Hs9NNPusNwmCWDFnHaqQyujpU4zxN0P2Mufd3xWx5pUZmeZ
         pKudKAlgArMX6Zc/9doL+VexajEtGsKH/S0Tkfu1dSjohM9qNxDiJc1uCYYsZWP376lH
         uWpmT6d7BC+uP00yMS6XTmtRDRO0FRNOD9WNTWiGMdEAjS2bbx80fDA5h1xBm4FGbzsT
         F9m4N/U5iHz6PJCBit+5StaSjQKtip3wEUTmRzKUf8q06DXhbWMWqaWAnu33rcOWOLeA
         Z1siEQjtUmB+V4tLXUWAI2++BJJi5aios3VTyopATJ5wbyA/RrklrSAf6tIpTH+sZKyK
         h1Xw==
X-Gm-Message-State: AC+VfDxHgB4QpEsbukQzBPzgysefY+SXXEymIjjKEbvusTeCx+s6KFUH
        K3km48aYgJdKK1ObvF8PfKQrQ4VBIRL45V10zg==
X-Google-Smtp-Source: ACHHUZ5qzOXOek98pMB0JPWvzatF/yDipaVz04OAtt6PZwHKRW9nr0BfKhp8DQ35Rjx+AlLCeBpRGg==
X-Received: by 2002:a05:6214:2263:b0:625:aa49:9abc with SMTP id gs3-20020a056214226300b00625aa499abcmr2762701qvb.64.1686068020628;
        Tue, 06 Jun 2023 09:13:40 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id cc21-20020a05622a411500b003f6b32a1049sm3021766qtb.55.2023.06.06.09.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 09:13:40 -0700 (PDT)
Date:   Tue, 6 Jun 2023 12:13:39 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] block: fail writes to read-only devices
Message-ID: <ZH9bMx10optlZZlf@redhat.com>
References: <20230601072829.1258286-1-hch@lst.de>
 <20230601072829.1258286-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601072829.1258286-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jun 01 2023 at  3:28P -0400,
Christoph Hellwig <hch@lst.de> wrote:

> Currently callers can happily submit writes to block devices that are
> marked read-only, including to drivers that don't even support writes
> and will crash when fed such bios.
> 
> While bio submitter should check for read-only devices, that's not a
> very robust way of dealing with this.
> 
> Note that the last attempt to do this got reverted by Linus in commit
> a32e236eb93e ("Partially revert "block: fail op_is_write() requests to
> read-only partitions") because device mapper relyied on not enforcing
> the read-only state when used together with older lvm-tools.
> 
> The lvm side got fixed in:
> 
>     https://sourceware.org/git/?p=lvm2.git;a=commit;h=a6fdb9d9d70f51c49ad11a87ab4243344e6701a3
> 
> but if people still have older lvm2 tools in use we probably need
> to find a workaround for this in device mapper rather than lacking
> the core block layer checks.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>
