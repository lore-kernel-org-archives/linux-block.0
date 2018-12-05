Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F940C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E17A20879
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 16:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gPrR40wf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E17A20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeLEQbA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:31:00 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36205 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbeLEQbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 11:31:00 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so21148368itj.1
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 08:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=89Cfdh56mCZ6uWYbtKK3gkegK+scCCxk2U5whdwmvEg=;
        b=gPrR40wfwHciZiXwX/p35zcJjS8Mtd0TBPtjUo5PU/r6laQJe/Nanehl0rCqCPSJM6
         sUPrfB2nl1SYVl31YFdRj2Hysl3c9rxzx182YNY9Lion//voK336QOsejXhF7DLN8r8t
         rZ4K40OiZdVv79z7hrOK+mTILjU0TwBQRlk8hQLYwIBdrPrphhc2sLgQSkje07528kS5
         pBEuTatyFfWodaj5hhJ6Z6YJrRZMTKBS6B5GrtNsd9giL1AmIKEMNdsucXLgXBYFQHs7
         gFMxzCQrUA32AGbXtscxMAWvGpkLuZwrK2Ol4PKRWXKJbcHTnw7KtrDEKu51URnJ+0U4
         DuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=89Cfdh56mCZ6uWYbtKK3gkegK+scCCxk2U5whdwmvEg=;
        b=LD5dBq5k6aZBtMmgMB3k52go/oK3jLBQRFTWgjiFxhJcBq5tRIkIaq/ax4dbD2o4Ov
         YKqwT40yQFuWuGfL4ahvIZvLX/CvzoGRCX1TUArTGDm56kwrbuCSQ8C4eheAhIAaK+O5
         JxhykwW2erHFV4VE5QF9cllPXI1WXSAqOzLg/HkPBnvvGtZ17YpKRPc08wl3lXNaPOE8
         6+2JmG1iumrjepaXvxKqFMArVY0/ugal//DENxQItccw2Zd0+5O7r/tyM6rsbHSzqeKm
         2s+Jn5yOyVKYtmJuBBTBYzNaAnRVFqPoOObzDFLKKLMiOwcgpneILk9ypqz9UaR14/ta
         6HzA==
X-Gm-Message-State: AA+aEWb7avvx9M3hrCEaPIqykh4gkJ5wBxTiJvGUjUE4riKGqQgkhhxu
        EfS8cG44fnpNWxwdLDaj9yfeSXwtsac=
X-Google-Smtp-Source: AFSGD/V13eJUY4j4HmcpmVUfr1HIisfBQyw2TyQzNPZmfrBTWWrGY5cm/owMVtkbcUrL1n9ADRsrQQ==
X-Received: by 2002:a24:553:: with SMTP id 80mr13382075itl.76.1544027459843;
        Wed, 05 Dec 2018 08:30:59 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id e16sm8621391iob.43.2018.12.05.08.30.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:30:59 -0800 (PST)
Subject: Re: [PATCH V9 4/4] blk-mq: replace and kill
 blk_mq_request_issue_directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1543995842-20704-1-git-send-email-jianchao.w.wang@oracle.com>
 <1543995842-20704-5-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a2b3bf6-c112-de40-ccac-da95b22679ba@kernel.dk>
Date:   Wed, 5 Dec 2018 09:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1543995842-20704-5-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/5/18 12:44 AM, Jianchao Wang wrote:
> Replace blk_mq_request_issue_directly with blk_mq_try_issue_directly
> in blk_insert_cloned_request and kill it as nobody uses it any more.

Looks good.

-- 
Jens Axboe

