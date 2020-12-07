Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F72AC0018C
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A3023A23
	for <linux-block@archiver.kernel.org>; Mon,  7 Dec 2020 23:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgLGXt7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Dec 2020 18:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgLGXt7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Dec 2020 18:49:59 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EF0C061749
        for <linux-block@vger.kernel.org>; Mon,  7 Dec 2020 15:49:18 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id s21so12010573pfu.13
        for <linux-block@vger.kernel.org>; Mon, 07 Dec 2020 15:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=HrXuFaSEQbpp4LXlhF5fUTHsukqRhZzVaPR/VEdvTwc=;
        b=ATRflG+LUSPDAqqjhziQAZ/yRlFIkH1NdCWLh3h+PgURrV+sqbIybMgt8iSaixyLtQ
         cpw4L2U8GLo+sYNhUzuZLoAF3r87tPa04Zd1lvmtKupECX2ecq9XtaRMyTIf8D9nDBjS
         HsgqkasfmHvgt4/E7dAfL7erv1+4iXLXr2SEuJCL61+laKa+ZBr1XPTo3wEGDzV2wZZH
         w9bK9URAzFGNBkZeH6Xj5xYXB0Q2tmBibVJmYBKWL6J+W8HAdR+HFHfHGCNiR21XSmGp
         amoGqM8IUe7FYaBOVRMAlaXg1FWAg6QxwgltlODOwkKLqtgyC0yJRskvnWzZZvdmhaZV
         vPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HrXuFaSEQbpp4LXlhF5fUTHsukqRhZzVaPR/VEdvTwc=;
        b=sL8SefzKibRWcroXr/p2R0BKxhIbTHt7Hp59MJJDzkRt6qML2tIVjDdxbbZBFsX08i
         w8lb5W+zvhniKcmbwhJvS/bfsnlKVR91wmLxjB+Hl88euckitZzKeg+g7RmrzoRMMVP8
         Hv3wfqf1/wZxwOfxJe4G6zWTdUw8iUKAbokwQdn98VjoMHMglog7K5EesxHfZ2N7vQXH
         uq2C5SHAwfrMna81jCak/REmIFh2IrEn2JKPQu1HmnjrOUFTvartBYYfh+PdfiXsySZ7
         0xAd8y/+dy3ReOPYF0qET2o3X5KGg1oJys+ZYKQYm4pWwuL+AYN1DWHhoZrqyVQSbbvs
         WEHA==
X-Gm-Message-State: AOAM531zBSX8ncZ01HG2mI6chrvl9ivAgezUpwDJOXRrnXP+LxsfAaCI
        JU9Xu61WBtp2/vCRTQuBFkXCtdd+cBFfYQ==
X-Google-Smtp-Source: ABdhPJyECkFeYp59Bi14lD+7mpnCnJ28cLrBZBBgOz7ZuhaZaXWpdSvXKk1G0haG9RfmXotSgxlCWQ==
X-Received: by 2002:a63:1d60:: with SMTP id d32mr19450608pgm.343.1607384958171;
        Mon, 07 Dec 2020 15:49:18 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id f92sm483771pjk.54.2020.12.07.15.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Dec 2020 15:49:17 -0800 (PST)
Subject: Re: [PATCH v3] blk-mq: skip hybrid polling if iopoll doesn't spin
To:     Pavel Begunkov <asml.silence@gmail.com>,
        linux-block@vger.kernel.org
References: <d5c7dbf6f10efa44271dcb36a178f9566fe76c19.1607263384.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0d83c5a5-8775-04ed-f225-f1b40c3bdafb@kernel.dk>
Date:   Mon, 7 Dec 2020 16:49:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d5c7dbf6f10efa44271dcb36a178f9566fe76c19.1607263384.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/20 7:04 AM, Pavel Begunkov wrote:
> If blk_poll() is not going to spin (i.e. @spin=false), it also must not
> sleep in hybrid polling, otherwise it might be pretty suprising for
> users trying to do a quick check and expecting no-wait behaviour.

Applied, thanks.

-- 
Jens Axboe

