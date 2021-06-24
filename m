Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912EEC48BDF
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 10:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DBFC613FC
	for <linux-block@archiver.kernel.org>; Thu, 24 Jun 2021 10:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhFXKGh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 06:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhFXKGg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 06:06:36 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED0C061574;
        Thu, 24 Jun 2021 03:04:18 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5047723otl.0;
        Thu, 24 Jun 2021 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nl1+VNWKIb1LF2pwZvKJJ4GC2fkN1Iqi7Pk0zPEUOE0=;
        b=NwZ8oiDXegfYp8rMFYg3pVmzyThIB9ROoftrwe+j8mLZDhuNZbkVklCE4/dD4J0N7/
         yn5OR7rxSh16ndI/5WDWah6H88S5t8rq0kcfcQr/ZkmUmGjyLEBm3Jx4hXPrCMinNJwX
         cJRM1LccyX9qEeQC4Ws2dC/k8CTui/fTKEj/M8qFECZm8luj8kHVnrVoR476HkCtS571
         1UE7fpBELF765OnAGiLttJ7pyVIgz4AAWls31v/ujlD7m//TvYGQ/E2T5xFTTb4mwzrQ
         CSZ7cDuCBumdhEmIMu9E/3Z1NyWsyTV0d5gG4r6J0GCC7e6DaKnzBQjh44pqJRMcQs7Q
         X8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nl1+VNWKIb1LF2pwZvKJJ4GC2fkN1Iqi7Pk0zPEUOE0=;
        b=pr7oXLDkrFPpE8AAljeKqdZE+aZGKJ2pQ5BWXe7Qz6Cx9k9tX4GhgGLNN2JFMnu88g
         phoODwd+nEg+8oHbgN7m1WmD+8JChzcfGq1I0kcp9+cSWaNXmxCecrS08Iw3q5Pqx66p
         /R1qJ4HTlxvhW+7N1sjZqXtK2KClZuFBRDO+YVghDDZ57b6fuxH/VHSaahaga69m4We4
         AhC7tsF0ZIPkQhIn+j/1AQEJ91YAnL5+wt1wX60/bGnrmGf0aVGpPupBMrZzYCZeqKl5
         oSrJQT/1gftjb3NKCXnu0/qUxJW/XMHqgv9JrKVAqicq6pUzqRTZPJbCB1zzWW7BjHRF
         1hvg==
X-Gm-Message-State: AOAM530h+r74gBuN3FWgyYPkQ5XVZapHBeRLD8fEbj7/emCffjLT589I
        Q/C+KNCYb1cVpiIPJRba7kA=
X-Google-Smtp-Source: ABdhPJzsULLTd7WyQU7NLUUKR84QFffjslMChnoKcCOBgchH6lIyHzkOq+ywjZFNKwnk5q6bUeNbEA==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr3873230ots.153.1624529057550;
        Thu, 24 Jun 2021 03:04:17 -0700 (PDT)
Received: from fractal ([2600:1700:1151:2380:2770:dacf:615a:4fe7])
        by smtp.gmail.com with ESMTPSA id l25sm552227oie.57.2021.06.24.03.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 03:04:17 -0700 (PDT)
Date:   Thu, 24 Jun 2021 03:04:15 -0700
From:   Satya Tangirala <satyaprateek2357@gmail.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 07/10] mmc: handle error from blk_ksm_register()
Message-ID: <20210624100415.GA4845@fractal>
References: <20210604195900.2096121-1-satyat@google.com>
 <20210604195900.2096121-8-satyat@google.com>
 <YMrAn7EkKkNVEjUW@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMrAn7EkKkNVEjUW@sol.localdomain>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 16, 2021 at 08:25:19PM -0700, Eric Biggers wrote:
> On Fri, Jun 04, 2021 at 07:58:57PM +0000, Satya Tangirala wrote:
> > +		/*
> > +		 * This WARN_ON should never trigger since &host->ksm won't be
> > +		 * "empty" (i.e. will support at least 1 crypto capability), an
> > +		 * MMC device's request queue doesn't support integrity, and
> > +		 * it also satisfies all the block layer constraints (i.e.
> > +		 * supports SG gaps, doesn't have chunk sectors, has a
> > +		 * sufficiently large supported max_segments per bio)
> > +		 */
> > +		WARN_ON(!blk_ksm_register(&host->ksm, q));
> > +	}
> >  }
> 
> There appear to be some MMC host drivers that set max_segments to 1, so this
> explanation may not hold.  It may hold for every driver that actually supports
> crypto, though.
Yeah, I think it does hold for every driver that actually supports
crypto. I'll check this more carefully before sending out the next
version.
> 
> - Eric
