Return-Path: <SRS0=E+wN=EK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B35F4C2D0A3
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C47A20782
	for <linux-block@archiver.kernel.org>; Wed,  4 Nov 2020 20:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604522518;
	bh=YcRSXAd//ZL/LuZ2fxQljMLJgZ+gdPrEKso/5hIM+Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WfrF4nd1qWUgmnk4vryoofnMd4ORt0fWJ7FC6DojoMR+c3W6BS9xOhQEpSce6kVYn
	 IYB6ogSTTLhMDRwBoRG/o79AktEneIuMmaK5lYwdyr/Nj+/gIE/jTFlUnV6393L4U+
	 3nZc350HV37BWIDDJfGnzQQozJoBQ8CPB7XlEyFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgKDUl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Nov 2020 15:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730143AbgKDUl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Nov 2020 15:41:57 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5999FC0613D3;
        Wed,  4 Nov 2020 12:41:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id w11so10837113pll.8;
        Wed, 04 Nov 2020 12:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a8St5pp0soPrSjxzCNc27dEA06gKv09iB+TVe3CnsMY=;
        b=uqdCDgvOmupZcK7zwHTNXU441hXO1xdR22KOSJ2rBddAzXognkVmA0ReJc+Il9PU6B
         Vfp7YvGk/VWw7jfIrC1A5KcH5qAyBy4jitHfAxP+TLr0HdpcvVrAkq7w/XBbQ2+Wm/Xp
         x7uIB18CFQPQGqkaOvoxqjO63YrSrHWFs8XYDcyd8NL4ffoR0XknHQeb31KdaFiLutZo
         CxzzP7yQ78H3Dh7LTXtP7cPSc3P/JjoAnV9xvN7OnTdFKr5MbBVMOx6K93v2r/B2QoCC
         ONNXuc168ZdkNbLb1dqtghn5t6Xq++ibvgC4b4eRLl+xULCT+yfvUTaO08CnxL61LGuS
         25CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=a8St5pp0soPrSjxzCNc27dEA06gKv09iB+TVe3CnsMY=;
        b=idflmIEDthsLCjoySLhsOqmB/DTQowlEfa0eToP4RC4wgeas7FcgY9x5o/wN76hb+b
         oPs+N2N2yIUeY5c8gLzmj07otjq2OuSfJdx1nkRRGQuQIw/0jtwMRtJ0S+6OKovMLQ/K
         tDOSeJZJQWknvsiX9sijctcirupAIIKkzTrQceCeCIDI6HBCdYLULoyJuaKUpM5UFT+E
         JssCE+EHk+rL0Ja0HuZGS8lqbrPDa9q8KGpTWmjxqsg2wgKOjgIRU4fTb4XPUPivQpJ4
         9Qh3Acv1GYtSC+A5dUKVZE6zXr2yA5wBtr0MXwWU89ry0eWmrDA21pMdi9nuejpYqIPr
         z+9g==
X-Gm-Message-State: AOAM530UtIa0twy/I+fyr92pPD3IS6mhmKs8bNH4Uq2I5f1df9ToZ1jf
        YC3GVJfzaASDxA0S8JhgPBA=
X-Google-Smtp-Source: ABdhPJyi6HdF8YtY0A7PxQD8Of2VjktVmicYLrTLywrYhST/yaFx4oKSj3CnsvqBN7GxkJJ/rs6J+Q==
X-Received: by 2002:a17:902:7882:b029:d6:38a2:8dee with SMTP id q2-20020a1709027882b02900d638a28deemr30199831pll.58.1604522515890;
        Wed, 04 Nov 2020 12:41:55 -0800 (PST)
Received: from google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id a24sm3298962pfl.174.2020.11.04.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 12:41:54 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 Nov 2020 12:41:52 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, ngupta@vflare.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] zram: break the strict dependency from lzo
Message-ID: <20201104204152.GB3544305@google.com>
References: <20201028115921.848-1-rsalvaterra@gmail.com>
 <20201028185927.GB128655@google.com>
 <20201103212847.GA1631979@google.com>
 <CALjTZvZpjgSqT8fRF90yooTV6S5eoz+PBJn7BfesT=y2uW8nmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvZpjgSqT8fRF90yooTV6S5eoz+PBJn7BfesT=y2uW8nmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 04, 2020 at 02:12:35PM +0000, Rui Salvaterra wrote:
> Hi, Minchan,
> 
> On Tue, 3 Nov 2020 at 21:29, Minchan Kim <minchan@kernel.org> wrote:
> >
> > Can't we just provide choice/endchoice in Kconfig to select default
> > comp algorithm from admin?
> 
> I'm fine with whatever you guys decide, just let me know what works
> best for everyone.

Thanks. Sergey, if you don't mined, I'd like to approach more explict
way to select default compressor algorithm in Kconfig.

Do you have any suggestion?

Thank you.
