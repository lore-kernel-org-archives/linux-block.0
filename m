Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD338C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB29217FA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 08:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQtHvnEb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbfDYIPZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 04:15:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37495 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYIPY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 04:15:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id t17so17273639wrr.4;
        Thu, 25 Apr 2019 01:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=658SRk7b8ZveF4hHRQ6cfQbo38vY/JLKn59mggf35X8=;
        b=oQtHvnEbDeSrlObkmdqj7I89uy+PKxhm7l8uwYp+Enzh10hwieUj5ovRluveiHzGHX
         fj856YFHPgZ1evvdd8PxRLmoqJJ4onCSHrue5hdyaTqYvvsnopodh0WHRaFKIwoOOeUy
         AG3fWsEoI4jqmsSHcKN5o7JootWyKhEEmX3Xca+nP6HARwEAqsg8pgYXgkItyVeqG5IK
         hDtTrnFT3rpyuGMlyDwku568xjZ257nQIKoC8+JgKcv/mUSW0GOv2ZHCAieTVl4lGoqf
         sRTcKO8KvtlctLQQPC+2Bxspq8rMBltfjDP3JZiZ1kts70G/Wch2yUCdfgezj1Mn/iy9
         F8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=658SRk7b8ZveF4hHRQ6cfQbo38vY/JLKn59mggf35X8=;
        b=CdjiOIqwOUkG42+a7ZI277aqweQ+CNkzSNjnNMuu6nNasHa0yX9FiMapMLyjuRP5tJ
         F6DxN5SYFbiClls5yc/7ymXzM/MohSu23ZxnPa//qBOElJHPkblDt4b4bLub8ESSn547
         P0Q5lqcE5uTachcitO81urzUd5skIzQyyFv/cCUokLHASMRXM+Ncemp/h13QcV6MsIvM
         5ZXx+9AQBmGv20BLC9rJs4GdhGxumLa7yt9hwWRuTeHqf5Kv1yA6nbS9xkDZ6Kd4Y+o4
         mhQfpMqRA+DnSbNcLHPZ+y0lifRA9A7x5QYvhaLX331i1RHuSScWrvI6vb975XlCrQSl
         aA1w==
X-Gm-Message-State: APjAAAXgM5/eFKvnH99uxCxu6Kd2Tm8POi+Wgy9e1R/bRX1iyi+HYBzD
        UytMe39CYNCHiZV7bYHAPNrCWftgrvUdmExObIbwWe0edaeYrg==
X-Google-Smtp-Source: APXvYqwiJgU/SHYbS0sbX0x3sq1gOWOxflVYPcrLBtsm9COY3bRkWxYcnpdG5htb/Md8/R7C52iBdCLVqEyRI4x1+nE=
X-Received: by 2002:adf:b60a:: with SMTP id f10mr23819235wre.116.1556180121881;
 Thu, 25 Apr 2019 01:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <38bef24c-3839-11b0-a192-6cf511d8b268@lca.pw>
In-Reply-To: <38bef24c-3839-11b0-a192-6cf511d8b268@lca.pw>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 25 Apr 2019 16:15:10 +0800
Message-ID: <CACVXFVO_9KOkC=A-uz-NjUOxs_r771yibnKaCPs0z1VuK=QRtw@mail.gmail.com>
Subject: Re: bio_iov_iter_get_pages() + page_alloc.shuffle=1 migrating failures
To:     Qian Cai <cai@lca.pw>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 25, 2019 at 4:13 PM Qian Cai <cai@lca.pw> wrote:
>
> Memory offline [1] starts to fail on linux-next on ppc64le with
> page_alloc.shuffle=1 where the "echo offline" command hangs with lots of
> migrating failures below. It seems in migrate_page_move_mapping()
>
>         if (!mapping) {
>                 /* Anonymous page without mapping */
>                 if (page_count(page) != expected_count)
>                         return -EAGAIN;
>
> It expected count=1 but actual count=2.
>
> There are two ways to make the problem go away. One is to remove this line in
> __shuffle_free_memory(),
>
>         shuffle_zone(z);
>
> The other is reverting some bio commits. Bisecting so far indicates the culprit
> is in one of those (the 3rd commit looks more suspicious than the others).
>
> block: only allow contiguous page structs in a bio_vec
> block: don't allow multiple bio_iov_iter_get_pages calls per bio
> block: change how we get page references in bio_iov_iter_get_pages
>
> [  446.578064] migrating pfn 2003d5eaa failed ret:22
> [  446.578066] page:c00a00800f57aa80 count:2 mapcount:0 mapping:c000001db4c827e9
> index:0x13c08a
> [  446.578220] anon
> [  446.578222] flags: 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
> [  446.578347] raw: 083fffc00008002e c00a00800f57f808 c00a00800f579f88
> c000001db4c827e9
> [  446.944807] raw: 000000000013c08a 0000000000000000 00000002ffffffff
> c00020141a738008
> [  446.944883] page dumped because: migration failure
> [  446.944948] page->mem_cgroup:c00020141a738008
> [  446.945024] page allocated via order 0, migratetype Movable, gfp_mask
> 0x100cca(GFP_HIGHUSER_MOVABLE)
> [  446.945148]  prep_new_page+0x390/0x3a0
> [  446.945228]  get_page_from_freelist+0xd9c/0x1bf0
> [  446.945292]  __alloc_pages_nodemask+0x1cc/0x1780
> [  446.945335]  alloc_pages_vma+0xc0/0x360
> [  446.945401]  do_anonymous_page+0x244/0xb20
> [  446.945472]  __handle_mm_fault+0xcf8/0xfb0
> [  446.945532]  handle_mm_fault+0x1c0/0x2b0
> [  446.945615]  __get_user_pages+0x3ec/0x690
> [  446.945652]  get_user_pages_unlocked+0x104/0x2f0
> [  446.945693]  get_user_pages_fast+0xb0/0x200
> [  446.945762]  iov_iter_get_pages+0xf4/0x6a0
> [  446.945802]  bio_iov_iter_get_pages+0xc0/0x450
> [  446.945876]  blkdev_direct_IO+0x2e0/0x630
> [  446.945941]  generic_file_read_iter+0xbc/0x230
> [  446.945990]  blkdev_read_iter+0x50/0x80
> [  446.946031]  aio_read+0x128/0x1d0
> [  446.946082] migrating pfn 2003d5fe0 failed ret:22
> [  446.946084] page:c00a00800f57f800 count:2 mapcount:0 mapping:c000001db4c827e9
> index:0x13c19e
> [  446.946239] anon
> [  446.946241] flags: 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
> [  446.946384] raw: 083fffc00008002e c000200deb3dfa28 c00a00800f57aa88
> c000001db4c827e9
> [  446.946497] raw: 000000000013c19e 0000000000000000 00000002ffffffff
> c00020141a738008
> [  446.946605] page dumped because: migration failure
> [  446.946662] page->mem_cgroup:c00020141a738008
> [  446.946724] page allocated via order 0, migratetype Movable, gfp_mask
> 0x100cca(GFP_HIGHUSER_MOVABLE)
> [  446.946846]  prep_new_page+0x390/0x3a0
> [  446.946899]  get_page_from_freelist+0xd9c/0x1bf0
> [  446.946959]  __alloc_pages_nodemask+0x1cc/0x1780
> [  446.947047]  alloc_pages_vma+0xc0/0x360
> [  446.947101]  do_anonymous_page+0x244/0xb20
> [  446.947143]  __handle_mm_fault+0xcf8/0xfb0
> [  446.947200]  handle_mm_fault+0x1c0/0x2b0
> [  446.947256]  __get_user_pages+0x3ec/0x690
> [  446.947306]  get_user_pages_unlocked+0x104/0x2f0
> [  446.947366]  get_user_pages_fast+0xb0/0x200
> [  446.947458]  iov_iter_get_pages+0xf4/0x6a0
> [  446.947515]  bio_iov_iter_get_pages+0xc0/0x450
> [  446.947588]  blkdev_direct_IO+0x2e0/0x630
> [  446.947636]  generic_file_read_iter+0xbc/0x230
> [  446.947703]  blkdev_read_iter+0x50/0x80
> [  446.947758]  aio_read+0x128/0x1d0
>
> [1]
> i=0
> found=0
> for mem in $(ls -d /sys/devices/system/memory/memory*); do
>         i=$((i + 1))
>         echo "iteration: $i"
>         echo offline > $mem/state
>         if [ $? -eq 0 ] && [ $found -eq 0 ]; then
>                 found=1
>                 continue
>         fi
>         echo online > $mem/state
> done

Please try the following patch:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.2/block&id=0257c0ed5ea3de3e32cb322852c4c40bc09d1b97

Thanks,
Ming Lei
