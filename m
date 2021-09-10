Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB99C433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 08:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2EC611C0
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 08:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbhIJIBL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 10 Sep 2021 04:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIBL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Sep 2021 04:01:11 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B97C061756
        for <linux-block@vger.kernel.org>; Fri, 10 Sep 2021 01:00:00 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v10so1352566wrd.4
        for <linux-block@vger.kernel.org>; Fri, 10 Sep 2021 01:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2EzhBx0PMRhfQS+NCG8vRKNuqi8wvz9u9B7rxHri58Y=;
        b=E0DfoaGEIzIETU2U9nlDTMsDxsk6mxe6rJGuVJvcSjalHiPPxlhxmcFUiyW65bm5Hs
         Xr9DNGZQ/xUU2CN3mHBLPdD7JcOwJLwTI8E4Jqe7sC1H72ZmIqicOyKA+GQ7TKz8UsN8
         Gyqczex7Ki2C7QjEFHeUWmr2H67qtKv5dUso2KIbqYitIvtMkcUHcihkC+sBIkeHXx3b
         3sHou5sK9QUi12XYqGEMjbY36NmZsZ4EbU5Kbm9h6abXCIJisybZvfZZCU01LTEldJi3
         NfqhIExPj4wJpl9pUWvV6jL4tcq8HEm5NP/cOlhlSTrg+POAX66HWhSpMwFNDxsUUfXB
         itTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2EzhBx0PMRhfQS+NCG8vRKNuqi8wvz9u9B7rxHri58Y=;
        b=ZjT+8BGuP6UrEPhY4tCfvAZDnXSpxv0v8GuUlz18t89dvMG4cejIk9OnVRG2YZmUxI
         2/zim0oHgYYbdAsliNRgQkdfp4vETa/sVRelDgas+/7nM68VMwOqwgQwIyysMaU/L/Uc
         K370N+vkM/2wQIM+f0qTvzpLSASR18EWHYY4o++qrX6yC+mvkgAPZirTxMmmynJnxWL4
         i9r04rYUPElyycEo+CnCFQ4Py5ADVP46luan0llRGohqs8xJkqKoASZupqWzUoe9sZQQ
         iVDpG9RNd2nXqxK6oil5zIkr1lM/iJSrPpATly5gplR6HyeFa9GbUMQMy+sAXaeeBiqr
         af0g==
X-Gm-Message-State: AOAM533bqLRZbY4f5Dvxn6IBByJ2nisxZ2a61g68XGUuJeFnauZf2nAp
        N2SaSNVE3sZeF2FucphFOitQiA==
X-Google-Smtp-Source: ABdhPJzGKyhjbB05EoODWX7RadvRd0lWPb0a6qFzw7tW2w8J8Ob027f0aDUlDoU6kIz9G64ctbqnPQ==
X-Received: by 2002:adf:f18a:: with SMTP id h10mr8345599wro.42.1631260798922;
        Fri, 10 Sep 2021 00:59:58 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id i5sm3288201wmq.17.2021.09.10.00.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 00:59:58 -0700 (PDT)
Date:   Fri, 10 Sep 2021 08:59:56 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Lukas Prediger <lumip@lumip.de>, axboe@kernel.dk,
        hch@infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTsQfBwSPkZasDff@equinox>
References: <409876e1-1293-932d-8d37-0211bef07749@infradead.org>
 <20210909180553.8299-1-lumip@lumip.de>
 <10f60086-2be0-d26d-dfa6-fe128772a409@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10f60086-2be0-d26d-dfa6-fe128772a409@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 09, 2021 at 06:25:35PM -0700, Randy Dunlap wrote:
> I have no problem with Jens's suggestion.  It would look more like this:
> 
> +{
> +	__s64	last_media_change;	/* Timestamp of the last detected media
> +					 * change in ms. May be set by caller, updated
> +					 * upon successful return of ioctl.
> +					 */
> +	__u64	media_flags;		/* various <struct> flags */
> 
> #define MEDIA_CHANGED			0x1 /* Set to 1 by ioctl if last detected media */
> /* other bits of media_flags available for future use */
> 
> 
> and not having __u64 has_changed;
> which is overkill for a flag.
> 
> -- 
> ~Randy
> 

Yeah I like this, good idea. Thanks.

Regards,
Phil
