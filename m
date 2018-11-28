Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96672C43441
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A90B2081B
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 16:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xz+8+ERr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A90B2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK2DKZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:10:25 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:35517 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbeK2DKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 22:10:25 -0500
Received: by mail-io1-f45.google.com with SMTP id u19so20395511ioc.2
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=AwruOfkURi1tuwoZRl59Ro6eWgSu9r6EUO58L5eqNLA=;
        b=xz+8+ERratb+86+JANF5+w/DAVQG4QTmy+KMrEItCUUOglKKh5FOb4KIxK1ZXBiY+A
         CM4GnpAtRPwfNypdXa8nWU9phtp8medbfFQSNcD7IeAphuhwaP+ySdeq2T92A5eBbn4w
         83PSyt1Emtf+6Yrc0SXtXS3RstXeZvD9zfblAtOVZpctF/lB1ue4kCWX6TXBm5EJiyzC
         3WaFlAWz1a8+OKxAjzkENQQaA4Qi+17LC5an39mM10JPUTcgCu2fLulY6ldn+7LcoU6L
         TgdDDKN+ecwCfYQgdWhOf2SnhlTyrwc3sJNcshbZ0eRz5KcciS2Y/etetCEd+X0khgio
         DVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwruOfkURi1tuwoZRl59Ro6eWgSu9r6EUO58L5eqNLA=;
        b=JamYkfuVe6aIuz6pmCaTXH09zbtKo6vOjv61278bORENVs2pMf/1FEDpXI+HmM1slJ
         HPZiwmfWDoFrBHrYUOX6PaYsDL/KLnIIcDaxfqRfgduS1yBOPh40Uf2odXjo0rRX9Dok
         TIOwWrIae8TOhpuZXHmK6SxpvHwL0MlzMaEGDUROw8owvC8X15pgLz07wKn0CryI42iW
         51l294NWTpFscsFU1+ytSJinjkyzhFwSpMrF59cYSFa6WZRSJUIU5ILJK/01aLtuIqbi
         si+/kBme7Lvz5/jchobWPVM/6FWi3m413VcsJZKkr1FVX6xka5S3FRxXTbVefSxY+F2X
         zM7w==
X-Gm-Message-State: AA+aEWZ5RBpqkuDcEUN0ToIlmWIDutU5CJiA8vGAwN8fC1h+krlOa/z9
        Wt1DPmk5VQxRVwzqo9PqzNUPnpbmgmE=
X-Google-Smtp-Source: AFSGD/Wd1Z5ZqetTm5Ret1G+jx9TmJ3m5CoOsh8bAnKvHEGE8S5DI8fZLe+Ix4dzP9eXnon7CHiiBg==
X-Received: by 2002:a6b:8e43:: with SMTP id q64mr27983458iod.197.1543421295018;
        Wed, 28 Nov 2018 08:08:15 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x6-v6sm1439689itg.15.2018.11.28.08.08.13
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:08:14 -0800 (PST)
Subject: Re: [PATCH v3] block: add io timeout to sysfs
To:     linux-block@vger.kernel.org
References: <20181128160433.GA35371@192.168.3.9>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <22cca1f1-d563-777a-3b66-23a71b408771@kernel.dk>
Date:   Wed, 28 Nov 2018 09:08:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181128160433.GA35371@192.168.3.9>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/28/18 9:04 AM, Weiping Zhang wrote:
> Give a interface to adjust io timeout(ms) by device.

Looks good, applied.

-- 
Jens Axboe

