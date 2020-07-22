Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F75BC433E2
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 18:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F10208E4
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 18:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ni0DuArt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGVSIf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgGVSIe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 14:08:34 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5005C0619DC;
        Wed, 22 Jul 2020 11:08:34 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so1377014plm.10;
        Wed, 22 Jul 2020 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uAqHhbL8Bv/ZNYIQ4GNW4miZnWZzAlf8d/zWNsbgOgM=;
        b=Ni0DuArt5evdxjjJbC673B9IK6n1LEB66RemFkvlPRNbxtJxk10YPsrSUH8klxbWQE
         v7fpcGsc27Ebd3mk/aOWe7Zv5ZAviu4OOYP5WhGzVLoppzgeE3f/1nzk7rJyjBxZZioW
         +QbO+g70jD5M1oEL9O3M0oZk9vcxEE0iUdIQZiaSuElf+XOOeBX3vSSGZL8ars+JwytC
         Lwi3IGid4++GquLS8Wcs7GzEULVKq0jOLnI7s/1a51smJJL/LwFZ+ZJOXvt87igU0Bhm
         B6UbqrbFNy+Lvvht3deTCHIpEILFzZrPzrgJuoVfSbESWNhwFKQEpKA0BkfnmuWSY2Zy
         AX8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAqHhbL8Bv/ZNYIQ4GNW4miZnWZzAlf8d/zWNsbgOgM=;
        b=PCKgAeZyTgf91S8YMy8wMIFKDLzIGw9tRpac3xmZ1CZYfmN3v8FaQ4nfyNU6BzWg8a
         1zRU1DbbSH1VW88xjbR2ssBV7aiCHuHyy/OmpXfMi5r71bRFzfnDGeJ4R4fmf4fqG3X9
         FCySX6aKD/dfEKbF7InRDr+ci0n8n2k+UJ7ehMH5kefiZiaKeg6YFaZgbgQoVsl1HBL7
         JOVQuamvbz6Uz4Nm51rY/FKyuCoRVIqXDXfSlwWT4UGv2/84cAxBES8BFlCgXaKB5cYO
         ReW1KckgTPEx745TJdAEeE1eXxnTv8/ib0zXvjTcHKYhKTBbVqNa1Hp0P9wafI0E/l/o
         d6/A==
X-Gm-Message-State: AOAM530DvkwKtbMfFigwzIF/Ig1ELEIblSY+P1TMGX46paOMRw3+sztg
        lMR28e5zpRKqZjjGqBlU+Ec=
X-Google-Smtp-Source: ABdhPJyIYxrSDW6ruHrOIuq3057oRw1Bh7OoBHkfqMIeHRSypstq6dmCdXHxVSaeQp+1iy3Qm0kVSw==
X-Received: by 2002:a17:90b:811:: with SMTP id bk17mr535628pjb.183.1595441314266;
        Wed, 22 Jul 2020 11:08:34 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id z11sm277591pfj.104.2020.07.22.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 11:08:33 -0700 (PDT)
Date:   Wed, 22 Jul 2020 23:37:01 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] skd: use generic power management
Message-ID: <20200722180701.GA616@gmail.com>
References: <20200721070939.GB51743@gmail.com>
 <20200722175247.GA1293794@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200722175247.GA1293794@bjorn-Precision-5520>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 22, 2020 at 12:52:47PM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 21, 2020 at 12:39:39PM +0530, Vaibhav Gupta wrote:
> > Okay. I will improve on it. Just inform me after testing that if any other
> > changes are required. I guess [PATCH 1/3] and [PATCH 2/3] are okay, so I will
> > only send v3 of [PATCH 3/3] after suggested changes.
> 
> FWIW, there's a recent conversation on users@linux.kernel.org about
> updating individual patches in a series (sorry, can't find a link to
> it).  But the gist of it was that posting only [v3 3/3] leads to
> confusion because
> 
>   - we can't tell whether [v3 1/3] and [v3 2/3] got lost en-route, and
> 
>   - collecting things from v2 and v3 is more work for the maintainer.
> 
> Bottom line: repost the whole series, even if some patches haven't
> changed.
Thanks a lot for updating me with the info :D .
I sent the whole series as v3 hours ago.

--Vaibhav Gupta
> 
> Bjorn
