Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_POST,TVD_PH_BODY_META_ALL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD636C43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C2420663
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 17:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mS/ZmBRO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76C2420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbeK0E2W (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 23:28:22 -0500
Received: from mail-it1-f172.google.com ([209.85.166.172]:37284 "EHLO
        mail-it1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeK0E2W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 23:28:22 -0500
Received: by mail-it1-f172.google.com with SMTP id b5so29057519iti.2
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 09:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bN1B9nhrhiTri0BadmhfrZJG1XQqtqjlCYbXrfpUSH0=;
        b=mS/ZmBRO4pAsZVSD6m8Bc/Jfo4zKMfVd0oHqUMaCWOwKtRch37JtrhlKOZCIMHUBVv
         2qWtW+SObngwELs6AMcUd6V31BGJYRHAFB18/Kvv4ZWVt1Z+eFDS7bqutepF4OBFSZlX
         eycGeI+bqsAbReDdaMbY2d4BIZ6CPa2MZqR1W6YpIieEkrnLlzGCIS8vL/SEzpjGchC0
         CPU4qkhd95esH7Ts2aKZOXsMdtuumm+6urQtIcx0BFM7pWTEV5jdQJSGfWYdQ7kkRtX2
         uJe1IHODf7Cc26vo6qZVP9QUBLPExqiuBty4KGN47OLGtFXP+D5ecVXGaTFaP5ZCQKXr
         Ckxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bN1B9nhrhiTri0BadmhfrZJG1XQqtqjlCYbXrfpUSH0=;
        b=Aw4nBof9xHKd6YvFsvcIePUc2OFRsgsZeORqmU492gkmsKyrSK2KyN8QEF7Y95s4Vg
         hi8GWIXK9RIEm8UrAHDzO5fNy3MA+cM3XCOIC0iqQ3i8N430tPCaOllejDlTkEEponIz
         UsVtY/fMViPMnXoXF4r9WCwQ8VAt3vX4ePP3hNJ6TJNLS2z+eq5IWgokkDOnkx45PYtW
         FzUCoOYyjQT2xpRZfrnsor2OA2CzWsfCcrCKI2/LyCAU47gtpF1WaHzrO0gQCq6zGS8s
         uosA3UU5yR6CFHomU90/WsknStWNGh0MnW2MR4KKejRl7XEwIq0O5cDYJXCVjfXJu0+W
         HL1w==
X-Gm-Message-State: AA+aEWYWqziuvgq/q2KdY3fS3c+EQG4HUL6vuJuc7Ze4DFnJwPxOK0yT
        MCbQOa8Ksdlk9+17PiT1wkAJCQ==
X-Google-Smtp-Source: AFSGD/Vhz926GoB1i/hdrjzwmmCTBbRAqmbHKslZ/n8dDh6O+sUJEUI90MM9/jVGf1qB+eiujQtvQg==
X-Received: by 2002:a02:660f:: with SMTP id k15mr6068264jac.38.1543253614679;
        Mon, 26 Nov 2018 09:33:34 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t129sm611149ita.4.2018.11.26.09.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 09:33:33 -0800 (PST)
Subject: Re: [PATCHv4 0/3] scsi timeout handling updates
To:     Keith Busch <keith.busch@intel.com>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     Martin Petersen <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>
References: <20181126165430.4519-1-keith.busch@intel.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b9813c10-776f-46fc-15d4-bbd675edc402@kernel.dk>
Date:   Mon, 26 Nov 2018 10:33:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181126165430.4519-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/26/18 9:54 AM, Keith Busch wrote:
> The iterative update to the previous version taking into account review
> comments.
> 
> Background:
> 
> The main objective is to remove the generic block layer's lock prefix
> currently required to transition a request to its completed state by
> shifting that expense to lower level drivers that actually need it,
> and removing the software layering violation that was required to use
> that mechnaism.

Thanks Keith, added for 4.21.

-- 
Jens Axboe

