Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C95C48BDF
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A2861481
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 13:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFOOA0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 10:00:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231416AbhFOOAV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 10:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623765497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=odQ0Lu/tCh1+kB0NSeyzTA0utkTWcjcG/MNkt+xpzl0=;
        b=ij3QgyGVf/NWPDlDrw6FrOo7y4e9TDx1uWzfxGwJGuf+ZilXJsINo5gTpYEGM0tIP/XA8o
        TWYjh87dBa3ibx4Lfvs8+rH4MmFjFfXPeOqrdCq59lZ3uzbH3jNW7UoIb3IV9duRuKil6z
        gb0Bj5hgGXsofeE8386K9m7yS1IEQSk=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-gWFUIiuvO2S6Vk0TrlEDJw-1; Tue, 15 Jun 2021 09:58:14 -0400
X-MC-Unique: gWFUIiuvO2S6Vk0TrlEDJw-1
Received: by mail-yb1-f199.google.com with SMTP id j7-20020a258b870000b029052360b1e3e2so19905154ybl.8
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 06:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odQ0Lu/tCh1+kB0NSeyzTA0utkTWcjcG/MNkt+xpzl0=;
        b=ALNfJnKuwawRmGYupmcGtyhwagG+r4HsQvPGwODgklXVo1Amxzx9DE6ylXDCTYI+4f
         NaHdIELs1KK37QzFh6wvX340/2ht6sicmQgu0TpswEo1Y/7sZ2jWX+9vNnnmcjvkbGdw
         QhGnfMYXNoYIEFNCnf9gYZLcfa/NRJkeNtZL0fHLRvKhB3dW/bSxAhd+2k1SVvmIcxWN
         Q9Ur79gdutNDeJEhqsX3XdP7XF+7dVyEffO41yxxCQHCjRbuOomfdDS+lSmoIHTCnvVe
         TCSVoAkFdEaKwHCetHMqz2K4zOWu9Bl9EC+X+3dbRL5xZHWR6rA/lSrZZ2oP1B/Ywkir
         MB4w==
X-Gm-Message-State: AOAM532lG07Xl8Z4pARQFfQ7hwrJPLuZ3hBWY3du/GLASM38wRGBaEh6
        zjinfR8Fp+sI1NMrxdiH8gB3hnnuAh4GxBDk2NZQAox5PAE7DKzmIdPNMmXEjHd6gZtUhoxC+Gb
        +CJMYEu929anHTdqlQuzTs+MsTFc4niqdNRkbpOA=
X-Received: by 2002:a25:248d:: with SMTP id k135mr6205786ybk.305.1623765494226;
        Tue, 15 Jun 2021 06:58:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyWxJDKWiofTKoKNSY8gnaihrPtWg0cWoBhfQDAiUJPDdqrogIVxPKfX3cHx850Y7cHua0Cu2IPllzCBKKDNTg=
X-Received: by 2002:a25:248d:: with SMTP id k135mr6205751ybk.305.1623765494059;
 Tue, 15 Jun 2021 06:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <cki.E3198A727A.0A5WS1XUPX@redhat.com> <CA+QYu4qjrzyjM_zgJ8SSZ-zsodcK=uk8xToAVR3+kmOdNZfgZQ@mail.gmail.com>
 <20210615115243.GA12378@lst.de>
In-Reply-To: <20210615115243.GA12378@lst.de>
From:   Ming Lei <ming.lei@redhat.com>
Date:   Tue, 15 Jun 2021 21:58:03 +0800
Message-ID: <CAFj5m9Kp4T1R_RB1B4W3dvjU5M17wWCZ6OVbvYWjXLcGvab6=A@mail.gmail.com>
Subject: Re: ? PANICKED: Test report for kernel 5.13.0-rc3 (block, 30ec225a)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Bruno Goncalves <bgoncalv@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        skt-results-master@redhat.com, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Fine Fan <ffan@redhat.com>,
        Jeff Bastian <jbastian@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 15, 2021 at 7:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Jun 14, 2021 at 02:40:58PM +0200, Bruno Goncalves wrote:
> > Hi,
> >
> > We've noticed a kernel oops during the stress-ng test on aarch64 more log
> > details on [1]. Christoph, do you think this could be related to the recent
> > blk_cleanup_disk changes [2]?
>
> It doesn't really look very related.  Any chance you could bisect it?

It should be the wrong order between freeing tagset and cleanup disk:

static void loop_remove(struct loop_device *lo)
{
        ...
        blk_mq_free_tag_set(&lo->tag_set);
        blk_cleanup_disk(lo->lo_disk);
        ...
 }

