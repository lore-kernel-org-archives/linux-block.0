Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55BDC4338F
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CF360F9E
	for <linux-block@archiver.kernel.org>; Wed, 28 Jul 2021 01:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhG1BaP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 21:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhG1BaP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 21:30:15 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA1C061760
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:30:13 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e14so725516plh.8
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 18:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F/W78E3w8bd3psxYX0IIxref8Eo+wzHY8m4KRkXjPMs=;
        b=fSpVrx2KFTwbTxZxaxYBjKJ9a3HRRpiHfBG8wD07VjuWC7mdbYEQ/7GkiPoSY+/g36
         +TtB+dCcoMKG1TPpgjH+W/O2nqputas/NPxb5d/iKCDtXteeWA5Muau5Hiw7k0rZrmBp
         XaotHXeRLZbN2gC+C3tJaqkKc+t5iWRCRbObY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F/W78E3w8bd3psxYX0IIxref8Eo+wzHY8m4KRkXjPMs=;
        b=I/O97vYNibgYf6DLKYNMTyrTv6KQsmeyudl8Lq1p4WCR8v3ltUmXIsREcaE8fgce8V
         pDKo7IId/E9qiO1qzV8ocrNasNd3/iZPYpodrsufqXucw72tTiGUeHJKPNHsfjHfNPKh
         +h8ZlaFk/rjtTpkoJ8al5oJtoW5HT+dQmfyevf2qQ6M3gWr50xeZOhw8c52n+4Tm2rWZ
         GpEIveETpuOs5kJHVcOUcKxERcEicPbUKJnSF6LMJHuel+uhSfBlliSUKFqgfWvooN11
         p5vYBKp4JrWpCXQse5gYFZ6Vcty2tBEBqybA8VyNpZakZ2r7WnjcADzvAo50mFvWi51X
         8BZg==
X-Gm-Message-State: AOAM53073H0TStC4JNgdv3cTZih+0/ny3HNWPjevfX8rxEvkZfu6S/nC
        qYXo7A4pbwK3Fb4sgC/zDeUU8g==
X-Google-Smtp-Source: ABdhPJwJtaC/+3L1bVkg9P8zv+anpCg9BvvGSgBVtWnX3lLVWENuhM7S6jL/vTi/ew8TMCXVE//XxA==
X-Received: by 2002:a17:90a:ca93:: with SMTP id y19mr7226022pjt.142.1627435813032;
        Tue, 27 Jul 2021 18:30:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r13sm5628761pgi.78.2021.07.27.18.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 18:30:12 -0700 (PDT)
Date:   Tue, 27 Jul 2021 18:30:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 33/64] lib: Introduce CONFIG_TEST_MEMCPY
Message-ID: <202107271829.CE9BADDB@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-34-keescook@chromium.org>
 <9827144a-dacf-61dc-d554-6c69434708de@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9827144a-dacf-61dc-d554-6c69434708de@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 27, 2021 at 04:31:03PM -0700, Bart Van Assche wrote:
> On 7/27/21 1:58 PM, Kees Cook wrote:
> > +static int __init test_memcpy_init(void)
> > +{
> > +	int err = 0;
> > +
> > +	err |= test_memcpy();
> > +	err |= test_memmove();
> > +	err |= test_memset();
> > +
> > +	if (err) {
> > +		pr_warn("FAIL!\n");
> > +		err = -EINVAL;
> > +	} else {
> > +		pr_info("all tests passed\n");
> > +	}
> > +
> > +	return err;
> > +}
> > +
> > +static void __exit test_memcpy_exit(void)
> > +{ }
> > +
> > +module_init(test_memcpy_init);
> > +module_exit(test_memcpy_exit);
> > +MODULE_LICENSE("GPL");
> 
> Has it been considered to implement this test using the Kunit framework?

Good point! I will see if that works here; it would make sense to make
this KUnit from the start.

-- 
Kees Cook
