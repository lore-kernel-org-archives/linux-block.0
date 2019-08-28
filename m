Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9CDC3A5A1
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 04:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62406217F5
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 04:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="gKntHUbp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbfH1EGr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Aug 2019 00:06:47 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17869 "EHLO
        sender3-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbfH1EGr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Aug 2019 00:06:47 -0400
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Aug 2019 00:06:46 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1566964261; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=nC0x4IFtr5oUkqo7CJopOuSOhRR5Uj5vv7ozu9uG51mRfJHG04y/d8q19F3JJjvyFIue4GIq6lCYQdVAC4rQDOUAOs8nhMo2nupo3oq/oSKfPKH0TE3Q9cmmU6JOBsaNWtmXKDRBvOWpssbX8X8LyzrYX+IDRTO3ZLCPFLGx92k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1566964261; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=kZZ0SaUSYboCypvlsV1KXUwzNEviRw5SwLxgGnE8zzY=; 
        b=RZWvI+EBuMXc7SdAQBjrfAPV51T1la8dCfa1BgIvCmhQBFM8sIesVFfnVa7Ay/lPCraO//X5XhYfZ/MCYGyYWwRg1bNYk9OyEg1p6JVbuBrl3YopBQLnNSys54inM3FcV/GwWY4abp/58f+eYSlW+RgdThRFIu95xftdh7wunuM=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=euphon.net;
        spf=pass  smtp.mailfrom=fam@euphon.net;
        dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1566964261;
        s=zoho; d=euphon.net; i=fam@euphon.net;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        l=522; bh=kZZ0SaUSYboCypvlsV1KXUwzNEviRw5SwLxgGnE8zzY=;
        b=gKntHUbpwtEPWYsG8RAFSvgvTifHJiZkg0vZjQvPumRN9CB0yaXDLVlxxcTjfXxU
        ZsYBpyud35mPITI8gubkdPsc6N8m82VpRlujPxbqsV6jFCGarVssE8zSEnomCZmJ2gE
        M0vRNjeXrf8TtvD1IZdzdga5MoM4tn2JwiI/IadU=
Received: from localhost (120.52.147.46 [120.52.147.46]) by mx.zoho.com.cn
        with SMTPS id 1566964259915588.9970437337977; Wed, 28 Aug 2019 11:50:59 +0800 (CST)
Date:   Wed, 28 Aug 2019 11:50:55 +0800
From:   Fam Zheng <fam@euphon.net>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>,
        Fam Zheng <zhengfeiran@bytedance.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, zhangjiachen.jc@bytedance.com
Subject: Re: [PATCH v2 3/3] bfq: Add per-device weight
Message-ID: <20190828035055.GA16893@magic>
References: <20190805063807.9494-1-zhengfeiran@bytedance.com>
 <20190805063807.9494-4-zhengfeiran@bytedance.com>
 <20190821154402.GI2263813@devbig004.ftw2.facebook.com>
 <C2F0BE1E-9CAA-4FBD-80D8-C18ECCE3FD4B@linaro.org>
 <fff76a58-65e7-7060-0329-aef15c422639@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff76a58-65e7-7060-0329-aef15c422639@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-ZohoCNMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 08/26 07:59, Jens Axboe wrote:
> On 8/26/19 12:36 AM, Paolo Valente wrote:
> > Hi Jens,
> > do you think this series could now be queued for 5.4?
> 
> The most glaring oversight in this series, is that the meat of it,
> patch #3, doesn't even have a commit message. The cover letter
> essentially looks like it should have been the commit message for
> that patch.
> 
> Please resend with acks/reviews collected, and ensure that all
> patches have a reasonable commit message.

Will do. Thanks!

Fam

