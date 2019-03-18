Return-Path: <SRS0=WbMh=RV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBACC43381
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 22:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D899F2171F
	for <linux-block@archiver.kernel.org>; Mon, 18 Mar 2019 22:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awPrbu7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCRWOP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:14:15 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:42370 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfCRWOP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Mar 2019 18:14:15 -0400
Received: by mail-wr1-f43.google.com with SMTP id n9so14757308wrr.9
        for <linux-block@vger.kernel.org>; Mon, 18 Mar 2019 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+A0pC70TpjGGI1Z0C+jlw/ivVgQIP8bQvCh5OhOe8Ik=;
        b=awPrbu7drkmA9i8eyHnzamXuldNlsOiLZdAE7bgWwYDUvH1gzik/2qyXP9KzLxlq0k
         StWVHIUajI3Dqi4zTjYvwr+CN+UYCUXAHstK2LyMJLmUP7tHcApKVciaN3fHU3ZhszaB
         ADa9FIQfBZSm/1qbBUduD/it/JSmnet2GQhfF72n0iCabt2vpqgAF9nfWVbq/MdE5+sk
         zyUgdqxIDQddPNDphGeaf19HHFIJZdanIu8cNWGQmso5Nhw0tAp/lkR+rczIHIXgi3L0
         Q3doYiYF7z3z7Hr1c9hVeajE7SmRxuUYY6jFVjkGKDBc3l3H4oRfSPTboalU4Ooo7TEG
         sFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+A0pC70TpjGGI1Z0C+jlw/ivVgQIP8bQvCh5OhOe8Ik=;
        b=nI1JWvpje6Bo1AlWSbYDEkHUtkod7iATlExtxEmDMydZ+7BY5ufQwo7KmzGKG7JK7z
         eWJS3FIAyFbCIx3+fK3yC7XHy8WptF7eJ2rwMzoA/BsBE4PJz/4cVyA4UDnl1gb8YrDG
         4eLbFvxVIxL51Gb92f4EeDsbNRgg1H2Y8kM9XWMJgYgc7jJeINajxSfixBdnGnJLGixo
         GJJrZwQw9MmPV/ZftXE8kqMqF7WjFSk0nJHlCYuhRXiXuXNkdyOm8nIK6F6oHBIi3jck
         f7OD7qBuPe6aF3fZUV07wQwgcg6TpYru49l3kOD1Nc5Bm9PXlpoh9+MO5NmqpcRY0F6B
         MpIw==
X-Gm-Message-State: APjAAAWEYdxTTS3kc43OZvpxAwppUgY++xhEsrQOBBlETjj/U7RE1654
        KqzASYH+SWaMeARzbeURYgWom0S6K48XlLp+PrjORvuW
X-Google-Smtp-Source: APXvYqytbP6uLi0mA76QLnkpwyjMz5ndrTjjeF2Jbl8xV4gfxVy4BhcJrMGah1aqreCO/vS1ck59DOinuXfBP+DqWdE=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr6911053wrp.23.1552947253146;
 Mon, 18 Mar 2019 15:14:13 -0700 (PDT)
MIME-Version: 1.0
From:   Nikhil Sambhus <nikhilsambhus@gmail.com>
Date:   Mon, 18 Mar 2019 18:14:01 -0400
Message-ID: <CAFQ9A4Zc8Fc4bDyAsiduTw4kTpxR=dVZr7LUdqUkvQSu1CaGpg@mail.gmail.com>
Subject: Error while enabling io_poll for NVMe SSD
To:     linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On a Linux Kernel 5.0.0+ machine (Ubuntu 16.04)  I am using the
following command as a root user to enable polling for a NVMe SSD
device.

# echo 1 > /sys/block/nvme2n1/queue/io_poll

I get the following error:

bash: echo: write error: Invalid argument

The current value of io_poll is 0.
-- 
Regards,
Nikhil P Sambhus

"To bug is human, to debug is divine"
