Return-Path: <SRS0=bAqE=SN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369E7C10F14
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0517820850
	for <linux-block@archiver.kernel.org>; Thu, 11 Apr 2019 05:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbfDKFsH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:48:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726615AbfDKFsH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Apr 2019 01:48:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F03D8C33E2C9E09B71BB;
        Thu, 11 Apr 2019 13:48:01 +0800 (CST)
Received: from [10.151.23.176] (10.151.23.176) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.408.0; Thu, 11 Apr
 2019 13:47:51 +0800
To:     Ming Lei <ming.lei@redhat.com>
From:   Gao Xiang <gaoxiang25@huawei.com>
Subject: Some new bio merging behaviors in __bio_try_merge_page
CC:     <linux-block@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        Jens Axboe <axboe@kernel.dk>, Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <85c5fa1a-a506-e26f-c354-1554d47d8b2b@huawei.com>
Date:   Thu, 11 Apr 2019 13:47:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.151.23.176]
X-CFilter-Loop: Reflected
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I found a erofs issue after commit 07173c3ec276
("block: enable multipage bvecs") is merged. It seems that
it tries to merge more physical continuous pages in one iovec.

However it breaks the current erofs_read_raw_page logic since it uses
nr_iovecs of bio_alloc to limit the maximum number of physical
continuous blocks as well. It was practicable since the old
__bio_try_merge_page only tries to merge in the same page.
it is a kAPI behavior change which also affects bio_alloc...

...
231                 err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
232                 if (unlikely(err))
233                         goto err_out;
...
284                 /* max # of continuous pages */
285                 if (nblocks > DIV_ROUND_UP(map.m_plen, PAGE_SIZE))
286                         nblocks = DIV_ROUND_UP(map.m_plen, PAGE_SIZE);
287                 if (nblocks > BIO_MAX_PAGES)
288                         nblocks = BIO_MAX_PAGES;
289
290                 bio = erofs_grab_bio(sb, blknr, nblocks, sb,
291                                      read_endio, false);
292                 if (IS_ERR(bio)) {
293                         err = PTR_ERR(bio);
294                         bio = NULL;
295                         goto err_out;
296                 }
297         }
298
299         err = bio_add_page(bio, page, PAGE_SIZE, 0);
300         /* out of the extent or bio is full */
301         if (err < PAGE_SIZE)
302                 goto submit_bio_retry;
...

After commit 07173c3ec276 ("block: enable multipage bvecs"), erofs could
read more beyond what erofs_map_blocks assigns, and out-of-bound data could
be read and it breaks tail-end inline determination.

I can change the logic in erofs. However, out of curiosity, I have no idea
if some other places also are designed like this.

IMO, it's better to provide a total count which indicates how many real
pages have been added in this bio. some thoughts?

Thanks,
Gao Xiang
