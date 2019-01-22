Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E64C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 04:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE33621721
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 04:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=utexas-edu.20150623.gappssmtp.com header.i=@utexas-edu.20150623.gappssmtp.com header.b="sNR3pZpe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbfAVEpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:45:21 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:39986 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAVEpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jan 2019 23:45:21 -0500
Received: by mail-it1-f173.google.com with SMTP id h193so18387074ita.5
        for <linux-block@vger.kernel.org>; Mon, 21 Jan 2019 20:45:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=utexas-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=pFm6NdtmGQUgX5uCwT+wzokGP3WrxOaXCo4AYeCV1kA=;
        b=sNR3pZpe8PD5wnw5JxlXZfzkTqrfHNisP29+r8IqfX99qYbgMOuTR7Y80QQtCE1Vvr
         7nhB1BkW1GFIKEDsOGx1ADqAuBOPTdHvdXqT+hOuhd1VHdXMutN+KJDWjfjTV/xIHyJy
         bkY2zLq836cDAmvLHTbBU45NrShe/h2nAm7KnPTb1wSjmZObFoMb1lSx8qjrX9FRWOXs
         +EXS+4EnLMy0jwn9Km+3MXb0FMSJ6Af8/Y8vc0KY5h57zdupMTXebfBxiIM1GhYWJuDr
         WzurbjG2mhGmrzcGlhYb1uPXFGmZGQiP4G5KNluHgSLyZUTi5GUhCa7QhHC8un9NKVt1
         CrNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pFm6NdtmGQUgX5uCwT+wzokGP3WrxOaXCo4AYeCV1kA=;
        b=tEnPi7sgFT2lXidf2cpDQpadZtuDIpm0/6wAIgvZDULtTGrdUQTHRx5ce5EQxBKWFV
         Z+0KOXbYcJtDmEG/PtQz6CK/SZANPP31XAnhpE3JN3779XkEPJUryx9RatY9+5lW0T++
         rV2xwqBEmvdRFR35C+m6YX8x/938rZO3VF18CJpgzt/0SyLtxNgPoTwR3f+hJ0VQ/kUW
         mlQkOcN9Su6RPLsThsVaIO4lbBV6jKd8FT3OYxStX6XSYxvfR4OL75JhKp2ITg9Jc8Zq
         8etZHRUAEmsiXvPiHHtFD5XPcvKnb8k5xPy3YExpef15UDaRgM1R7euo1/MYYwbgJwA9
         yEwA==
X-Gm-Message-State: AJcUukeCMlgDHIo8amZZqotxLjyfR0vKbIaybyNWVk+Eujivt2Imwy9H
        1bWNWcUGMUYbjDngvQY9JQ/Va3k00Kp3XeMnuz50uj9znDxciQ==
X-Google-Smtp-Source: ALg8bN7iU2M9BRB4hLtzLskbPFA0GTGtxcPNATXz6PveBa1aZcd//RK1qqb8rIIoOkPyjwRGLChHF9tR3r8U/zN43Co=
X-Received: by 2002:a24:5946:: with SMTP id p67mr1359010itb.46.1548132320092;
 Mon, 21 Jan 2019 20:45:20 -0800 (PST)
MIME-Version: 1.0
From:   Ashlie Martinez <ashmrtn@utexas.edu>
Date:   Mon, 21 Jan 2019 20:45:09 -0800
Message-ID: <CAFk8rvbdfzdChGf9jsTT7qPVf7bpW4VH0mys1He8_KjUD5mD2A@mail.gmail.com>
Subject: RFC bio flags and ops in v4.10+
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

I was working on porting parts of a file system crash consistency
checking tool called CrashMonkey [1] to linux kernels 4.9 and 4.14
when I noticed an inconsistency in how the bio->bi_opf field is
treated. According to the comments in /include/linux/blk_types.h, the
REQ_OP should be the upper bits in bi_opf, while the request flags
should be in the lower bits. In kernel 4.9, the accessor and setter
methods for this field appear to be correct. However, kernels 4.10+ do
not properly shift the REQ_OP argument up for either setting it or
getting it from bi_opf. Is this the intended behavior or is it a
mistake in how the code was written? Please note that I have not
checked all the releases between 4.9 and 5.0-rc3, but I know 4.10,
4.14, 4.15, and 5.0-rc3 contain the same or similar code for setting
bio->bi_opf.

[1] https://github.com/utsaslab/crashmonkey
