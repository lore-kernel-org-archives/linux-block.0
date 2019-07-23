Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DB5C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A47E2218BE
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tds.net header.i=@tds.net header.b="hoORmh2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfGWAGd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 20:06:33 -0400
Received: from smtp.tds.cmh.synacor.com ([64.8.70.105]:24341 "EHLO
        mail.tds.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727643AbfGWAGd (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 20:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; d=tds.net; s=20180112; c=relaxed/simple;
        q=dns/txt; i=@tds.net; t=1563840391;
        h=From:Subject:Date:To:MIME-Version:Content-Type;
        bh=HfLnM7usCbRgzhfPrAB/SI0JDWA=;
        b=hoORmh2c1vqHrXIG+9QCA6e5tAomSGjOYz5FFNJtK5jF30QTXfgEoEPrC8InPu8r
        5McPaFyCy4N4EWug3XN8EIkq6yzvCcr6TWgxDVLZOfnfQg2MPHtla+agvrRQ2Sto
        wBtXwidSjjPYJ8WiPuY9WoML7RSfIQSzZdyWVQyKT8hsYGnR5YrWJlcEKPr3SQH9
        dKThVoLp/p0/u+vS5//pMzPLvI15IsmcbzktqavC+vgY2JeB3ZBxA2hvgM5RPb9W
        OVfaKSjBWoDCHbkeJP8zRZGM1mD6JiozWCeKDCllHXGz3bP3eGA0mJ5AyHkeWZT3
        o3EmrCiqzfqa2wB6SGY0Dw==;
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.2 cv=T/zOdLCQ c=1 sm=1 tr=0 a=QQ1z/TRHJLkw7QGu0419XQ==:117 a=QQ1z/TRHJLkw7QGu0419XQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=nHvWMnLLnzEA:10 a=0o9FgrsRnhwA:10 a=C9He5zk_2WUA:10 a=kU5C1K9T137bR3JZkYMA:9 a=h6HAsI16Cc7kcdTR:21 a=PMgU3WoxihswJ-e1:21 a=GGopsvZ8UP8xCoVB:21 a=QEXdDO2ut3YA:10
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: ZGF2aWRjNTAyQHRkcy5uZXQ=
Authentication-Results:  smtp01.tds.cmh.synacor.com smtp.user=davidc502; auth=pass (LOGIN)
Received: from [69.21.125.220] ([69.21.125.220:41042] helo=[192.168.2.226])
        by mail.tds.net (envelope-from <davidc502@tds.net>)
        (ecelerity 3.6.5.45644 r(Core:3.6.5.0)) with ESMTPSA (cipher=AES128-SHA) 
        id 3A/61-28836-78F463D5; Mon, 22 Jul 2019 20:06:31 -0400
Subject: Re: fstrim error - AORUS NVMe Gen4 SSD
From:   davidc502 <davidc502@tds.net>
To:     linux-block@vger.kernel.org
References: <fb510e33-5c81-6d62-fcde-a2989b3a1a8f@tds.net>
 <4b76413b-1af4-a406-5b16-6789b2b7012a@tds.net>
Message-ID: <bdb8e486-bcda-1b11-0fd7-f25bc48eeb2c@tds.net>
Date:   Mon, 22 Jul 2019 19:06:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <4b76413b-1af4-a406-5b16-6789b2b7012a@tds.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



  Hello,

  I'm not sure my email from yesterday went through due to .txt 
requirements.  However, I've added some additional logs at the end of 
this email.

  If this email group does not deal with these type of issues, please 
let me know.

  Best Regards,

  David

  On 7/20/19 9:41 PM, davidc502 wrote:


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

   Node             SN Model Namespace Usage                      
Format           FW Rev
   ---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
   /dev/nvme0n1     SNX       GIGABYTE GP-ASM2NE6100TTTD               
1           1.00  TB /   1.00 TB 512   B +  0 B   EGFM11.0

    More Log information

  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] print_req_error: I/O error, dev nvme0n1, 
sector 4160 flags 803
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] amd_iommu_report_page_fault: 28 callbacks 
suppressed
  [Fri Jul 19 17:05:08 2019] AMD-Vi: Event logged [IO_PAGE_FAULT 
device=01:00.0 domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] AMD-Vi: Event logged [IO_PAGE_FAULT 
device=01:00.0 domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:08 2019] print_req_error: I/O error, dev nvme0n1, 
sector 1141976 flags 803
  [Fri Jul 19 17:05:59 2019] amd_iommu_report_page_fault: 2 callbacks 
suppressed
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] print_req_error: I/O error, dev nvme0n1, 
sector 4160 flags 803
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] nvme 0000:01:00.0: AMD-Vi: Event logged 
[IO_PAGE_FAULT domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] AMD-Vi: Event logged [IO_PAGE_FAULT 
device=01:00.0 domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] AMD-Vi: Event logged [IO_PAGE_FAULT 
device=01:00.0 domain=0x0000 address=0x0 flags=0x0000]
  [Fri Jul 19 17:05:59 2019] print_req_error: I/O error, dev nvme0n1, 
sector 1141976 flags 803

  If there is any other additional information I can provide please let 
me know.

   Best Regards,

   David

