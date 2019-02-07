Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59A7C282C2
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0DC21916
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 22:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBGWih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:38:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43956 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbfBGWig (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 7 Feb 2019 17:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AC602C01DE0D;
        Thu,  7 Feb 2019 22:38:36 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B415D87CF;
        Thu,  7 Feb 2019 22:38:35 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, hch@lst.de, avi@scylladb.com,
        jannh@google.com, viro@ZenIV.linux.org.uk
Subject: Re: [PATCH 12/18] io_uring: add support for pre-mapped user IO buffers
References: <20190207195552.22770-1-axboe@kernel.dk>
        <20190207195552.22770-13-axboe@kernel.dk>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 07 Feb 2019 17:38:34 -0500
In-Reply-To: <20190207195552.22770-13-axboe@kernel.dk> (Jens Axboe's message
        of "Thu, 7 Feb 2019 12:55:46 -0700")
Message-ID: <x49zhr7442d.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 07 Feb 2019 22:38:36 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi, Jens,

Jens Axboe <axboe@kernel.dk> writes:

> For now, buffers must not be file backed. If file backed buffers are
> passed in, the registration will fail with -1/EOPNOTSUPP. This
> restriction may be relaxed in the future.

[...]

> +		down_write(&current->mm->mmap_sem);
> +		pret = get_user_pages_longterm(ubuf, nr_pages, FOLL_WRITE,
> +						pages, vmas);
> +		if (pret == nr_pages) {
> +			/* don't support file backed memory */
> +			for (j = 0; j < nr_pages; j++) {
> +				struct vm_area_struct *vma = vmas[j];
> +
> +				if (vma->vm_file) {
> +					ret = -EOPNOTSUPP;
> +					break;
> +				}
> +			}

Unfortunately, this suffers the same problem as FOLL_ANON.  Huge pages
are backed by hugetlbfs, and vma->vm_file will be filled in.

I guess you could check is_file_hugepages(vma->vm_file):

        if (vma->vm_file &&
            !is_file_hugepages(vma->vm_file)) {
                ret = -EOPNOTSUPP;
                break;
       }

That works for me.

-Jeff
