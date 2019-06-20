Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC0BC43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573FF2083B
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WHOwtRFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfFTJeQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:34:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33453 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfFTJeQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:34:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id v15so270272ywv.0
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YKI+yTrLnHg0eyuhSApw4YTr6TwAZK0XtUwJCmBLlP0=;
        b=WHOwtRFe2+CDd/A1RnFpk6qSlT0It1PXpf1HqA/SiP+Y2CvzpknLFPsrSs64f7B2pa
         1NpN68bhl2eGmZk6aHOpgqEmFWDWVGD9jZi7uQojP+E2lEDLJLwIy+3eU2O6HowirLsr
         ZpTD8glSKc7trTRK5Hl08Dx/GnnBn23tnYuE4DnoIfOWdmd+mOOaAMo1UftyDrGVoy92
         zWA1yucU+LgpG5XlcL0CV9ktnnWrlNF5xfLhHuSTjeitOdpvMK4aXUIVK3PTYN4cp+Qd
         dHzkaZ8KVUzjtQfeq4J3GNDCZpeX8Lq9X8q/v+N5gN3QfYITE7+3RnoXM5SCiWxnGtl0
         kCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YKI+yTrLnHg0eyuhSApw4YTr6TwAZK0XtUwJCmBLlP0=;
        b=A/1i72sN0RhZLOCWzpjiL4/fDiPkzhy0udEKi6vEnB+5enysXIrfrswX4euVR4DXgs
         +yN1XBTbIpK+x4ejRTz4nMdiWW/u6FFHWwNVpi1/Q2es38NEXD8gJGYVed3Bu1Qeu4HI
         a+m/us45a7p4TuhCtr/A8gv7EysHwcxlaMKBlYZ59MBuyDI2OLlNHSJdsLXUAqZAJ48W
         JolrXkOL01dryHVX8mrEtNwq2afQdItwediPwMYDG4c+0Mf+1s0rl2Cv+rxk6F8Ux3rP
         hbpWhzun/2+XgiqA5WOpCLR1SPMGkQphhov+5MLt4/F8FsM3Jfa4SSfM09VJmE1/1nM6
         YMJQ==
X-Gm-Message-State: APjAAAVgJehLWfs80YCq75dKKeXkxHts2c7X3CkB2izjT4XTSBPNJee6
        cbrXxoqpoT4vtSJBynEf0Wtsjljml3E3tHnR
X-Google-Smtp-Source: APXvYqxjxksQSmBVaa0CiGaDBKH4u48Pxq+IS4k+S7mHiEzEA5WC4CriRk5WvtxZ/gK5KsiVogC18w==
X-Received: by 2002:a81:ae0e:: with SMTP id m14mr54617987ywh.308.1561023255578;
        Thu, 20 Jun 2019 02:34:15 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id j82sm5595028ywj.1.2019.06.20.02.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:34:14 -0700 (PDT)
Subject: Re: [PATCH 00/29] bcache candidate patches for Linux v5.3
To:     Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20190614131358.2771-1-colyli@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <61ccf75d-4a1c-ad12-489a-ad4cd75422f1@kernel.dk>
Date:   Thu, 20 Jun 2019 03:34:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614131358.2771-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/14/19 7:13 AM, Coly Li wrote:
> Hi folks,
> 
> Now I am testing the bcache patches for Linux v5.3, here I collect
> all previously posted patches for your information. Any code review
> and comment is welcome.

Applied for 5.3.

-- 
Jens Axboe

