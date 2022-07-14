Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BDBC433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbiGNSPL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240560AbiGNSPL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:15:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409667CAA
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:15:10 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bf13so2277741pgb.11
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=RnAUJDeFVqtcYLmiM6RnBTHgzpJ2sbGtXQfTY4CG9Xw=;
        b=F+wUtufXFBM4SfgXLNefq8u6s5IPnIba1jNffu7FS4VAcAdE1bcILRIVtepkljy6CT
         396PJ0fVoDjH2sntr60DT3iQb2/ft8qwbr1wT+k35N53QMiAqZFw48krf+BUM8/2XKRi
         y3EbAtUTeHX0f1HqE/PfF6T02e7qhvxc0ZWjOKQmPiDFddX2KzmYD8Ltxd+89HOuELF5
         MSAr40tLmp/andD3196mOSFjvQ5TpraXHyBgdWvskhZKtmFCcWrw7etNiLxvYivFOsc5
         1kIbi5+cvZHsdOEF4vyscgtrfEz+/bW5vQKT+NIozl10WCXsKjRbXRlf7mDgi4CNgJSP
         b1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=RnAUJDeFVqtcYLmiM6RnBTHgzpJ2sbGtXQfTY4CG9Xw=;
        b=kvUZW4QupyHlRG1BqjowPiYTCWDGncbtjw4jg2cWyLOnU5DDJsA6MmtmLeRS6j57bZ
         mKI16uQdjGgo6fmtuzx151PbhX4hQBNWQWv6L7P/M788ZVPIBWI8ad55NJasSNZ1j7Mh
         tvVTXHE6O/dsmSK6jAA0K9xsYWNNN0kTDCpd8Ailb2qfYZVYpzfqJLhind1GelnKgf4b
         FjRC+j/rNrlaLLoCZKK3MfecLpLkH41xNxTG+BXA0Dt0oVi+uueagNcCFr6HuwUREw+8
         q+4LYtl3K4+DZkVA4PVQRibcI7FappD9Pm+nV2736LgxZy40b7TKwvnYBsaOeCzM02B0
         wvug==
X-Gm-Message-State: AJIora//Y+zGg7LAkWnMofdt7dKXBr/aCMiWsj8O7SRj+4zm4XQ52/Wh
        5mD7v+lIn/m+fIDIfizCOvidbQ==
X-Google-Smtp-Source: AGRyM1sBmNDrZLzTFdtP7eo3/KzijLtECfnDDPcNnBENy0V++JD/SdYUAiAV5s4fL0JHqeP9B5ARGw==
X-Received: by 2002:a63:42c2:0:b0:412:82c5:45af with SMTP id p185-20020a6342c2000000b0041282c545afmr8435383pga.461.1657822509589;
        Thu, 14 Jul 2022 11:15:09 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u9-20020a1709026e0900b0016be702a535sm1770160plk.187.2022.07.14.11.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:15:09 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, jaegeuk@kernel.org,
        Christoph Hellwig <hch@lst.de>
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
Subject: Re: [PATCH v3 00/63] Improve static type checking for request flags
Message-Id: <165782250871.660480.3102858195023513970.b4-ty@kernel.dk>
Date:   Thu, 14 Jul 2022 12:15:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 14 Jul 2022 11:06:26 -0700, Bart Van Assche wrote:
> A source of confusion in the block layer is that can be nontrivial to determine
> which type of flags a u32 function argument accepts. This patch series clears
> up that confusion for request flags by introducing a new __bitwise type, namely
> blk_opf_t. Additionally, the type 'int' is change into 'enum req_op' where used
> to hold a request operation.
> 
> Analysis of the sparse warnings introduced by this conversion resulted in one
> bug fix ("blktrace: Trace remap operations correctly").
> 
> [...]

Applied, thanks!

[01/63] treewide: Rename enum req_opf into enum req_op
        commit: ff07a02e9e8e6489db841e0c48a5c78e7e78d572
[02/63] block: Use enum req_op where appropriate
        commit: 77e7ffd7ad3952909be6a9c599b7d164c8866fec
[03/63] block: Change the type of the last .rw_page() argument
        commit: 86947df3a9236481276e8baadde50a403b02b4d4
[04/63] block: Change the type of req_op() and bio_op() into enum req_op
        commit: 2d9b02be73ba8efba406b399a722b4e33614dd0e
[05/63] block: Introduce the type blk_opf_t
        commit: 342a72a334073f163da924b69c3d3fb4685eb33a
[06/63] block: Use the new blk_opf_t type
        commit: 16458cf3bd15e5624205df6e8a76b9a5363555f3
[07/63] block/bfq: Use the new blk_opf_t type
        commit: dc469ba2e790cb0a335e2650b701639752ff65cd
[08/63] block/mq-deadline: Use the new blk_opf_t type
        commit: f8359efe4742a39b4ece554ab9d7e5f03c4fff83
[09/63] block/kyber: Use the new blk_opf_t type
        commit: d625fecd8af84ac669075caf1941ff0d1995de56
[10/63] blktrace: Trace remapped requests correctly
        commit: 22c80aac882f712897b88b7ea8f5a74ea19019df
[11/63] blktrace: Use the new blk_opf_t type
        commit: 919dbca8670d0f7828dfbb2f9b434ac22dca8d2e
[12/63] block/brd: Use the enum req_op type
        commit: ba91fd01aad28b2290a00518c4cd6eb728b4f06f
[13/63] block/drbd: Use the enum req_op and blk_opf_t types
        commit: 9945172a7120790fb8832cfec9557773f69e9d74
[14/63] block/drbd: Combine two drbd_submit_peer_request() arguments
        commit: 86563de87447ad9458fda9d1862c5ba333c8ab2e
[15/63] block/floppy: Fix a sparse warning
        commit: 23f8ae7148cc32287364741e32b20f37730114aa
[16/63] block/rnbd: Use blk_opf_t where appropriate
        commit: 03df83ac9eb77f749bfd84c7d448cb2b90c1196c
[17/63] xen-blkback: Use the enum req_op and blk_opf_t types
        commit: 6c5412e268340e0d98eade4571658bacb4652176
[18/63] block/zram: Use enum req_op where appropriate
        commit: bc0421ea44b82d2108bcf79e020498c5ff0000af
[19/63] nvdimm-btt: Use the enum req_op type
        commit: ba229aa8f2494bb76aa3f0c80e8a6c0023c829d7
[20/63] um: Use enum req_op where appropriate
        commit: 7ee1de6e2712efabe8e6cab8db5238ed13643dc1
[21/63] dm/core: Reduce the size of struct dm_io_request
        commit: 581075e4f6475bb97c73ecccf68636a9453a31fd
[22/63] dm/core: Rename kcopyd_job.rw into kcopyd.op
        commit: 71f7113d20ae1083e66ce3301f387362184cdd96
[23/63] dm/core: Combine request operation type and flags
        commit: a3282b432f64e9b88632bd380c90157673dce75b
[24/63] dm/ebs: Change 'int rw' into 'enum req_op op'
        commit: 67a7b9a5b54fa3a1b9e4ab5b9808198680cba082
[25/63] dm/dm-flakey: Use the new blk_opf_t type
        commit: eff17e5161feda42c64b1402e86724649927bcde
[26/63] dm/dm-integrity: Combine request operation and flags
        commit: c9154a4cb8dc6a1bca4158174fedecf98de7580d
[27/63] dm mirror log: Use the new blk_opf_t type
        commit: c1389b33332ee09e8981a21a8abb812d93ca253f
[28/63] dm-snap: Combine request operation type and flags
        commit: 6b9901395702c34c3ef0fe63573fcf69192244ea
[29/63] dm/zone: Use the enum req_op type
        commit: 8a5a7ce8774ce9d2fb52df6ecb0d234cf76811d1
[30/63] dm/dm-zoned: Use the enum req_op type
        commit: 13a1f650b6ec935834977461b87585f6387257b4
[31/63] md/core: Combine two sync_page_io() arguments
        commit: 4ce4c73f662bdb0ae5bfb058bc7ec6f6829ca078
[32/63] md/bcache: Combine two uuid_io() arguments
        commit: 9a4fd6a22c64cd7e5555d252ef6c5f2c6dce8ec2
[33/63] md/bcache: Combine two prio_io() arguments
        commit: 552eee3b53f661b76e354ab2ba71e2a625cb9722
[34/63] md/raid1: Use the new blk_opf_t type
        commit: 3c5e514db58fdca10ff5e08a5d2e8a4b077300e4
[35/63] md/raid10: Use the new blk_opf_t type
        commit: cb1802ff82e1ebbbafd860e5a73c26607d72dcd9
[36/63] md/raid5: Use the enum req_op and blk_opf_t types
        commit: a9010741ce7c9533fa825cc49f0739d4d8ebda48
[37/63] nvme/host: Use the enum req_op and blk_opf_t types
        commit: f9ed86dc1dc87662145d0327845fde1c6f3db6cd
[38/63] nvme/target: Use the new blk_opf_t type
        commit: a288000f9fe381a21693832275491b9c802921c4
[39/63] scsi/core: Improve static type checking
        commit: ea957547e819a21bd49895c6162f78d542867d39
[40/63] scsi/core: Change the return type of scsi_noretry_cmd() into bool
        commit: 88b32c3cdf5fff7ed5bdaec7493428185cc65b6e
[41/63] scsi/core: Use the new blk_opf_t type
        commit: 2599cac57a9af4e7ce628e2ef41e92797cba4ae2
[42/63] scsi/device_handlers: Use the new blk_opf_t type
        commit: c15cbe9a84b05462195102bcead0213eb068c595
[43/63] scsi/ufs: Rename a 'dir' argument into 'op'
        commit: 0d8009f39d0adb5b0415190f71841a88f14d9790
[44/63] scsi/target: Use the new blk_opf_t type
        commit: 79fe9d7d9f6479d3fe85d39813ec452844fac99a
[45/63] mm: Use the new blk_opf_t type
        commit: f8e6e4bd9fd8c452565f3eaeb358e3cc08d880f4
[46/63] fs/buffer: Use the new blk_opf_t type
        commit: 3ae7286943ae6f6bfecfe0a3da9d1a4c64f5531f
[47/63] fs/buffer: Combine two submit_bh() and ll_rw_block() arguments
        commit: 1420c4a549bf28ffddbed827d61fb3d4d2132ddb
[48/63] fs/direct-io: Reduce the size of struct dio
        commit: c6293eacfc16fe3d85f468fc7ed91eb18f5861d3
[49/63] fs/mpage: Use the new blk_opf_t type
        commit: f84c94afcf823c6c78438c56c9414763beec50d9
[50/63] fs/btrfs: Use the enum req_op and blk_opf_t types
        commit: bf9486d6dd2351f6cfff9a8df87657a1248a918d
[51/63] fs/ext4: Use the new blk_opf_t type
        commit: 67c0f556302cfcdb5b5fb7933afa08cb1de75b36
[52/63] fs/f2fs: Use the enum req_op and blk_opf_t types
        commit: 7649c873c16a384d447f7dbf9b153e333159f914
[53/63] fs/gfs2: Use the enum req_op and blk_opf_t types
        commit: 67688c08b7e5e9f8f945b22fb460a31ed3feb880
[54/63] fs/hfsplus: Use the enum req_op and blk_opf_t types
        commit: c85f99929ea66c357199b6a3fe958745e1190f5a
[55/63] fs/iomap: Use the new blk_opf_t type
        commit: dbd4eb8148f694ae300fe9682b505acf53053f6e
[56/63] fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
        commit: 6669797b0dd41ced457760b6e1014fdda8ce19ce
[57/63] fs/nfs: Use enum req_op where appropriate
        commit: 5d12ce77e1e677590de13468fe1a497388de3a9e
[58/63] fs/nilfs2: Use the enum req_op and blk_opf_t types
        commit: ed4512590bd5839f8ea9eef1626b0f4db626b1d1
[59/63] fs/ntfs3: Use enum req_op where appropriate
        commit: ce6b5315883448fbecfaca43b95d3bf2ed1d008c
[60/63] fs/ocfs2: Use the enum req_op and blk_opf_t types
        commit: 61ba06c7069bfe1d2b66ab474ce0d6b4f5419d64
[61/63] PM: Use the enum req_op and blk_opf_t types
        commit: 568e34ed7339e357f73c8e1ae5cc4f4595805357
[62/63] fs/xfs: Use the enum req_op and blk_opf_t types
        commit: d03025aef8676e826b69f8e3ec9bb59a5ad0c31d
[63/63] fs/zonefs: Use the enum req_op type for tracing request operations
        commit: e46b5970496705127f9ae494c66e0242773097e8

Best regards,
-- 
Jens Axboe


