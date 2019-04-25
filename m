Return-Path: <SRS0=cXaM=S3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D315CC10F03
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98825217FA
	for <linux-block@archiver.kernel.org>; Thu, 25 Apr 2019 05:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="raQQIWLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfDYFGP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Apr 2019 01:06:15 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]:35724 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728930AbfDYFGP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Apr 2019 01:06:15 -0400
Received: by mail-qk1-f177.google.com with SMTP id n81so8422468qke.2
        for <linux-block@vger.kernel.org>; Wed, 24 Apr 2019 22:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=RFHcL3/I5oViWNDB29N5Vv3s3iXZS3vLHz926lnu8dY=;
        b=raQQIWLl3ZVWFZPAq2ChQx8oBHR6CzyZSpOrVFMO//pEN1XQJvZ/zhaLhuDoRJ2JxM
         3Tng4pQ+bP5xY9oTLY8W6/7hec5pOK4THU+8VMJ8GnOlAq9pX+wFy2onyl8OPOpAo9oq
         05nUl9cEtUu7BTPrXX44uuVdKhaCUcxlfX343JebiSS1jc1A4GWqc3jcOIz/pw5mgYH8
         IfYGEGFVRu3ckRKf+vpMvUFJyfn8EEFkJL0ZyGecLO9fTeH51cqB+kHqEHGp9UYOS4KA
         Vaec0jpx7pc/8Jmgl+jDvqfhj3USv+r7mlvCFOusmurA1lCeHvYPsxJi/SIVTYl5aS4l
         s/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=RFHcL3/I5oViWNDB29N5Vv3s3iXZS3vLHz926lnu8dY=;
        b=eJR2XkajIjYPgVbaC97VZvU/MAR69UWmFyMuCA07paSvndOfM8v1Ua4plUOTPUErES
         /RwSp90Kn4HE2VjX3YNVNyxnoJXFd4ZFDAwUj2g4bWrh76UxVuySckSuBUvbdO8LzetC
         MbOZgS4coVG+bxSf79uM5i1mJKD0czNrp0HLvy0S7SEwNF0YQ12N7xuLQl052fL5gQR8
         TBsDvfO/17M9y1bZ5G0wJjfOqzB+C0Ic0MAXQr/XM1aN9+GP8lg8XaT3qkHL8DWnrr+J
         rZ4CUYprKp9j9aXm8Pa2yANi29+nvJ8n4GoY3OP9VaD96Rp10Tj8AEMA/3S1a3h5cS/4
         E+2Q==
X-Gm-Message-State: APjAAAUlmIMBXe2fTXyjIlrSEnwakSAX7+nWmTSydaQ3K6DInKCu/1Kb
        QWQ0zZE3J3xN3zYu8C3pvzpJyvsK/us=
X-Google-Smtp-Source: APXvYqxUMu+OqZjph/dbZarDsgd5i+hqlV71t0YgzIN4bwMZuUdWtLrjpLgui0bh/7lV3TtMUl+ikQ==
X-Received: by 2002:a37:4814:: with SMTP id v20mr28284942qka.36.1556168774051;
        Wed, 24 Apr 2019 22:06:14 -0700 (PDT)
Received: from ovpn-121-162.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id m31sm14030646qtm.46.2019.04.24.22.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 22:06:13 -0700 (PDT)
To:     Jens Axboe <axboe@kernel.dk>, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>, dan.j.williams@intel.com
From:   Qian Cai <cai@lca.pw>
Subject: bio_iov_iter_get_pages() + page_alloc.shuffle=1 migrating failures
Message-ID: <38bef24c-3839-11b0-a192-6cf511d8b268@lca.pw>
Date:   Thu, 25 Apr 2019 01:06:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Memory offline [1] starts to fail on linux-next on ppc64le with
page_alloc.shuffle=1 where the "echo offline" command hangs with lots of
migrating failures below. It seems in migrate_page_move_mapping()

	if (!mapping) {
		/* Anonymous page without mapping */
		if (page_count(page) != expected_count)
			return -EAGAIN;

It expected count=1 but actual count=2.

There are two ways to make the problem go away. One is to remove this line in
__shuffle_free_memory(),

	shuffle_zone(z);

The other is reverting some bio commits. Bisecting so far indicates the culprit
is in one of those (the 3rd commit looks more suspicious than the others).

block: only allow contiguous page structs in a bio_vec
block: don't allow multiple bio_iov_iter_get_pages calls per bio
block: change how we get page references in bio_iov_iter_get_pages

[  446.578064] migrating pfn 2003d5eaa failed ret:22
[  446.578066] page:c00a00800f57aa80 count:2 mapcount:0 mapping:c000001db4c827e9
index:0x13c08a
[  446.578220] anon
[  446.578222] flags: 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
[  446.578347] raw: 083fffc00008002e c00a00800f57f808 c00a00800f579f88
c000001db4c827e9
[  446.944807] raw: 000000000013c08a 0000000000000000 00000002ffffffff
c00020141a738008
[  446.944883] page dumped because: migration failure
[  446.944948] page->mem_cgroup:c00020141a738008
[  446.945024] page allocated via order 0, migratetype Movable, gfp_mask
0x100cca(GFP_HIGHUSER_MOVABLE)
[  446.945148]  prep_new_page+0x390/0x3a0
[  446.945228]  get_page_from_freelist+0xd9c/0x1bf0
[  446.945292]  __alloc_pages_nodemask+0x1cc/0x1780
[  446.945335]  alloc_pages_vma+0xc0/0x360
[  446.945401]  do_anonymous_page+0x244/0xb20
[  446.945472]  __handle_mm_fault+0xcf8/0xfb0
[  446.945532]  handle_mm_fault+0x1c0/0x2b0
[  446.945615]  __get_user_pages+0x3ec/0x690
[  446.945652]  get_user_pages_unlocked+0x104/0x2f0
[  446.945693]  get_user_pages_fast+0xb0/0x200
[  446.945762]  iov_iter_get_pages+0xf4/0x6a0
[  446.945802]  bio_iov_iter_get_pages+0xc0/0x450
[  446.945876]  blkdev_direct_IO+0x2e0/0x630
[  446.945941]  generic_file_read_iter+0xbc/0x230
[  446.945990]  blkdev_read_iter+0x50/0x80
[  446.946031]  aio_read+0x128/0x1d0
[  446.946082] migrating pfn 2003d5fe0 failed ret:22
[  446.946084] page:c00a00800f57f800 count:2 mapcount:0 mapping:c000001db4c827e9
index:0x13c19e
[  446.946239] anon
[  446.946241] flags: 0x83fffc00008002e(referenced|uptodate|dirty|active|swapbacked)
[  446.946384] raw: 083fffc00008002e c000200deb3dfa28 c00a00800f57aa88
c000001db4c827e9
[  446.946497] raw: 000000000013c19e 0000000000000000 00000002ffffffff
c00020141a738008
[  446.946605] page dumped because: migration failure
[  446.946662] page->mem_cgroup:c00020141a738008
[  446.946724] page allocated via order 0, migratetype Movable, gfp_mask
0x100cca(GFP_HIGHUSER_MOVABLE)
[  446.946846]  prep_new_page+0x390/0x3a0
[  446.946899]  get_page_from_freelist+0xd9c/0x1bf0
[  446.946959]  __alloc_pages_nodemask+0x1cc/0x1780
[  446.947047]  alloc_pages_vma+0xc0/0x360
[  446.947101]  do_anonymous_page+0x244/0xb20
[  446.947143]  __handle_mm_fault+0xcf8/0xfb0
[  446.947200]  handle_mm_fault+0x1c0/0x2b0
[  446.947256]  __get_user_pages+0x3ec/0x690
[  446.947306]  get_user_pages_unlocked+0x104/0x2f0
[  446.947366]  get_user_pages_fast+0xb0/0x200
[  446.947458]  iov_iter_get_pages+0xf4/0x6a0
[  446.947515]  bio_iov_iter_get_pages+0xc0/0x450
[  446.947588]  blkdev_direct_IO+0x2e0/0x630
[  446.947636]  generic_file_read_iter+0xbc/0x230
[  446.947703]  blkdev_read_iter+0x50/0x80
[  446.947758]  aio_read+0x128/0x1d0

[1]
i=0
found=0
for mem in $(ls -d /sys/devices/system/memory/memory*); do
        i=$((i + 1))
        echo "iteration: $i"
        echo offline > $mem/state
        if [ $? -eq 0 ] && [ $found -eq 0 ]; then
                found=1
                continue
        fi
        echo online > $mem/state
done
