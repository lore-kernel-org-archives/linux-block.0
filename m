Return-Path: <SRS0=qPv+=4N=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3398C35E01
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B032084E
	for <linux-block@archiver.kernel.org>; Tue, 25 Feb 2020 20:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgBYUYe (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:24:34 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46829 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731565AbgBYUYe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 25 Feb 2020 15:24:34 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so717309otb.13;
        Tue, 25 Feb 2020 12:24:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SarAUtwSg/du3J2AkC0iqKUiVmVTqsDv5t7WA8bnfZJvWzelWPe+bORPKJbA7yxEGV
         aE8na/uE2+zJo9unRXvVxRxA3P2jhuQTGdc0iP6jcuXQZ9decqzCNMsd4mp7GXJxkxiK
         4OPhbSwBTFqrKJw4HcXUlruDflQw/cLpR5/ud/U+ABmuKtFq06Y0hzCoy2+dKvEImDIS
         mIv4yD82LiyLxst1iBRLaIrLFUUbg1IoOnaBdcMWi69/NfVvnkUic5SsFoopzTLk/KSM
         l5tGpY9CrLnP7FVlVIqdOuHiNEfZ6dRHPJBiFrXBB/fH0kk35d3s9+yvOZn86EajREky
         ArJQ==
X-Gm-Message-State: APjAAAXV/pHYEyGWsWH+wrkPEnqTOsbD8pnD4WvyWmzttrUWdVEPNW5m
        0m8AwX4IAjRSu727Ifa8zHM=
X-Google-Smtp-Source: APXvYqx5EGiLCfIm35x2UQKiBboqPVfPqsypKW8ua6yYrgulykDBfuhSzfywyh1HFj30yx2LA9MC4A==
X-Received: by 2002:a9d:76d6:: with SMTP id p22mr294967otl.37.1582662274074;
        Tue, 25 Feb 2020 12:24:34 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id l8sm2643863otn.31.2020.02.25.12.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 12:24:33 -0800 (PST)
Subject: Re: [PATCH v2 4/5] drivers/nvme/host/core.c: Convert to use
 set_capacity_revalidate_and_notify
To:     Balbir Singh <sblbir@amazon.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     axboe@kernel.dk, Chaitanya.Kulkarni@wdc.com, mst@redhat.com,
        jejb@linux.ibm.com, hch@lst.de
References: <20200225200129.6687-1-sblbir@amazon.com>
 <20200225200129.6687-5-sblbir@amazon.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ef01984d-1052-70cf-f0b9-d46557c2af51@grimberg.me>
Date:   Tue, 25 Feb 2020 12:24:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200225200129.6687-5-sblbir@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
