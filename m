Return-Path: <SRS0=UUXI=53=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506B3C2BA2B
	for <linux-block@archiver.kernel.org>; Sat, 11 Apr 2020 14:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3D72145D
	for <linux-block@archiver.kernel.org>; Sat, 11 Apr 2020 14:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CjUCGvi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgDKObV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Apr 2020 10:31:21 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:45244 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgDKObV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Apr 2020 10:31:21 -0400
Received: by mail-vs1-f65.google.com with SMTP id j65so2904066vsd.12
        for <linux-block@vger.kernel.org>; Sat, 11 Apr 2020 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9ZXgjDb+KwiiQSp/A/i2RANwYZsGpovkCsRU6ThyQ8Q=;
        b=CjUCGvi2lmFaBvef8N0enUVUFPemvp6bJ8KbZCjEz2b7JCrwRdBwfxZqtE/z3dfozK
         XgRGGbKOm5k53qHGnAT5VJXuReWAiBfAprrvrr1T7O3HIu1JZznETPsaAyeJvniLd0Mn
         Jec9azyyBvSSOMt7hYlKdihsBNE1Umh+VOoVtN/QFapqmMH5jZqhTO71/zEoLjl9BKtc
         mMP3iOtdSIAQzxN5b2NSnB8JczlzT9DpwDSRGwIy8CUXvB0ay8bQSqz2E3cVkFHCJclP
         7VqHxyPNPb5xGNistcfn/BPRvtdsGsn+VNYcTMaP7DiRg4hhTNZaPOZh/CnohD/cleCP
         yBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=9ZXgjDb+KwiiQSp/A/i2RANwYZsGpovkCsRU6ThyQ8Q=;
        b=YxXBpAJy0rKWGEQUjhCsyH151VIvetulVr7lH71rOhFISvPW3XMbhUKUBkHisvU71K
         fvRrdT6xwapyqDjOD3lvD2UXVUQ5nWQJsOwSWlGi4D13/9n/wXvogII9ZS0H+X8CzdeC
         a/YZRzWFkpFglkGH0ruVNZdldR1rj10ubxefd7FyyQYvpCIR9mm032eVi/ofQhif9tqA
         mBtIBi8nNGj4t/DPgr6eCJec9KSUixxuKmmiKRgxAcR+a3ZdyOhSuVmJMZimsxulISCr
         FMLiv/9pkm2c1gHMS/JuGDMFKGOD2OJUJOkI503ikEnFG2icm1VZIwMxaQeMMeCORCXO
         pgBw==
X-Gm-Message-State: AGi0PuYlM1CRo0Ledo8OfknCwuGz9/Ypmk9Y1h369kgmqKw7myo+86Fb
        NCJgdhl1ZWupbAqTrp2uknJtv4BJj+zkPKI9VwaSYoss
X-Google-Smtp-Source: APiQypIzpIvli3B9uzFh5dHe6yo4BbVIbd9vLN451E9tTCxWFX0iKDN8NXub/fd6BsABL3JMQK54ApZ+5H9U+e1icHY=
X-Received: by 2002:a67:885:: with SMTP id 127mr5065899vsi.119.1586615480565;
 Sat, 11 Apr 2020 07:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:ce95:0:0:0:0:0 with HTTP; Sat, 11 Apr 2020 07:31:20
 -0700 (PDT)
From:   Daegyu Han <hdg9400@gmail.com>
Date:   Sat, 11 Apr 2020 23:31:20 +0900
Message-ID: <CAARcW+piE++DqhZQGEPEpQHCvCFFWC6m7hoZN=4x9tNThf0QrQ@mail.gmail.com>
Subject: Block request size is limited to readahead size when doing buffered
 read to nvme over fabric target(remote nvme)
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi all, I wonder why the block layer generates requests that are
limited to readahead size when doing buffered read to nvmeof target
ssd.

I don't know=C2=A0it is okay to ask questions this mailing list.
I'm sorry if these personal questions were banned.

To describe in detail the environment I experimented with, it is as follows=
.

I used a Samsung nvme 970 ssd for storage and a Mellanox connectx-4
Infiniband for the network.
My server OS is kernel version 4.20.
I did buffered IO by using C language read() API and trace using blktrace.
NVMeoF ssd was formated as ext4.

C read API test
- I saw that the initiator sends requests to the target only as large
as the readahead(default: 128KB). After that, I changed the size of
the readahead through sysfs and the size of the request changed.
- In Direct IO, a request size set to a buffer (char array[]) size
created at the my user level program.

FIO test
- In the case fo buffered io, the request size changed according to
the block size. I think because I set the block size to 4K.
-=C2=A0Similarly, in the case of Direct IO, the request was made according
to the block size.

To sum up, more requests were completed in Buffered IO using C read
API than local IO to nvme ssd.
From what I have measured, I think that nvmeof in buffered io is worse
than local performance due to requests split by readahead size.
I tried to analyze the blk-mq and nvme code, but these layers are too
broad and difficult to understand.

Why is the request size set to readhead size when buffered IO is
performed from target nvmeof using C read API?
I want to know the reason and which code makes the block request.

I had my trace logs. If you want to see logs, I will attach my logs.

Thank you.
