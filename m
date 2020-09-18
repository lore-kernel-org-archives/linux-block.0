Return-Path: <SRS0=GCUE=C3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C5BC43464
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C57A21D7B
	for <linux-block@archiver.kernel.org>; Fri, 18 Sep 2020 14:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600440387;
	bh=Ujby03RawZFbaBolJ4HLl3xztbQz8b8kH5bKPGGs9LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2ZgJSJfVJ/6EJBuzLtI6QnD2NTko4rlj0jG1k2l2b3f+/riOJboGszCxYuQYeRkrG
	 PTD47qRCZX0kVmAogEoAkDGO16UxHR8xo/uret75mvlMcUJaHSMkCVPzMWJlC/o8PV
	 P+rwGtgPe91Q9H5fzoldvNJULxa4DFcBxafsmc1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIROq1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Sep 2020 10:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbgIROq0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Sep 2020 10:46:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E52C0613CE;
        Fri, 18 Sep 2020 07:46:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 67so3590314pgd.12;
        Fri, 18 Sep 2020 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O2gKBbjWeOUkcv+S6dyzsOFS6GQkgFkqNOlDLf528KI=;
        b=PRyXB/v06JWW/jjQrBtLKBRDF5ULq3jwiUkJXCc+xg9NWxBsgS2p6S8riGC2VtVb0T
         4+umuO0rdo/OJYloVdJ0Vn/8HarelyIPzMI/ok4RDRdQ07C9h/2vWyR451p0Z3CAh3l3
         MGbdammsOH3hOHr+ZBeId/pu2B4YQwaLYPRLA/RF5sOciTQFjOzhVcvgWQQD3/Y9zOtF
         WDrTGfKemfvpkFH67pJGX/VTyFju7j/f8CoxG6h5K/P3ZeTETBb8lo2ToT16Buj74hbG
         VL1+ku4i2qa0/t7ThPXuFwaWPtkfCIQTkParrQJkCi6rFj8HR5isExBdeLdl2i3YseoW
         QyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=O2gKBbjWeOUkcv+S6dyzsOFS6GQkgFkqNOlDLf528KI=;
        b=maXgEWkg1DDIQfEruvf60DxlH8ZtM/6xycT08VvF/tfwBO2wqFrPPc35miT/sHVu2r
         IvWW2OeewRxw6eCdRPYmuLbe1wkmElk8A99gjqyHxBRqv4OgogXPVYCu2XAkV4WCVGv9
         xHpgP8RyL6vRsL03YYgirHLxjjarstnq8pTwJBXf+Wy0xjQKyxEahACxOCh+FL/DMqPo
         xuHYV9rgqAZ3Ak4A2kw6WfMuwS1BXFUfq9RstRmNegikZe6QuwQ3mjPBGdCAXnrDnUcQ
         Ds8qIvSUL3YhE8iwr+FNlDf2tH2b8651H3TuZxfzcVl4pQfh0a3v2vCSTRaB0A9t/nHn
         Dy4Q==
X-Gm-Message-State: AOAM532kOXdAYWAgG+3DmnnWlOCugOMkop2k+V5Hbd//go3oDUEl7gca
        4S0SchrijM0EQHEcree+eN0=
X-Google-Smtp-Source: ABdhPJz4CI4TCh/puGQapmXeVYctrnDdDOVVqoI68FbGBp0ftdovIvo6SkLSDQNG4grnPI9Tp23Fcw==
X-Received: by 2002:aa7:9635:0:b029:142:2501:3980 with SMTP id r21-20020aa796350000b029014225013980mr16298544pfg.69.1600440386234;
        Fri, 18 Sep 2020 07:46:26 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id e16sm3397040pgv.81.2020.09.18.07.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 07:46:24 -0700 (PDT)
Date:   Fri, 18 Sep 2020 07:46:23 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        sonnyrao@chromium.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zram: Failing to decompress is WARN_ON worthy
Message-ID: <20200918144623.GA748396@google.com>
References: <20200917174059.1.If09c882545dbe432268f7a67a4d4cfcb6caace4f@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917174059.1.If09c882545dbe432268f7a67a4d4cfcb6caace4f@changeid>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 17, 2020 at 05:41:20PM -0700, Douglas Anderson wrote:
> If we fail to decompress in zram it's a pretty serious problem.  We
> were entrusted to be able to decompress the old data but we failed.
> Either we've got some crazy bug in the compression code or we've got
> memory corruption.
> 
> At the moment, when this happens the log looks like this:
> 
>   ERR kernel: [ 1833.099861] zram: Decompression failed! err=-22, page=336112
>   ERR kernel: [ 1833.099881] zram: Decompression failed! err=-22, page=336112
>   ALERT kernel: [ 1833.099886] Read-error on swap-device (253:0:2688896)
> 
> It is true that we have an "ALERT" level log in there, but (at least
> to me) it feels like even this isn't enough to impart the seriousness
> of this error.  Let's convert to a WARN_ON.  Note that WARN_ON is
> automatically "unlikely" so we can simply replace the old annotation
> with the new one.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
