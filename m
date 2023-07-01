Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83058C0015E
	for <linux-block@archiver.kernel.org>; Sat,  1 Jul 2023 06:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjGAGuz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jul 2023 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjGAGuU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jul 2023 02:50:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AC14EC7;
        Fri, 30 Jun 2023 23:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1688193642; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Dj/B0mgRrKrLnMXtlkOiDHBrQ8XKKmSpVKf9xMaQ1k9i7r604s7yFWhszgPdQLl6jR
    gKstS2vd7YC0l0yyvHUmmVCRtcAUHB62ZR2mw+5Cm9+lpzjt7/e8t2VsXpfwP0N/Lf4K
    QUFND+sFhm4k3mtY1SfzmsW1uBa+26/mVrdggL8zewlHPlf6gY140LQC2MjXBbswy9rf
    DvByc9qup2raI9oZ96R7NayVrTJ12nctK3ZaL3Qm/cB+6HgUUaZ0ykr0X+ruHHqHSZl6
    QUKrwpS5QgqXL1qaQMTasOqQVIDbfemhF0Bo4Stwtt9s3kDVY4Xc1LwQw2iMTdDj1jOe
    pXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1688193642;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Geopluaz3TDcYvhoF+eKUr/b/1qwY3K/34g5xOAaUv0=;
    b=PknmAxBhkNqodBGezqBzR57eXS/t2+5hbSDEQByusu6Lim1S9x/38QHqYASP6qxVqR
    i3Z3TbuvuXA4nEkV0jOITE77CItUMkUxuNqyLU6aIe0H3Ro13Qgl8J/y7i5cRVfzzCPv
    jzPiaO3nnbP72ZNUuDFHH1jR/5RjWurk0TBuvoMw2QCggK+Nw0ZAZYrCgjRgADVMtNid
    keqHYt3IFHrQVOHJEk4B1e31s/KMaK/re8BNCdgMAwlB/fJBmFWuTlzolNFiQCAPNIbZ
    1F07ZujRrtPGL09VaL7YNVCRGx8YKTlEgrbGIiUU8wXj/57z0X15aINGjISAKzqvuJqx
    dtkw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1688193642;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Geopluaz3TDcYvhoF+eKUr/b/1qwY3K/34g5xOAaUv0=;
    b=RdUp8H2aheIHUCvCztydQrF53l0f9iumSjPciOeEYcz82te1mCCCWzUpaNJNwdN9n7
    jzU9HOC/UsExanBfxoEdF10nZ2iebUCNp04z9ko3K5QLgBePcPGtxJMb0bC7lxbSOnha
    kX7WCvCEHNQdIMD/xIh2G6IENTI/dUbjzKmrVtC8FmwOZIKOIqo06qkYyGe/JN4r85wI
    y98SDLdYcX4N3hZXu0YayoxtbPYc/H3ALD1ZeCUj/oOHhzQEaQlzULwx1ZWYvgNDaMAj
    HSVRRQ+928SsWL1vs3UHZg0r00+dynoh+ycUI/E95rDDR2/dd07CXWADRtX5qMyDGGyB
    pWbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1688193642;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Geopluaz3TDcYvhoF+eKUr/b/1qwY3K/34g5xOAaUv0=;
    b=cCcdVDTKyp0U1B9gi/3O243CwI2nJaisPzxNIy4FowyFjOqwN7CbfwbUA2UXKXf2uB
    e8CbACLaX0bERNq2GaCA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGM4l4Hio94KKxRySfLxnHfJ+Dkjp5DdBfio0GngadwjU4IS6qmHYqr4pnLwccgWBLjxs"
Received: from [IPV6:2a02:8109:8980:4474:19de:8732:90de:fd8]
    by smtp.strato.de (RZmta 49.6.0 AUTH)
    with ESMTPSA id N28a51z616egsBq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 1 Jul 2023 08:40:42 +0200 (CEST)
Message-ID: <3e3ce346-f627-4adf-179d-b8817361e6e3@xenosoft.de>
Date:   Sat, 1 Jul 2023 08:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] block: bugfix for Amiga partition overflow check patch
To:     Michael Schmitz <schmitzmic@gmail.com>,
        linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     linux-m68k@vger.kernel.org, geert@linux-m68k.org, hch@lst.de,
        martin@lichtvoll.de, stable@vger.kernel.org,
        "R.T.Dickinson" <rtd2@xtra.co.nz>,
        Darren Stevens <darren@stevens-zone.net>,
        mad skateman <madskateman@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20230701023524.7434-1-schmitzmic@gmail.com>
Content-Language: de-DE
From:   Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20230701023524.7434-1-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01 July 2023 at 04:35 am, Michael Schmitz wrote:
> Making 'blk' sector_t (i.e. 64 bit if LBD support is active)
> fails the 'blk>0' test in the partition block loop if a
> value of (signed int) -1 is used to mark the end of the
> partition block list.
>
> This bug was introduced in patch 3 of my prior Amiga partition
> support fixes series, and spotted by Christian Zigotzky when
> testing the latest block updates.
>
> Explicitly cast 'blk' to signed int to allow use of -1 to
> terminate the partition block linked list.
>
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Fixes: b6f3f28f60 ("Linux 6.4")
> Message-ID: 024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Cc: <stable@vger.kernel.org> # 6.4
> Link: https://lore.kernel.org/r/024ce4fa-cc6d-50a2-9aae-3701d0ebf668@xenosoft.de
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> ---
>   block/partitions/amiga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/block/partitions/amiga.c b/block/partitions/amiga.c
> index ed222b9c901b..506921095412 100644
> --- a/block/partitions/amiga.c
> +++ b/block/partitions/amiga.c
> @@ -90,7 +90,7 @@ int amiga_partition(struct parsed_partitions *state)
>   	}
>   	blk = be32_to_cpu(rdb->rdb_PartitionList);
>   	put_dev_sector(sect);
> -	for (part = 1; blk>0 && part<=16; part++, put_dev_sector(sect)) {
> +	for (part = 1; (s32) blk>0 && part<=16; part++, put_dev_sector(sect)) {
>   		/* Read in terms partition table understands */
>   		if (check_mul_overflow(blk, (sector_t) blksize, &blk)) {
>   			pr_err("Dev %s: overflow calculating partition block %llu! Skipping partitions %u and beyond\n",
Hello Michael,

Thanks for your patch.

I patched the latest git kernel source code with your patch today but 
unfortunately the kernel has reported a bad geometry. (EXT4-fs (sda4): 
bad geometry: block count ...)

dmesg | grep -i sda

[    4.025449] sd 0:0:0:0: [sda] 3907029168 512-byte logical blocks: 
(2.00 TB/1.82 TiB)
[    4.071978] sd 0:0:0:0: [sda] 4096-byte physical blocks
[    4.119333] sd 0:0:0:0: [sda] Write Protect is off
[    4.165958] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.212921] sd 0:0:0:0: [sda] Write cache: enabled, read cache: 
enabled, doesn't support DPO or FUA
[    4.259469] sd 0:0:0:0: [sda] Preferred minimum I/O size 4096 bytes
[    4.502519]  sda: RDSK (512) sda1 (DOS^G)(res 2 spb 2) sda2 
(SFS^B)(res 2 spb 1) sda3 (SFS^B)(res 2 spb 2) sda4 ((res 2 spb 1)
[    4.551981] sd 0:0:0:0: [sda] Attached SCSI disk
[   82.421727] EXT4-fs (sda4): bad geometry: block count 319655862 
exceeds size of device (317690430 blocks)

I can't mount the ext4 partition on the RDB disk and booting isn't 
possible as well.

Thanks,
Christian
