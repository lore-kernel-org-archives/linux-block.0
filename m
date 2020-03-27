Return-Path: <SRS0=yDPB=5M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A955C43331
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC9D21655
	for <linux-block@archiver.kernel.org>; Fri, 27 Mar 2020 15:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DTBPwCtl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0Pfs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:35:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34762 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgC0Pfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Mar 2020 11:35:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so4689260pfj.1
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2020 08:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HJ0d5xYgpclWdukH1jBaMHibnM4HFjumRZhUN1j7yw8=;
        b=DTBPwCtlux/hfF4agATg2qvTk+b+c1bkx2spbcCWUUfhBD61qX2X0Ir0cu6yw2CcE+
         5sHF9pl6W54fmNaxjaBVcaVzuULy5f67trQpq9P8c/vAAqAnCuG2r3On6S7WfELnxMIb
         hAq4XTTMUdbV8j+sOI16se8sTBNuIml5GInBSdaxWd9QaoC4oj5kMAyprQAPzbIG9vYG
         m8VgPm50scOxrv7LX9TI00U53xqMuBJ1DBnDytaDpyLWEilz/KWUYtvzLSApCzVssFLS
         lu4MtXtE+0mhYuzzaVYveadJSjr1z7rIbfr18f7DXxtMHxPTc4/lyGUGyrY9H9kVRuqs
         ZzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HJ0d5xYgpclWdukH1jBaMHibnM4HFjumRZhUN1j7yw8=;
        b=BwUoziB6LJckBw+RVDFFhea57Qs/Z3OKpgP9Hzj5D+DTTmcGaMPYZxL+URy0e2ggMp
         u/JBr4IYV6Wg+ncrdVsZLiZf7d5tBFqDXV/XMSXxu27RcMG0lg57srqIOP1JzzxIoA0g
         HjqXZImuIYyRrY4nolFZWR4E6eGQ2t047HseCD2T34yCs8BeKt/TDYDlo+4RgFNfa5rt
         8tfEqzQuI9tDJmd3F6GTMTp8wf4P8t3wjc02RQxwifk130wEyACsR8+B1LFxKEmlYXUs
         WGN5CZvf63uwm9BBT+hhispYY0DZwhaMhcJVek4pOtvYXYLPU15DASNJlIyLzO0NWGxM
         hhuw==
X-Gm-Message-State: ANhLgQ2nzaZzK1tMvQjQbH3qT275KnVkNkr5bIO/AtTj4iS6Pn7Ser/c
        BwrenP3SW9PRv0XLtFYlCB5yyg8G8Hu9eA==
X-Google-Smtp-Source: ADFU+vtk89VsSlqoAF6Yvan0HPV5HceGZiJSw5/NdFckfp6cNfU8iC1AaFYNNwf7msEkMnYBvEfJuQ==
X-Received: by 2002:aa7:97a7:: with SMTP id d7mr15209248pfq.194.1585323347322;
        Fri, 27 Mar 2020 08:35:47 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id f6sm4544602pfk.99.2020.03.27.08.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 08:35:46 -0700 (PDT)
Subject: Re: [PATCH V3 0/3] null_blk: add tracepoints for zoned mode
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200325021629.15103-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <093c4ab1-924f-b109-31a8-ce5813f52e14@kernel.dk>
Date:   Fri, 27 Mar 2020 09:35:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB496594887E19F1C972CEC9B786CC0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/26/20 9:12 PM, Chaitanya Kulkarni wrote:
> Hi Jens,
> 
> Can we get this in ?

There still seems to be the unresolved issue of the function
declaration. I agree that we should not have a declaration for
a function if CONFIG_BLK_DEV_ZONED isn't set, so move it under
the existing ifdef.

-- 
Jens Axboe

