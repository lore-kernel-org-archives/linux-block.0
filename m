Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB86C10F1B
	for <linux-block@archiver.kernel.org>; Sat, 10 Dec 2022 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLJW5r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 10 Dec 2022 17:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLJW5p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Dec 2022 17:57:45 -0500
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B628CCD;
        Sat, 10 Dec 2022 14:57:43 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 45035403E4;
        Sat, 10 Dec 2022 17:57:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1670713060;
        bh=8hEeAZyiSBtGooQxdC/TTRUYL6HjB7JGCmD1KZrPD4k=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=Xf7OurNODCSrJw4PpvybDT7Nb7eOxlwnlWEv4bPTDRVPD0u3Wxw4obq/UOFWur1dP
         ua2fKrkSYYnpQtS95tcToOzenHfEsXly0Ugf3yzyjC8gJJB1ElgPKWXk+j7HN43BZr
         gyTKRDyK3gAYTnTi9v4yFuLflX9rgyrI8pt+BXjGT35nVCbBQ9IH4KMl6DsCum94xc
         QJk9PfIog6EY1V3LfQJ5xSEozg5qgHxBH70QpguvKNwoAHVV7TS9V0gmt1GG/ZEDSe
         inzxPFZ9zrKwp5nOWFHPZMpZO38UmBHphBkOCexuDgjQQD+qafCe3po3ZSJ4sWH/DX
         vJ1J7eH+UvAUg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Sat, 10 Dec
 2022 23:57:35 +0100
Message-ID: <6c07d130-0f49-f6b1-aacb-746a73d027ba@veeam.com>
Date:   Sat, 10 Dec 2022 23:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 00/21] blksnap - block devices snapshots module
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <Y5P7qDolYickFyBJ@debian.me>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <Y5P7qDolYickFyBJ@debian.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.18.0.171) To prgmbx01.amust.local
 (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315566D7566
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bagas!

Thanks a lot for the review.
I will definitely correct the shortcomings that you have indicated.
