Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F6DC38145
	for <linux-block@archiver.kernel.org>; Wed,  7 Sep 2022 21:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiIGVHa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Sep 2022 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiIGVH0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Sep 2022 17:07:26 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F94C2F95
        for <linux-block@vger.kernel.org>; Wed,  7 Sep 2022 14:07:18 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id y18so11459614qtv.5
        for <linux-block@vger.kernel.org>; Wed, 07 Sep 2022 14:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5XFSbTu8JLiaqbe/aaB5H3G6q2+uAR8AZMv3BlQCVkw=;
        b=hAaWh9Hp75G7fMyvoVm+2YeyAMoo/jh/Sj00Sg9ngiZrFj/iyVFFOZZRq3Dl8JCJBg
         gVjEtOwcXK5pgpv8GgXyUKSq87CXj6tAif+k1fYyZSbX/uZYoYjlsbEbf87UId2CmIRa
         ArT7QIeeYfRNxvsHxteZ0nNX7sqmM7wwcc0b5grb4+jZ0eRAy3asuPle285XnAEUHyGo
         fS3aGASz1Pkj0Su5/Yq7FWoLCFLpkaAa2rrLckTpKYzO/lpYX3r5kQJ9Epj5VUgpN6M9
         pwLjgg3OPF3IYA2LsqWwLIm5frSEa68tgiHu2tYeXmZC4qAsdjgCHxmjgOdvBe8/Ql4n
         fPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5XFSbTu8JLiaqbe/aaB5H3G6q2+uAR8AZMv3BlQCVkw=;
        b=C56JcnuKc+hynarU9aTb+TxhPfBpvewetzI3YgErnHoCmKKZWc7kEfOSTfmhDxd0Fr
         GLD4IOPU5WBE8Ky0x9Jr1GrDc/D0n9RkxU5C4cIVA0IlFW1SO2V8CxD1e13A4pdQY52/
         JYv2k6iMix2oMsAgFRnrpp6BIB2vc/+W0UJTN03BzO+13kdFgDavo8NTr0wDvLsB9hOr
         e35lDx81jmQCxslT5ulv/Nktc6TCn8gkgJ+np2Gf0WCJosKoHpUxrWfa797UXQfjOFJD
         cNB3tnT7r0dt31CDJSEshWZVDOQhu5I6Tkug3WG1j6BcyEr4oKMDdw9jU5sHXcBKUxDd
         yCfA==
X-Gm-Message-State: ACgBeo3wivwvUkQy5ko5eLGa3fXEh8kcgOnJiBWzA0Xz3Hx0BtAdUJO3
        FoYXkxpPN+hHxdb3L+i4JLvthw==
X-Google-Smtp-Source: AA6agR5Y+ctVk6tTsu8FtmceqQEVqGmzGqiBK6IB5xxE15uCaH8k9MNkzjPeibjNcwOrOLSiOfXN1A==
X-Received: by 2002:a05:622a:1b9e:b0:344:5627:7afe with SMTP id bp30-20020a05622a1b9e00b0034456277afemr5219357qtb.329.1662584837422;
        Wed, 07 Sep 2022 14:07:17 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u4-20020a05620a0c4400b006bc1512986esm16634752qki.97.2022.09.07.14.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 14:07:16 -0700 (PDT)
Date:   Wed, 7 Sep 2022 17:07:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/17] btrfs: remove stripe boundary calculation for
 compressed I/O
Message-ID: <YxkIA8vVgL2jy11c@localhost.localdomain>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901074216.1849941-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 01, 2022 at 10:42:09AM +0300, Christoph Hellwig wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Stop looking at the stripe boundary in alloc_compressed_bio() now that
> that btrfs_submit_bio can split bios, open code the now trivial code
> from alloc_compressed_bio() in btrfs_submit_compressed_read and stop
> maintaining the pending_ios count for reads as there is always just
> a single bio now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> [hch: remove more cruft in btrfs_submit_compressed_read]
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
