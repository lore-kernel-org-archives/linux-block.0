Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1921C34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 15:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8612324670
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 15:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582125123;
	bh=8sO2O1iN/fsitX1ahhYJ37j0AJhxITcscfsVE8Utbxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLFGEI5vP2f2jntnHeWh9LFdu79PWTjbF8QHo40oEBGHklHlor6XQQbRI3gL5jHc1
	 iyGaS/xc4t+Fk+U1CH0MgZw9git93C0kqNVbjl9ebnWPZRW8uodyYMKHB4pGk1FxEs
	 HGBW6PWmtdynEQN50AALtF9iZpgd2m7XCQMOV9Xc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBSPMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:12:03 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45523 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSPMC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 10:12:02 -0500
Received: by mail-qk1-f196.google.com with SMTP id a2so367464qko.12
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 07:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+SHsILg/1tswq9R8SBNEMGUgYVfB/wPfRGE9VNJMS8=;
        b=IRwttiSbmJWxnB+PgBI1s4bJTTbBK34CFJSYtcd6DREJyMyHA18rF0uilM2mIAz3jn
         X9r4fIZ+DJOCyvCouzQAECk60MFE4V/ibV0xnxecHLfHGKoXKW1/ifYnl67qLBAco+jq
         B7mOmgKKzURep4S9dDmqnyqgUQOpWNEOsv+vjJjCwPYt35HRYe39JdyPFr6Ldfwbew33
         707fQoOFXIlXutG/+V/cTlvhKxHJ1LzbcYAc6n/eUowxMLpuW7A9qbZLgOWAM6ERSrii
         HdTyIjdEYwRbB5Mfi6aXfFF9ENXoW8HepwUZjkPNckyJkyaLwOEZFqLrBgiFpfQqnI/K
         DLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=n+SHsILg/1tswq9R8SBNEMGUgYVfB/wPfRGE9VNJMS8=;
        b=PNhE8N1sdZD1CT3c7Vm06yf7YhdiYiAPmfhnhpylkSAt5axpn52BYsNzRmoz8rp/qd
         lBL7Wy5jQpZtm0Oxk3LxXU4zs9VkfUMK0LRQMJwOeOEO0RYPdQEDuWZRZAES3QgTrGkT
         KMLORP+Mnntyj92wbVZis5xG6fknYs/PnyxTKm3lOe8FTAvkHUT+ahG9SzRsv/V7/ntR
         iYztFTCS19yMRR29XTosEr3VgSXF6bd0bqNQDd/fPHviKXyCN6OOJzY9oPKcGWIp3cXQ
         BKNUrJ+Rx7HE0RMZi7GQlNNLl2gidpi3KZ29zUfcvVh2Edbtll8K3tgQl7ysMTiTcNOR
         iPGw==
X-Gm-Message-State: APjAAAUcbCBwhHHGQfyVYLiDAeQeMD+4kcFLem2xoQ4BD2+GLxTas7kz
        A2B7SeA3wGjIutO/dSHcb7hCcfj/SgU=
X-Google-Smtp-Source: APXvYqxd1A2wZSvD8WKDX7W9mv+zYGzLQxciYLC5qdf9xdI9RE8mmDDk9iN5gije67VsTJ4csrcXiw==
X-Received: by 2002:a37:9306:: with SMTP id v6mr2115603qkd.257.1582125121469;
        Wed, 19 Feb 2020 07:12:01 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:e7ce])
        by smtp.gmail.com with ESMTPSA id d197sm1122238qkc.16.2020.02.19.07.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 07:12:00 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:12:00 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Yufen Yu <yuyufen@huawei.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, bvanassche@acm.org
Subject: Re: [PATCH] bdi: fix use-after-free for bdi device
Message-ID: <20200219151200.GA698990@mtj.thefacebook.com>
References: <b7cd6193-586b-f4e0-9a5d-cc961eafaf81@huawei.com>
 <20200212213344.GE80993@mtj.thefacebook.com>
 <fd9d78b9-1119-27cc-fa74-04cb85d4f578@huawei.com>
 <20200213034818.GE88887@mtj.thefacebook.com>
 <fa6183c5-b92c-c431-37ab-09638f890f6c@huawei.com>
 <20200213135809.GH88887@mtj.thefacebook.com>
 <f369a99d-e794-0c1b-85cf-83b577fb0f46@huawei.com>
 <20200214140514.GL88887@mtj.thefacebook.com>
 <32a14db2-65e0-5d5c-6c53-45b3474d841d@huawei.com>
 <20200219125505.GP16121@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219125505.GP16121@quack2.suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello, Jan.

On Wed, Feb 19, 2020 at 01:55:05PM +0100, Jan Kara wrote:
> Also I was wondering about one thing: If we really care about bdi->dev only
> for the name, won't we be much better off with just copying the name to
> bdi->name on registration? Sure it would consume a bit of memory for the
> name copy but I don't think we really care and things would be IMO *much*
> simpler that way... Yufen, Tejun, what do you think?

Yeah, could be. So, object lifetimes in block layer have been kinda
janky mostly for historical reasons and in a lot of cases ppl apply
bandaids to work around immediate problems and at other times things
get restructured and properly fixed. Given how the objects are used
here, it'd be a typical case for RCU protecting bdi->dev and I wonder,
in the longer term, that'd be a better way to go than special-casing
name. That said, it's not a strong opinion.

Thanks.

-- 
tejun
