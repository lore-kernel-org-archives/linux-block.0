Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788ECC04EB8
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22C7B20850
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 03:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lNU9qXuj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C7B20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGDQY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 22:16:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42409 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGDQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 22:16:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so1132606plp.9
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 19:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iXPuQLIRIMo49oR4Lcg42MfzuXEOLwmMR2b0MMMIYuI=;
        b=lNU9qXujj9ioxLW1pQsdTZYwxFRuYm9J5sIea6sbAdfvfyEQrMDp1Gy4DLBAxwGFen
         o/MVvm/cGBUpKkopSt2yQX81v6AkQ48EX1V/ufhrpdLGVZTzw4JIx0B09wXMVGHPH0GH
         /Js7edLaubItHS1YnaXMBCoPQh6ArrbFYHXMZWfnm7l5kevUMU5YrpnGlTNA82NYNkbP
         Eji0uloSpdGcB4Xmn2WczSriut+AAejTV0cVvwEiL7n8uzfVnkv3p/EOxE5Xs1Ew5Yqx
         KwzqPgiXsIjaP52nc3HWz/mAY9II2edp7nUfbEWfI4RGzMwSoE81YioNYWsZ769d73gt
         FjAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iXPuQLIRIMo49oR4Lcg42MfzuXEOLwmMR2b0MMMIYuI=;
        b=V/vOiHK0P5bCt9Uk90IeBmE5zy3dG86HJX97Nf9Kr62RylbGiBuVab3vEkx/uxHbRY
         NuX0PX/BZ4mjatgOQzCAyDkwMkiSx0ODv/m9K3QI07dwWX1DSO+UKuw5r3O1CZyK+3Yt
         2nFjQSkEMSUpScatwTrK+PiyzQnOLN23ud6HYLLWUYPpVblsS5AbgfNGI8xW3dTqXpQQ
         IxNPPzjkflTGrfqTE6aSAeLgB/jlZqfIzc/F98xKfD0zNk1tAMEaK+4jXVg0O7x4q71U
         0ro9hQwkna5VBU1Sbdou/+w5jgUxbsGO73LRRXEQmC3+f+0p5Suk21tNtvG9JsJEMlEc
         PjiA==
X-Gm-Message-State: AA+aEWYkQw3M8bWefyVgjGkPgQ/0PeeaEjtbz/XZuuHoFUBk/IWtWkTS
        DmMxdRvGiJhR0Zihypt0sbFU7Q==
X-Google-Smtp-Source: AFSGD/Vz73My2QKkqdTZSy5kkOVKUrabHadWPVtyGI8pFRRcN9+eYftY9VkAt0EvmY767b/rdl0Ksg==
X-Received: by 2002:a17:902:7481:: with SMTP id h1mr551505pll.341.1544152583501;
        Thu, 06 Dec 2018 19:16:23 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p7sm2872275pfa.22.2018.12.06.19.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 19:16:22 -0800 (PST)
Subject: Re: [PATCH V11 0/4] blk-mq: refactor code of issue directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2bcbb76-af6f-7660-2bc3-9796338cccff@kernel.dk>
Date:   Thu, 6 Dec 2018 20:16:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544152185-32667-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 8:09 PM, Jianchao Wang wrote:
> Hi Jens
> 
> Please consider this patchset for 4.21.
> 
> It refactors the code of issue request directly to unify the interface
> and make the code clearer and more readable.
> 
> This patch set is rebased on the recent for-4.21/block and add the 1st
> patch which inserts the non-read-write request to hctx dispatch
> list to avoid to involve merge and io scheduler when bypass_insert
> is true, otherwise, inserting is ignored, BLK_STS_RESOURCE is returned
> and the caller will fail forever.
> 
> The 2nd patch refactors the code of issue request directly to unify the
> helper interface which could handle all the cases.
> 
> The 3rd patch make blk_mq_sched_insert_requests issue requests directly
> with 'bypass' false, then it needn't to handle the non-issued requests
> any more.
> 
> The 4th patch replace and kill the blk_mq_request_issue_directly.

Sorry to keep iterating on this, but let's default to inserting to
the dispatch list if we ever see busy from a direct dispatch. I'm fine
with doing that for 4.21, as suggested by Ming, I just didn't want to
fiddle with it for 4.20. This will prevent any merging on the request
going forward, which I think is a much safer default.

You do this already for some cases. Let's do it unconditionally for
a request that was ever subjected to ->queue_rq() and we didn't either
error or finish after the fact.

-- 
Jens Axboe

