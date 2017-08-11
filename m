Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:35406 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbdHKPRp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Aug 2017 11:17:45 -0400
Received: by mail-qt0-f171.google.com with SMTP id p3so22768113qtg.2
        for <linux-block@vger.kernel.org>; Fri, 11 Aug 2017 08:17:45 -0700 (PDT)
MIME-Version: 1.0
From: Thanos Makatos <thanos.makatos@onapp.com>
Date: Fri, 11 Aug 2017 16:17:24 +0100
Message-ID: <CAM2wQBup_G1QsyUmJByZAN6WGpUJsUxV5Ria+4ETj9B7VQtZYA@mail.gmail.com>
Subject: forcing merging of block requests on NVMe
To: linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In my environment I have large, sequential I/O requests (e.g. 4 MB)
split into much smaller requests (e.g. 8 KB) and passed to a kernel
module, which in turn submits them to an NVMe device. This splitting
of requests seems to hurt performance badly. Because of architectural
reasons I cannot avoid the splitting of the requests by the issuer so
I have to find a way to reconstruct the original, large request.

The only way I can see to achieve this is to directly implement this
functionality in that kernel module of mine, however before proceeding
with the implementation I'd like to see some proof that merging the
requests does solve the performance problem. The trouble is that I
can't think of an easy way to do this as the NVMe device doesn't have
a block queue interface, and I can't seem to find some virtual block
layer that does it for me (e.g. dm-linear, mdadm linear, loopback).

Is there any way I can effectively merge these requests?


-- 
Thanos Makatos
