Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89499C433F5
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 22:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbiEYWN3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiEYWN2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 18:13:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670D795
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 15:13:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso146894pjb.3
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SW/yemAjSovys8Uer8z0V9vxV7yS0NxL3SP6dhq1+ZA=;
        b=eP+2u7n3Ea65W1a/205XFq4CbBDP8zm/sUK3KZIh3GU9HJCERqMX5FkZZlcbQlIpZk
         b/7XO5tGLjDvsYnKuGPTJ+NH5f4gGxn776wWVPBRuh1ncs/UIDNSj5fC284q3pBa5Of5
         XX0aZ7ZIgwe/p9C33BoH6wmQnvAYveEVXMvRRq0Bq9/yJif8vg/39HV97zVH9PV1QgXp
         a22D/lqoDCRZg1fPjq8kmtfCgRVzZ5WepfzUn8X1dwhbRyA+d9ziUkCjv0tu5RbTG0W+
         QOdOAwJjHhWNjryEx6cRYko7eWqytcEVni8X/Xf1eZaPFD0xvRONFNImFT1F09O9h0gw
         7zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SW/yemAjSovys8Uer8z0V9vxV7yS0NxL3SP6dhq1+ZA=;
        b=ChsORjy0oakqvBwi+lZLr8SkpiXQcNue2VN20sXgnacN2OiCOB8a06zczpjf0RruaH
         jDyUUlOLNF03D81xy6FAWBQRfNhhnFWvVq9xSwQdiIlVaerAsENURy75Lb6yNOaZ8yE7
         AXHIs8CHaVUY0Iw+J4JRLtJbv4lbucZ7VPyf23KIjoo1tpT7daBL7yis8GsdPq59fouA
         9ZuSSdlLYTMReB9yOrSLLfqiuh43UDt6yl4pmt7hwbCFZ3cY/8R6II7La5wzZ6HjXQt9
         Tg5l8jPGGFG18wagmwhU3BFKgRzjwlgnLphdCnvZLnCb/blHXZU3MPY8VKzoNvoTrjqm
         /lMA==
X-Gm-Message-State: AOAM533kx4OixjbNL6aZb+UwhCJ1CH+S4v0zSoHp6jPVxDiaWMqIsAVO
        rb+9qdlSYwtw5RzemaFA0tk2Jvbg90N5gA==
X-Google-Smtp-Source: ABdhPJxkpn7UGGPzkvjr/7sONrTFLUqBCwe2q3aU/VRMlYT0et5HtP9JLl31tL6Rz3/RRyF3jM00AQ==
X-Received: by 2002:a17:90a:154b:b0:1e0:6797:4018 with SMTP id y11-20020a17090a154b00b001e067974018mr12651483pja.172.1653516804735;
        Wed, 25 May 2022 15:13:24 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::4:38c1])
        by smtp.gmail.com with ESMTPSA id m9-20020a62a209000000b005185407eda5sm12090371pff.44.2022.05.25.15.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 15:13:23 -0700 (PDT)
Date:   Wed, 25 May 2022 15:13:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH blktests] CONTIRIBUTING, README: transfer maintainer role
Message-ID: <Yo6qAhC8LD8IhcAX@relinquished.localdomain>
References: <20220525020424.14131-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525020424.14131-1-shinichiro.kawasaki@wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 25, 2022 at 11:04:24AM +0900, Shin'ichiro Kawasaki wrote:
> To offload blktests maintenance overhead from Omar, I volunteer to take
> the blktests maintainer role. Replace Omar's name and e-mail address in
> CONTRIBUTING.md with mine. Also note his original authorship in
> README.md.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks so much for taking over! I've applied your patch. I'll send an
announcement shortly.
