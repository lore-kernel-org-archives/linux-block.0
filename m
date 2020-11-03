Return-Path: <SRS0=cbU1=EJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFCC2D0A3
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 17:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FE1B2080D
	for <linux-block@archiver.kernel.org>; Tue,  3 Nov 2020 17:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="m/Z4E4xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKCRBO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Nov 2020 12:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgKCRBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Nov 2020 12:01:14 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C00EC0613D1
        for <linux-block@vger.kernel.org>; Tue,  3 Nov 2020 09:01:12 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id l2so15354617qkf.0
        for <linux-block@vger.kernel.org>; Tue, 03 Nov 2020 09:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nq9emdk9/VH3etoKCshVdn5b0ODJscsHUoyYM3vXRsk=;
        b=m/Z4E4xllSTiWaEF9DMmkER2TYTqigEOfGHL8tnnebBSuZAllPym9m3FcE7VITk9zG
         AwaALaAeoBzD0bNlgrrzTgnK3a8hCFqMekzjEunGQWg8xpQlN/n9e+3GPgwwUxkzsHKh
         00/i0IUn9+23K+ZWY7xt1DAPoHL5odjunW4WIwkZbkQ/TMt04L+fe27+TavVv8rscymn
         Vc1zfbXtbtVW2nn8+M0cHGSO/NBUx9km4pADBe0dlitcVuHS8Qqe+EfU3O6jJ06BrkI8
         6C4M6X5D4h8/K9A7v3p+rTBPC0Pk94JuGNV1MiS84TrxoUHo3KDW8/fU94nOASGjstUS
         3VFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nq9emdk9/VH3etoKCshVdn5b0ODJscsHUoyYM3vXRsk=;
        b=djROrC+er1I3Q7EYhhGDHDGRZSYjTDN19hs6yXC9c2IBNcWNrAKnjXscehaEr277zC
         qDiY4eZLLM1C/qYnelhYcfqiwt+7dv1lfBQRxK6DBwNfLelUvQvxE6vXycdk2H6EnSzE
         nCRG0YkVqsRCye1KCdNWOyp6JOF/7rpMUV3aLm6DKdRDvYsW3EHuUgHxE4pFaCFLi0Gt
         l8Y1rSZ2pcjiYPvS7pfRhO5M8xoN9B3NMXP0Tatq9evn9MGU3cCimoDQJ4wGnRvTjjFG
         /jKdJyQX4xWbBTWNM3TC+voLEnnDxm6CBPqzLwyAQMX8QWZiANCxSVEs5gVnYGySNJ8C
         k0hg==
X-Gm-Message-State: AOAM530kW881JDI+C5yGL6vBTMNZEq7KrSUTTEI1KXJBPcjGIZPV7q9z
        Aq7mAADgaCZmTbiGAL5J7cSZpA==
X-Google-Smtp-Source: ABdhPJx9uvhiDJfmYjsgwJSwPH9cXkjoyHlQhyl/BtA+7OFacC/7K2DwA11+kxnIGYs16+38zj8hEA==
X-Received: by 2002:a37:2784:: with SMTP id n126mr20725104qkn.477.1604422871347;
        Tue, 03 Nov 2020 09:01:11 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h4sm10820116qkl.82.2020.11.03.09.01.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 09:01:10 -0800 (PST)
Subject: Re: [PATCH v3 2/2] nbd: add comments about double lock for
 config_lock confusion
To:     xiubli@redhat.com, axboe@kernel.dk, ming.lei@redhat.com
Cc:     nbd@other.debian.org, linux-block@vger.kernel.org,
        jdillama@redhat.com, mgolub@suse.de
References: <20201103065156.342756-1-xiubli@redhat.com>
 <20201103065156.342756-3-xiubli@redhat.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <cfea847e-8d60-ee61-3375-7637197ab8bc@toxicpanda.com>
Date:   Tue, 3 Nov 2020 12:01:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103065156.342756-3-xiubli@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/3/20 1:51 AM, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> When calling the ioctl(), fget() will be called on this fd, and
> nbd_release() is only called when the fd's refcount drops to zero.
> With this we can make sure that the nbd_release() won't be called
> before the ioctl() finished.
> 
> So there won't have the double lock issue for the "config_lock",
> which has already been held by nbd_ioctl().
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
