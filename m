Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E1C2BA83
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F09F324649
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581689119;
	bh=ztMdt3oEz3IEYAhpCdtBhaJTpddt87Qu/Jt6NDeR+K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCBjKk/6bintmeG9++KuGSEeKzJPK1Ly6v3zwUcAH542ANB7FhOFz/U9HjpUM8nPE
	 QuJ+XgPsxIrAanaX6EjB9pCVbo/FZ/66dWk7zP5ekL8GasuJ7uaVs95ihMaGcsZ+At
	 d6vDa8Wg4AGCKakdmZT7y8pfK8DgRyfAk7q8/suU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgBNOFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:05:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40798 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNOFR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 09:05:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id b7so9266291qkl.7
        for <linux-block@vger.kernel.org>; Fri, 14 Feb 2020 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=05uQZMBwV8GnBepYg6ALQFiI3J3horleCUJcgJHWnJM=;
        b=o4Uk/4IexNqYace9U6l2/aln39T9TBJxopHzeSuSj6WJ3XJDejcEpOgsNk6G8o3IMD
         zFjdtzra7NPfhLZW6cVihUFa7jFn2FExquIlVWHjl942/44EiY2C4od/F5fxYMye9gcq
         fc4dyxgR4fS1CF3KnW+lPOk8STV8Xa6CsqInMfL0eH40i1UGNmMWpuVTgpuFvbXenMH4
         yk+L3q+lMERsYKt7U5pEqhBRz4G61hTXckWVx26qfqgVRu/e+Xqs0x9To+JQ9W7zSk0I
         69KU0gH4/hz5xMUvN3lSr0ixMd9NcCV63uYH3PicqmSLMBI8XFSSMhXe5PM7yHtr/ICu
         BA0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=05uQZMBwV8GnBepYg6ALQFiI3J3horleCUJcgJHWnJM=;
        b=VoqpE2XYL6tGJ7k9CYrpqB8WeJETwT/oNWcW580EdKP7ErOj4PzmLA7NeI2D3N335C
         CbmOwcpw+YJ6lNSxekoTLEVh7LQmdsmVFJ1ZUcHENN3o9/gXEcany0DwBOTG6yMrROu9
         /+rs3j3Jey/6JFfCiN4b9DtNXbe9028pc/smTylL+QeUXd6u+BEWz6WldY/x+gakGGWy
         MvDzYIYZT/hpFsBkTk9O1bXCoHVHbRzrs+LmKCifPilVPZFyVKv/wV8n/cHLDXHx5RiA
         iLUYY9BK8Dx4ClTJhZCwwGJWDhnLxxOYMFcWNdOuuw0/gkANOuJ3hFWb1o3WR/R9wtLC
         9Zyg==
X-Gm-Message-State: APjAAAUGSnHg64bAEmIZ6ng0WKR9B5b1srdOhmf/0MuPmgBDByNKtqBA
        ha0WnFOjZkOMBoyaGQd2uI8=
X-Google-Smtp-Source: APXvYqzHv35r29XL/U7MdyR2z2hHS5htKqKO1d8KGLZN49EQEyXDl2Pl7bzpCu61y7z88f44bg79fQ==
X-Received: by 2002:a37:e214:: with SMTP id g20mr2739383qki.367.1581689116294;
        Fri, 14 Feb 2020 06:05:16 -0800 (PST)
Received: from localhost ([71.172.127.161])
        by smtp.gmail.com with ESMTPSA id z21sm3362590qka.122.2020.02.14.06.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:05:15 -0800 (PST)
Date:   Fri, 14 Feb 2020 09:05:14 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jack@suse.cz,
        bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200214140514.GL88887@mtj.thefacebook.com>
References: <20200211140038.146629-1-yuyufen@huawei.com>
 <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
 <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

On Fri, Feb 14, 2020 at 10:50:01AM +0800, Yufen Yu wrote:
> > So, unregistering can leave ->dev along and re-registering can test
> > whether it's NULL and if not put the existing one and put a new one
> > there. Wouldn't that work?
> 
> Do you mean set bdi->dev as 'NULL' in call_rcu() callback function
> (i.e. bdi_release_device()) and test 'bdi->dev' in bdi_register_va()?
> 
> I think that may do not work.
> We cannot make sure the order of rcu callback function and re-registering.
> Then bdi_release_device() may put the new allocated device by re-registering.

No, I meant not freeing bdi->dev on deregistration and only doing so
when it actually needs to - on re-registration or release. So, sth
like the following.

* Unregister: Unregister bdi->dev but don't free it. Leave the pointer
  alone.

* Re-register: If bdi->dev is not null, initiate RCU-free and update
  bdi->dev to the new dev.

* Release: If bdi->dev is not NULL, initiate RCU-free of it.

Thanks.

-- 
tejun
