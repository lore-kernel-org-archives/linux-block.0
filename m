Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3B8C6FA89
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 21:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiIGVMl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiIGVMk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 17:12:40 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6721BC2FAB
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 14:12:38 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f4so11472394qkl.7
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 14:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=V1MPWICjNbVej9alvDqcw5ZrURtoJsrV949+/FBaEQ8=;
        b=BjHkzBZKoRPIJvwkLFDCvXN43YYDxubEuHIfBWgPqt0au5f5ON5tyn6QZxGqy5EMZq
         z2YvpKmBwyDqmbILzOrvHuI9YAI7WTuPpS4jljnj+2cUeLTZPORg5OdLqgBXuSxrYI4Z
         EMo7mYrz2S+qAfc3euniPpEYE7KxDnrKFKm/V1xPcvbQ44fErTNl3ZVYkZ9H9tjqMm6H
         Tap2FGysqqfdqZ9amw5e04BjUw9vDYJ2HbEk3DbrB5zt+Q23S0c9IJRL5dxvB7htGKHQ
         QkjkAAtVsrrCfAqH5Si8CwSyOcj9dh9zq1c+0lamuDIKFxvp1PUZN1POufVlfvh5ehUy
         vA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=V1MPWICjNbVej9alvDqcw5ZrURtoJsrV949+/FBaEQ8=;
        b=pg9j9I0nQi2xFmjnlH0mUYFCt7HOZ7NnYlUE0qhLbC7VIjnOZYEtjNlm/n/hRYcWn6
         pTcZuRY52y+I5enkpsNP9gK7WkTizMAF0flCku7wPO0k5pBR9d3UFH8ohD7ixvYLXDmp
         bRoI+VDuuYsSHtScYAc30bJtn8+G4KMEBy32CCoqKPgfi5im0sMdy5DoLr+wOGXIxpwE
         kToGBj5OSgqP3WH/0BZUIbKyImfQF1ZhSJiRocU4S5eo6oy3XVHLcYWV65GjMAa9puAB
         vV6ZVLuZ97LoekFvqyissbv28VTGfojhLX2MJI5Qo7ON/fp8zW4zpAXdi//FPAPm3a8B
         HXzA==
X-Gm-Message-State: ACgBeo2W5ao/qNRuOCjbMeg0CbtiT7ze3752Fnn+rzT9b7C7+NSdEncH
        iLWi6Z9NPll4mU//L8c5RnvWRg==
X-Google-Smtp-Source: AA6agR6dqO5hs1i8teqOq2Q7WHsu4pem6GGM9f+pJ4IGoEV9bZ7Z64EjMjRWvAiPHYbn6xLB5jsYBA==
X-Received: by 2002:a05:620a:24c6:b0:6ba:c24d:8304 with SMTP id m6-20020a05620a24c600b006bac24d8304mr4166545qkn.325.1662585157257;
        Wed, 07 Sep 2022 14:12:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z1-20020ac87f81000000b0031eddc83560sm14161112qtj.90.2022.09.07.14.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:12:36 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:12:35 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 14/17] btrfs: remove now spurious bio submission helpers
Message-ID: <YxkJQ9/CuYo8ytTi@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:13AM +0300, Christoph Hellwig wrote:
> Just call btrfs_submit_bio and btrfs_submit_compressed_read directly from
> submit_one_bio now that all additional functionality has moved into
> btrfs_submit_bio.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
