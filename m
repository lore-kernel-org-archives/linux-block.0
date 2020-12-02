Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A891C71155
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35DD722201
	for <linux-block@archiver.kernel.org>; Wed,  2 Dec 2020 19:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgLBTp1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 14:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLBTp1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Dec 2020 14:45:27 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51E0C0613D4
        for <linux-block@vger.kernel.org>; Wed,  2 Dec 2020 11:44:40 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o8so3215676ioh.0
        for <linux-block@vger.kernel.org>; Wed, 02 Dec 2020 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyEPDAytTEl0uopebdyNHFfe+27dQnLC51NhV3dnBlQ=;
        b=OBM1e4X4T5ctyaC99rN18qygJBuxT+Na4CBNEK0YrhauMduyrFTBQhoBjaEMQ9gkgP
         RJDGNWlQZUoeYB18Zc8lohe07PWMzXOXi36725jdFTsya/BtObnqro1yRkyJ+pPO4K4m
         2Key7R6FaAFR5VWNEtq5Q8UX8qafo/GEDz6cEwX68EMT3OyNwoakm1ExLrjmVVqzAkX5
         TeGUe2RLSQvwYYvowut5+1w4CA2CMErINS9xnd5OutfEFUpKZ1U5Rb+h7ImZFTFCrloo
         BhBk8q6z//pFqFhMRW75a30MgVsZ0ZSTKti8GAxpWsA4PNnPv6iHFpneacE6hFIqcjsz
         uJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyEPDAytTEl0uopebdyNHFfe+27dQnLC51NhV3dnBlQ=;
        b=nGb8qVrwgzEFBc+eDusHSTjIKT7iV6XanS77CDS/VtcH/dbvNiHH/fs/rANTSylP/n
         ob7btXPnjU87NmzIEjLl52ENvHNCv2zCW16q2J1Y4MOtfY178CdYef+uAzcwSaLThH9w
         OIS5UDZuxqjg6t8F1VWDQRnEcD6Y74Ywq4po2e6JJ1VS0isK8j9ZKGLLyeXlCRw19qbT
         Y2LE0oOKracswoPy0nqxCd4SBRUH59h7s42V/uiFfGRb0iiao4qg371Wxyd4R1Nv5yJJ
         LmLdMlLLeeqTMyLwoYoG3OoffT41Npdjro5dn20sDiTuY1w7/YMYBwN53XQjHmtVEzh4
         +DgA==
X-Gm-Message-State: AOAM5307qj7pzIydjZinHz4/OfPPGd5sxdzxqW6ruaqzspHrDemWzkGe
        of/L/HK9L/v6t2EzSnilg2wSug==
X-Google-Smtp-Source: ABdhPJz8UN2fY5APc9Sjo+vvBdGu2jQKXfD20JyDILa/0y1RXXAbuPmiCHQzcqnjlgbJWrFl1+onVg==
X-Received: by 2002:a6b:3118:: with SMTP id j24mr3303413ioa.171.1606938280197;
        Wed, 02 Dec 2020 11:44:40 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z18sm1157219ilb.26.2020.12.02.11.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 11:44:39 -0800 (PST)
Subject: Re: [PATCH] blk-throttle: don't check whether or not lower limit is
 valid if CONFIG_BLK_DEV_THROTTLING_LOW is off
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
References: <20201126031834.40807-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51844d83-3447-cf0f-bde2-d368f5f43f5a@kernel.dk>
Date:   Wed, 2 Dec 2020 12:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126031834.40807-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/25/20 8:18 PM, Yu Kuai wrote:
> blk_throtl_update_limit_valid() will search for descendants to see if
> 'LIMIT_LOW' of bps/iops and READ/WRITE is nonzero. However, they're always
> zero if CONFIG_BLK_DEV_THROTTLING_LOW is not set, furthermore, a lot of
> time will be wasted to iterate descendants.
> 
> Thus do nothing in blk_throtl_update_limit_valid() in such situation.

Applied, thanks.

-- 
Jens Axboe

