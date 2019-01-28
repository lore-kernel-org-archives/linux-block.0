Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB48BC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B48021741
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LHOOLUs6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731662AbfA1REf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:04:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35579 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfA1QNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:13:50 -0500
Received: by mail-it1-f196.google.com with SMTP id p197so20182660itp.0
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 08:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+p5W5b5YhPrIyuyCVbbojm99T2mgbhXRvn/xv6F8hBg=;
        b=LHOOLUs67vNUfNi5Pzr8IBnyrJhJommQ1wD5/dXSHxV1e/Byqypw7l9HuPdUV7WR08
         KsWUsDXwHqKg8ndKaZsl1KbPwhjukst2dF1zktma6b4bUae6azVxhF4KZWJIzRLgdKxO
         ISFVbR+oc3QoNrN4Uhx/yPNhmnGSV7mBhSX/iWuZtYPp8CBtP/Dgr7Aq4LG6/++RpbwK
         UuuD9FkWGVmtv876fiQCugajMe/BOGm9QlrwLHTdFVnfSVvGzagltwflHGVJKWst0Rkj
         9WU3wCq1ptu/twdSHc3ROglEV2YKhxErErvWG53v2k88IJOFlRN0Jd7orUoaPJJp557S
         ZGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+p5W5b5YhPrIyuyCVbbojm99T2mgbhXRvn/xv6F8hBg=;
        b=dEG+yaoihPx0tbXPLtZo7WYRsyc79UBYQXrA1USFEyoe5lJgu4pEg7/mx+eJLJP/7B
         T/s4hthqGvr4b4WmRtJhQW1n1Dl+9wh9bVZ2O+PovSn7DIJzU8V+Zg6F6jk0RKY2Xdn+
         THFz0YtN9UpdnKFwPveJwi4IlnRh80gUdUhXnN6xXoSk8yzAd1dZMPzNM/bhN2obspvE
         UcQGuBLhtmM/WpMvAFFNbCAWHQjyhlxfMiW/lDNMyTpWN38YVrdzS3kD41ubL4nkYBhI
         C+XwBC0+TPzxH7lTRkpbTcISyE9VaW+hpaYrljMtRKKZHBsIrU+4Ve2SEGVmLRSVoRan
         hJZQ==
X-Gm-Message-State: AJcUukd8ozVgRXnG6ccxV8I+f5ERCeRvxevBEGgAxH1uOCUl/Sf2efPX
        w9eFsErXSVJsR402OUnl9ODvwA==
X-Google-Smtp-Source: ALg8bN5ZYKWcFCnpQucCEYxuUVeg2pHwNa7dTDEjAoiUjUj/9OWVGhnpo2vO/jnln3PhDA5U2MpdIg==
X-Received: by 2002:a24:9fc1:: with SMTP id c184mr4965115ite.8.1548692029125;
        Mon, 28 Jan 2019 08:13:49 -0800 (PST)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t69sm17265685itb.26.2019.01.28.08.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 08:13:48 -0800 (PST)
Subject: Re: [PATCH 01/18] fs: add an iopoll method to struct file_operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, jmoyer@redhat.com, avi@scylladb.com
References: <20190123153536.7081-1-axboe@kernel.dk>
 <20190123153536.7081-2-axboe@kernel.dk> <20190128142559.GA9563@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d436182b-9da9-2141-0e6b-db733c66269e@kernel.dk>
Date:   Mon, 28 Jan 2019 09:13:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190128142559.GA9563@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/28/19 7:25 AM, Christoph Hellwig wrote:
> On Wed, Jan 23, 2019 at 08:35:12AM -0700, Jens Axboe wrote:
>> TODO: we can probably union ki_cookie with the existing hint and I/O
>> priority fields to avoid struct kiocb growth.
> 
> Please kill this comment.  While this should be doable the semantics
> would be a bit nasty, so unless we have to I'd rather skip this work
> for now.

Agree, killed.

-- 
Jens Axboe

