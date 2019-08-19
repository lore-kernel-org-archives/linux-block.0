Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD757C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CC67206BB
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Mb8tCh2b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727606AbfHSOxt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:53:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36718 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfHSOxs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 10:53:48 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so4891156iom.3
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
        b=Mb8tCh2bLsjeTjXBHqs0/cQN56crbWNd/Q8xr/pSttNKCouz6ipVyNQ0+eAAUwy4Fg
         s1np2ZTCFqN3neFZsTIeSJtxhAFbC+5XA8RAZAyolGlsOmTH9S3LITyl9eoPOssO0lnJ
         kpUpE6ip013rwPiNw2Bu9nefooFjpQS3wtXUPgNduuc2sBF0o7NXM475JBSCWstwU8k5
         NwYY4rZpqmg8nJv9ipS2IGWDJSJR8UJB890KZ+Cc3lRgtwo0iih8BhCEn4xhGKW+ZdAf
         ZDEUK9HPlh4Ub0yDU+XPxaEGu1+idYMNf2bT2tJijA6R6pwJ+0sV/oek3N7RrhW3k4HF
         tdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAozpPrx+Q1jLhuTy6OsL4NNG3IG45MFANMoIltkwAo=;
        b=EYucfwEKbqjsLzcV+DEJXX36WVMdFfi8hIdSHFcxyMjJXW1uU20G40kdapAcpKDUVC
         BRbk/360s60JvhVgekdkeIjLEXTKLNArQeBNDE44tKatAbldiOffWBftsFbET8tGc3TF
         hx2BghcD7DDrCkf+LkLMGMwvCwHmjSXp4WpA7LWqzISsmbt+tsFoxgbx3ZxspJbYZ1ym
         z+llTzCzpqNv90ykgZ9rbNyQEWyNbVZRCY6EWbLyAgUfWtd8qNWZ/fNtNJjWxxKwayi8
         yu7VW8VnWWJvCRcFqR/qOi6jZkO86zlIH+vZFIysvDDi8xAjD2w4f29KIzcwJmyqGVX5
         vz9g==
X-Gm-Message-State: APjAAAUBaMV84rS8mHZneGTiUOyqg2VRVD+w95a3/Y/FvlEFlwMqBiUb
        eGQ0/A3/CsZlAn26/o8kfrM8dg==
X-Google-Smtp-Source: APXvYqww0IFLngqPqM7W6572CFxzF909pM0goodpc31llb6Yt4oi/F2OvBrkbuK/8LN1xVz/+eRMdQ==
X-Received: by 2002:a02:952d:: with SMTP id y42mr15298473jah.66.1566226427998;
        Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Received: from ?IPv6:2603:3026:406:3000:70aa:6052:7aba:c7b? ([2603:3026:406:3000:70aa:6052:7aba:c7b])
        by smtp.gmail.com with ESMTPSA id o3sm13893887ioo.74.2019.08.19.07.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:53:47 -0700 (PDT)
Subject: Re: [PATCH v9 3/5] block: sort headers on blk-setting.c
To:     Wolfram Sang <wsa@the-dreams.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org,
        wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1564129876-28261-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190816195026.GC6886@kunai>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6ed6c62d-d773-71ec-382b-acd850e3dff1@kernel.dk>
Date:   Mon, 19 Aug 2019 08:53:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816195026.GC6886@kunai>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 1:50 PM, Wolfram Sang wrote:
> On Fri, Jul 26, 2019 at 05:31:14PM +0900, Yoshihiro Shimoda wrote:
>> This patch sorts the headers in alphabetic order to ease
>> the maintenance for this part.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
>> ---
> 
> Jens, can we have your ack for this patch so Christoph can take this
> series via his tree (also for patch 4/5)?

Please just drop this patch.

-- 
Jens Axboe

