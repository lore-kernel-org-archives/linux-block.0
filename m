Return-Path: <SRS0=/Row=77=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F77EC433E0
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 11:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A91A20734
	for <linux-block@archiver.kernel.org>; Thu, 18 Jun 2020 11:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bKSyGjjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgFRLWs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgFRLWr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jun 2020 07:22:47 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FEDC06174E
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 04:22:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id mb16so6014851ejb.4
        for <linux-block@vger.kernel.org>; Thu, 18 Jun 2020 04:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VTDxXAF2sbR0WA9dg5vtqihKVFO44BpkkTRJ7bNpHJ4=;
        b=bKSyGjjFsgJC05/EkdH+6ymDCmWDL+ZTIGMyicMKS52E7vZ7jrTWjgJP3Y8ooI3fgC
         zQU3mhpDFOyik9zneAsQwjXLF+eym44lZWZ4pAWoGWUSmaKSd+p6QoG0lK7R7mvnF+c1
         lnsy7+EjssEOxP2lIW3RowJRfX+733GJcM1JhBoGtLjWU659ZQ+i54t8vwdyA+dz6b9a
         ZHRXVs0BkhS05xUvcjrqG2ajQCmuVjGv1xbKlUMmLcfEinpqPgoaAqhw+kPRJ4q3gpev
         +ZRSbI/6O139X2by1g89Z/pl59DRwkggBr0pwcdqb2m/KEstmmjuOH5ngM4OEz5GscNc
         fCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VTDxXAF2sbR0WA9dg5vtqihKVFO44BpkkTRJ7bNpHJ4=;
        b=YVD0ZImezt3fFPvpZpUSMszNUDC66sCzcywvOb7FkEocGDXqS6bKXbBrwOHV9ZHiFY
         4G47YE8gg83CAL6uiKw715sWU6Q5JK1YIZrygmiQZDNa0Ey/CaNCXW0w3OP0Ah2OzD1y
         Fx6+EGMUZgb7waTr4SxAlni9h6HxGmsu6XFAPFSYsZp13hgOVaiHdsougD85LUqs3beb
         bfkuS5TA729CuwuckV+ZSky0yFeYZMyq1m8s3Jo3dyW80Z+IUw3dtrDijNB0smC6HFFO
         yt3Vct0lz0oKgD73bpQvEMYemnDjnBRs1tqqtrOhlSxeGfo9EGkcduCjRPyhIbIfOd/C
         Oqjg==
X-Gm-Message-State: AOAM533TkP9W7AtyJ249mjWIgdmADFvJ5rPk0T3SjM8yxFdg1yhINkFV
        VXVDzyWBTwOCCvI9mo1FHRFuNA==
X-Google-Smtp-Source: ABdhPJwZ64i8ZG7QxhxTCvXn+BDdMNKkXBOo4OoWCZKvGCKMhlVS55GEXbKq5a5zvhSaXb6jJiQo3A==
X-Received: by 2002:a17:906:7498:: with SMTP id e24mr3505427ejl.174.1592479365407;
        Thu, 18 Jun 2020 04:22:45 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id qt19sm2068411ejb.14.2020.06.18.04.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 04:22:44 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:22:43 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: lightnvm: pblk: Replace guid_copy() with
 export_guid()/import_guid()
Message-ID: <20200618112243.4izabkwsonp3btu5@mpHalley.local>
References: <20200422130611.45698-1-andriy.shevchenko@linux.intel.com>
 <20200618105755.GR2428291@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618105755.GR2428291@smile.fi.intel.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.06.2020 13:57, Andy Shevchenko wrote:
>On Wed, Apr 22, 2020 at 04:06:11PM +0300, Andy Shevchenko wrote:
>> There is a specific API to treat raw data as GUID, i.e. export_guid()
>> and import_guid(). Use them instead of guid_copy() with explicit casting.
>
>Any comment on this?

Looks good to me Andy. Thanks!

Reviewed-by: Javier González <javier.gonz@samsung.com>
