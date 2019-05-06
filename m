Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF62C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB7E2087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVtEISd8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfEFQyS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:54:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36845 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbfEFQyP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:54:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id cb4so2735827plb.3
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 09:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KCEwrmU0WXfK4atvqThwEnw4yweGWf/NWKBCEgr7l14=;
        b=VVtEISd8kVc5rlPdF+mZWA81XMq/W5DTFtorR+2CvKU2ht/SZDDP3k4/GtF/5co+5x
         ouCRIr9lGEYjmCi07bW+9pvG78SfTtVuJPk5ee3d1mz9ejfdnULNyWLTcIyFkHNfxKe6
         6TxLTh9qM/Pun6UIaHvmFrJNL4MprtMFrepis1FkWY1K9FAleDp4XCpFGLcIOFWL/rfC
         R3kHoHZ+ANqoXcezYatpah2FE8pZ5hT0aZPcy0NZ1dYnDYgH3lME2AGLJF/SUaSM4Klu
         e6p0FcFzCV56yLydglu1xcN2paKOXU1jdIqb2rRKBNTJHK/HFUa9enW1EGzHP3zSs1pF
         7LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KCEwrmU0WXfK4atvqThwEnw4yweGWf/NWKBCEgr7l14=;
        b=pQknImQXqCCe871iswBeoKHGibsIzrsrq09j8rGIfq06j9nKNWI6vPj05skIV65/AL
         etgKPOnJsrJfsw6YzdNwJ6sbU0ZWXETz7hemiPWEtkGHRFdU+RsvQ68IAbfSmuYONkRK
         4gCreWHos/PU0A7dP4iiw4F6c8COxZyFKQ1rbtoMK7HHtXnkL3NQoKXLATLcv/1FfbAK
         t7/DgI/6BTJP0my7CW3fn0fbZhl/2O8bT4JlT/RPfxPP7brsdRsQOQnz/FuEfP8zFo5y
         N+g+ox+kYCZHr8lHH026Sde84prfZG6Z4gIAN0+xknweC38q7r1chikoSIWsVeD1hcXi
         7SAw==
X-Gm-Message-State: APjAAAVlp+9hC3/+jJ7fN13Azztj1QuN4mQIUcHadQtG56Ld8fqgYRkI
        Ajbywbe4OlzqPOWZy9AQV08=
X-Google-Smtp-Source: APXvYqyOcTkcFfVsQy6lsNiOQwe/uSzxHEEc66MzeSc7kTFyzoO3k2eaJ/pE95fgn4pIQpzSEzzpIA==
X-Received: by 2002:a17:902:9a46:: with SMTP id x6mr33034506plv.71.1557161654227;
        Mon, 06 May 2019 09:54:14 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id c19sm13731453pgi.42.2019.05.06.09.54.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:54:13 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
Date:   Tue, 7 May 2019 01:54:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> We need to get rid the string comparison as much as we can e.g.
> in following output the nvme-cli output should not be compared
> but the return value itself.
> 
> -Discovery Log Number of Records 1, Generation counter 1
> +Discovery Log Number of Records 1, Generation counter 2
> =====Discovery Log Entry 0======
> trtype: loop
> adrfam: pci
> subtype: nvme subsystem
> -treq: not specified
> +treq: not specified, sq flow control disable supported
> portid: X
> trsvcid:
> subnqn: blktests-subsystem-1
> 
> Reason :- we cannot rely on the output as it tends to change
> with development which triggers fixes in blktests, unless
> testcase is focused on entirely on examining the output of
> the tool.

Totally agree with you.  nvme-cli is going to keep updated and output 
format might be changed which may cause test failure in blktests.

If Johannes who wrote these tests agrees to not check output result from 
nvme-cli, I'll get rid of them.

By the way, Checking the return value of a program like nvme-cli might 
not be enough to figure out what happened because this test looks like 
wanted to check the output of discover get log page is exactly the same 
with what it wanted to be in case data size is greater than 4K.
