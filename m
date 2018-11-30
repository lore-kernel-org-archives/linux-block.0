Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D76C04EB8
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B637220868
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 15:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pTSOBQdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B637220868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeLACgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 21:36:07 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:37538 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbeLACgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 21:36:07 -0500
Received: by mail-io1-f42.google.com with SMTP id a3so4829524ioc.4
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1iO5SyoOXnGAgHLzQNAgOMGZhmV/ltP0SwlccgybswI=;
        b=pTSOBQdQi5sm8HtYdCPmhxLYiwjAxqykKWfOg/nsqAkEWoJrTHy7qQ9GADTNtBmXjQ
         z3ad+8qGgN+51vI26/wK3pKqx3bcyCnf2bVPpjDphu0j3beSgyW96X+9Ry6WDvkqkxAv
         /kfKUaP4L7h/nHy59MGAOivfNQnI2TJTzcM2LG9DmnR3nEZOKyGYOFysQ4TR1niEfRRS
         KYOoE7u8Gv/GDgH03ipLe/xUBmJmBC01WdZ3I0W6X662QuHteOViYkRE0qOfe8K3q8za
         7BQyy7wYgs+Tpbr92HHWED/AAdVqzMzJAJff2PkwVQbinRN/m3MvLKnutuGPSg2l/JBx
         10RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1iO5SyoOXnGAgHLzQNAgOMGZhmV/ltP0SwlccgybswI=;
        b=dsKhaJaqQ2N7e3ZXXxyjPNkGEIBR75W/XJh/qvVoK8Xw4C6im8dZW0NKwhukYxsVqi
         pQwxLX0j1pPVgF/PYenrZQtJVe75iUDUEC7/0fNM+PG+QpOTqMha8NO9RQdWtMBceuFV
         xz2baqnOrxSMcvKdLkKpHSutJsRxsMh+lmx2V8pgx0lk2Dy2zeXbYGV8lCpLppBc3Tz3
         inn0AvIz7hDRsOJq5SEBB07V7+wVKT2O12JdjVKlcIN1d/2szb1pT1u4sfNHQxPsm7Qk
         3mPiZAPCZ53HiKTdqZClL/dVgZCTaKVhN7oAg8oT4FCvO0XmZUs7HyLW8wOMekhOg6FA
         zppw==
X-Gm-Message-State: AA+aEWZDw3tW2/MxDKkWlstBd48c1bZtXfGX9ODt3qgZeIK2/mBPvbsq
        vI6fQ+tA644peNH+Sto1b8Njdg==
X-Google-Smtp-Source: AFSGD/VKpTRj5/zqiYyYa6JXhwLogySgP1PLoeuOHWP5P/b1VniQO744W8WdPnrgYrMktlTdDZQzVw==
X-Received: by 2002:a5d:9405:: with SMTP id v5mr5268852ion.250.1543591586132;
        Fri, 30 Nov 2018 07:26:26 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a10sm2725215itc.3.2018.11.30.07.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 07:26:25 -0800 (PST)
Subject: Re: [GIT PULL] nvme fixes for 4.20
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20181130152430.GA3107@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01b6314c-903e-6787-ccf6-e93aa789199a@kernel.dk>
Date:   Fri, 30 Nov 2018 08:26:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181130152430.GA3107@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/30/18 8:24 AM, Christoph Hellwig wrote:
> Various fixlets all over, including throwing in a 'default y' for the
> multipath code, given that we want people to actually enable it for full
> functionality.

Why enable it by default? 99.9% of users aren't going to care. That
seems like an odd choice.

-- 
Jens Axboe

