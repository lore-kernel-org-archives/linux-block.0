Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B085C43219
	for <linux-block@archiver.kernel.org>; Mon, 18 Apr 2022 13:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiDRNb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244450AbiDRNaa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Apr 2022 09:30:30 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F1C12636
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 05:54:34 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id s17so1432096plg.9
        for <linux-block@vger.kernel.org>; Mon, 18 Apr 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=ibYDSZCFNyFY0E0xngH81UyJF82hqCghGqnVPLy+gv8=;
        b=vC9VRENF/75LZHQO0Jmt6CUkAae3UjBfTPuDF0tWoqRTCDRZmo8HfD5ThHskhG+ttd
         Pb4E+Bm8QkdesdnIeSUdCK0uTkYqY4EnO/E1XMMjnuAqCu8yWkQwiUuJ9iY7ud95Qnx2
         f4SAdRo1cPQ2v3F2of3hIt+cb3rwD0EvWYnpV4vtuTAOdzLWk1UhZp7MoSZKC/MTbU54
         H7bg8uAIF3bvuEK9uekwY4wA2SP3L/0PtDSMZgN9cSVOjSc+1aVt3UCnot+lS/TQ7xf6
         viy8udDRKQitduBgLgFLGKJW/11xcZ6Ynd9P13N6I8H5rWnZ4vXdqSck8zAfPM7m3Rys
         vxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=ibYDSZCFNyFY0E0xngH81UyJF82hqCghGqnVPLy+gv8=;
        b=CKPkDVIXM8XJtSw5ABQEATm3irFuvBgPQu27CxPbQy/w+W3FbTtQIaA/TVSSnfQrWh
         D3XnGU2+j2WnDhMkx+2efZEhgiiTiD/Pa6EBkhW6jKM0duDrVHpjH5ajZo9E5dF5HO4a
         LjugA97sRqTAVDmx9X7t8CFTgIdHDExDvqmEITeOxMfrLrAtPDuJntztAe5VBAztWmyb
         +4K3nIsoioQi+f8Gys4yS16XaObEwL6BRQGt4ELmYZ9PScDe/2knNaLMdyTc1n3icpFc
         1jbC6j2ct71gVc270calXZlhtIgcBp8K2SxEYhwcbWDp6ArITIhYuJ9bH6cILAnspmGH
         EqkQ==
X-Gm-Message-State: AOAM533GJm5oPnRjhgw/qAvNQZz1U+P1S+0ztR0YJr71QNDvVIGBW/ec
        c6Fj6MPkyJ4gRM8+n6+kk1i0eg==
X-Google-Smtp-Source: ABdhPJz27Q2KH3dc6+wcyn8Fer81Q/YsmmGcpXrAJWb3QGquOeH4hUXGRnhuHPecX23uf799lbv9Aw==
X-Received: by 2002:a17:90a:6c64:b0:1cb:a150:52d with SMTP id x91-20020a17090a6c6400b001cba150052dmr12926639pjj.111.1650286472739;
        Mon, 18 Apr 2022 05:54:32 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k7-20020aa788c7000000b0050a553bcf80sm8667087pff.18.2022.04.18.05.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 05:54:32 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     minchan@kernel.org, josef@toxicpanda.com, ngupta@vflare.org,
        Christoph Hellwig <hch@lst.de>
Cc:     mcroce@microsoft.com, linux-block@vger.kernel.org,
        penguin-kernel@i-love.sakura.ne.jp, nbd@other.debian.org,
        jack@suse.cz, djwong@kernel.org, ming.lei@redhat.com
In-Reply-To: <20220330052917.2566582-2-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de> <20220330052917.2566582-2-hch@lst.de>
Subject: Re: [PATCH 01/15] nbd: use the correct block_device in nbd_bdev_reset
Message-Id: <165028647141.16008.13343182404375254679.b4-ty@kernel.dk>
Date:   Mon, 18 Apr 2022 06:54:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 30 Mar 2022 07:29:03 +0200, Christoph Hellwig wrote:
> The bdev parameter to ->ioctl contains the block device that the ioctl
> is called on, which can be the partition.  But the openers check in
> nbd_bdev_reset really needs to check use the whole device, so switch to
> using that.
> 
> 

Applied, thanks!

[01/15] nbd: use the correct block_device in nbd_bdev_reset
        commit: 2a852a693f8839bb877fc731ffbc9ece3a9c16d7
[02/15] zram: cleanup reset_store
        commit: d666e20e2e7983d03bbf5e208b8485541ae616a1
[03/15] zram: cleanup zram_remove
        commit: 7a86d6dc1493326feb0d3ce5af2f34401dd3defa
[04/15] block: add a disk_openers helper
        commit: dbdc1be32591af023db2812706f01e6cd2f42bfc
[05/15] block: turn bdev->bd_openers into an atomic_t
        commit: 9acf381f3e8f715175c29f4b6d722f6b6797d139
[06/15] loop: de-duplicate the idle worker freeing code
        commit: 2cf429b53c1041a0e90943e1d2a5a7a7f89accb0
[07/15] loop: initialize the worker tracking fields once
        commit: b15ed54694fbba714931dd81790f86797cf8bed2
[08/15] loop: remove the racy bd_inode->i_mapping->nrpages asserts
        commit: 98ded54a33839e7b8f8bed772e01a544f48e33a7
[09/15] loop: don't freeze the queue in lo_release
        commit: 46dc967445bde5300eee7e567a67796de2217586
[10/15] loop: only freeze the queue in __loop_clr_fd when needed
        commit: 1fe0b1acb14dd3113b7dc975a118cd7f08af8316
[11/15] loop: implement ->free_disk
        commit: d2c7f56f8b5256d57f9e3fc7794c31361d43bdd9
[12/15] loop: suppress uevents while reconfiguring the device
        commit: 498ef5c777d9c89693b70cc453b40c392120ea1b
[13/15] loop: avoid loop_validate_mutex/lo_mutex in ->release
        commit: 158eaeba4b8edf9940f64daa83cbd1ac7db7593c
[14/15] loop: remove lo_refcount and avoid lo_mutex in ->open / ->release
        commit: a0e286b6a5b61d4da01bdf865071c4da417046d6
[15/15] loop: don't destroy lo->workqueue in __loop_clr_fd
        commit: d292dc80686aeafc418d809b4f9598578a7f294f

Best regards,
-- 
Jens Axboe


