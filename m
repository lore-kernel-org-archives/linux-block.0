Return-Path: <SRS0=V/uB=YN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3921CA9EAD
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B694721928
	for <linux-block@archiver.kernel.org>; Sun, 20 Oct 2019 23:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BMkLgXbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfJTXmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 20 Oct 2019 19:42:23 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54880 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfJTXmX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 20 Oct 2019 19:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1571614944; x=1603150944;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/UNosYy4fGH3jSNC6FWo80lL59SdY8u6GGobtRzBgJg=;
  b=BMkLgXbbjTXIGwXGUXykF98b7QbUjFIxVAqkk+p/JCzLoN0FEFq4/qQV
   aTAic2zh7Rjshms3/6aJg1b4HSpUae9PDPaMWFfusBfUT//7bDyJ4L6JO
   oS4NYPaMW3x3++LGI2IsPPhODywXyErIzz3+oGwpDPGH+udx2Ap/670gd
   FRhOgiig/BLJL0IH1mwAvKy/ZsI/bfmnK6O10Mf7KL9xCUwLuBLux6Xkb
   ofhwVLz5TGA91PtVC7JRnvJWOfEy8Gt96PakAMO1RKgbCISo8kBIthutt
   P6cOiloXPZZ6+iFRzjZ1pzCDvUpIcrYSQRDCOIRo9euERSfNP0h95qgnI
   w==;
IronPort-SDR: fAgMzLOgTAGnZeBtvqFbYV7xIqFtfd1eBY7hMDkZMpV0TFS74riPiUC4Y1xQZvsV615cuevfuZ
 T/l2V0g9BZQPb7xz0uLMomW32Scc2Mk37DOpqHQsaNB+KOzw+ky05f4X7Hq10QW+1zgnXXUXz0
 Yrey08SYEdG5e9xdQqhqO+NRCcisc8s8Xw5jmTHg9EUQflFo+qaLaG8PhrxzQghgweSc+tN0S8
 eqd8l7k44TZ3LZlO+lKOxdO/PgUyoQepRoSo59q9kS4b98DIXdmgJEV+0mwU4XwVDhTUXYbZHl
 qfo=
X-IronPort-AV: E=Sophos;i="5.67,321,1566835200"; 
   d="scan'208";a="121710476"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2019 07:42:23 +0800
IronPort-SDR: bUip0sHz1a7O/vxPsVUbReJ/WS1hixE+/f3x/KZILlHmSRstnTr8B60fvHklA2ciVE829qQX6a
 MpB5N1StT2YnjtcBu/ZCqajJ/7OfpJWoic0dgKxdOH45SgSBvNU1g3OY2J/kQdL8yN8M8Edy+R
 ZThn8O5giU83cZQtWkCVuXlwskxZJjJaQs5NWlFhPwj6O1KanOCt8g2rLNLtBWpQ0bxlNmi734
 cCOQ3bS/YLSsY15fVdmYyzX5kxv7rpxTFaAFzgMyPZ3IJh4lN/dKro1e4U5hKzmlyG9KlPSX2g
 at7hnDlBAQ7bH/ygKklEpJ4T
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2019 16:37:57 -0700
IronPort-SDR: 7BPY8H2q14vbAj/Dl3YTfQh2HVgKgl2aQlUUntJlOFWhwdsZ51p9+a3BmLv4iDizI3Amvl8HhE
 J/RT5sbx6K590h5FBm7e8CrupYcQf6wrqi3xtjld2/S3uzsCuftVukkQZXTUN1fcnXBZnxp8p9
 U+U9pXmRzOMU3x6G0gf2VZ94+SoQslVyVe0fE2z4wLf5EmkR6oRxpsFmE09SXSurTaWAaU8/k1
 HX4Fp1W1/zIGZ4q9YNIYn4JKWXWQG/cX7ZhTG5j1LvUM9rcRKQLTlvwAqQdCAhqLIvrRjcQy70
 Njc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 20 Oct 2019 16:42:22 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 0/2] Small cleanups
Date:   Mon, 21 Oct 2019 08:42:18 +0900
Message-Id: <20191020234220.14888-1-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is series is a couple of cleanup patches. The first one cleans up
the helper function nvme_block_nr() using SECTOR_SHIFT instead of the
hard coded value 9. The second patch introduces the nvme_block_sect()
helper to convert a device block number into a 512B sector value.

Please consider this series for kernel 5.5.

Damien Le Moal (2):
  nvme: Cleanup nvme_block_nr()
  nvme: Introduce nvme_block_sect()

 drivers/nvme/host/core.c | 14 +++++++-------
 drivers/nvme/host/nvme.h | 13 ++++++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.21.0

