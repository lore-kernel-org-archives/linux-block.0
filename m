Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BDEC43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21EB620831
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sZcJs4jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EB620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeKTBnG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Nov 2018 20:43:06 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:54309 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeKTBnE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Nov 2018 20:43:04 -0500
Received: by mail-it1-f194.google.com with SMTP id a205-v6so8753579itd.4
        for <linux-block@vger.kernel.org>; Mon, 19 Nov 2018 07:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dv1rRrWMh+CRmNhNG10ZQhLGLOgXn3WkxVnNuE9ubBE=;
        b=sZcJs4jddbZUfWDBJHxgu/J5P6ohvFrkQHlf9T5s2Yk1woPg5u+EeXie3vTKqAYkjO
         pPyeynVfZm1BEycbvt4lzQ2lenL/xh4X+39vJtosLIkwXnnI/2AG0JmwcGDZlYg6ZSSt
         dhq0dZz3nF/3fzz6ZQEDbEQEWPdK+Kz831++n7rbFmBBFqkHl5bUIrHMngqFy0kzdMsY
         sy3mdm1tng93Eq3I8OVgPgWPHnUyuF8uSu79pf35SG75jmw4gmxFsuB2brlJJi1GdmOJ
         XXNlARaU5S7t4sP21i/BsDY1WCHkhsU6whRi68RfU4JUaiWE+40RUhlO+/qKRduPUMrt
         eu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dv1rRrWMh+CRmNhNG10ZQhLGLOgXn3WkxVnNuE9ubBE=;
        b=GAGIJT/O1xR4s4hFHrOUVWA6280EsrDdpfJZArRRJXnfhecpOqyTRVKblxyxi8k6Rj
         Za2kUzqRrnoVofnHYzNXqNEiCRWsRRvtaHY5N5rzEpMjPlHuBQk28FLA5sy/mK5lWc6a
         Zru6dHNjEYjsbjyJXcYqapQHVh6fZf50nrB3FxZm8WuFkeBQXicKRDCkylfLJDSS0Hdz
         SjTKdlJ9esbFBtlkn7pPi+Mlrz99xMrddxaYCmnqQezWRtcCda+AEHJ2Vu5xZwwDokS8
         TFShrPD/Kfqc5Kur1PrfQCb1TfxWlwKhfx9HCrQZ/okVsZiFQ9IJC71ok/TZWozDm95i
         OWlg==
X-Gm-Message-State: AA+aEWaJCV5nLEOvuRbGMDHOM8c9d+hMp9oR4kvlIesPfgzjJIbraaui
        qyL8CLPRSae7Zk/oeyx+l8CpYQ==
X-Google-Smtp-Source: AJdET5fRN/zNywr5HDNWaiuk8UEsSKP3zDxQwLT/XmchP+a3ciNNKEd0Ez0Y3gsRq28i571VbMxpew==
X-Received: by 2002:a24:5308:: with SMTP id n8-v6mr8805774itb.146.1542640749638;
        Mon, 19 Nov 2018 07:19:09 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v15sm12501897itk.12.2018.11.19.07.19.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 07:19:08 -0800 (PST)
Subject: Re: [PATCH 3/7] nvme-fc: remove unused poll implementation
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-4-axboe@kernel.dk> <20181119075904.GC9622@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5badecdb-cd80-c1ab-bb9d-72880800bb1c@kernel.dk>
Date:   Mon, 19 Nov 2018 08:19:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181119075904.GC9622@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/19/18 12:59 AM, Christoph Hellwig wrote:
> On Sat, Nov 17, 2018 at 02:43:50PM -0700, Jens Axboe wrote:
>> This relies on the fc taget ops setting ->poll_queue, which
>> nobody does. Otherwise it just checks if something has
>> completed, which isn't very useful.
> 
> Please also remove the unused ->poll_queue method.
> 
> Otherwise looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Sure, will do.

-- 
Jens Axboe

