Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC415C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9756220720
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ox3BWTAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgGBI1y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgGBI1x (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:27:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A258DC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:27:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a1so28246941ejg.12
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 01:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RKNNI9ilwlTW24O/K9HeiTVOSxJ/N3BqN+ZQDEWHhcQ=;
        b=ox3BWTAxS7015W5ouWIph5TlQaJD64Q/jzbWXSueNXw5InF4mgLX9zWqSqhCNUd5ui
         Nmh6O5s+ftnGOQ2flcWnqEgi0qb0YTOfndBn9aw7erT5rGpuwv8TurItWIdD69bRAaeK
         Zt+MjYBfYZ9o7fQ91yQg4Ma8cHG8V6aCfbE4U7qA667dguUrqhLO3cjNH84slbhPW7gp
         nWt+i5xhw4y6sMWRfMNKcfpOsWAintVELYw84QpF7Y6FjvVU3Ymb3tkAuo81Buz7FB2E
         u5+sQIy4RTtYyHaMy7dqWLud9vpISf7s7AC9VGfs4MyXN+WqrZWOnv67/5tftkNr5fk3
         f0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RKNNI9ilwlTW24O/K9HeiTVOSxJ/N3BqN+ZQDEWHhcQ=;
        b=pWvWBGcxYgImcpWOD1BJOpET/KQ+Ru8OEagE+sJlnuemkrDBuf5aufyx/O5GlNKk1C
         efyEXVDOde6h6wgonV/BT5V99nGFeuqvdTnwwy2ZVcrysTYUY1kIICdFCBu0QJrGB4SC
         zKv1HFqn7GVR1k/C1bwP6lb8F31bTFKDCnQIi1RTYacbiNroj1fZRByM/tCIWZ2Ifq00
         cJ8vFDWlFHBB0+eHgEMA1ghKflf4dPsngarMv7GZAn/85WMX8wJwcjO+1Uisb5qwAyrD
         elHXUnW5a1+/tW6KMkGzAOLgoefrN+dK+SyO56WzcWgqYyaOJuKSC6CAU2f4d+uGBVSB
         E5SA==
X-Gm-Message-State: AOAM532e4Wkbd73Vug7xbr7w+/vYPFiP3CzbhP1GHxPActHnkpAg59Be
        nDDGazjWuXkHF6mPT8ViC8o9xQ==
X-Google-Smtp-Source: ABdhPJwLYs3u1lg4itWPmPWTqmj9rfL+4jOz/2f+iuNc6XCeNvc40KrjILE7OBRTGcMtPpUFGNlGxg==
X-Received: by 2002:a17:906:4bcf:: with SMTP id x15mr17409793ejv.188.1593678472297;
        Thu, 02 Jul 2020 01:27:52 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id q3sm5163437eds.41.2020.07.02.01.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 01:27:51 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:27:34 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "mb@lightnvm.io" <mb@lightnvm.io>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH 3/4] nvme: Add consistency check for zone count
Message-ID: <20200702082734.pb775iqyqkm2if6w@mpHalley.local>
References: <20200702065438.46350-1-javier@javigon.com>
 <20200702065438.46350-4-javier@javigon.com>
 <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN4PR0401MB3598D462060502A55417B1399B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 02.07.2020 08:19, Johannes Thumshirn wrote:
>On 02/07/2020 08:55, Javier González wrote:
>>  int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
>> -			  unsigned lbaf)
>> +			  unsigned int lbaf, sector_t nsze)
>>  {
>>  //	struct nvme_effects_log *log = ns->head->effects;
>>  	struct request_queue *q = disk->queue;
>
>
>Please no C++ style comments and no commenting out of code in an official submission.

Sorry. I see some debug code leaked here.

Javier
