Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3EAC31E51
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58F1208E4
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 13:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwxxC1Ae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfFRNS7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 09:18:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37040 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfFRNS7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 09:18:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id bh12so5716160plb.4;
        Tue, 18 Jun 2019 06:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=frPkqK5kCI1XnEaOJ+gNA8ONJutQPz+wVq6WTnhwMv8=;
        b=MwxxC1Aei34Cyt/RQZWMjP+a4hNcl64B+WUfPUJH+bukkH+G4UWUE5+Dat7QBE+FHi
         kwOPH8bijP+7vCqoozK8KxIRc5ZAPHrTAolIn+NddL1OmmrUzbfUIb5IZd0XwQuusVpH
         SLkzArTcdoWTyP2tHqrUxQOLIANVq4ci7fUBVt4DCjgQ0Nwg/SDOxohCWUgNpnGi8QB/
         vwE8byzpuMJeo43H6vSLet8Zym3fn0uNLcjupCuVRJf+9/N7LVYjRYhADnqIONQ0/LHU
         hDpnKFEYwGRskf3Tth2u6xHq2hy8AAYl89RH4lIOXIfdQE9+OtnDs/iE6k7o4ibgv8cb
         Gmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=frPkqK5kCI1XnEaOJ+gNA8ONJutQPz+wVq6WTnhwMv8=;
        b=QL6oRg8Q6dVTf8JDTIw88aEpffDD7pBvsYIuUizBGwllSLSr8QSog76iAz6A9q9R4g
         DaSawSDsBHpWUqvq0eBvuq/2DEJ5y2/IZJovnYtP8svRbMeuNsffeVtjFa8Z1zEgnZxa
         I104rdRwMpL/AvMb6vmrf65yR1iVWTTp8S9K7NzKxeEUU6ALxKbFfc0OWPugsx5bVY6V
         3oKhwIsCzJZFgWy4XGsA9O+OrGgxQj9jSXUZql8rXl8fFv7rzHo3e8XrMUd2P6nN9I9C
         U6Oo2XKC77E1C4e1y9eQ8bQRO/0GGAr0vIIXZIlKweRC3TPoVWzfNdH/YdrtJARvO0LI
         lijQ==
X-Gm-Message-State: APjAAAWeEpfod4DBjeCbMBIgngDZL7Wnp0QTByeTLO2GZf5HM5Y6N2lm
        69juno3LHd7/RhbtU8S7LIM=
X-Google-Smtp-Source: APXvYqw8fKeZTvDIlKYXkdfuvQguQX28fZf2Wih+dmg/3F4bhG+gPQl4Td0q7H2vlj0KjFtJiznIgw==
X-Received: by 2002:a17:902:8bc1:: with SMTP id r1mr21851807plo.42.1560863938494;
        Tue, 18 Jun 2019 06:18:58 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id j1sm16770659pfe.101.2019.06.18.06.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Jun 2019 06:18:57 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:18:54 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Weiping Zhang <zhangweiping@didiglobal.com>
Cc:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, bvanassche@acm.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 4/4] nvme: add support weighted round robin queue
Message-ID: <20190618131854.GA419@minwooim-desktop>
References: <cover.1560679439.git.zhangweiping@didiglobal.com>
 <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b0fa12a337f97a8cc878b58673b3eb619539174.1560679439.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-06-16 18:15:56, Weiping Zhang wrote:
> Now nvme support five types hardware queue:
> poll:		if io was marked for poll
> wrr_low:	weighted round robin low
> wrr_medium:	weighted round robin medium
> wrr_high:	weighted round robin high
> read:		for read, if blkcg's wrr is none and is not poll
> defaut:		for write/flush, if blkcg's wrr is none and is not poll
> 
> for read, default and poll those submission queue's priority is medium by default;
> 
> Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>

Hello Weiping,

Please add linux-nvme mailing list for this patch to be reviewed from
the nvme people.
