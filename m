Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D083CCA473
	for <linux-block@archiver.kernel.org>; Wed,  6 Jul 2022 12:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233406AbiGFMrC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Jul 2022 08:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiGFMrB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Jul 2022 08:47:01 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D72127C
        for <linux-block@vger.kernel.org>; Wed,  6 Jul 2022 05:47:00 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l124so3890127pfl.8
        for <linux-block@vger.kernel.org>; Wed, 06 Jul 2022 05:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=dWSt263Qaw0m9Glsw02JwFApleRJFRb/cK5wUXMCZwk=;
        b=j+fmEXUn17byBaaEWJCYGcOxR5xOeuoirY/s0cZzZ6HyE6j7AkcULy2cduleOPB4vA
         1fUxIe212oQYbMmfWn1K7XGD3YgcL1lSmRzRKoedP2xZUo8xYwMpBgx1zzHsj90heXi1
         NQpwkZ4GGKRptHBBMzhAzmimFtumrG7off3e5NRG7G/XE+HS5luAc7mCXDNDU144O8pL
         mCMi5KYlhgxfDIhqTioswKyepbmMcqucUAWhJ5awFyF55whoeOD9ttJIXlqTVFWkch20
         +6ECSy4zrhbdbxV0u1vLH5x375l04xrY6/6D0X9EjFWRPY3uatnpbti8rLYdmCz9YyI9
         25KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=dWSt263Qaw0m9Glsw02JwFApleRJFRb/cK5wUXMCZwk=;
        b=ChFCyvtElPxc6kyDCzF8UmPIyER62u2a1s47Agf0PboDPsjAtRYhx6fwMwaN82UZhP
         yTxGfwGSwfH9N4tj22gXyOfCSLcbxJVxRnI4kUdMEhCas5N6p0S78aCoO9OMyTpgrRl4
         t59vIQfSOUESCrlLOv5jM/hWQ9C8pZJJx28WdwcQT0M7rEmE02UqgPf2JrovsuMJBMSo
         W2gFRRxgNklX4a0G5Y1MTt4ZiSI1b5mBri1LeJxicSrB91bh/tIqE6ZJRTz7sp1msAhj
         ndYwGqiE7KySVLJ0DkQlBi/56gxfI5MXgZU9Iw0NQ2Wl3NDnJmZMI5jc4lflp7uRv3Lo
         DZPg==
X-Gm-Message-State: AJIora9P0YHVKtNI0MN66t8uDlvUEwnLLYUAEO0VTSgtBVHocRN8YWqE
        YDy8XF7Ew8kg2mutsFnx6Ndhe7J0ODS9Iw==
X-Google-Smtp-Source: AGRyM1vbTy3ndf+pSCLNGkm7VeLniHNquKUECZA2Rht1+4+EvHZMthqZzry/qox4vZy8sRhwMJ6GMg==
X-Received: by 2002:aa7:94ad:0:b0:525:265b:991f with SMTP id a13-20020aa794ad000000b00525265b991fmr47728895pfl.30.1657111619892;
        Wed, 06 Jul 2022 05:46:59 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id by5-20020a056a00400500b0052521fd6caesm17610237pfb.111.2022.07.06.05.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 05:46:59 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     damien.lemoal@opensource.wdc.com, Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
In-Reply-To: <20220706070350.1703384-1-hch@lst.de>
References: <20220706070350.1703384-1-hch@lst.de>
Subject: Re: clean up zoned device information v2
Message-Id: <165711161869.295759.6786523664338969947.b4-ty@kernel.dk>
Date:   Wed, 06 Jul 2022 06:46:58 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 6 Jul 2022 09:03:34 +0200, Christoph Hellwig wrote:
> this cleans up the block layer zoned device information APIs and
> moves all fields currently in the request_queue to the gendisk as
> they aren't relevant for passthrough I/O.
> 
> Changes since v1:
>  - drop the blk-zoned/nvmet code sharing for now
>  - use a helper a little earlier
>  - various spelling fixes
> 
> [...]

Applied, thanks!

[01/16] block: remove a superflous ifdef in blkdev.h
        commit: f1a8bbd1100d9cd117bc8b7fc0903982bbaf474f
[02/16] block: call blk_queue_free_zone_bitmaps from disk_release
        commit: 6cc37a672a1e21245b931722a016b3bd4ae10e2d
[03/16] block: use bdev_is_zoned instead of open coding it
        commit: edd1dbc83b1de3b98590b76e09b86ddf6887fce7
[04/16] block: simplify blk_mq_plug
        commit: 6deacb3bfac2b720e707c566549a7041f17db9c8
[05/16] block: simplify blk_check_zone_append
        commit: 052e545c9276f97e86368579fda32aa1ac017d51
[06/16] block: pass a gendisk to blk_queue_set_zoned
        commit: 6b2bd274744e6454ba7bbbe6a09b44866f2f414a
[07/16] block: pass a gendisk to blk_queue_clear_zone_settings
        commit: b3c72f8138b5f967a9fa527af84b35018897aba3
[08/16] block: pass a gendisk to blk_queue_free_zone_bitmaps
        commit: 5d40066567a73a67ddb656ad118c6cfa1c4a6d71
[09/16] block: remove queue_max_open_zones and queue_max_active_zones
        commit: 1dc0172027b0aa09823b430e395b1116d2745f36
[10/16] block: pass a gendisk to blk_queue_max_open_zones and blk_queue_max_active_zones
        commit: 982977df48179c8c690868f398051074e68eef0f
[11/16] block: replace blkdev_nr_zones with bdev_nr_zones
        commit: b623e347323f6464b20fb0d899a0a73522ed8f6c
[12/16] block: use bdev based helpers in blkdev_zone_mgmt{,all}
        commit: 375c140c199ebd2866f9c50a0b8853ffca3f1b68
[13/16] nvmet:: use bdev based helpers in nvmet_bdev_zone_mgmt_emulate_all
        commit: a239145ad18b59338a2b6c419c1a15a0e52d1315
[14/16] dm-zoned: cleanup dmz_fixup_devices
        commit: fabed68c272389db85655a2933737d602f4008fb
[15/16] block: remove blk_queue_zone_sectors
        commit: de71973c2951cb2ce4b46560f021f03b15906408
[16/16] block: move zone related fields to struct gendisk
        commit: d86e716aa40643e3eb8c69fab3a198146bf76dd6

Best regards,
-- 
Jens Axboe


