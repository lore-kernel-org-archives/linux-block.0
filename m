Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C529C4332F
	for <linux-block@archiver.kernel.org>; Thu, 24 Nov 2022 02:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKXCMO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Nov 2022 21:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKXCMN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Nov 2022 21:12:13 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FE17A36B
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669255932; x=1700791932;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=R4AJFIYWgUissg+r32yAn5oE/scp1NDuIHnaHBjMr9I=;
  b=pK9W7pYkFGSNichqZg0ugyXYTyIkm3m57IgRQAyi+teY26vsLgvg3RnH
   K48gD1wHRyB8VwORoZVmbYEJhNnxuYnS4cLxWVmHhtn9+GnITkW5bQSad
   2YreBe8D6Jn13anP5KOMug4buhavyDfIUjPwWNeqeIUo85J4zdSO7RKMM
   7FeSo9Kx4mBgwVH5vcyEnXfel3yvol5C598M0d3ncxKY+Q8w1pSZwiV0S
   A/sv5VF4pU46YmH7vdFJf+x0SKaCrgC5QaIAsyxqvp9SHMKUDB4+c4c8t
   gP8xXx9H04NOFef/s0RZQIwI3woy3qJaQAieKSVwbxp5jvGchqjs0CuFc
   g==;
X-IronPort-AV: E=Sophos;i="5.96,189,1665417600"; 
   d="scan'208";a="217347975"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2022 10:12:11 +0800
IronPort-SDR: eCrJNS6/aW4JKSkk757r3G1BTfGR3RdamATpvKDs08BceCA2zlh4EeObseUeMKssAy9kgYZiz3
 vBuulY0YtaKD1IpbrVb6Yx4UaL8kgC1vmDhyePE3PnKKAIPqBetgGw49j665ydW8YD+LsQi7nK
 el9XV00AC7qwmk07AnDhAiPpUKwv5iuXiLtDuzB86PKHqrOWNPe0qoBIQUSfphIs3VjlqPVaVY
 R9FFcTeS6y1ioMVXIeFDBaIqptAGeYQvDrpkg/kgjMNiOZhNZne6DkF9i1Sm8mBfWNwONK5D+L
 aBc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 17:25:14 -0800
IronPort-SDR: K5yV65rcTBeIkuUn8hBOev+k+LTJgL2UV8fO5zp9S4/s8ifTeY8QDk7mwG/DiM4mLPqXb7EmBP
 pLNClXCKeCBl8S2C7ePI7s8L57EsYIFHfwLE6rhzvSGCkOMegfdHwxrIwGhMRdCfJUzxPie7qH
 RNHzStRdXFr48ta9V3B3m/C74bp2IdVVt7IlyyPu1BTXHVyWRpr0k9ID12/N8v1Y1+0q8mqXwe
 zlQ7xqE6mzGODtjDsqoyjrcgQ+/3bkBtGA19b/czlarqm+Q1H37HKO1um0vNR2FEfBxpPbn4s4
 tg8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2022 18:12:12 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NHhMb1tJSz1RwqL
        for <linux-block@vger.kernel.org>; Wed, 23 Nov 2022 18:12:11 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1669255930;
         x=1671847931; bh=R4AJFIYWgUissg+r32yAn5oE/scp1NDuIHnaHBjMr9I=; b=
        ptZRIO9fn7AnQQwpb+VYEoSZCO3gd5lW6q6Rph6S0Ukxh8EB0pKae7K2P92NAkZJ
        KvW8qfqo6JD38yECRwaA9K8tY+M3DHs/ZMVh8dW+RJgiq/hqhSyW7HCnY2jAcmi9
        kVUxN1unQEnmgF9xZxed+szzOB45OVPqJAMbnhnqQ8BacqiGcBMHbGLUBGr1q2+n
        rCjhvFCBsH/rLP9rr5umt5mJBxfU3AhymNMteQZmGyFXrXXfsWuGQYXjPo+sxMg3
        i2qNCChCXjKRwulZeVDyRxyhqwJUn86Rs3rsxj5SPhV/9huEK2az8AJRx1hYAjUg
        tHdTy84SKaVMiJJrmAuKcA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id T5ENQ85HLiDy for <linux-block@vger.kernel.org>;
        Wed, 23 Nov 2022 18:12:10 -0800 (PST)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NHhMZ1T2pz1RvLy;
        Wed, 23 Nov 2022 18:12:09 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/2] mq-deadline fixes
Date:   Thu, 24 Nov 2022 11:12:06 +0900
Message-Id: <20221124021208.242541-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A couple of patches to fix (1) a potential problem with mq-deadline IO
priority handling and (2) to improve write performance with HDDs.
While the performance improvement patch is technically not a bug fix,
the improvement is so significant with some HDDs that I added cc-stable
tag to get the patch added to LTS kernels.

Damien Le Moal (2):
  block: mq-deadline: Fix dd_finish_request() for zoned devices
  block: mq-deadline: Do not break sequential write streams to zoned
    HDDs

 block/mq-deadline.c | 83 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 6 deletions(-)

--=20
2.38.1

