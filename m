Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C62C54EE9
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 21:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiIGVIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIGVIL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 17:08:11 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83545C22AF
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 14:08:10 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id a22so11434938qtw.10
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 14:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=4ERbyTXHv2lNc1OengqdU9yPwIrFd5BCgzt43DOXgbY=;
        b=mttEMBLSxaMSVF0EY/TViBdNqlFKy1EgBz5Xqsb3PMuybnAtoFTahj27y2FZuJqltL
         5vHIvJOUjazNrLllbFdjPA8kicDMh2O9P4DTwkBtROGhmcP7vrBAKesbGuSg4IBYBWHB
         0yqo/cTXuHKX91QYi8bRo+L8pWJiQ8PsN0oKAHiKl/ytO7E+UIxPSWUem904U6g6DuwO
         gX2lzH7hfmW2Sre/4vZMIbAF1r1mtDzzJ2IFEBnQQNJKjqgPVWNK5e6Wre6BrFbj8YNQ
         ecKSrxHuhVUiLmZBgyfkODE3YPYjnX7u/z7Yt3bOlLFo/eS5qsaBYF8OotFBvoQ0Bh1Y
         pq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=4ERbyTXHv2lNc1OengqdU9yPwIrFd5BCgzt43DOXgbY=;
        b=JiHJmK5B62jkeAcUNRYiOMl4ZYMu35QBwcOMRaiKVx0deMVpPWz/kRYTGgHJA1i1fz
         JBinr5WqD7gWwHcLojLL1Ji6Icqlx8R5QIM/eYH40sNbwxP3ANeCoIuB5oQ0QuBeViTn
         v07b6IEbCREmyBmhsYEyAS4jcJHUHLUIorFlZ90bIcK58wPXjjPtcgaS1rb05oyorGik
         aIxhlVn65tc0RWoldCEmj63/QEwRIPYqbdYZF6DaI/fiNfsreZrm2nByeJz6jCH7QXZD
         oFHvd6vlTMFJJ2cqwmvltMgxzL5D7n+/AMqKdqUZYaJEcFMDSJ4ydjjPhtYrp+TwordT
         P8RA==
X-Gm-Message-State: ACgBeo1GZ0dxTBVbmhsNavjkLPrTlPYQF2JUVM0LZQ3yjyv2bG/eCXAT
        IipRNgpJF5l0K+Sj92lG9/c1DA==
X-Google-Smtp-Source: AA6agR6R9Ma4fBS5M0YMOexWJqKtOp++nxoZDcJuRj8U2CzvivXJR8/9/fGFcY7cndh6ByDpsAlNXQ==
X-Received: by 2002:ac8:5cd6:0:b0:343:669b:7266 with SMTP id s22-20020ac85cd6000000b00343669b7266mr5132698qta.549.1662584889528;
        Wed, 07 Sep 2022 14:08:09 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a24cf00b006bbb07ebd83sm15329310qkn.108.2022.09.07.14.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:08:09 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:08:08 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/17] btrfs: remove stripe boundary calculation for
 encoded I/O
Message-ID: <YxkIOFcSN4tMv6Ur@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-12-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-12-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:10AM +0300, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Stop looking at the stripe boundary in
> btrfs_encoded_read_regular_fill_pages() now that that btrfs_submit_bio
> can split bios.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
