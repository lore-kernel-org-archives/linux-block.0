Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344778AbiFNQwZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 12:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346696AbiFNQvz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 12:51:55 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE0544A0F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:51:54 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id f8so8211609plo.9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 09:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=t83AYSlzSApM9nN7I9alCqcQKbV28raP6GborJR/Amc=;
        b=QROL8zsy/qLoJljA2EfuCExl/ZV9dMBmCEAUoVNakZfiuz4O3ZvWAtG41TebR9QxSf
         qs7DZd/Z1GZNOam991EDR+GDLtI6+ZW39DMVqB/cZasfea6MMlMklVSqnGH5H6hnE8yf
         dbFStvST+f6FN6TBe9aHLriLIE1QLxnghpHaa8xEKnjZD/+PyDahf70qbTQl2f5ijmUu
         b3PnDVv50DMGzrzm3ihYFCqy8cgOZkWPpzh2ZRk2p7bc9IVFYgCnjNiMkbTVfUyXq5Om
         f/9R461ckKMDORrvMgXfnjt3aY/U+My8LYb0RhXQewdCmBtsIrAHitEvCAMUEaTnROI4
         FlXQ==
X-Gm-Message-State: AJIora/zvMCR5TrEMfDlAeXnTsUeA6LIA/lsFKbVJgR+3Ns8BfZlJWAl
        byfGt8mosobfygXsG2J+5mY=
X-Google-Smtp-Source: AGRyM1tOVC0y3KN8th4nAQ9ARAtBJYthGH8OTKQsbaJOi+L4VnA8dzugaAeEIDnpN4lXIixQ2w+otg==
X-Received: by 2002:a17:90b:4c4a:b0:1e3:3b3:8800 with SMTP id np10-20020a17090b4c4a00b001e303b38800mr5662384pjb.6.1655225513748;
        Tue, 14 Jun 2022 09:51:53 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ab60:e1ea:e2eb:c1b6? ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id p127-20020a62d085000000b0050dc7628137sm8169880pfg.17.2022.06.14.09.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 09:51:53 -0700 (PDT)
Message-ID: <6ed896d6-0167-9501-ab68-01d979c1d98c@acm.org>
Date:   Tue, 14 Jun 2022 09:51:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 5/6] block: fold blk_max_size_offset into get_max_io_size
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
References: <20220614090934.570632-1-hch@lst.de>
 <20220614090934.570632-6-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220614090934.570632-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/22 02:09, Christoph Hellwig wrote:
> Now that blk_max_size_offset has a single caller left, fold it into that
> and clean up the naming convention for the local variables there.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
