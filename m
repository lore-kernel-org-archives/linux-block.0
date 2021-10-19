Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C555DC4332F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE156135E
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 12:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhJSMUW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 08:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbhJSMUV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 08:20:21 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A6BC061745
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:18:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id s3so18243255ild.0
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+u6Zw+sZeymRMtbHbtGbZtKzgW0EhyLBdVB1VY/1pQs=;
        b=Tb48ymzvjxLTClrHNJYA4D2dVJ8Ztfbhzy0Ie48bKme14dbHEk7NHzUlD4CtsOuTVh
         JgNzHEVLQhxIsPLhyJX7Z/VzlReaLnFXc1kKfHdgzt2BBNgXuoe+ZF4bik430vu4puMl
         I+VMmrKJgTvifkJbrey0kcq4cSbLwlRG2Hgmwgr+LEzoG7E29CJqi0uqRCgehTOMKsrq
         Jh6TX2smlG382jHo0pR4VfMS1s4K5fB1q8nrd8S+Dn/GnVyVBFeUcEAXY/7qL1iaBQvm
         mo2ph9WGKLDLbO76XEykkT73n30KhxsNtReurXqJLhHlkq4NYNbpzmPgymF9ctR4BHQv
         4WIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+u6Zw+sZeymRMtbHbtGbZtKzgW0EhyLBdVB1VY/1pQs=;
        b=Uleb9a8GWyqSIbLB+bjVokhYMz5QXizP+VjMQMt2UepCo2s8DT2GxWnt7IdSFOcHUo
         u7B3dLRKCIpUBmWmdqdX53Ym1Cv+4M5Iiy15X4Bfeb8a+6SPIQFghFsIMzT+fRIxDBOP
         oEF5w14JsxBiCBT58uaxQANaOgQc6L43nFcLAuncf8D8JGsETkOJZekKf94gjPYSIorN
         6jtJ80Ax2KQiF9BXY3i19vGAriStfJP/pk4jhZalyObSWV1A4BQhQH7t17G05a47f3Rq
         rdEpFo2mosJJaZLH9PUbqd938yohAkHfrPqlHFBkQuJ7/s97XhSFbeWDhAx9+xRie86B
         kugg==
X-Gm-Message-State: AOAM532ut+zgj9Q5lxE1aANht+8JyqkQMXA8pODLw/I/CqcShY6KSyz8
        /G2h2rh7dIwFJRO4fjklZd84TQ==
X-Google-Smtp-Source: ABdhPJwdq2OzbwJ+5kSgKNQu/1r0vmMuOrQGPUlHM7JK+ER+0G+nwVQiAnqSrEK4pLXtvo4sGlmmaw==
X-Received: by 2002:a92:de47:: with SMTP id e7mr11929867ilr.282.1634645888670;
        Tue, 19 Oct 2021 05:18:08 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o14sm8393559ilq.81.2021.10.19.05.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 05:18:08 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-block@vger.kernel.org
Subject: Re: more bdev_nr_sectors / bdev_nr_bytes conversions
Date:   Tue, 19 Oct 2021 06:18:05 -0600
Message-Id: <163464587890.599826.15140587721963730407.b4-ty@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211019062024.2171074-1-hch@lst.de>
References: <20211019062024.2171074-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 19 Oct 2021 08:20:21 +0200, Christoph Hellwig wrote:
> these somehow slipped into a different branch, so here is another
> small batch.
> 
> Diffstat:
>  ioctl.c          |   20 ++++++++------------
>  partitions/efi.c |    2 +-
>  partitions/ibm.c |   19 ++++++++++---------
>  3 files changed, 19 insertions(+), 22 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] block/ioctl: use bdev_nr_sectors and bdev_nr_bytes
      commit: 946e99373037be4841e8b42dcd136e03093c9fd5
[2/3] partitions/efi: use bdev_nr_bytes instead of open coding it
      commit: f9831b885709978ed9d16833ceeb3a2ec174a2d2
[3/3] partitions/ibm: use bdev_nr_sectors instead of open coding it
      commit: 97eeb5fc14cc4b2091df8b841a07a1ac69f2d762

Best regards,
-- 
Jens Axboe


