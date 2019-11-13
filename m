Return-Path: <SRS0=BCjA=ZF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687DAC432C3
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 16:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32ADD2084F
	for <linux-block@archiver.kernel.org>; Wed, 13 Nov 2019 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573662050;
	bh=3ptigakXu87dguPwJfwVTlJiYjq/e9zI1NG6M1FBq+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UAlQLMOcgWOFtY33UW88RwTKjAEvx9OvhyQU8qp1M/VXVFlHnBDkVCVLu64og+qco
	 YgOBVP5ytQITG2fUScc4804eQ3jBPMPk2/SsE1yNCocCEMq/kbiXAqHreqodgazHeK
	 3iF6GZGlSmvn5bmnccujUyI0iJKMC0giGQZvKK2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfKMQUt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Nov 2019 11:20:49 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33874 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbfKMQUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Nov 2019 11:20:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id 205so2258774qkk.1;
        Wed, 13 Nov 2019 08:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BgjpAWhUsNd321xRdgYc+Qsl4mTKgPBuEJhT5kvzP4c=;
        b=PPgZ/DfOQB2NdizWDHzrIuVUEf8lBy5hSeDWmvmPCeyUkUklrL10lTD5KA6FChpjJk
         kPksEM7ZmApk1toieecuIDOk7KFS1fhjpApBmNvVSZzFjkvJVAQ31AuFO8iULfoM4UtH
         gYn9GmcrpKv0N74kANWg4byXvPDpLaWpHNPXCHxXNXCPiSnuJPONT3M9dRh7npXlX/S2
         l5VMxmzbf0PGS35IDtk8OvtUdhVOl7cQ0NHtyRBXPI9nkdcSN6ePYPphtWkLcAuWQs7I
         iHZ8e5FmgdP8ExQg/4+tAZfBJIZSf/ki5R8vx4YdqR0CkEwBw86wNSYUmtD4Tj23jFKt
         RjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BgjpAWhUsNd321xRdgYc+Qsl4mTKgPBuEJhT5kvzP4c=;
        b=rOFXIrwE+G/cKR9p6UKkZeADwp50qA6JBfPx4J8w/+yStztRK3bYKPJm6rHAUVm62p
         JPxq0F0JWuWFnRgmhpkzNV3O8wdQYRRPqKdu+DTlyuIccORrhvmJoM3AolxtcZrBMkAT
         nRDmTh89i2AodRQ2olkSoFKccemWgz4zqOZGyxqAGl07KPEVkY2nKQC94nJxzhDtpwR5
         iVAF4cfuDX3bnm1/ELfG9QstO97S/p3u9VyyaJDbMw6ZO0oYWcf7dh1ZjSmTALpYGI1v
         PGryjdRAVqQ8R1StT6l4dBsmVNdzuf1pe/TAsKwTZGKe6JH4HP1zBGMGjRlCDfe+3O2l
         CgMA==
X-Gm-Message-State: APjAAAUAqSedTDgPLGFlKta4Az8rLlhuurHyGbdeXCOjRd6AYk3oSoRk
        Bt7pIyxROTM2q6/ggWKLq7s=
X-Google-Smtp-Source: APXvYqwAYh9N8uNHYxxAjGuaXY45395Am/9P7k3KMvmn4xfHfq+KlMAQkHWozUCPX54oGMDPFlzMiA==
X-Received: by 2002:a37:a7c6:: with SMTP id q189mr3022192qke.469.1573662048230;
        Wed, 13 Nov 2019 08:20:48 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:69f2])
        by smtp.gmail.com with ESMTPSA id k3sm1112686qkj.119.2019.11.13.08.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 08:20:47 -0800 (PST)
Date:   Wed, 13 Nov 2019 08:20:45 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Jiufei Xue <jiufei.xue@linux.alibaba.com>
Cc:     axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH] iocost: check active_list of all the ancestors in
 iocg_activate()
Message-ID: <20191113162045.GH4163745@devbig004.ftw2.facebook.com>
References: <1573629691-6619-1-git-send-email-jiufei.xue@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573629691-6619-1-git-send-email-jiufei.xue@linux.alibaba.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Nov 13, 2019 at 03:21:31PM +0800, Jiufei Xue wrote:
> There is a bug that checking the same active_list over and over again
> in iocg_activate(). The intention of the code was checking whether all
> the ancestors and self have already been activated. So fix it.
> 
> Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>

Fixes: 7caa47151ab2 ("blkcg: implement blk-iocost")
Acked-by: Tejun Heo <tj@kernel.org>

Jens, can you please apply this patch?

Thans.

-- 
tejun
