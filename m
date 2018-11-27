Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11D9C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95ABB213A2
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 21:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="s6TA9BR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95ABB213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeK1IAq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 03:00:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43669 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeK1IAq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 03:00:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id r71so15488414qkr.10
        for <linux-block@vger.kernel.org>; Tue, 27 Nov 2018 13:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2+oB3NQ6DcHGeIHckr9cxaNYbTfbF5HSphI11S9KWTQ=;
        b=s6TA9BR+Y6w/5h1lwrPObaaUUawuQqf64/Sa+x+v3JxRRzJ57egayvruUwD9bjd+Sv
         q52LBGdh9SNQPlHfTlKYm6TWbbJqF/smr6Ea9KRseqDzubjyjQ1sTanXW1BHYoOTuU5a
         3NZ8/eJE4EYKKA+LZUO4bnLBGQ1PCQDzG4/7UTKoQfoGKdM61nGItxtYEjl27flovFMS
         bPdZIhr4xB553ypzY21QJ6OAAn8rjTUX51v1ZGKGQi4Ingk2T74IA3yrxYbNeKZC31+F
         nNI3Ju76jqgUvDTysHyezpw4/DQuY6vCU2/AeUFqOTy2zTvTMQxXsSJuoUqJVc/CsX1G
         HQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2+oB3NQ6DcHGeIHckr9cxaNYbTfbF5HSphI11S9KWTQ=;
        b=dgF57FRsC0my8axf2bYdF1wUS/3upJU3lMD940KN90a+KBGnFFFwIU1YLzgr+7AdVS
         HvjmEO60Uw7fx9GDXWTieD0mGAifnknHS1gmxixQLb8hGnayd0DHntO8E+lxKyCixnLN
         Rti1S9BxwdZudqfFMxjjFRkwznwgbOghbdVFh3piEFfPiLwt4XIeC3vuKwUSxIU6MzmJ
         3nctnNkyMUp/oHJWitWUb9IpkmpICDbtnNujYRZZAscGUfhF6wQq6cgCtJkmYS5lO7bY
         YmwKrsBrB8UGW58k9OtPVKeaIWbSCdeEd+lGt0POT/4TUmeI0Ooq3K60Q5tUeIIEJiDh
         mHeg==
X-Gm-Message-State: AA+aEWYzT+XFMP5DobM+y1YcEpydunl9tQO9Ttu2h9kmui3xPW1nXSGH
        R8WT6CpDeaJi3bNcFrMO1JlesIGbSxcANA==
X-Google-Smtp-Source: AFSGD/UTx+D9sHgOgVDvLn9iNz53MWss5o+Ab+zLZLpWM9J4WAS9cHQbtjjXKPmYC7yMNE7W1N5KTA==
X-Received: by 2002:a37:1b46:: with SMTP id b67mr31694458qkb.144.1543352495953;
        Tue, 27 Nov 2018 13:01:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:180::1:4c40])
        by smtp.gmail.com with ESMTPSA id u16sm3672633qkg.14.2018.11.27.13.01.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 13:01:35 -0800 (PST)
Date:   Tue, 27 Nov 2018 16:01:33 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/13] blkcg: convert blkg_lookup_create() to find
 closest blkg
Message-ID: <20181127210131.7cdgku7cmixxwdbc@macbook-pro-91.dhcp.thefacebook.com>
References: <20181126211946.77067-1-dennis@kernel.org>
 <20181126211946.77067-4-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126211946.77067-4-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Nov 26, 2018 at 04:19:36PM -0500, Dennis Zhou wrote:
> There are several scenarios where blkg_lookup_create() can fail such as
> the blkcg dying, request_queue is dying, or simply being OOM. Most
> handle this by simply falling back to the q->root_blkg and calling it a
> day.
> 
> This patch implements the notion of closest blkg. During
> blkg_lookup_create(), if it fails to create, return the closest blkg
> found or the q->root_blkg. blkg_try_get_closest() is introduced and used
> during association so a bio is always attached to a blkg.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
