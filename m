Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BC7ECAAD3
	for <linux-block@archiver.kernel.org>; Fri,  2 Sep 2022 00:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbiIBA3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 20:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiIBA3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 20:29:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27B296750
        for <linux-block@vger.kernel.org>; Thu,  1 Sep 2022 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662078543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
        b=HTleWPQF9AuxVr7rHAYALwMIr9d9MM209Qp2nlGjNaIFqvMwh8jdAxUJdmFd1CYcw/P5YF
        HGUN0Pm0cjOttQyvnxwsBnxLYWDP9W9tzCz1sB+Nu2Ti7ylHpR562o34yqdRFe7LroEzvY
        d0ZiGrko99AQZZ71/NFzVzejIZRvuTI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-453-onLTrBeBMzal0GKNHdxdeQ-1; Thu, 01 Sep 2022 20:29:01 -0400
X-MC-Unique: onLTrBeBMzal0GKNHdxdeQ-1
Received: by mail-qt1-f198.google.com with SMTP id cm10-20020a05622a250a00b003437b745ccdso401318qtb.18
        for <linux-block@vger.kernel.org>; Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
        b=3ntFuGDTfEQI5A1EQ5IX4Urr8aiHuaW0de62jlUk1KszFQL7ihY9IiyahkWHQvqwQ7
         bD+hGk/uq5BYdofSrRm9KdXrORqhGAyPN224AOjE1eCyzW+ZLSfSmlWoJuAzWKUQI7GK
         kjHdnHQNKgPk7R8MoN+025vMIP9DgTBvd8izeIlyTbmlzrLv9BgjLnzjtE4nlSYubTww
         wMZ9HDlYI0oVigAyekUx7Qqcwxv/NGHO+pLLQmJpbO7nP8s8gaiodQlu1Ug37eActcbc
         FXftTsa6yGPcIu5A3EjCsw4WwhpbI8q9bcUhr+sg1RjHm9nTsCUN/QQfL/8z57k3I7PC
         EJuQ==
X-Gm-Message-State: ACgBeo1RogYx8rmmCmTu+tOYm1AUTTlmLkA9u57qoh5vdK/NaGYSGA7r
        Ga9lZBweRzO7gHHvlLpPGK51cpgST4X8bZi3zK1x3qIg4Naaw02mxPtUIy3GLEynuvwWn4XS+Xl
        deHy9tXulrlEqd08Wnm9Cqw==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078605qtw.217.1662078541488;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ummQqIzdjpLP2wlMT3mmzaahpZ4roXiEIZrDjJAlvbH341hXfcfEvnw7FaTjjSfTvav+c8Q==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078588qtw.217.1662078541288;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm180519qtp.23.2022.09.01.17.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:29:00 -0700 (PDT)
Date:   Thu, 1 Sep 2022 20:28:59 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
        damien.lemoal@opensource.wdc.com, hch@lst.de, pankydev8@gmail.com,
        Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
        linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
        gost.dev@samsung.com, bvanassche@acm.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Message-ID: <YxFOS8fq8AeE5mkf@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
 <20220823121859.163903-13-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823121859.163903-13-p.raghav@samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different number of sectors per zone (aka zone size) than the underlying
> device zone size.
> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone size.
> The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

This patch's use of "target type" jargon isn't valid. 

Please say "target feature flag" and rename DM_EMULATED_ZONES to
DM_TARGET_EMULATED_ZONES in the subject and header.

But, with those fixed:

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

(fyi, I'll review patch 13, the dm-po2zone target, tomorrow)

