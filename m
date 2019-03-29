Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE3BC43381
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 00:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66229218A2
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 00:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLpKd8FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbfC2Ado (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:33:44 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39661 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfC2Ado (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Mar 2019 20:33:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so453990wrn.6;
        Thu, 28 Mar 2019 17:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=58fLkNz7cAB2lVNPA1AQzzwu9stnv5qb/Qggxe0rt9M=;
        b=QLpKd8FMk83fWSgoZDFQ/yOuqFHxO+n8NcovVsWBYFeUEggPS9SGe7MWvrE4kSIp5v
         eDg6izO91xSAobIZjLa/qkuXBG8+6fE3LmurfQibQAlT5eWrHDaTJhpbW/e1pzECF+zA
         3+t3z9FYPUnP9UXcAN5LNQ2cjQ9oSInGReJlSkbjF7PGxIJjkf9LUF1Vlv3iPyZUxYrG
         +xh04hdc8cNaI7uqUSLuzB5zVnErNMmP4JhVhwhDJi+6jbXFrm8WL0isPufojwMycTCB
         huhXUVC/n8cWsKziJsMLpSxfweh4UcZCwCeB1zAiodXfJN1ANo0BfD6sVAebe/CgfqRC
         wxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=58fLkNz7cAB2lVNPA1AQzzwu9stnv5qb/Qggxe0rt9M=;
        b=isPLgoqE62FfUSmACp10Wz2otgIqzPOkxR4w5JWADrVHh+HlyEpn9wO3JTWhNPbBUF
         rQ27sqSFQmvUI/bWV5+utreYQqKHyi+YEMM+daK4MtUfkDOY1lge7kIWwJGJB1ZSccOt
         hwOXTwUgelpD+uOON2jBEF6wzd/Lj7LSnTigVCVlruxI19SeYzpyeR/NmW0vEAXX/6S3
         t4FZIWbVmvqdl8u9ikvUE9spcwVDXZwnZXL48492LBAuJYKXS/sKsOdXxShb/O8ath53
         JcC+O6ja2k/gDBWBasubVAh1IO1xyaygEoHFUkh2pkGvKDOPTmT32StKX+tCTZ/FVbND
         y3vA==
X-Gm-Message-State: APjAAAXPmXgdQFPkY5ynsmjfUJTc8vhlpRH45qNbDuzw47L2YF17YqJq
        hPa5NC35fmQ1470pIqWFemqQ3mpdo+yngIkaO5w=
X-Google-Smtp-Source: APXvYqyYNaNQmWvc2tYvvasEKWIJsjxZyEwlEaJeDjyPh/Eu6RIN3F2yEWQ6c6fbkMmLV76AWEPn6znj0i3KpfwyaDc=
X-Received: by 2002:adf:b60a:: with SMTP id f10mr28002685wre.116.1553819621818;
 Thu, 28 Mar 2019 17:33:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190325010409.GB6379@shao2-debian> <bb98759a-2b51-9785-d903-282ca1ed91cb@suse.de>
In-Reply-To: <bb98759a-2b51-9785-d903-282ca1ed91cb@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 29 Mar 2019 08:33:30 +0800
Message-ID: <CACVXFVPi4WHcthPey4xKT8Jxwkq40J3iLu5v_sprD=eFjs4Qrg@mail.gmail.com>
Subject: Re: [block] 4e366a7962: blktests.nvme.005.fail
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, LKP ML <lkp@01.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 29, 2019 at 12:32 AM Johannes Thumshirn <jthumshirn@suse.de> wr=
ote:
>
> On 25/03/2019 02:04, kernel test robot wrote:
> [...]
> > nvme/005 (reset local loopback target)
> >     runtime  ...
> > nvme/005 (reset local loopback target)                       [failed]
> >     runtime  ...  0.596s
> >     something found in dmesg:
> >     [   24.160182] run blktests nvme/005 at 2019-03-24 07:35:16
> >     [   24.346189] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
> >     [   24.373089] nvmet: creating controller 1 for subsystem blktests-=
subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:dbd85962-80d1-4872-ac0f=
-d0214f3b1131.
> >     [   24.394247] WARNING: CPU: 1 PID: 881 at /kbuild/src/x86_64/block=
/blk-merge.c:608 blk_rq_map_sg+0x5f0/0x6c0
> >     [   24.396082] Modules linked in: nvme_loop nvme_fabrics nvmet nvme=
_core loop crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel a=
ta_generic sd_mod pata_acpi sg bochs_drm ttm ppdev drm_kms_helper syscopyar=
ea sysfillrect sysimgblt fb_sys_fops snd_pcm drm ata_piix snd_timer aesni_i=
ntel crypto_simd snd cryptd glue_helper libata joydev soundcore pcspkr seri=
o_raw virtio_scsi i2c_piix4 parport_pc floppy parport ip_tables
> >     [   24.403009] CPU: 1 PID: 881 Comm: nvme Not tainted 5.0.0-rc6-001=
48-g4e366a7 #1
> >     [   24.404372] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.10.2-1 04/01/2014
> >     [   24.405930] RIP: 0010:blk_rq_map_sg+0x5f0/0x6c0
> >     [   24.406808] Code: 41 8b 91 10 01 00 00 8b 43 24 85 c2 0f 84 e3 f=
b ff ff f7 d0 21 d0 83 c0 01 41 01 40 0c 01 83 d0 00 00 00 e9 cd fb ff ff 0=
f 0b <0f> 0b e9 c3 fc ff ff 80 3d 66 f3 1d 01 00 0f 85 88 fb ff ff 48 c7
> >     [   24.410274] RSP: 0000:ffffb95c409d7908 EFLAGS: 00010202
> >     ...
> >     (See '/lkp/benchmarks/blktests/blktests/results/nodev/nvme/005.dmes=
g' for the entire message)
>
> OK we're tripping over this in blk_rq_map_sg():
>
> 607    /*
> 608     * Something must have been wrong if the figured number of
> 609     * segment is bigger than number of req's physical segments
> 610     */
> 611    WARN_ON(nsegs > blk_rq_nr_phys_segments(rq));
>
> In all cases I could reproduce it I had nsegs =3D=3D 2 and
> rq->nr_phys_segments =3D=3D 1 (rq->bio->bi_phys_segments =3D=3D 1).
>
> Adding this into nvme-loop "fixes" the issue but I don't think this is
> the correct way to do
>
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -387,6 +387,7 @@ static int nvme_loop_configure_admin_que
>                 goto out_free_tagset;
>         }
>
> +       blk_queue_segment_boundary(ctrl->ctrl.admin_q, PAGE_SIZE - 1);

The above isn't needed for linus tree, however it is required for 5.0 and o=
lder
releases.

But nvme-loop target have other problems, and I'd suggest you to apply
the following patch:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-linus&id=3D02db99548d3608a625cf481cff2bb7b626829b3f

>         error =3D nvmf_connect_admin_queue(&ctrl->ctrl);
>         if (error)
>                 goto out_cleanup_queue;
>
> What raises my suspicion is this code fragment from bio_add_pc_page():
>
>  731
>  732   /* If we may be able to merge these biovecs, force a recount */
>  733   if (bio->bi_vcnt > 1 && biovec_phys_mergeable(q, bvec - 1, bvec))
>  734           bio->bi_phys_segments =3D -1;

The above change from you might cause issue given some queue's .bi_phys_seg=
ments
is 255.

>
> This -1 (from this patch) would fit the one less than 'nsegs' but after
> days of searching and staring at the code, I cannot find where we loose
> the one. Before this patch set we would only have cleared the
> BIO_SEG_VALID flag and thus we never run out of sync.

I'd suggest you to address the following comments first before working on
your patch:

https://lore.kernel.org/linux-block/CACVXFVNPW1TOsCaAibc-YJHDEdK95Y8-v1rHNa=
ab7oV=3Deb+8TA@mail.gmail.com/

https://lore.kernel.org/linux-block/CACVXFVOq1ngjpD62SreSZda5k_WJjxOZRHwpqt=
6si7bRv=3DO46Q@mail.gmail.com/

>
> Adding a call to blk_recount_segments() doesn't do any difference here.
>
> It can of be a read herring as well.
>
> What makes me suspicious is the fact that I can't reliably trigger it by
> running nvme/005 but have to run it in a loop ranging between several
> seconds to some minutes.
>
> Anyone any ideas? I've been staring at this for several days now but
> can't find out whats wrong.

Can you trigger this issue on linus tree or 5.2-tmp of block tree?


Thanks,
Ming Lei
