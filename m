Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B960EC433DB
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 789F864FC6
	for <linux-block@archiver.kernel.org>; Wed, 10 Mar 2021 23:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhCJXaa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 10 Mar 2021 18:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbhCJXaQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 10 Mar 2021 18:30:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1BFC061574
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 15:30:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so365613edx.1
        for <linux-block@vger.kernel.org>; Wed, 10 Mar 2021 15:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vuj/D7o1+/AE9t3wM/vQsuPf0MOJqhA/d5cfPutvQfU=;
        b=o2uQ9nbLBO9R5FOm8KE2FiXDRix0GjxEoucgtHfPLR/wQNZblGYKZeUbZaB3a3gVls
         j5myReVOVSv8e+2as+yWYoc126H5rXjnDz1S/XKEZZqyjP5CjOuJtJdCXwtvh1gGajGB
         AttnNRUhzEiJr3aYXULMyxlHaZvK4tQR2BqqciENC5bZuYnHlM/sDf07rKUZp/9ev5Cl
         YaTNrQmG9WizlGQCUI2TAeuVaoqvCRRHdWDslVQgyQLqCWkKN4ZG/iNSyYEhHzvH3WFj
         K4JoRLLeA8DgfDKV+deTn3ktf5nSBZdM2H3ftPJJGmo54eTR0tvDEMLQuNJeSgoQMGGN
         ngGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vuj/D7o1+/AE9t3wM/vQsuPf0MOJqhA/d5cfPutvQfU=;
        b=enFrI87HAn1EX9stkJit7r8eStOMvCmI3BA4ds2wqMw1CFrRPtnqzdTVirX2y5jbdx
         CJDS2xmqSyoPKNpsUYcUuQole24lo5SX1gCW1LPE+O2cBkdPBJUOnfDLCHiMv9LCmOEr
         S8R5Yrc0eqCJOsrm+lZVk3Mk2f2kq6LAcJAbz1UPNEDi8AEcoDWbhxOPrzL79JGSgWSs
         fBPZX0WgokGRL47PXauVcCqMd4JluCWeegQghMLxyeQ2x0Vs94wkDyDl71rEkETUsUQx
         mtr/aMKuHlbciAPsGnI+LBubcPFJZ/LFo+RH8VnBjokePSnOQKGRxKctqGNd3WTwRFYh
         BYsg==
X-Gm-Message-State: AOAM532mbP2NAeDJwcCykV3AUlatBfp/SkM3dGmRBU0Rpoj7AzKfIrXK
        tLl57M5GGiMuM2xCcUJqbX8oaVrILEj0KE5cs81K0Q==
X-Google-Smtp-Source: ABdhPJyAUtjsQZeO+IyfOJ0D71CMa4kn2W9c7sy/JaW+YXPD6tUcwvd9d32TJu/3+N1X9rS+ufsB+LKVJeI/Uw+LbQg=
X-Received: by 2002:aa7:c3cd:: with SMTP id l13mr5720329edr.52.1615419014504;
 Wed, 10 Mar 2021 15:30:14 -0800 (PST)
MIME-Version: 1.0
References: <161534060720.528671.2341213328968989192.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20210310065425.GA1794@lst.de>
In-Reply-To: <20210310065425.GA1794@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 10 Mar 2021 15:30:02 -0800
Message-ID: <CAPcyv4i4SUEd_zg7HyuqpE3_KUQU=4Pci40CKX7aM6NNsy9wew@mail.gmail.com>
Subject: Re: [PATCH v2] libnvdimm: Notify disk drivers to revalidate region read-only
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Ming Lei <ming.lei@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
        kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 9, 2021 at 10:54 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks good to me:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Question on the pre-existing code: given that nvdimm_check_and_set_ro is
> the only caller of set_disk_ro for nvdimm devices, we'll also get
> the message when initially setting up any read-only disk.  Is that
> intentional?

Yeah, that's intentional. There's no other notification that userspace
would be looking for by default besides the kernel log, and the block
device name is more meaningful than the region name, or the nvdimm
device status for that matter.
