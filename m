Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D5AC43334
	for <linux-block@archiver.kernel.org>; Fri,  3 Jun 2022 12:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244380AbiFCMra (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244370AbiFCMr2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Jun 2022 08:47:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E72624E
        for <linux-block@vger.kernel.org>; Fri,  3 Jun 2022 05:47:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u8so5937219wrm.13
        for <linux-block@vger.kernel.org>; Fri, 03 Jun 2022 05:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ernKh7q0koX2BgfmbtKyvN+sg+w6Vr7ESQoRzLB3iMc=;
        b=JRjI1YhO3OMnpJqoPgRm8jo8atjsJf/awv7LDrMgBEmraIDVecraxoyzrdvif7TeZv
         p/rpk5pKcsMRxcL06Z/8LLrLgqe4K9iEfIVst1W+y3URe9T7WIzz+DgjaKI7lgsx1E5Y
         IdJkC5eXVEctg7X5aiZ0lFomxlxG1mhz1Z0W9Gyjb1TscH+ZW69wlO8wwo/bpqQzInIn
         9m6rMB/aSHVKrcy1L0k4ZBmauPmWGWZfIRSULDQ751gFI1T+eUZmWEBiRMcFNV7XJtA1
         ew4P+TNEBUC7L1NdTzDDvB3tlmRTtGc1idpKzCRnzEw1GMTE9JIhT5Lq9zi2f/3ToMmH
         EukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ernKh7q0koX2BgfmbtKyvN+sg+w6Vr7ESQoRzLB3iMc=;
        b=jvmORVrulnBc5Q+uQ82cHrrEoNXxlOThQy9TVrz6Nt5kbUa29PlopaV2iY4w1gZK3/
         JjuzY3YJ00ZKvmoX42cB26AXrkyZug1eTWOUB3PCO1yPgxsJqqsntyoQu76oFYsHt+Ku
         J2ikbbQrCmvV9z2NZzZHcP//dWxX2VUtLf+II7QibeZYIQ73857oHSU6L/W7yqylBDgT
         wfz3XUXVwQjxj3ZN5mKZ6VXUA9L3Q8aBRfTz5o/St3DYK9aIbgUe4MXzYHxdyrO9qcy3
         9WQgcu7V39c4oGVZludoi53t5FEJhZ7ITJnoSppedlk++8VFFc9gJMQXoTNZOa6YSYVA
         PrDA==
X-Gm-Message-State: AOAM5331eHCL+o58p5u/gNRumT7s41Ybs8YreDIiAnbasRy3C0bUw8Ol
        gcW/7WUkHEhCVg9sG01Yyx6RJYxUwAir3LuuT28v1+Mg63RITw==
X-Google-Smtp-Source: ABdhPJzA3MAsqbhrglKAnMzFv+rkvY0j8WZELmwPb8U9af72b+nK0qRcTfi5bQ7VIe9dd3ua7OB3k8UPZqsTk16C9i4=
X-Received: by 2002:a5d:6481:0:b0:20f:ed13:f28d with SMTP id
 o1-20020a5d6481000000b0020fed13f28dmr7965679wri.719.1654260444757; Fri, 03
 Jun 2022 05:47:24 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Schaller <misch@google.com>
Date:   Fri, 3 Jun 2022 14:46:48 +0200
Message-ID: <CALt099JajMVCwHgdRdRSF1uhNC=EO+tTq4T4Bg8QDwUO3uX83w@mail.gmail.com>
Subject: New partition on loop device doesn't appear in /dev anymore with
 kernel 5.17.0 and newer (repro script included)
To:     axboe@kernel.dk
Cc:     hch@lst.de, linux-block@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000002d888805e08a8672"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--0000000000002d888805e08a8672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear maintainer,

Since kernel 5.17.0 it appears that creating a partition on a loop
device doesn't automatically create the corresponding /dev/loop#p#
entry anymore. We rolled back to kernel 5.16.18, which doesn't have
this issue. I also tested kernel 5.18.1 and it is affected as well.

I've attached repro.sh, which is a Bash script that reproduces the
issue (tested on Debian testing). The script only requires standard
Linux tools (including GNU Parted). The script creates a raw disk
image file (sparse), associates the file with a loop device and
partitions the loop device so that it only contains an ESP. At this
point there should be a /dev/loop#p1 entry so that the following
mkfs.vfat can create the filesystem for the ESP. However on kernel
5.17.0 and newer /dev/loop#p1 isn't created and mkfs.vfat fails with
"No such file or directory". Furthermore on kernel 5.17.0 and newer we
see the following error in the kernel log: "I/O error, dev loop#,
sector 32640 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0"

I also did a kernel bisect against the vanilla stable kernels and that
revealed commit 1ebe2e5f9d68e94c524aba876f27b945669a7879 as the first
problematic commit. I've cc'ed the commit author as well.

This issue is also tracked on the Debian side with
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1012298.

Best,

Michael Schaller
Site Reliability Engineer - Software Engineer
misch@google.com

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

--0000000000002d888805e08a8672
Content-Type: application/x-shellscript; name="repro.sh"
Content-Disposition: attachment; filename="repro.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_l3yfw9qh0>
X-Attachment-Id: f_l3yfw9qh0

IyEvYmluL2Jhc2gKCnNldCAtZXgKCmlmIFtbICIke0VVSUR9IiAhPSAwIF1dOyB0aGVuCiAgPiYy
IGVjaG8gInJvb3QgcmlnaHRzIHJlcXVpcmVkIgogIGV4aXQgMgpmaQoKaW1nPScvdG1wL3Jhdy5p
bWcnICAjIFJhdyBkaXNrIGltYWdlIGZpbGUuCmRldj0nJyAgIyBMb29wIGRldmljZSBhc3NvY2lh
dGVkIHdpdGggdGhlIHJhdyBkaXNrIGltYWdlIGZpbGUuCgpmdW5jdGlvbiBjbGVhbnVwIHsKICBz
ZXQgK2UKICBybSAtcmYgIiR7cmVzfSIKICBybSAtZiAiJHtjZmd9IgogIGlmIFsgLW4gIiR7ZGV2
fSIgXTsgdGhlbgogICAgIyBGcmVlIGxvb3AgZGV2aWNlLgogICAgbG9zZXR1cCAtLWRldGFjaCAi
JHtkZXZ9IgogIGZpCiAgcm0gLWYgIiR7aW1nfSIKfQp0cmFwIGNsZWFudXAgRVhJVAoKIyBDcmVh
dGUgc3BhcnNlIGZpbGUgZm9yIGEgcmF3IGRpc2sgaW1hZ2UuCmRkIGlmPS9kZXYvemVybyBzdGF0
dXM9bm9uZSBvZj0iJHtpbWd9IiBicz0xIGNvdW50PTAgc2Vlaz0xNk1pQgoKIyBBc3NvY2lhdGUg
YSBsb29wIGRldmljZSB3aXRoIHRoZSByYXcgZGlzayBpbWFnZS4KbG9zZXR1cCAtLWZpbmQgIiR7
aW1nfSIKCiMgR2V0IHRoZSBhc3NvY2lhdGVkIGxvb3AgZGV2aWNlLgpkZXY9JChsb3NldHVwIC0t
YXNzb2NpYXRlZCAiJHtpbWd9IiB8IGN1dCAtZCAnOicgLWYgMSkKaWYgWyAteiAiJHtkZXZ9IiBd
OyB0aGVuCiAgPiYyIGVjaG8gJ2ZhaWxlZCB0byBmaW5kIGFzc29jaWF0ZWQgbG9vcCBkZXZpY2Un
CiAgZXhpdCAxCmZpCgojIENyZWF0ZSBHUFQgcGFydGl0aW9uIHRhYmxlIHdpdGggYW4gRVNQLgpw
YXJ0ZWQgLXMgIiR7ZGV2fSIgbWtsYWJlbCBncHQKcGFydGVkIC1zICIke2Rldn0iIG1rcGFydCBw
cmltYXJ5ICJmYXQzMiIgMU1pQiAxMDAlCnBhcnRlZCAtcyAiJHtkZXZ9IiBzZXQgMSBib290IG9u
CnBhcnRwcm9iZSAiJHtkZXZ9IiAgIyBGb3IgZ29vZCBtZWFzdXJlIGJ1dCBub3QgbmVlZGVkIG9u
IGtlcm5lbCA1LjE2Cm1rZnMudmZhdCAgIiR7ZGV2fXAxIiAgIyBUaGlzIGNvbW1hbmQgZmFpbHMg
d2l0aCBrZXJuZWwgNS4xNwo=
--0000000000002d888805e08a8672--
