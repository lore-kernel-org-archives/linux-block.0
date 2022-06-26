Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEADFC43334
	for <linux-block@archiver.kernel.org>; Sun, 26 Jun 2022 09:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiFZJ6W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiFZJ6V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 05:58:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47FDF46;
        Sun, 26 Jun 2022 02:58:19 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o10so9234813edi.1;
        Sun, 26 Jun 2022 02:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/rG5L3Zjx9O3il61DrqQzvI/iIYj2HZ2W4d57u5l2ZY=;
        b=a1p8ZXROoy3Vpxr1xGZzlW0bbbFpW5+cFhERiGrPRi59K9WiUOa5cFz5RYWNOjo1cA
         /1N10XbiNOikzFELkZx7IjOAWs8SOb0HLxrwQ6XEEtNBmBocNbr/JJCk1m7ohRX4Jj7z
         eHIET/VUHzCSGZK5x7uclwFqcgXN1V171I+LWkK8z0MhzeUsmv3Vxlh+4nWycqdfcHpS
         YO4s3xspNvDVsWvY5MJYmUnl2UsY+Io6wxxVaL9rciXCY6AU4ZHEshQpL4u90G7bY+FY
         a4DAxiUjbQEvbF/snsSPXG+RWePe7TvspLOTGBF7vzhmGNgX9s4fzNe88r2ertErdZxO
         jATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rG5L3Zjx9O3il61DrqQzvI/iIYj2HZ2W4d57u5l2ZY=;
        b=I48t83vCCU7iIrODjxu9Tj/txRQdJAtvHvK94i7cfBnKZJ1uEhNqAHfOgUpANXKIUo
         nlGjLBdcHrwzMOGavhDBOdufROMQPvVkyjRgeHDfT9iAw981vpBH3Muu9sYAcvw8DmWO
         toiEAuWQZrX1FVI/1dA+s6F24t54C1io/7zSS2KVtPt1PKzUrb9U2FBidYwaxK+bA5HK
         uWyOCjnc+IEqqG1E8XXEsQdz7f3AnlYQzcfku134/FjPg7l5YadDUcY3L2yNKAfNyx4b
         UAaMQSRIinWhH2fA6IBE3qXxp5GhGPJjrrbvyM4xy9jhQyG0K33JFzIW1yBllSz21xhQ
         iq6Q==
X-Gm-Message-State: AJIora+d/q4ONCdL85UxBy6ufNNewNKbfZ9vmSLn5IR0AW3AB1SZTpgT
        TW/gF9y5L4yEai9VJLZXtZA=
X-Google-Smtp-Source: AGRyM1vy9WMzVInsUCMzpXRPnXKYpr0TmNJZtoX7aLWnY5PkkohhOaI2vaQ4RyrCiTT8k4E/Nqov1A==
X-Received: by 2002:a05:6402:26cb:b0:436:2173:3f7 with SMTP id x11-20020a05640226cb00b00436217303f7mr10113913edd.61.1656237498110;
        Sun, 26 Jun 2022 02:58:18 -0700 (PDT)
Received: from mail (239.125-180-91.adsl-dyn.isp.belgacom.be. [91.180.125.239])
        by smtp.gmail.com with ESMTPSA id q2-20020a170906a08200b006fed93bf71fsm3645154ejy.18.2022.06.26.02.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 02:58:17 -0700 (PDT)
Date:   Sun, 26 Jun 2022 11:58:14 +0200
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
Message-ID: <20220626095814.7wtma47w4sph7dha@mail>
References: <20220623180528.3595304-1-bvanassche@acm.org>
 <20220623180528.3595304-52-bvanassche@acm.org>
 <20220624045613.GA4505@lst.de>
 <aa044f61-46f0-5f21-9b17-a1bb1ff9c471@acm.org>
 <20220625092349.GA23530@lst.de>
 <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3eed7994-8de2-324d-c373-b6f4289a2734@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jun 25, 2022 at 05:44:54PM -0700, Bart Van Assche wrote:
> On 6/25/22 02:23, Christoph Hellwig wrote:
> > On Fri, Jun 24, 2022 at 12:57:56PM -0700, Bart Van Assche wrote:
> > > BTW, I discovered the code in the tracing infrastructure
> > > that makes sparse unhappy:
> > > 
> > > #define is_signed_type(type) (((type)(-1)) < (type)1)
> > > 
> > > Sparse reports four warnings for that expression if 'type' is a bitwise
> > > type. Two of these warnings can be suppressed by changing 'type' into
> > > '__force type'. I have not yet found a way to suppress all the sparse
> > > warnings triggered by the is_signed_type() macro for bitwise types.

Yes, __bitwise is quite strict and only support the bitwise operations
(&, |, ^ and).
 
> > Yeah, that is a bit of a mess.  Rasmus, Steven - any good idea how
> > we can make the trace even macros fit for sparse?  Maybe just drop the
> > is_signed_type check for __CHECKER__ ?

I would strongly advise against this:
-) the macro is sued elsewhere too (for overflow checking)
-) sparse wouldn't check anymore the same code as the one seen by the
   compiler 

What about I would add to sparse something to strip away the bitwise/
recover the underlying type? Something like __unbitwiseof() or
__underlying_typeof() (some better name is needed)?

Implementing directly what's needed here, something like __is_signed_type()
would be possible too but is a bit too specialized and so much less useful.

-- Luc Van Oostenryck
