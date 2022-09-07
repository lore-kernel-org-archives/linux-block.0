Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D85E2C54EE9
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 21:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiIGVLx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiIGVLw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 17:11:52 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84801B028F
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 14:11:51 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x5so11444437qtv.9
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=BCFYG9/qxn8lVxwD6cqDmGQqlvy7uroaAgkV9Mai+c4=;
        b=Mf/9+B+xgp0UgWrVVVe/+dL5VOKDBsbbBJ90xaLhhgDlEffcuEPn0YFj5yff+57T/k
         xNSS3TDJfW2tM7JAy7hL489XQp2YhbKG9AmhK1obC8LuWi8BKRzk9siWClgnuCdpC+iq
         pw2rLjOyCEesItzr/g8MhTz9Q6QGTwGtbNThmPb7f16d1qrlCOBimptdUHesRZSjrvgM
         6tIJB9lqww16B52Y16gb7ql8eqsvP/GoVmbM7mg7yfWo2BODslaewdM3pdWTqUZYLBWD
         k/DwJKAo0dRESn1/KgkMysdyJUdmUItwIFGeGBToc9Y72547wdPWjIWE4svmD5pFIDtf
         Txzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=BCFYG9/qxn8lVxwD6cqDmGQqlvy7uroaAgkV9Mai+c4=;
        b=k2n9Xth0YiiAo8j5iIkG1xYdxZn2QKX3bx0RSvtF5ZptBrrjhWsZ0HnrgpHNnsXtdS
         Knd3gbQtNg5znLpHUuOhnNTcVkUsQxe+Nlu/8PUWLydhp8HIg9uqjk0VZrNbiUQLjZkZ
         inRabU8Rn3p3HQp/ibXygfajDVxTNm3mjNezLtwrWFBporhN5p5UXetcyPQ+khqmh18P
         9hmW+bmKMUI3Ri3xVEop/J8FO2qh9+tQ53ETfj106PzMkrfVGssOb3EslYWeALQB0Bwy
         3zMp2d7z0GS/xBBTVg4Pa/tAwkLwCNyh3c8ZhjPxU70+Xv+AX0SZR8NH3zhiXj+3GlYd
         YYsQ==
X-Gm-Message-State: ACgBeo0oTXqEzBwy92NAa+uQ9ddyT6RV1Um1ebfBy1IggMDn7K44LWkK
        9J+F5yIwst9mF+S6LSZWv+HV1w==
X-Google-Smtp-Source: AA6agR4RMOconEOYiWnnAocmU7yPShSSHn12U/sO2Ye9rYws/zbmXiRYZycUAP7jfEWP+blXpeBZpQ==
X-Received: by 2002:a05:622a:1348:b0:344:560b:2521 with SMTP id w8-20020a05622a134800b00344560b2521mr4917911qtk.525.1662585110603;
        Wed, 07 Sep 2022 14:11:50 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a44c500b006bb9e4b96e6sm17064095qkp.24.2022.09.07.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:11:50 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:11:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/17] btrfs: remove submit_encoded_read_bio
Message-ID: <YxkJFNTbdjtCFWOX@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:12AM +0300, Christoph Hellwig wrote:
> Just opencode the functionality in the only caller and remove the
> now superflous error handling there.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
