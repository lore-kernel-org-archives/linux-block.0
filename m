Return-Path: <SRS0=Qcaa=SK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADF7C10F14
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6578521473
	for <linux-block@archiver.kernel.org>; Mon,  8 Apr 2019 14:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hbwLO92i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbfDHON1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:13:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38286 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfDHON1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Apr 2019 10:13:27 -0400
Received: by mail-pl1-f193.google.com with SMTP id f36so2933928plb.5
        for <linux-block@vger.kernel.org>; Mon, 08 Apr 2019 07:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5F2ipcgTQZ7/1Fw8SnxsdTFozbBZBBzMmzasQqL+rMI=;
        b=hbwLO92i8RUzbqy6pagrY5BTSMka6GF3D07cuH+x3CzssOfbgTJOoub3wSoDoM/SyY
         CgArUVK/FQ1dn31aBfum7F7kZ4E8suWHFJFiivhC4ekLTmHYOxO8VfRcUMta+E8blNgA
         rSOsCosQM20ykMD+6JAY54DmydOGPqfy9qnI3FZLNQP5mYr2qe0990Z/6KOHuYg2LsCX
         TAjP3mbA3oDUuFDIyWmU3uANzIbbfaCoxdCIsQO1bIolgUJT9gcz75DBUa7tZLG9VD7g
         4VM7s76x1+yn4F21H50t/vjq7EJvOBneP7wifhKdCzzLm+NwEQpeSQ4t7dlkoYkPGzO2
         8EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5F2ipcgTQZ7/1Fw8SnxsdTFozbBZBBzMmzasQqL+rMI=;
        b=P0bVgyMJe1BDluj+UMWmfILMK48/c5CXLTo2a03lx6Y8q33GHM+3mYZXPYEmFN7pGg
         NDmQoZ7PfI+n6BaPWCdmraRpXdnPafTEcVk/Gk1NnInMt9Ctif/fjM2Tvwihoba0A50G
         JmxbxLijgDyj/nSbCxg605MWA9mi49XmASd1Kd+b63If1Hd5QJeyhZGpML1gCQK+VOUT
         SZcl5Qf078GBhzJPcUwhNErz0Z2x1hz9e4iQAuPG+Jh+5ZOvJ92zNnq5S11xgEsihHH1
         MRz66KFM6Dm1003pZeAXOa1V8mBgRuHb5Zoyh4mHw109m9uMxt2kIpLgAmncCaGYoHDm
         btDw==
X-Gm-Message-State: APjAAAWTsI8mpMdwLCL1crUzpV2Z8H3Krm/06p/EmRXeSY/7SGzzJh5v
        ZqXUSE+wgY5CohvcxR5XjM9b/McOUK093A==
X-Google-Smtp-Source: APXvYqyDm73WyRXkoz8HOgUvee77j8cBScVDeRJwQrf6BuaZS6fX3a1/J+SBnOEwA+CKmy3m9+TlRQ==
X-Received: by 2002:a17:902:3381:: with SMTP id b1mr30657604plc.5.1554732805604;
        Mon, 08 Apr 2019 07:13:25 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id y5sm34479896pgv.15.2019.04.08.07.13.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 07:13:24 -0700 (PDT)
Subject: Re: [PATCH] block: remove unused variable 'def'
To:     Hisao Tanabe <xtanabe@gmail.com>
Cc:     linux-block@vger.kernel.org
References: <20190407152742.30821-1-xtanabe@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da33d12d-c28e-a395-c927-5debd301e5fb@kernel.dk>
Date:   Mon, 8 Apr 2019 08:13:23 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190407152742.30821-1-xtanabe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/7/19 9:27 AM, Hisao Tanabe wrote:
> The 'def' local variable became unused after commit f382fb0bcef4 ("block: remove
> legacy IO schedulers"), let's remove it.

Applied, thanks.

-- 
Jens Axboe

