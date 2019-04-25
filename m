Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C44C10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 13:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DEC20675
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 13:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qxaAfMIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfDYNCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 09:02:43 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36776 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfDYNCn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 09:02:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id c35so9510498qtk.3
        for <linux-block@vger.kernel.org>; Thu, 25 Apr 2019 06:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96rStI40ThtBmGcWqYI3X4FkM6ZOQSu6lIf8l+fiVRo=;
        b=qxaAfMIyKYHlle3VEEYUbn1n6SkmraS0hGY3XRZc85e8UAKtTedVMkO8YbxfZ9Clm9
         SquNBtGJqsQR35uJDL9ybre7ScBA/sqf66LYc0cej5Ae1U+DNxHYy7//gbHap6CHAkli
         07p/0FmCAWPTU/lXbMgJ4J3nv9XLxVPgiObE2Ncc4i5dYOrwbDRU1iTUfjYPE1GfXsvH
         EihHH+Dswv+chz1//hzv4dwPXBo2AyEHvdKORkneIZ6fGV/fXi7l4xvFL4tigYHVVD5H
         GDqA6uG1y944GsxQ4ja473S5xoRb0fM1jawGW46f1udR5vgAGkgW+LBd3EcACVHAsuGq
         kUNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96rStI40ThtBmGcWqYI3X4FkM6ZOQSu6lIf8l+fiVRo=;
        b=LCyRJBoBJZTQU37cHDgOx5QlcQX87BL7/E/zs+6hRd0pZsjFHYZR9XSr10QIzAbNX/
         7s916OUT5f2pfcOmLEZIFCOPJTOZvkxuJccRV4stVEOjDXJ6Jn/j5McLPVyLiRS3yc+/
         qUWAGJbKFZxEvP7oQAU+yh+etHTOxh0R068B25CRdGhvgE/Y2GkVPrqKSIPe/WOKjWJr
         22eLSfD3HLqCtJWDxd+f9sSg54WidTfhpFnhPXXIZ4ASb1aUr4QNeh3iGh8xTYAkL0op
         aZpeEBGrM16u9tGlJDjld03wQAjrGmhxIVx+c4uwsJ6DxhBp3ygXsFMdUssL8G9eiytq
         zN/g==
X-Gm-Message-State: APjAAAXw5JJUy6kCEWZ+jpuylgeAFIg66fLKEn4qh7xD3DYD/a6r7WIt
        YmjeLnUttSA/nCN0isSA9HbwVw==
X-Google-Smtp-Source: APXvYqyh5r8KkohsRUySMiD9/d/TioZ/eW5WfI/YXkGE3MnYQ3KFch0EEtDGfvtS2Fr8OjGQcHbOOA==
X-Received: by 2002:ac8:28f4:: with SMTP id j49mr30851971qtj.310.1556197362203;
        Thu, 25 Apr 2019 06:02:42 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w58sm10048612qtw.93.2019.04.25.06.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 06:02:41 -0700 (PDT)
Message-ID: <1556197359.6132.2.camel@lca.pw>
Subject: Re: bio_iov_iter_get_pages() + page_alloc.shuffle=1 migrating
 failures
From:   Qian Cai <cai@lca.pw>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 25 Apr 2019 09:02:39 -0400
In-Reply-To: <CACVXFVO_9KOkC=A-uz-NjUOxs_r771yibnKaCPs0z1VuK=QRtw@mail.gmail.com>
References: <38bef24c-3839-11b0-a192-6cf511d8b268@lca.pw>
         <CACVXFVO_9KOkC=A-uz-NjUOxs_r771yibnKaCPs0z1VuK=QRtw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 2019-04-25 at 16:15 +0800, Ming Lei wrote:
> On Thu, Apr 25, 2019 at 4:13 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > Memory offline [1] starts to fail on linux-next on ppc64le with
> > page_alloc.shuffle=1 where the "echo offline" command hangs with lots of
> > migrating failures below. It seems in migrate_page_move_mapping()
> > 
> >         if (!mapping) {
> >                 /* Anonymous page without mapping */
> >                 if (page_count(page) != expected_count)
> >                         return -EAGAIN;
> > 
> > It expected count=1 but actual count=2.
> > 
> > There are two ways to make the problem go away. One is to remove this line
> > in
> > __shuffle_free_memory(),
> > 
> >         shuffle_zone(z);
> > 
> > The other is reverting some bio commits. Bisecting so far indicates the
> > culprit
> > is in one of those (the 3rd commit looks more suspicious than the others).
> > 
> > block: only allow contiguous page structs in a bio_vec
> > block: don't allow multiple bio_iov_iter_get_pages calls per bio
> > block: change how we get page references in bio_iov_iter_get_pages
> > 
> > [  446.578064] migrating pfn 2003d5eaa failed ret:22
> > [  446.578066] page:c00a00800f57aa80 count:2 mapcount:0
> > mapping:c000001db4c827e9
> > index:0x13c08a
> > [  446.578220] anon
> > [  446.578222] flags:
> > 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
> > [  446.578347] raw: 083fffc00008002e c00a00800f57f808 c00a00800f579f88
> > c000001db4c827e9
> > [  446.944807] raw: 000000000013c08a 0000000000000000 00000002ffffffff
> > c00020141a738008
> > [  446.944883] page dumped because: migration failure
> > [  446.944948] page->mem_cgroup:c00020141a738008
> > [  446.945024] page allocated via order 0, migratetype Movable, gfp_mask
> > 0x100cca(GFP_HIGHUSER_MOVABLE)
> > [  446.945148]  prep_new_page+0x390/0x3a0
> > [  446.945228]  get_page_from_freelist+0xd9c/0x1bf0
> > [  446.945292]  __alloc_pages_nodemask+0x1cc/0x1780
> > [  446.945335]  alloc_pages_vma+0xc0/0x360
> > [  446.945401]  do_anonymous_page+0x244/0xb20
> > [  446.945472]  __handle_mm_fault+0xcf8/0xfb0
> > [  446.945532]  handle_mm_fault+0x1c0/0x2b0
> > [  446.945615]  __get_user_pages+0x3ec/0x690
> > [  446.945652]  get_user_pages_unlocked+0x104/0x2f0
> > [  446.945693]  get_user_pages_fast+0xb0/0x200
> > [  446.945762]  iov_iter_get_pages+0xf4/0x6a0
> > [  446.945802]  bio_iov_iter_get_pages+0xc0/0x450
> > [  446.945876]  blkdev_direct_IO+0x2e0/0x630
> > [  446.945941]  generic_file_read_iter+0xbc/0x230
> > [  446.945990]  blkdev_read_iter+0x50/0x80
> > [  446.946031]  aio_read+0x128/0x1d0
> > [  446.946082] migrating pfn 2003d5fe0 failed ret:22
> > [  446.946084] page:c00a00800f57f800 count:2 mapcount:0
> > mapping:c000001db4c827e9
> > index:0x13c19e
> > [  446.946239] anon
> > [  446.946241] flags:
> > 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
> > [  446.946384] raw: 083fffc00008002e c000200deb3dfa28 c00a00800f57aa88
> > c000001db4c827e9
> > [  446.946497] raw: 000000000013c19e 0000000000000000 00000002ffffffff
> > c00020141a738008
> > [  446.946605] page dumped because: migration failure
> > [  446.946662] page->mem_cgroup:c00020141a738008
> > [  446.946724] page allocated via order 0, migratetype Movable, gfp_mask
> > 0x100cca(GFP_HIGHUSER_MOVABLE)
> > [  446.946846]  prep_new_page+0x390/0x3a0
> > [  446.946899]  get_page_from_freelist+0xd9c/0x1bf0
> > [  446.946959]  __alloc_pages_nodemask+0x1cc/0x1780
> > [  446.947047]  alloc_pages_vma+0xc0/0x360
> > [  446.947101]  do_anonymous_page+0x244/0xb20
> > [  446.947143]  __handle_mm_fault+0xcf8/0xfb0
> > [  446.947200]  handle_mm_fault+0x1c0/0x2b0
> > [  446.947256]  __get_user_pages+0x3ec/0x690
> > [  446.947306]  get_user_pages_unlocked+0x104/0x2f0
> > [  446.947366]  get_user_pages_fast+0xb0/0x200
> > [  446.947458]  iov_iter_get_pages+0xf4/0x6a0
> > [  446.947515]  bio_iov_iter_get_pages+0xc0/0x450
> > [  446.947588]  blkdev_direct_IO+0x2e0/0x630
> > [  446.947636]  generic_file_read_iter+0xbc/0x230
> > [  446.947703]  blkdev_read_iter+0x50/0x80
> > [  446.947758]  aio_read+0x128/0x1d0
> > 
> > [1]
> > i=0
> > found=0
> > for mem in $(ls -d /sys/devices/system/memory/memory*); do
> >         i=$((i + 1))
> >         echo "iteration: $i"
> >         echo offline > $mem/state
> >         if [ $? -eq 0 ] && [ $found -eq 0 ]; then
> >                 found=1
> >                 continue
> >         fi
> >         echo online > $mem/state
> > done
> 
> Please try the following patch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?
> h=for-5.2/block&id=0257c0ed5ea3de3e32cb322852c4c40bc09d1b97

It works great so far!
