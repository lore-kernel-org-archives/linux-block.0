Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-1857040130.protonmail.ch ([185.70.40.130]:64809 "EHLO
        mail-1857040130.protonmail.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932741AbeFPMoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Jun 2018 08:44:16 -0400
Date: Sat, 16 Jun 2018 08:25:56 -0400
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Fedja Beader <fedja@protonmail.ch>
Reply-To: Fedja Beader <fedja@protonmail.ch>
Subject: How to reattach a disconnected device with active device-mapper mappings on top
Message-ID: <0aSIDZ2i1MLsXuBjfmtw40SGD5ohN1QiU-8E52lJXMdmHr0WuR-qJ9FrkUzUA9uMdg6c0QGgPuvuB7OiAWVtkg==@protonmail.ch>
In-Reply-To: <QwoNd_VO1UTeANHRFO1qxNsb8lVeglvWeu_PohUt2pQqvo3zLMVW9MHwbBnQmC368b1Q4LLoBG5m7o7_kRxmag==@protonmail.ch>
References: <QwoNd_VO1UTeANHRFO1qxNsb8lVeglvWeu_PohUt2pQqvo3zLMVW9MHwbBnQmC368b1Q4LLoBG5m7o7_kRxmag==@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

(This message was also posted to dm-devel@redhat.com)

I have a hard disk connected to my laptop via an usb-sata bridge that someh=
ow got disconnected. There is a stack of device-mapper mappings and a mount=
ed filesystem on top of it that are currently failing all I/O. "dmsetup dep=
s" reports
"1 dependencies : (8, 16)".

The same HDD is now reattached, but as /dev/sdc (8,32) and refuses to be at=
tached as /dev/sdb, which is now a permanently vacant slot.
How do I force this hard disk to attach as (8,16) so the whole device-mappe=
r stack and the filesystem on top of it can resume working?

Thank you,
Fedja
