Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D31C433EF
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiFZQYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiFZQYm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 12:24:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926EBC30;
        Sun, 26 Jun 2022 09:24:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id q6so14248790eji.13;
        Sun, 26 Jun 2022 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GKFVONWxoNWLQ+KQRLKWkiKJtsHOSKJZH1HI0byEJP4=;
        b=n4FZO+2HZcxIH19RNsFxZgFqDA8rtCv2e6fo2QNGXmteXn82j+/59IOLr8HUP3WoRu
         BSxcpevYg5PO8Uai/88i0ts7gs7pDdf9L1g+ZwJUdDx7o4M2iDlsAdD+yohKgtsp1D+G
         tZmCBi59U9IBYyxElnWF0BmAhvo9OOVYHtrKarG93dHTHOq9catXi5U9yTi7c8AMCyIH
         TmLPqWClnd4NDm0apqfTwveN2Is6t22YB+WS8wI1OIkmGYh0A3dJZk0zcvCtFfvKUZuN
         SEvpVSkJcDRUUzAQaBoJ7E1D/B1Bd4fzsUGyfb1SGjVWSXRQFU34Kvd82qszgyNU8Aj1
         V2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GKFVONWxoNWLQ+KQRLKWkiKJtsHOSKJZH1HI0byEJP4=;
        b=MgmNw15rzHfIOU/pqNWQbjq1nHc0C5lYjPKNFeTOY1o9DRu1244xCpuqPihVuQU1xq
         aZAnwqIfoywMm4vcltCt8AbZg8x5ij35/6h3hYgGKj0iYc6cyFTLCmqywpeEdZ1onq+M
         q/bQ6ICDF4S0PcqMsnUjkzpMGP+Onuc/XmIdqi1lB+2aPv9UGeir1SekZGE6Y2mrbB+E
         ZWEV6XELBOnI69eEqqd5VQGVjEVIVAgegEeQwUzn9tYaVT+hIoeljk6NkhAQ0TNLgM/5
         BKd4P8WtsQ7vU9GEGMlk9caenJV0kVIlpMBB3LieI7RsC8DHH02NZruP0Wz/5aHgZ0bB
         oiwQ==
X-Gm-Message-State: AJIora93l5PoJZ5zGBBugV0Abd+YH1Z3+A2AqBOIiThPxQBJS3DtX5Q7
        15UnY1jMeF8CjwSWQrjzOY8=
X-Google-Smtp-Source: AGRyM1tDVvC0gHUKc3HdI98C62253tpkXG/Ed29CyPIDRi+mcrBLRG8i3rXOVtt8xD2lVgZoQjNh9A==
X-Received: by 2002:a17:906:2bda:b0:726:3b59:3ea9 with SMTP id n26-20020a1709062bda00b007263b593ea9mr8563233ejg.43.1656260680045;
        Sun, 26 Jun 2022 09:24:40 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id jy19-20020a170907763300b007263713cfe9sm3340683ejc.169.2022.06.26.09.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 09:24:39 -0700 (PDT)
Date:   Sun, 26 Jun 2022 18:24:38 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH 51/51] fs/zonefs: Fix sparse warnings in tracing code
Message-ID: <20220626162438.3zyjenssj2gxy7b5@mail>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
 <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
 <20220626095814.7wtma47w4sph7dha@mail>
 <a206782a-bd90-58cd-1e83-bb5988edb0f9@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a206782a-bd90-58cd-1e83-bb5988edb0f9@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Jun 26, 2022 at 08:42:27AM -0700, Bart Van Assche wrote:
> On 6/26/22 02:58, Luc Van Oostenryck wrote:
> > On Sat, Jun 25, 2022 at 05:44:54PM -0700, Bart Van Assche wrote:
> > > On 6/25/22 02:23, Christoph Hellwig wrote:
> > > > Yeah, that is a bit of a mess.  Rasmus, Steven - any good idea how
> > > > we can make the trace even macros fit for sparse?  Maybe just drop the
> > > > is_signed_type check for __CHECKER__ ?
> > 
> > I would strongly advise against this:
> > -) the macro is sued elsewhere too (for overflow checking)
> > -) sparse wouldn't check anymore the same code as the one seen by the
> >     compiler
> > 
> > What about I would add to sparse something to strip away the bitwise/
> > recover the underlying type? Something like __unbitwiseof() or
> > __underlying_typeof() (some better name is needed)?
> 
> Another question is how to keep the non-sparse build working. Does
> anyone want to comment on the following alternatives or propose another
> alternative?
> 
> (1) sparse implements __strip_bitwise as a macro.
> 
> (in compiler.h)
> 
> #ifndef __strip_bitwise
> #define __strip_bitwise(type) type
> #endif

...

> (1) would work better than (2) for kernel developers who are using a
> version of sparse that does not support __strip_bitwise().

Yes, sure. I was thinking about using (and adding) __has_feature()
but the goal is the same.

[I prefer this because, internally, an operator is needed anyway and
__has_feature() would be more general (but then it would need to be
protected by its own #ifndef __has_feature).]

-- Luc
