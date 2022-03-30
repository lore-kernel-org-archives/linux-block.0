Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9041C433FE
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 14:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347285AbiC3Ovj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241633AbiC3Ovh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 10:51:37 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A316595
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 07:49:39 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b9so14666911ila.8
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=S7jHDD9H3A3SYC5lPe9ohlnX79nRebzt30Q3Ep3X12o=;
        b=OZ3cEQ5h4qtPgX1AY6RLmB6gT57kvwRHQ79ygDaebLZjiOApKBgJvNSiNC+hGN40JU
         KFowpuzoi9RAMLTJX0fOxY1oyMHVZHloUrVLxLuOG/UlFNOYGVgGvwa2UU4emiJEzaf9
         q/b6t2EDuopDh+F9mdxQX6O8ADsK4gowwAsRa9RVPJ5GdcZXQj2mX6/QUQhRN12B8hnH
         NkupImYcQse6AfeDQRluWPm9O4lLIm1PCY+Y0ru6sks+rFgKWBzTtmSTEYxmLYKnRe/x
         TPd8nXiKZe260b1aynJD8YblWjvbxaX/g0RFrXX3pPqJAeiHYOnhcG7UGyHQwei5xlG9
         5gPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=S7jHDD9H3A3SYC5lPe9ohlnX79nRebzt30Q3Ep3X12o=;
        b=CjSAwcFQWd/8MN0cRkms2DmSi8HcgkVhNRcz97IoHv9aJnabj71uxWf0Z/IbaShCgw
         pSGmjkXyTE/XBGxj+2iQ11UlrwxwTl8455hopPciDxwEyh/4xwDDKbay+9SkKh5OVfbf
         0quMiQfUoIZpB+cvQZBhLS/ChLwsahXc7yWZCTBsAsFFKTnprl/GOxyf7XjikYLyp2qJ
         s7Km32E6m5VJ+RH9Q5PS1iQKcSr59Brh3FWwvigepGCgw3GqTQs2YXvtB7zc5ZdTf5c5
         3AUWaTGYKGZEWIeGq4IiZZu3ekttqKkzSKpRt5BdctsOy10BxhkGNQ3lee6kbq4EeKjU
         C4Hg==
X-Gm-Message-State: AOAM5331CzQkztU2aVmX9QjHV/FpwgPXDdiFmk76MJiXhg8bOeMbiflq
        4+yhe28pNs6AHtNMH/h+AxGJCQ==
X-Google-Smtp-Source: ABdhPJz3EibI69DwP9lkcaYHyRWrAtLzvk4HhXkWXzgIOSW08I0BfaQQag5PmpjZEv83Snk+VZv0fA==
X-Received: by 2002:a05:6e02:1e0e:b0:2c6:18c3:9691 with SMTP id g14-20020a056e021e0e00b002c618c39691mr11475070ila.287.1648651778718;
        Wed, 30 Mar 2022 07:49:38 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id r9-20020a6b6009000000b006412abddbbbsm11434439iog.24.2022.03.30.07.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 07:49:38 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-bcache@vger.kernel.org, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Coly Li <colyli@suse.de>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        target-devel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-raid@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220308061551.737853-1-hch@lst.de>
References: <20220308061551.737853-1-hch@lst.de>
Subject: Re: cleanup bio_kmalloc v2
Message-Id: <164865177761.37391.13379579175408786139.b4-ty@kernel.dk>
Date:   Wed, 30 Mar 2022 08:49:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Mar 2022 07:15:46 +0100, Christoph Hellwig wrote:
> this series finishes off the bio allocation interface cleanups by dealing
> with the weirdest member of the famility.  bio_kmalloc combines a kmalloc
> for the bio and bio_vecs with a hidden bio_init call and magic cleanup
> semantics.
> 
> This series moves a few callers away from bio_kmalloc and then turns
> bio_kmalloc into a simple wrapper for a slab allocation of a bio and the
> inline biovecs.  The callers need to manually call bio_init instead with
> all that entails and the magic that turns bio_put into a kfree goes away
> as well, allowing for a proper debug check in bio_put that catches
> accidental use on a bio_init()ed bio.
> 
> [...]

Applied, thanks!

[1/5] btrfs: simplify ->flush_bio handling
      commit: 6978ffddd5bba44e6b7614d52868cf4954e0529b
[2/5] squashfs: always use bio_kmalloc in squashfs_bio_read
      commit: 88a39feabf25efbaec775ffb48ea240af198994e
[3/5] target/pscsi: remove pscsi_get_bio
      commit: bbccc65bd7c1b22f050b65d8171fbdd8d72cf39c
[4/5] block: turn bio_kmalloc into a simple kmalloc wrapper
      commit: 57c47b42f4545b5f8fa288f190c0d68f96bc477f
[5/5] pktcdvd: stop using bio_reset
      commit: 1292fb59f283e76f55843d94f066c2f0b91dfb7e

Best regards,
-- 
Jens Axboe


