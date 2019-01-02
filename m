Return-Path: <SRS0=PKU6=PK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE66C43387
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFAB218EA
	for <linux-block@archiver.kernel.org>; Wed,  2 Jan 2019 19:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0wjMkseF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfABTCg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Jan 2019 14:02:36 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36668 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfABTCg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Jan 2019 14:02:36 -0500
Received: by mail-io1-f68.google.com with SMTP id m19so25293401ioh.3
        for <linux-block@vger.kernel.org>; Wed, 02 Jan 2019 11:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OwLFi+NOHLmpylbgShheL2s74pOeXmajJEcxTT2BjNo=;
        b=0wjMkseFZ+XXSXtiuXogix5/Cn8GHrWR3so3vtmGzRXc/hkDCgLgzwHnomhJY+WbES
         PgDUU3oU/ka0yOsT/MvIZJnkSXhqyWqKS4U1OaMYwkHbgoNMiS/0UIiOSQRMHy77PPcd
         2YDs6u0wiMgkP7aL9HkrHbthKUdTWj5eQOt5hBROIOFmrplCqQbgMTVKK11ig78AmBcQ
         YSqtjc6+2+qGmw+HoPFhM5p+2MZOtCn0ClDBVy1hnChDnpU8Zm8qO5tZfr/i1sQ7PYJg
         8CK65lqeVLbVfSlsMoTrpzElRGv7TyUz6OQMTwLvqTkVyHPa1o1LLEQNH2fAWripZxZD
         u9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OwLFi+NOHLmpylbgShheL2s74pOeXmajJEcxTT2BjNo=;
        b=bbgzhS/2Hr1RAjFoXbSkMulUkPinZa2Q8hYL0fDePrBMJrpozehDNEXp8tU7/RnJTZ
         tNeHDupS1Q5Cr2Yu+bG/5PH6LIKwoiB2pzN0eNIo2K7FIYfYkyyU75saO0ISUafkLZcf
         3DQ+uEs4G6waF/0Pd8j5mclGYvxH8yQ9xWowUa3dC25roBe2QbnuH9cOOKNPO6g1sDC1
         qYt4gn1gx74cDZNkbyoLLdvIA091wr3RDdPUVwrD2wYYcvP5U+0FIzKhfzVhrA6sGaVB
         rGxgkIa2PnwsWqNxFtPMgsBqhYQPAJGBI7boVy6xydqmeBFcPS4dibkBW7h2eMYCxn4Y
         loEQ==
X-Gm-Message-State: AJcUukfvI1imur32Jb3LI7zWXebd/ww7xkd1VMYjJGSO1duNYo37+o2H
        Ma2/AXjV6faYBl7k2Bkc0Wbs0e/j3nMQLg==
X-Google-Smtp-Source: ALg8bN43s8stlD+Q65Ff0hui+KlyRn00pXVeLoW6rXo64gja46HdzeHtYpm7uL0ENOX9g+EMj70ABw==
X-Received: by 2002:a5e:c107:: with SMTP id v7mr33857208iol.155.1546455755046;
        Wed, 02 Jan 2019 11:02:35 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h64sm23220030itb.14.2019.01.02.11.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 11:02:33 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     IDE/ATA development list <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] libata change for this merge window
Message-ID: <14f317bc-b328-f4e8-30b2-b5e73b2b62c5@kernel.dk>
Date:   Wed, 2 Jan 2019 12:02:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This libata change missed the original libata pull request, so it was
staged for a later pull. Just a single fix in here, fixing a missed
reference drop.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.21/libata-20190102


----------------------------------------------------------------
Yangtao Li (1):
      ata: pata_macio: add of_node_put()

 drivers/ata/pata_macio.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Jens Axboe

