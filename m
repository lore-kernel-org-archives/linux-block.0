Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE92C43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C11220857
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 14:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h1lYlVOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfDAOZE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:25:04 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:40366 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfDAOZD (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Apr 2019 10:25:03 -0400
Received: by mail-it1-f171.google.com with SMTP id k64so16669itb.5
        for <linux-block@vger.kernel.org>; Mon, 01 Apr 2019 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hB0Mn2Lixajuir7J7FmHfAw00LgecZYvZBAy6Pj7V2I=;
        b=h1lYlVOATLXMGAkhzzF0J6n0yu3ekIuNjcTqFHMRMPbpxgh24kT8OAKLdFCyqrywxN
         nS4d9BpyrJuXMfKTG0TVD8OMaVSFg7o86Z00GjDEqPhsuDE0Qb5a6OrvemGtB9ZtYb3+
         HqO+KGjLpY4tu05cLYRfPZDACgVALAPXenCiYA4wxO6Lui7rOmN4QiVgpvHI2qCK9wbc
         KvpMwhR4l5ZPZ2HIXEbFHAUtxzACKI8XIGtrDJAk37oJ1ykA1ehAD+Oj1nkPesGwbJeM
         NuoKQ6mAEViY8RqOPFshC/cvN5A11K+/veOzEk1M40/QtEdrWxXVaHk0V/gIs0wbom4L
         emvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hB0Mn2Lixajuir7J7FmHfAw00LgecZYvZBAy6Pj7V2I=;
        b=QKsyGkKxQTB1ZzM0bKYSuthfRTdneNHMwOYX+1XxUQHD1k0+/ADaOw/08e8NdI41jA
         FvLy/8J4ToXN18baaOGP3tY8QcimHaQAJ4UEHdvwsQtpRivftZZ2KR1VW4DDnxVuLIow
         RiDarZBdE7ieC1nrqo6sz1vuWbTzYv+D0iIR1upyUcNrwSgHFXpwuF5CVzZCCdQ44TEy
         muwjGq3BvjF1cf6O+oEdOF8WGNGzkld8X0tDb+4Xqizj18rzFZOkmciYMwkhbTFxJJGa
         fefHaPfsibpa/Y+NC+Bc0XhhZ7f/ryvHd++OmujCe0scuy/W8yLyTif1ZOpCZ+y1+gaE
         12IQ==
X-Gm-Message-State: APjAAAVTvD/Ucm9A8h0UVGsesPzSjaeZW3tNanID8FYcHG/lRSZuN/EB
        4hcMN45RpPDDZrbz19y9XNpPhhDv3129Cw==
X-Google-Smtp-Source: APXvYqwV1SVmPL28czQp2NUDx0r7T/b4wK6Avq1cq8iz34UMzbmPhaF/5LaW0UJlKlS2ZVMK+X8qIQ==
X-Received: by 2002:a24:4198:: with SMTP id b24mr15356857itd.25.1554128702637;
        Mon, 01 Apr 2019 07:25:02 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v187sm7403392ita.0.2019.04.01.07.25.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 07:25:01 -0700 (PDT)
To:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: blk-merge warning in for-5.2/block
Message-ID: <100ac534-cce5-47d2-d703-e81fcbaca34f@kernel.dk>
Date:   Mon, 1 Apr 2019 08:25:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming,

I'm getting this one when building the new set with gcc 8.3.0:


-- In file included from block/blk-merge.c:13:
block/blk-merge.c: In function ‘blk_rq_map_sg’:
block/blk.h:73:56: warning: ‘bvec.bv_offset’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  phys_addr_t addr1 = page_to_phys(vec1->bv_page) + vec1->bv_offset;
                                                    ~~~~^~~~~~~~~~~
block/blk-merge.c:530:17: note: ‘bvec.bv_offset’ was declared here
  struct bio_vec bvec, bvprv = { NULL };
                 ^~~~
In file included from block/blk-merge.c:13:
block/blk.h:76:18: warning: ‘bvec.bv_len’ may be used uninitialized in this function [-Wmaybe-uninitialized]
  if (addr1 + vec1->bv_len != addr2)
              ~~~~^~~~~~~~
block/blk-merge.c:530:17: note: ‘bvec.bv_len’ was declared here
  struct bio_vec bvec, bvprv = { NULL };
                 ^~~~
In file included from ./arch/x86/include/asm/page.h:76,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./include/linux/stat.h:19,
                 from ./include/linux/module.h:10,
                 from block/blk-merge.c:6:
./include/asm-generic/memory_model.h:55:52: warning: ‘bvec.bv_page’ may be used uninitialized in this function [-Wmaybe-uninitialized]
 #define __page_to_pfn(page) (unsigned long)((page) - vmemmap)
                                                    ^
block/blk-merge.c:530:17: note: ‘bvec.bv_page’ was declared here
  struct bio_vec bvec, bvprv = { NULL };
                 ^~~~


Jens Axboe

