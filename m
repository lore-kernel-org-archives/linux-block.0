Return-Path: <SRS0=jW7Q=YD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DE7C4360C
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A17121929
	for <linux-block@archiver.kernel.org>; Thu, 10 Oct 2019 13:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="brKX8AGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfJJN47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Oct 2019 09:56:59 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]:46798 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfJJN47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Oct 2019 09:56:59 -0400
Received: by mail-qt1-f181.google.com with SMTP id u22so8765725qtq.13
        for <linux-block@vger.kernel.org>; Thu, 10 Oct 2019 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xCIpw3rx5fAU7TZxetuXrfOkSP3oSGobe1/1dnDRzEg=;
        b=brKX8AGHf56UdvlCsUj5lynFN7p2wFZCJuBYmwXCDdSzFgAaI9gfA1q3qkzv82RA+U
         /uHcR686GkdkDho3KfFU1yiVPVJkILyHqueQd/JI53BMEbca009zkDMC09BKHMve1Q23
         2YG/1SSczpRDdIpP6ho66sVbAyzX6dCREa8zBTyj8rBzaWM4732J2UnyXjj9kT6I1tfl
         bJJOU+FFB0fD0HUH3rOs2wuPU93ijXF5+QjV3IzMaMGbIC2FzLkxyGpKpSsMoVeJ4dhA
         2qZ6ayAaDzjN/fJUPbJtw72TJoihF8m8RTZI5+NWJNRWBhfACtZkaFfOWc++vji7xq9H
         SiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xCIpw3rx5fAU7TZxetuXrfOkSP3oSGobe1/1dnDRzEg=;
        b=kzOap2yllBCS5n4Ro3liccq4i/Lqf+hy69tGFA0vVy/SKpCY2BYmJNLxwFVTLQSwcK
         Xqc953vmkEsML+PqBeSvJZdR/Zz6ALyZs0n9AR6VKcOuSWXqz17yOj/9+AdHMyWkwOB/
         t9v6F4xMUTPVeSYagnf8l2BDPlA14v9dWO+6XNB3eBl3lhZnnTH+r2LmYIZNFrTyApdf
         YJo7tTpQOg7XlQMgnsf4NiPc11Jr7YatYtOjhiJtUo1esrYX7zsdDa3JtaE20UhY9EQl
         EzJT0KEZaW845xIPso2osXP0OWC1kbd6MgN1MJd3tgXmn5cZkq82gf2DfriuYNGoNP5j
         GLdQ==
X-Gm-Message-State: APjAAAUDuwPjnQSBWNe9KQK80tzKObxMgw8xcSuZ/kMs4nD60aaE4S9D
        n8di3Jkn0Gk+QWxz+bmhFFHsRQ==
X-Google-Smtp-Source: APXvYqxF6jvlqWBmKjnV4d0At+yaZviJsRJz9ErCCzA10Wz8LUzxdZSHuOOstTpwT2Pj5APaz0YHHw==
X-Received: by 2002:aed:3ec8:: with SMTP id o8mr10598501qtf.386.1570715817086;
        Thu, 10 Oct 2019 06:56:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::18ce])
        by smtp.gmail.com with ESMTPSA id b16sm3235944qtk.65.2019.10.10.06.56.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2019 06:56:56 -0700 (PDT)
Date:   Thu, 10 Oct 2019 09:56:55 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     xiubli@redhat.com
Cc:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH] nbd: fix possible sysfs duplicate warning
Message-ID: <20191010135654.lvdawtrzk7df6id3@macbook-pro-91.dhcp.thefacebook.com>
References: <20190919061427.3990-1-xiubli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919061427.3990-1-xiubli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 19, 2019 at 11:44:27AM +0530, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> 1. nbd_put takes the mutex and drops nbd->ref to 0. It then does
> idr_remove and drops the mutex.
> 
> 2. nbd_genl_connect takes the mutex. idr_find/idr_for_each fails
> to find an existing device, so it does nbd_dev_add.
> 
> 3. just before the nbd_put could call nbd_dev_remove or not finished
> totally, but if nbd_dev_add try to add_disk, we can hit:
> 
> debugfs: Directory 'nbd1' with parent 'block' already present!
> 
> This patch will make sure all the disk add/remove stuff are done
> by holding the nbd_index_mutex lock.
> 
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> Reported-by: Mike Christie <mchristi@redhat.com>

Sorry, don't know how I missed this.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
