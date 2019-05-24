Return-Path: <SRS0=cawq=TY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8234DC072B5
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 13:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53A6720644
	for <linux-block@archiver.kernel.org>; Fri, 24 May 2019 13:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="KVMIGYPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391553AbfEXNRS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 May 2019 09:17:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:37037 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391439AbfEXNRS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 May 2019 09:17:18 -0400
Received: by mail-vk1-f196.google.com with SMTP id j124so2109649vkb.4
        for <linux-block@vger.kernel.org>; Fri, 24 May 2019 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uZ0Zg2uNirK9y14G1GGlkyl+JyTXOEhOPCDV27xwj8c=;
        b=KVMIGYPAnG8rCkGjZMc5w+BUKN3bsquzT+RjW3mWL8+At7Zi2zogqW+Xd6kiPBCctA
         4dE7ML06tMw3uJNZT/659ydbjB/R1C+JWBdxsVIePOWjQjgHP+hC8Z4+wzyCd79LMjAe
         5miSfzE55s6KgkstL7V/0JTa+LyCyKcWAnJ1WzdO1UDAN3QRFW962kdB8g1wKgrYNybV
         h8ntSwUZX+4EHuUhKd5AEuognCDKVtgGoj8PpC8zaLHwHTfCDN+A89Cy6uLItyZmywxk
         rlgfeNQUQcvoGGPU6j8LtoQZS8g2ylCMixTXz1PmCeK7z22xOjFCuEoQPwKad01b42hW
         ZPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uZ0Zg2uNirK9y14G1GGlkyl+JyTXOEhOPCDV27xwj8c=;
        b=JM6kzLcyV4HZu6emhP2MuhwxOwA1aiijtsQvNUq1n7ua9Xz2YNFHhTq/rs7W6mNXNp
         GS/x5EwTmmDXqDJYG2klCWuFssHBR0QPxDvEbLPxKSKPioFSnMScrP/5BwJiu0HcebYV
         CYSF6czcqsspkdNiYq5kU5ly9+frXywCjqXNpf6Qksag11RbpECuJHWQAhFbt1vfr86d
         bHAPB3Xb/sRqSwpEchq2fpU287uiY+ROnfFDXT6HZfGFe2err42oBt0woKCocRN++hIL
         wOj5xIcg29MFmvD1oxzHCaSCTtT9d8SOl9hOw1qjylRPlQxGP0icrYJMuxNAPU0FHiV+
         TrHA==
X-Gm-Message-State: APjAAAVQkjrfDWL+2XB8TohCnAyLsJnFZmJsWhov4YBEzdjGFbQsX63L
        lXE8eqVv9Ix0l4H85xNUniNmSg==
X-Google-Smtp-Source: APXvYqwbxvb1agF6wdEfvSucciNSzicTQUfXHMAfETxwg9x9k6nYAbdxRWEXFj3tTX26smk+8dleRQ==
X-Received: by 2002:a1f:3ad1:: with SMTP id h200mr4754507vka.24.1558703837630;
        Fri, 24 May 2019 06:17:17 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e914])
        by smtp.gmail.com with ESMTPSA id l31sm610274uae.15.2019.05.24.06.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 06:17:16 -0700 (PDT)
Date:   Fri, 24 May 2019 09:17:15 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yao Liu <yotta.liu@ucloud.cn>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nbd: mark sock as dead even if it's the last one
Message-ID: <20190524131714.i3lbkbokad6xmotv@MacBook-Pro-91.local.dhcp.thefacebook.com>
References: <1558691036-16281-1-git-send-email-yotta.liu@ucloud.cn>
 <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558691036-16281-3-git-send-email-yotta.liu@ucloud.cn>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, May 24, 2019 at 05:43:56PM +0800, Yao Liu wrote:
> When sock dead, nbd_read_stat should return a ERR_PTR and then we should
> mark sock as dead and wait for a reconnection if the dead sock is the last
> one, because nbd_xmit_timeout won't resubmit while num_connections <= 1.

num_connections is the total number of connections that the device was set up
with, not how many are left.  Now since we have the dead_conn_timeout timeout
stuff now which didn't exist when I originally wrote this code I'd be ok with
doing that, but not the way you have it now.  It would be something more like

	if (nbd_disconnected(config) ||
	    (config->num_connections <= 1 &&
	     !config->dead_conn_timeout)

instead.  Thanks,

Josef
