Return-Path: <SRS0=yHxa=2T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2326C2D0CE
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 16:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAB720718
	for <linux-block@archiver.kernel.org>; Sun, 29 Dec 2019 16:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TRlbMfYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfL2QMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:12:51 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35180 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfL2QMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Dec 2019 11:12:51 -0500
Received: by mail-pj1-f68.google.com with SMTP id s7so7141835pjc.0
        for <linux-block@vger.kernel.org>; Sun, 29 Dec 2019 08:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aYcF2mO4NIqWePT4xRGqhnUgeQJLeviUy7xDWml95rQ=;
        b=TRlbMfYe7tuBUt4uXWV4kK7saHcIeSOYM/AdKqAkq1ZEE74eyQflWBA4+jL+e8wJaG
         5ddet/dE7T/OmCtWGKWemrfhHDzd0MXo/h0WfMXzTRH1PyzL4Kj40pTSIbL9+XIhqzfD
         zvLVdwaKds6KS+KuW4xuLzg4tMlbbqIajU3ZghITzeYs+EDpRX/e24Ues0BJzuYf9Hxh
         G6G4L6b7QK9f1l6WR56wMp+puiD0lgA69IWAlKCV+etTRSpwJebD6PRom4Rq0uQnQj5b
         lJ9q3DurjNk0OEEngsgswAISWvmPkbEuP4s89ROCtTpMaSDp+RWFRfVC4MklJFZdYovd
         NH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYcF2mO4NIqWePT4xRGqhnUgeQJLeviUy7xDWml95rQ=;
        b=GsxLJiW8pXp11vBS699hVMwRhS9Z+XBu5ZICDbm0oTKOz46MiBJR7VxeePoimMNToe
         miTfA7UzpASdc8A4cbvOi0JkYZYjw3b4ei/A0Ji4aOrQIVRLuWZwmprgcgY8ELiaYeRi
         /qkWH9shMtFjs7NtRB8qmH2M9+ITMBlGoiBTKgGW/Wq2q31CNfZEL3RcXi5eDG2BX1X+
         Etjtq3Sf1ru6fJ8bgta0pNAr3fze5vN2Ff++PXa4tnJcLIhtJRW0otjMAU5kjaDuiB17
         168zygMe8z8g9fJD5PI5iX4aKpnp0fj3XFL83ubJRDo5QXR1WffphDN8M/QWvTs3JRkx
         XWqg==
X-Gm-Message-State: APjAAAWUhvSVezI01gBZKjPEpD8vNWP85ipjgreKxCYL2PcRe7+pIme8
        YMD/E2wfwFMXa5HpyBsv7lDGB/EJwlcvMQ==
X-Google-Smtp-Source: APXvYqwd+e3wML7zwpBObs1hEKvbW+IpOT5Yl5VN9s/LEBflVqAV29ZCKUJhQlQSYi/2ceMRQviQgQ==
X-Received: by 2002:a17:90a:2729:: with SMTP id o38mr41689939pje.45.1577635970360;
        Sun, 29 Dec 2019 08:12:50 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id i66sm17011325pfg.85.2019.12.29.08.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2019 08:12:49 -0800 (PST)
Subject: Re: [PATCH] null_blk: Fix REQ_OP_ZONE_CLOSE handling
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-block@vger.kernel.org
References: <20191226065425.490122-1-damien.lemoal@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <57aa4be0-5eab-cf56-b83d-5f44be02d7ce@kernel.dk>
Date:   Sun, 29 Dec 2019 09:12:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191226065425.490122-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/25/19 11:54 PM, Damien Le Moal wrote:
> In order to match ZBC defined behavior, closing an empty zone must
> result in the "empty" zone condition instead of the "closed" condition.

Applied, thanks.

-- 
Jens Axboe

