Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEDEC433F5
	for <linux-block@archiver.kernel.org>; Sat, 30 Oct 2021 17:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685C0603E8
	for <linux-block@archiver.kernel.org>; Sat, 30 Oct 2021 17:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhJ3RKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Oct 2021 13:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ3RKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Oct 2021 13:10:18 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8687CC061570
        for <linux-block@vger.kernel.org>; Sat, 30 Oct 2021 10:07:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id d63so16471046iof.4
        for <linux-block@vger.kernel.org>; Sat, 30 Oct 2021 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=cj7b4WzzJcmZ+tVCjhkRXyXcKv7YSLzrxMjWUHMImLY=;
        b=Wopv4tcWqOAJZGqYx1oWAbH++R5QUK3biTMI/xiKmgq8kzd4BjfbTwqyki2cw/dKMZ
         zMePBAMmf+SLZ1e8obk5O2B8EqEDPivRKlRqkehfknMQ8MNLufX0ul/cJWZhewILt5Oh
         6lHlndFiey7eEaiN0hgGC39LpO35JqvHs71OpDs0TY9XL4bVtIavn6nIEfmea/hq+LZm
         LUd2MMSVR+UBeThxm8no9AVI+Lkwbvjh/Wd3YPAJax1gQlPv8O8NjJriy/LoIbj10SRd
         9zfUre2XtVMt8acixbfHpVQ/bS6vxPEHVT/7jgMGiywvDrcUkISQerA52lYJTtjCW/Wj
         XOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=cj7b4WzzJcmZ+tVCjhkRXyXcKv7YSLzrxMjWUHMImLY=;
        b=6GsZMjRT4WjMiDnt8J3QbLbo4Enhz/OU/Z4Y5JkttQ1BE3UPCpV2ofr1kdKVse7WQn
         v/mtw0kPP6X08XXLjB/xg/Mh90DipUnHFY0FyMGKKbM6VvU/6CVPZvr47fQnYHxQIxF1
         6iPe94iboUsPsECGFSZodYYO4pXQ9FIr2ZL0ddICCllnb9LEqdHi9VdDnKCxeqzGE8FG
         goc9c/X2Scp/rKKRoyqmamc5jDQ0ceszrNVsYWIj4baZdSFotC9kKsTvwr3gwHotv861
         63Hh9MTqXFCePdRsCFqk8rf6wjfQw6ecNBFAiNBuwEVzB0tSBPr2/t/B0u/tU5ArOiPH
         ooMw==
X-Gm-Message-State: AOAM532YchTqZkMlk7TbtZnHx13pW5j1+odMMNYsxX5LeBlDJb5CHBnH
        vavg9TP9fDLQMTeWHrh0b+Ke5A==
X-Google-Smtp-Source: ABdhPJzTVX/ZyGI7Pmdgi3Ji0UX3geoz9OnmwOkoYIKCEwZOPpGwJ2EvLzYUymZf8Uzb5XEpGHWwDg==
X-Received: by 2002:a02:cbb1:: with SMTP id v17mr13623686jap.51.1635613667880;
        Sat, 30 Oct 2021 10:07:47 -0700 (PDT)
Received: from [127.0.1.1] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o8sm5504963ilu.2.2021.10.30.10.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 10:07:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     vigneshr@ti.com, richard@nod.at, geoff@infradead.org,
        vishal.l.verma@intel.com, kbusch@kernel.org, sagi@grimberg.me,
        minchan@kernel.org, mpe@ellerman.id.au, ira.weiny@intel.com,
        hch@lst.de, senozhatsky@chromium.org, dave.jiang@intel.com,
        miquel.raynal@bootlin.com, paulus@samba.org,
        dan.j.williams@intel.com, benh@kernel.crashing.org, jim@jtan.com,
        ngupta@vflare.org, Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20211015235219.2191207-1-mcgrof@kernel.org>
References: <20211015235219.2191207-1-mcgrof@kernel.org>
Subject: Re: (subset) [PATCH 00/13] block: add_disk() error handling stragglers
Message-Id: <163561366669.77445.6593243934116934390.b4-ty@kernel.dk>
Date:   Sat, 30 Oct 2021 11:07:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 15 Oct 2021 16:52:06 -0700, Luis Chamberlain wrote:
> This patch set consists of al the straggler drivers for which we have
> have no patch reviews done for yet. I'd like to ask for folks to please
> consider chiming in, specially if you're the maintainer for the driver.
> Additionally if you can specify if you'll take the patch in yourself or
> if you want Jens to take it, that'd be great too.
> 
> Luis Chamberlain (13):
>   block/brd: add error handling support for add_disk()
>   nvme-multipath: add error handling support for add_disk()
>   nvdimm/btt: do not call del_gendisk() if not needed
>   nvdimm/btt: use goto error labels on btt_blk_init()
>   nvdimm/btt: add error handling support for add_disk()
>   nvdimm/blk: avoid calling del_gendisk() on early failures
>   nvdimm/blk: add error handling support for add_disk()
>   zram: add error handling support for add_disk()
>   z2ram: add error handling support for add_disk()
>   ps3disk: add error handling support for add_disk()
>   ps3vram: add error handling support for add_disk()
>   block/sunvdc: add error handling support for add_disk()
>   mtd/ubi/block: add error handling support for add_disk()
> 
> [...]

Applied, thanks!

[01/13] block/brd: add error handling support for add_disk()
        commit: e1528830bd4ebf435d91c154e309e6e028336210

Best regards,
-- 
Jens Axboe


