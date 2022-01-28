Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B45C433FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 00:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241678AbiA1A7A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 19:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241444AbiA1A67 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 19:58:59 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CDCC06174E
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 16:58:59 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id y84so5951450iof.0
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 16:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnqrK1B7nE7jhPSJbx7uJGsFsnzMH0p8PmdMrmsnx7c=;
        b=eiqFDzffYRJHxrlhdAhplyWNbDu7+9XCywnSXd70CEjIhMS+QILhU1gn2PxLfmnCZT
         bNJ9Uu6Wc0dwdvneqYk7j+Gx1rRovjfECn7zCQ0xWiL4H6hvX9A8b5oKYyqce02E7DCW
         NTzQ49F7FCqba9EG78FvWG2FJ0q8GVrQIyWy2fIDxxDCLv3njcQzyLih4s1aXLOz0i+/
         5sSTGgzeA0gu4w3dPuF1jSpGKYFT3eqFqlPbp/g33aBBagrayGA8ak+IubpG+AiehtbE
         3dsYzg7w2/MbCg9ctg4WDF1ndwIhh6gr6Vd+Zl57wcQBRUaLrzVSaK25RiFiy+diDvja
         JVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnqrK1B7nE7jhPSJbx7uJGsFsnzMH0p8PmdMrmsnx7c=;
        b=YFN5EULRROR8oZK9piQu8bm31gCfCKX9iLuNphTv0KLN5hpC+PLLOvVg3k4Sfi9CGo
         +7LC9By+AfWwYAwe43EKIAumg/Sy29rN5dZSK4IJlSIh6rN0WVYcgCSQBF4RQjLWIYX5
         8lc/5W3T79BDB+OktN5o9vcrEitSt40RWMr4/dOXeCrd/Dah8huar0OWY1/Z2An77NVB
         ewEOVnG3pu5vgUmnw+C33f4wlsAHv98EW2r6AyzL8msd1Lh6nK0VM1aFp3tYKW+EGp2l
         k34/MxDKBSMxB0Sc+Le+yJjnPhTzrqs/4Y76f5fsJ5Eied2e7Qzvmaip641m46IWkkQH
         Hmyg==
X-Gm-Message-State: AOAM530wCO6DY6J8qEmcLtL9hxLN4LpWMhdK8BogwJ7DtUXzzl2Q/BbU
        Z2rP2snP21lmeGiQofLdzvBx/C5iev887g==
X-Google-Smtp-Source: ABdhPJwV/AEHiSXVQGFEZXPZwOlZ61Jpa3Td0l0CjC3IrFA3/SuJ9toHc9iJFAxn2WQdRiu2+bdIdQ==
X-Received: by 2002:a02:84ef:: with SMTP id f102mr3301483jai.25.1643331538286;
        Thu, 27 Jan 2022 16:58:58 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id m4sm12789023iln.48.2022.01.27.16.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 16:58:57 -0800 (PST)
Subject: Re: [PATCH 0/9] Remove remaining parts of congestions tracking code.
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        ceph-devel@vger.kernel.org, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
References: <164325106958.29787.4865219843242892726.stgit@noble.brown>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2e721a70-bc57-0894-9d76-34a9d58c0cb7@kernel.dk>
Date:   Thu, 27 Jan 2022 17:58:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <164325106958.29787.4865219843242892726.stgit@noble.brown>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/26/22 7:46 PM, NeilBrown wrote:
> Congestion hasn't been reliably tracked for quite some time.
> Most MM uses of it for guiding writeback decisions were removed in 5.16.
> Some other uses were removed in 17-rc1.
> 
> This series removes the remaining places that test for congestion, and
> the few places which still set it.
> 
> The second patch touches a few filesystems.  I didn't think there was
> much value in splitting this out by filesystems, but if maintainers
> would rather I did that, I will.
> 
> The f2fs, cephfs, fuse, NFS, and block patches can go through the
> respective trees proving the final patch doesn't land until after they
> all do - so maybe it should be held for 5.18-rc2 if all the rest lands
> by 5.18-rc1.

For the series:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

