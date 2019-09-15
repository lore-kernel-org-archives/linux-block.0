Return-Path: <SRS0=U2g7=XK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF3AC2BA1D
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 22:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE12121479
	for <linux-block@archiver.kernel.org>; Sun, 15 Sep 2019 22:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pmAyNKTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbfIOWCk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 Sep 2019 18:02:40 -0400
Received: from mail-pl1-f176.google.com ([209.85.214.176]:46203 "EHLO
        mail-pl1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfIOWCj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Sep 2019 18:02:39 -0400
Received: by mail-pl1-f176.google.com with SMTP id t1so15895643plq.13
        for <linux-block@vger.kernel.org>; Sun, 15 Sep 2019 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VqfP4ccJJLFRqJWGJwJ9wDcsXzO00eiiNAB5L2JrV6o=;
        b=pmAyNKTAmkoK4Yy50TGMVbu+n+LEuJ1nsd1MERhyrOzQW/OauYOfEU9h90xTJRhXIK
         OlvdhebTEb4rZn1msbGSrYpm1S62b4dKV2MSCAGGUQLEDyq1aZZ+UwKQmBYJFapfWUcI
         I5mdGk4jGo8ueu/PDNAjQk293ZDDKSMoQLst+GsYg3SPjNNbvtU9YOxS/Oi8bY+DpJ7P
         f8r1+lPnLR4wlgs/iIbjXNBMmQGm3ZKX3ElSyy9BAaJU6VCLc/MX3mzgCB53zSCF+6xS
         VDLqBWZ+cwAnKMU+wjt0mYUB6q/7s0ZsppYtwo+HnSyjJ/EBvbHWBSXf1bUxaTGCbab/
         Knbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VqfP4ccJJLFRqJWGJwJ9wDcsXzO00eiiNAB5L2JrV6o=;
        b=qn0sgSiOleHpj25gIZ6rZ/bP6CLnj5jMtWavBwOpn/RYTTuZnVpYZpZSeZa1rbf8M0
         iSqh45FUaiQJPmguzNgtG/Ki3z3aEG2JF26EBLilBHpOhJEALldz55KUl3yEVfVJ6XSR
         mS7X+2zAfKEnBVG4WfJ7nDpbxQ+PWp0imWGN6eDgWqqrusMvTLga9afuMI2i6Hx8ZWOP
         3RIXNeQb8Eao9RoNndNm1WxTWCUuuoeTMYuvygHtk/L5kitv6whbJaWaqJ6Ik36ea2G6
         +MdZD+Nm9dUic33vuBf4z0kihOBKs1bTKXIINNnb2rmEzoUbTcxspYz50WzLBQnyd+RS
         logg==
X-Gm-Message-State: APjAAAV7inIbpqVbklDWFdAIXmz0wzuvZm6w3kxh2rKxgMocUnYfMFJi
        ysPyB0QegieNPDSOI4aeAyGoHg==
X-Google-Smtp-Source: APXvYqyrmSg6qXtpNaG4LOj41VwN4WT03lPOx7LM7WqlyEb60nK0iYCGbiCEO7LgFPYFwyqqK0VNEQ==
X-Received: by 2002:a17:902:b48c:: with SMTP id y12mr46204199plr.161.1568584957572;
        Sun, 15 Sep 2019 15:02:37 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:2d68:69fa:2703:e8f9? ([2605:e000:100e:83a1:2d68:69fa:2703:e8f9])
        by smtp.gmail.com with ESMTPSA id 22sm5466744pfj.139.2019.09.15.15.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Sep 2019 15:02:36 -0700 (PDT)
Subject: Re: [PATCH 0/2] fixes for block stats
To:     Hou Tao <houtao1@huawei.com>, linux-block@vger.kernel.org
Cc:     osandov@fb.com, ming.lei@redhat.com
References: <20190521075904.135060-1-houtao1@huawei.com>
 <e2ba6719-e2f8-1bfb-c5b5-7a4396df60ec@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2016f8ce-34a4-901f-903f-7d451dd617ab@kernel.dk>
Date:   Sun, 15 Sep 2019 16:02:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e2ba6719-e2f8-1bfb-c5b5-7a4396df60ec@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/24/19 11:12 PM, Hou Tao wrote:
> ping ?

Applied, thanks.

-- 
Jens Axboe

