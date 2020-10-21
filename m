Return-Path: <SRS0=zsIv=D4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0892C388F9
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAA222283
	for <linux-block@archiver.kernel.org>; Wed, 21 Oct 2020 14:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441206AbgJUOYT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Oct 2020 10:24:19 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42565 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388975AbgJUOYT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Oct 2020 10:24:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id x13so1568868pfa.9;
        Wed, 21 Oct 2020 07:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kd24n8fvExqkMZoTQn7ZLbjiXdKLPg+Z9WhqJAOkLno=;
        b=XWHyi5y3L7LufXP4cUT+y2T8cASFrWbqFR+NNfKmjAczEJC1bgQqPNHlJL0Qo2cccF
         322HT8/VBJn1cqZ+V8E/1Y2g22qOA7q1Z/ZIXH94FeTs8/OBm70RXjZ5VLa2wdMJ17wz
         F9sB/Xbg94zNF/Tb1ORB3oewYa2GTxJtV70OLeXUVgSL5gwQlyHeWCDo4pac/2z9G15d
         jlGzek9sOu2K9MrXyWIwxNJwN3w48utbOT4BOgFELKjZeYZ5Fm3S6wPkAiGv1/jiJ+4I
         eiLaTGmzsZnWd7/ko0uMcMrVkbET8xhTT2Fp+FJqV7/OSAInxSRP61LFxNjko/CG9ou0
         CbqQ==
X-Gm-Message-State: AOAM532H4ScbvJnCH0xeP1g7bgFfsTgcRRmA9tn3ARJ7oSERcvJNFXsK
        M+AzrWH4f150RpmKhJRAphmY9zGwpRAzsntowzY=
X-Google-Smtp-Source: ABdhPJzzUagLy2/wTR2reR/iEjOUzGDitwgsUDsCMI6OUJ3VjWJ4T7EinTswEywdjKJZfSeH/cpZeoxXijk2LTN0EIQ=
X-Received: by 2002:a63:a546:: with SMTP id r6mr3613847pgu.160.1603290258598;
 Wed, 21 Oct 2020 07:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201012162736.65241-1-nmeeramohide@micron.com>
 <20201015080254.GA31136@infradead.org> <SN6PR08MB420880574E0705BBC80EC1A3B3030@SN6PR08MB4208.namprd08.prod.outlook.com>
 <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
In-Reply-To: <CAPcyv4j7a0gq++rL--2W33fL4+S0asYjYkvfBfs+hY+3J=c_GA@mail.gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
Date:   Wed, 21 Oct 2020 10:24:05 -0400
Message-ID: <CAMM=eLf+2VYHB6vZVjn_=GA5uXJWKL-d6PuCpHEBPz=_Loe58A@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 00/22] add Object Storage Media Pool (mpool)
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Nabeel Meeramohideen Mohamed (nmeeramohide)" 
        <nmeeramohide@micron.com>, Christoph Hellwig <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Steve Moyer (smoyer)" <smoyer@micron.com>,
        "Greg Becker (gbecker)" <gbecker@micron.com>,
        "Pierre Labat (plabat)" <plabat@micron.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        device-mapper development <dm-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Dan,

On Fri, Oct 16, 2020 at 6:38 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Oct 16, 2020 at 2:59 PM Nabeel Meeramohideen Mohamed
> (nmeeramohide) <nmeeramohide@micron.com> wrote:
>
> > (5) Representing an mpool as a /dev/mpool/<mpool-name> device file provides a
> > convenient mechanism for controlling access to and managing the multiple storage
> > volumes, and in the future pmem devices, that may comprise an logical mpool.
>
> Christoph and I have talked about replacing the pmem driver's
> dependence on device-mapper for pooling.

Was this discussion done publicly or private?  If public please share
a pointer to the thread.

I'd really like to understand the problem statement that is leading to
pursuing a pmem native alternative to existing DM.

Thanks,
Mike
