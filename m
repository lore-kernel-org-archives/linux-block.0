Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11A9C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9767020874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0TfISly1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeLQM4X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:56:23 -0500
Received: from mail-pl1-f174.google.com ([209.85.214.174]:42454 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeLQM4X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:56:23 -0500
Received: by mail-pl1-f174.google.com with SMTP id y1so6092461plp.9
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 04:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MymstzvIWfj1JC76vteJQu2DU3FMWntIek0f2syD+X4=;
        b=0TfISly13bipUhiUX/zX5XVS0VZOzKKZPBukK1PTRZlaQGvFre1ioW7YGA0ASA24xj
         O3bA02rJjPMgbuiSKe1ByDRSlhxzreOoYkwh3pk8AydE+F6ahGzMBUoLqBKRkXjGDqKz
         67aOr3Bt6hWuivsZfNiitoue3GaFjdGg+Wg4vxz9pb2LdqvGXwf8nRo68wTsyXD1FtV4
         Oj6pqH92H9/q21Qx4gjj+wEFz/69uFInPuVb0ri5bttf3Rivh7cQk9D04CxZqoSa6GnP
         72+qaK00FNJcaUVP3y35mehfRz1Ph2zGgc5qbXLdyBAVxjabKuBacMdbvcW0n0C85tL5
         UKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MymstzvIWfj1JC76vteJQu2DU3FMWntIek0f2syD+X4=;
        b=ZO90XUsuQ7fuMYZUDGteu6GlrwbecSfnk/buYXh9EUn66scA9AY2WVNFM8Dr8Iy5ET
         HbGIjeqU6dLnfO1qqN1mQu+2b3nmXy2hBjPpoH+mnR0rHjlfRgT+ObZsrfBaX1wricJX
         ms6G89i0EP2Zj77yWDbv2lBSll7c3edt106lVlxKm8Jc64f+yHJPycyVR/cTwDCa4UkD
         rKpooXWwfokh36TLTjn+PRX0/YdUHbEBOuxoLF4Lo5W67muX7LPAeT1tiElA3M5SvQCY
         x5EiW2NkTHFZzjRW4eMYBu9KCeiXtlJAMMTk0qmSKh8zeaFvqjKyMMOYscdeki49EyHv
         gEZQ==
X-Gm-Message-State: AA+aEWYjNOIVF5kHr6mF3mk9a0fT5PWUHmhD00IXeyix/Oqaq4l+i+JH
        +KaEAP5+mCz4bp9B0SyrqH9G6A==
X-Google-Smtp-Source: AFSGD/XomAC6NrfFmXX7GSVTF3gO/VOLIo7pkrncUjPKg0ehq8SEjK0F2fJviFEf4sZxUMnxxg7ZqA==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr12834111plc.288.1545051382441;
        Mon, 17 Dec 2018 04:56:22 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y6sm16694696pfl.187.2018.12.17.04.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:56:21 -0800 (PST)
Subject: Re: [PATCH 1/2] blk-mq: only dispatch to non-defauly queue maps if
 they have queues
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181217111627.22635-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1bab4b15-35a5-f59f-184d-d4690b945837@kernel.dk>
Date:   Mon, 17 Dec 2018 05:56:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217111627.22635-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 4:16 AM, Christoph Hellwig wrote:
> We should check if a given queue map actually has queues enabled before
> dispatching to it.  This allows drivers to not initialize optional but
> not used map types, which subsequently will allow fixing problems with
> queue map rebuilds for that case.

Applied, thanks.


-- 
Jens Axboe

