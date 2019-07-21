Return-Path: <SRS0=enhP=VS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9358BC76186
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5343B2085A
	for <linux-block@archiver.kernel.org>; Sun, 21 Jul 2019 02:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tds.net header.i=@tds.net header.b="RW7ASyK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbfGUCl0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Jul 2019 22:41:26 -0400
Received: from smtp.tds.cmh.synacor.com ([64.8.70.105]:50657 "EHLO
        mail.tds.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726095AbfGUCl0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Jul 2019 22:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; d=tds.net; s=20180112; c=relaxed/simple;
        q=dns/txt; i=@tds.net; t=1563676885;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=UeR1Hr7+4Gk/lVBzff1w4N7Fbiw=;
        b=RW7ASyK5mH6rRfxU+b4UFN/OmiHLxjz9Jqjgb4MPbGK9bKOOtWfFj98Pr1RXC2aV
        1MRD0MzxYqi5NVRiHTsqFJFHYkIn/aOFEsntO6lpp1xqHGL3flyC9FwegOzO5kfz
        AIezbek4dTTbRePkZMjyFjSRY+kE1iloZlEnuFU1WJ0jMUOksYRs+Yx1pYOE8Akz
        SvAou+bTq/b/Ec8zOooqcSe3J/ucaNRsbQmrPBv2UA6ArJrP2T/6Zl4aZVDz6Uoj
        oyShfuu8rE8aeX2epEvKa/fOxaaoHYJnW0GDEkYTdPS/RyKEB3af4FKcDYI6vl3M
        ne/p051VC7WNHnMHLtijfQ==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=MI4io4Rl c=1 sm=1 tr=0 a=QQ1z/TRHJLkw7QGu0419XQ==:117 a=QQ1z/TRHJLkw7QGu0419XQ==:17 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=nHvWMnLLnzEA:10 a=0o9FgrsRnhwA:10 a=C9He5zk_2WUA:10 a=qUfPYURAWP-WOvuaEEoA:9 a=QEXdDO2ut3YA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZGF2aWRjNTAyQHRkcy5uZXQ=
Authentication-Results:  smtp02.tds.cmh.synacor.com smtp.user=davidc502; auth=pass (LOGIN)
Received: from [69.21.125.220] ([69.21.125.220:55336] helo=[192.168.2.226])
        by mail.tds.net (envelope-from <davidc502@tds.net>)
        (ecelerity 3.6.5.45644 r(Core:3.6.5.0)) with ESMTPSA (cipher=AES128-SHA) 
        id 90/ED-30811-4D0D33D5; Sat, 20 Jul 2019 22:41:25 -0400
To:     linux-block@vger.kernel.org
Cc:     ilnux-nvme@lists.infradead.org
From:   davidc502 <davidc502@tds.net>
Subject: fstrim error - AORUS NVMe Gen4 SSD
Message-ID: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
Date:   Sat, 20 Jul 2019 21:41:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

  Hello,

  I've assembled a X570 board with a 1TB AORUS NVMe Gen4 SSD.

  When attempting to fstrim the NVMe, I receive the following error.
  davidc502@Ryzen-3900x:~$ sudo fstrim -a -v
  fstrim: /boot/efi: FITRIM ioctl failed: Input/output error
  fstrim: /: FITRIM ioctl failed: Input/output error

  Anyhow, I have put some details below which might be helpful. Note 
that this NVMe is supposed to be TRIM and SMART compliant. The SMART 
outputs are available using the utility “nvme-cli”.
  I am willing to provide whatever command outputs that are needed to 
help solve this issue.

  OS= Ubuntu 18.4.2 LTS
  Different Kernels I’ve tried = 5.1.16, 5.2 rc7, and 4.18
  fstrim version =  fstrim from util-linux 2.31.1
  Firmware version for Aorus NVMe = EGFM11.0

  mount output
  /dev/nvme0n1p2 on / type ext4 (rw,relatime,errors=remount-ro)
  /dev/nvme0n1p1 on /boot/efi type vfat 
(rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=iso8859-1,shortname=mixed,errors=remount-ro)

  NVMe firmware version using utility ‘nvme’

  $ sudo nvme list /dev/nvme0n1

  Node             SN Model                                    Namespace 
Usage                      Format           FW Rev
  ---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
  /dev/nvme0n1     SNX       GIGABYTE GP-ASM2NE6100TTTD               
1           1.00  TB /   1.00 TB    512   B +  0 B   EGFM11.0


  If there is any other additional information I can provide please let 
me know.

  Best Regards,

  David

