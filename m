Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51272C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2390120678
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 16:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="oaCWuswN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfIPQND (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:13:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42333 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbfIPQND (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 12:13:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id z12so260258pgp.9
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 09:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ngns2aZQDk8lD0GtZWORQNTVK+rxzxi28UBcZgbJoZA=;
        b=oaCWuswNbauDH2oisRLajp7tOrQT2Mky1p/Uxd+XPFP/qlKb7uU10XrbSkartWxxZb
         mGr1lVC80Fn7igRf0Tj8vVKu33vjSWxbZ9unCFA1sDVN0XhIMu+yiGKSdU/klp1RsVwG
         Mn40XdRq90F6W9tbzdYjCy0r3IvlOS5qCKhYtcG0ACXeh2ggzXyKG4nwH84smstPh6DL
         2cfhwg6WOARdKBRyeqXF4HX2kyCVxc4OnBPGuvGd4eoawPcJqBhFe1QKNFK2v8aDPmxu
         pawlgzO2SbT4HOEk4Cc7HjNTb1qRLNNRollHEZ0zlqQPm8Z26qYorHH8xQ/DQlC6dnCO
         Ck9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ngns2aZQDk8lD0GtZWORQNTVK+rxzxi28UBcZgbJoZA=;
        b=gJI/wxgTLYz1dkq4Ea6i8BKEJZhrtu1Q3ZiT5jaN+2KXyRMnQU/WYEMb8zl069yF0h
         byQNSPO5o7VlFfC0CXqcDQoIInEbDgwCIz8MlfefSF/53tNTXP4frCK+VHkPSdS/MygW
         sXPk8dfI+MtU1rPjH9PyPGzRA/UWA9faQUti8XPG8URwJefovzq3Mgey7qdwcH0uigLC
         2xKOtXcf3IvEdEHqFnjkor4QtXQI6SY2YGLRbXGD6FZvNxb+6xq4m3GZccFWDZSOLWNt
         hTaXOst09o7OxQz3in/GJLxXde13SSUswoktVGRcOQ9wV1RiLyd/Ysr+ASxhI+OhduxB
         7GPg==
X-Gm-Message-State: APjAAAU9xmjxP9wQ+obBN40jUwrtu//3Y1nT7N90BTza3LNDk3GTMRfc
        8oeqg8Hlam9/3Ftt1Xo2r2nAjQ==
X-Google-Smtp-Source: APXvYqzoI1MIdwgXIaldAvl4WtNnSZXN+zP3IjYUvchSSGvKCwmOB6fBDixfPEPrUt9pUC7czo7J/w==
X-Received: by 2002:a65:5348:: with SMTP id w8mr56564593pgr.176.1568650382556;
        Mon, 16 Sep 2019 09:13:02 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:c484:c1a1:f495:ecae? ([2605:e000:100e:83a1:c484:c1a1:f495:ecae])
        by smtp.gmail.com with ESMTPSA id h186sm70982796pfb.63.2019.09.16.09.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 09:13:01 -0700 (PDT)
Subject: Re: [PATCH v7 2/2] block: centralize PI remapping logic to the block
 layer
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        keith.busch@intel.com, hch@lst.de, sagi@grimberg.me
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1568648669-5855-1-git-send-email-maxg@mellanox.com>
 <1568648669-5855-2-git-send-email-maxg@mellanox.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f56d2bef-93f4-95b1-b607-d97396626359@kernel.dk>
Date:   Mon, 16 Sep 2019 10:12:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568648669-5855-2-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/16/19 9:44 AM, Max Gurtovoy wrote:
> Currently t10_pi_prepare/t10_pi_complete functions are called during the
> NVMe and SCSi layers command preparetion/completion, but their actual
> place should be the block layer since T10-PI is a general data integrity
> feature that is used by block storage protocols. Introduce .prepare_fn
> and .complete_fn callbacks within the integrity profile that each type
> can implement according to its needs.

Two notes (for future reference):

1) This doesn't apply against for-5.4/block, I had to fix it up
   manually.

2) For more than one patch, always use a cover letter.

-- 
Jens Axboe

