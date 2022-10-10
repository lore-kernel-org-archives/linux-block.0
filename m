Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BF6C433FE
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 13:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiJJNep (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 09:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJNeo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 09:34:44 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56675B49F
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 06:34:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id s20so16591908lfi.11
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pnRn9aBbQALc8l0f36wizDIxcat1IFTbbCH6/Nj/ClI=;
        b=CfY4+fFkIkoEms6Nm3+d2vRwQLcw/4pinnyN+blBXiTZ0yQ10qIbJekKYs/MNZv3lh
         6VmQQzYpDP7Lbo1ivcxaPGSqQ1diHgXyiKwaJwkUo2cBge0+SHgeqPINZe3KufFdoTZ9
         S4G35WTsNmMtaf1/BFjPQFRmyOfH5uUIYLvHPn32WGGFXw3RnCjU2wuljOcLuO+lZaFI
         399+zhh6+F55IGWoaFG+gj7HqpbXMxj/ib/dg3NXwo+IJ/mAYuHLD/AvhAyyiNsGGdpx
         6po0wGjaw1wFuWaqAuPFrZSAG1vvRmYJfMj7wAqGLUHkt9sPwi3scCGNXPG3quZ6nV7R
         EDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pnRn9aBbQALc8l0f36wizDIxcat1IFTbbCH6/Nj/ClI=;
        b=y3zTTXqXmoTGLV46L9k7jWLMCb6GtwUAgpWyqFLCRf7FzqIikGSx8+ySjqsmvXrvAf
         0x8gVlFVPa1E3ICJgwGI0c8dP4mUkfLj6OIgZ6v+oOTcM2CC6RN0hJRwkCVuYw0+Usc8
         3wy//zgS3QVbJJkI6UuRhXH0p/99Fzdc7p7tvRiEW5ErBM5uonCGnV/vJahiFWyckxB+
         IlVK9HVz28DnJ5RsIq+ukZd2+GhnX9D/UWHs7JDFzkIZUva9kJvHeyYu25wn6g++ICFD
         PGkzcmiq37WwyPtHWGoT2bHUh0Pd+G49TlaWfiCGCqSUSTOWNNA1XPaIV3IMAk4xYMlL
         8QRg==
X-Gm-Message-State: ACrzQf2T7KuUMbnAyWppoXX0zyHh4Pa5NUJNuq7C8Z9qjwlbERAFP4la
        O/3k3mtJfLhdfw3tPEvUD4o6uIXz4QtPC3nsxHS3YkARyZrpQJvS
X-Google-Smtp-Source: AMsMyM42LPuxFerp2BTzuFdRDO+P1ZGtmekZ9tBg1g200arCGljJEQAftkVtuhf+PFv5etSt5ZUXTaAwMzHxrAnNsbs=
X-Received: by 2002:a05:6512:3da2:b0:4a2:6fb7:b64b with SMTP id
 k34-20020a0565123da200b004a26fb7b64bmr6371039lfv.442.1665408880539; Mon, 10
 Oct 2022 06:34:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221010131857.748129-1-hch@lst.de>
In-Reply-To: <20221010131857.748129-1-hch@lst.de>
From:   Keith Busch <keith.busch@gmail.com>
Date:   Mon, 10 Oct 2022 15:34:22 +0200
Message-ID: <CAOSXXT6GSf+xsUP=RobpbGrggG0Raob-A13stU3UdpV-c+ue-w@mail.gmail.com>
Subject: Re: [PATCH] block: fix leaking minors of hidden disks
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 10, 2022 at 3:19 PM Christoph Hellwig <hch@lst.de> wrote:
>
> The major/minor of a hidden gendisk is not propagated to the block
> device because it is never registered using bdev_add.  But the lack of
> bd_dev also causes the dynamic major minor number not to be freed.
> Assign bd_dev manually to ensure the dynamic major minor gets freed.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>
