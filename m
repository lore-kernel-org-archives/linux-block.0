Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EFCC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386C6206D4
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 17:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgFWRnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:43:12 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:41372 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733210AbgFWRnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 13:43:11 -0400
Received: by mail-pg1-f176.google.com with SMTP id b5so10172275pgm.8
        for <linux-block@vger.kernel.org>; Tue, 23 Jun 2020 10:43:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=eOykswMPEGcxTFuFFItlTF6Jr3LxYnfZ/ezjLnUx58dv7CuP7FdKtBMyn6UI8uBy1Q
         6k0jJDrhAJj8/mgWsQz+9V1fj5jb/+lB2NpIzD1hC/MGgEjayaD+hIHAeOaxTSFarCC9
         zdYqbnvbYOwl5iouKIdFC6YqowB1jQ6XAujudDOnvSscVxz0L/WwqM5xPgoDZrK1gari
         J5mMPgiMhH80XG58Gf+5qa/JDbenC+0uGe2OaFZRbw9pu4YRo2+JdxyDeY0F97Ofka0y
         6QnI6U44R9RzrpYeMxqhjWjqJrjWlw6qkZ84emlTVs5ceu2HO6JmgW3EziLZ5NhCuLfL
         bmxw==
X-Gm-Message-State: AOAM530vzL/PI220Oatle4PEMEDDMzkEJPqzp9Ia8lVEDTwwvgUmOuyl
        Q7FDMN8s9/gavBa2JcEt8xE=
X-Google-Smtp-Source: ABdhPJzvOrvwr2DLTVVIde67x/c775RYVIHNXY8NHcSVpga+reIuikFYQrsLZ8mW0Kxoq9kCLhz+EQ==
X-Received: by 2002:a65:6846:: with SMTP id q6mr17025054pgt.397.1592934191009;
        Tue, 23 Jun 2020 10:43:11 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:acd7:a900:b9f:8b8b? ([2601:647:4802:9070:acd7:a900:b9f:8b8b])
        by smtp.gmail.com with ESMTPSA id c9sm17759079pfp.100.2020.06.23.10.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 10:43:10 -0700 (PDT)
Subject: Re: [PATCHv3 4/5] nvme: support for multi-command set effects
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        hch@lst.de, linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Keith Busch <keith.busch@wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>,
        Daniel Wagner <dwagner@suse.de>
References: <20200622162530.1287650-1-kbusch@kernel.org>
 <20200622162530.1287650-5-kbusch@kernel.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f78451a9-0df4-58c9-2398-bcec40dcddab@grimberg.me>
Date:   Tue, 23 Jun 2020 10:43:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622162530.1287650-5-kbusch@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
