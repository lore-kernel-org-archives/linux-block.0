Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE48C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C873218F0
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:05:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Yf182AZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733231AbeLUEFG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:05:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35667 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733203AbeLUEFG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 23:05:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so1880077plo.2
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 20:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QzmcpQ8aMMNlOMPemWqDPeZj/ggK2HDlNy8vLAIJiYg=;
        b=Yf182AZEsKhSCtSmFLogX3CGX6V8sEKK9Jueig8eAmQttn+HPLlZwRweVEPegeYcjY
         gfxxuDPDfWkJmbqzvpYwHVQSqDkVb5K4ui6bGlrPADij5MWrhvKD7TlZZad2MC4Jeo0g
         eKPMuJhuVdc2srHE/G1wUJR/mdE3uMOh+84UlqR4h/Hq7K7dpHnIbE6RcSnhdMYUfJ4x
         JQIEVL4ux/LJuX7wtCPsqWy1R/zaerzAoE44NTpmI9xuZh59cTXYXHFAczM1kghnrOc3
         uNyCKFNyXG3JB/scrU7pmaLIy/kAH2YTjx29zd5OBQJLzJDb1Y2rWy9v1SRBlc/n7gNO
         +eSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QzmcpQ8aMMNlOMPemWqDPeZj/ggK2HDlNy8vLAIJiYg=;
        b=Iden/NVqDKp+myk0VQxrNLvn7dwftFnk91kiXgQFUhFrPIvm/nrYiElfXnmHYqlsTO
         K44+7Z4Ayc0pTeLtjx0Mp9MoGZ2c86leQneHgSwGaBLm9UbTgmasktrbjlLcGAsLzrf3
         ytLHSU+IzQ9oo8GOKAT2v5k6UCeNniTpNb4usV7DR9ixxo6FZJk5SWHf1DlXNbqYmaZt
         jMGEcSk1G2HXVX4rSUls4VfUdKzQ7nPNZZX5Y19AjnbohmD5opqfsT6xmJysuXk5Ee6T
         Ok0DePfbZROVI7FDop+YQu1azH11goy7Ib6DeQY8qkfq7KTdtWh1xY99bUzFu6pfkMtv
         eq0Q==
X-Gm-Message-State: AJcUukfiytEU9Z4fE98PzBuXVVKAfsc4h3EOZEIvZRLhenzg6Okw4VfF
        8tW1swu9CJoTcxQ7WE23vqjfgsOWHujB1Q==
X-Google-Smtp-Source: ALg8bN6R8ThilkceVBlmVpyGC7lx9WFvEveWl4fAEGYilKfchYKgEMKpOSGv0m8aNoCTkLV2e4zhnA==
X-Received: by 2002:a17:902:6f09:: with SMTP id w9mr936663plk.309.1545365105820;
        Thu, 20 Dec 2018 20:05:05 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id n21sm31443922pfg.84.2018.12.20.20.05.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 20:05:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Aio changes for 4.21-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-aio@kvack.org" <linux-aio@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Message-ID: <947a6dca-5ba5-c8ed-8e64-3cede8fcc028@kernel.dk>
Date:   Thu, 20 Dec 2018 21:05:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Flushing out pre-patches for the buffered/polled aio series. Some fixes
in here, but also optimizations.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.21/aio-20181221


----------------------------------------------------------------
Christoph Hellwig (1):
      aio: separate out ring reservation from req allocation

Jens Axboe (6):
      aio: use assigned completion handler
      aio: don't zero entire aio_kiocb aio_get_req()
      aio: only use blk plugs for > 2 depth submissions
      aio: use iocb_put() instead of open coding it
      aio: split out iocb copy from io_submit_one()
      aio: abstract out io_event filler helper

 fs/aio.c | 144 ++++++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 88 insertions(+), 56 deletions(-)

-- 
Jens Axboe

