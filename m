Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A1EC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E39213F2
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8+jj11k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbfCVNDh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:03:37 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34040 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731239AbfCVNDb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 09:03:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id y18so1409367lfe.1
        for <linux-block@vger.kernel.org>; Fri, 22 Mar 2019 06:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kpY7YrZVzLcFgaCPSGxaBBXpEdi5yPLICoffH/zIitY=;
        b=J8+jj11kfEolu49+t98NB8TF+ihwZaIrqi17k4OMx3HWlGDnuovGKwnk5p8bBiOFcu
         td/SFxML1G3W8inVaTbur7GV85TGE/Jh7ihfz95Gy1QgrJ+RgfxT6WlaMgpR3bZx0Fvh
         8kASlVI2JgvODp9W4zJBAxDtZDQtZA+LRffuLOgOJopYl6qowwVt8eExLe0TzikI0HoD
         JpDNjzsi3wb9VdMPy9WBgPICH+nHcdR94F2xt/FRsVh3aw450Y5IhxdP8V5cmAw/xflC
         pXNrGr0cJM/ed3KEdtUvnnatHnyyXUOjGOy14O6AkiJmURbYzwBXuToildZ+qweUNKzQ
         ZDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=kpY7YrZVzLcFgaCPSGxaBBXpEdi5yPLICoffH/zIitY=;
        b=rbfYAashYaajieQSgxIn98VNTzQVi7qhB4ZEsPGvnrtR58x1aeA7+kM5kduY4VN2FG
         alVAdaFB1QSj8PIFebWq3gf7799vTsOHLtjCm5roNjb74kK8Ii1Bt32J4oRkwPZkcKr7
         eV+bEKHZGFjadeLfHtioXENWtcuhFZ42b38rmpE7u6cksJs/Yh8OIlAWH+lUvt+ADLwM
         25p82dLf/WlPnsO5ViUd7uOjv1n1+9LPP1Tfa7nSJf14ePx4rFhW9ENp4GIzlXqpvyLN
         iMBlgzDV+GDaAPUJWVoopCTgga1qTRHXhmXHdrGlpQ2gAISbv011IRfo+JGjmbEFtCzs
         Bn4Q==
X-Gm-Message-State: APjAAAWz53bX3x3lvFAOy805HZFxnH3rNvlPDFdw7CEloFzXQQOc2sCK
        +M7QBu/OXLelbQJt52FG0iwfFbdn
X-Google-Smtp-Source: APXvYqyg8P4CHl4UHIplGDBMkhW9sypynaWHi6uSfdTlxLWOd7Q96i+RG8XWOqduYEPCpDGyB7pZ/A==
X-Received: by 2002:a19:7914:: with SMTP id u20mr5426996lfc.41.1553259809274;
        Fri, 22 Mar 2019 06:03:29 -0700 (PDT)
Received: from [192.168.0.160] (ppp89-110-13-118.pppoe.avangarddsl.ru. [89.110.13.118])
        by smtp.gmail.com with ESMTPSA id s64sm1638653lje.49.2019.03.22.06.03.28
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 06:03:28 -0700 (PDT)
From:   Ivan Safonov <insafonov@gmail.com>
Subject: Read data to kernel buffer by blkdev_read_iter
To:     linux-block@vger.kernel.org
Message-ID: <b6d54ac9-ee29-edcf-907d-1e12fce321ac@gmail.com>
Date:   Fri, 22 Mar 2019 16:06:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,
I want to read data by kernel module from a block device like this:

static int module_init(void)
{
	const size_t len = 0x1000;
	struct file *file;
	char *buf;
	struct iovec iovec;
	struct kiocb kiocb;
	struct iov_iter iov_iter;
	ssize_t rcount;

	buf = vmalloc(len);
	file = filp_open("/dev/sda", 0, 0);

	iovec.iov_base = buf;
	iovec.iov_len = len;

	kiocb.ki_filp = file;
	kiocb.ki_pos = 0x200000000;
	kiocb.ki_complete = NULL;
	kiocb.ki_flags = IOCB_DIRECT;
	kiocb.ki_hint = 0;

	iov_iter_init(&iov_iter, READ, &iovec, 1, len);

	rcount = blkdev_read_iter(&kiocb, &iov_iter);

	filp_close(file, current);
	vfree(buf);

	return rcount < 0 ? rcount : 0;
}

but blkdev_read_iter always return -EFAULT. I tried to localize the error:

blkdev_read_iter
   generic_file_read_iter
     blkdev_direct_IO
       __blkdev_direct_IO_simple
         bio_iov_iter_get_pages
           __bio_iov_iter_get_pages
             iov_iter_get_pages
               get_user_pages_fast
                 ...
                   find_vma

find_vma return NULL for vmalloc'ed block.

Kernel version is 4.19.16.

Is this behavior valid for iov_iter with type ITER_KVEC?

--
Ivan Safonov.
