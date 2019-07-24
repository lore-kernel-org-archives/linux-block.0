Return-Path: <SRS0=+4Fh=VV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926CCC7618B
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 11:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F5C229F4
	for <linux-block@archiver.kernel.org>; Wed, 24 Jul 2019 11:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="hrVbr11+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfGXLhX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Jul 2019 07:37:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33795 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbfGXLhX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Jul 2019 07:37:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so46657144wrm.1
        for <linux-block@vger.kernel.org>; Wed, 24 Jul 2019 04:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aQfNFiJgGsv9UgTyWY3tUqj/qF9PNqN3A4wyBds+Y/Y=;
        b=hrVbr11+OiUw0odEuipDamOn+CeA1FYWaQZFMbx5tm88oSpJoJScJfyS/Bu5jYPICg
         7cDHOGH2yau3gw2mLzSSI03+SpYiwqppzZGErfQ8LHNCVcbsk+x9OsDTPZN1GkUUFfVQ
         Is1m7ROJqjwHQklsHgWAYs3daEfx7XHTqHrYT0qlBMD7ZLIPF7/GaD0vnSBR8GIxffqs
         uwMky4QRnl6v1PUjlk1HCJHMPA1ILomAWcsvtMmnEEDyECYgAhyUNqk4WzfYwhiLrSjG
         aBJG3s83NMAuYcZyCTXDehDYQCVI9rqsxnRzI9R2TyvPOpO+GkiBXBFj3UfQ/fu91tfC
         jQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aQfNFiJgGsv9UgTyWY3tUqj/qF9PNqN3A4wyBds+Y/Y=;
        b=GvJUo9rZDRaWOeou28wnXXLce/p2o+JKlCetIOniscpVwtENVRUIoYIaBfla+JBXuA
         N+PZh5BZ50J3nuCzC6tNZpE+42fJKI3ekfqILm09s+SgORqp96TCI2iKdvogMvpXSJFm
         KTdaUJi8UAKL7uAu3MEQ4vvtDvUtL1X/kn4NBfWw3RaMjtj01cJ6OtfeqBaiMXcVJHRJ
         B5M4ejOR837K8lwNOWF2S1j7vBe3rwE1o3hcNoKm05UFMNqxCLHNLQntgPAIgEqzD/vI
         fnW65Tk42vzOY7M3O46tFkgJ8FVCB+OVqGNb40rSJzV0e9rK7bchFOVY1xJnkvcQez6v
         P1cw==
X-Gm-Message-State: APjAAAUtHRzcN1t+17vHpaliwpxv9bzSIcLA5VYtG+EsVTOxyNUI4dV8
        5PTyuNhNUr1no52FRUaw2J1S7w==
X-Google-Smtp-Source: APXvYqyJbaRTnQola4b6eYJh8U7ie0ZzV/HGXTrlrS53rgawi0WhJg+42OgkqSTdv6HOjFzxYcwY/w==
X-Received: by 2002:a5d:46d1:: with SMTP id g17mr36583242wrs.160.1563968241541;
        Wed, 24 Jul 2019 04:37:21 -0700 (PDT)
Received: from localhost (static.20.139.203.116.clients.your-server.de. [116.203.139.20])
        by smtp.gmail.com with ESMTPSA id u13sm54814133wrq.62.2019.07.24.04.37.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 04:37:20 -0700 (PDT)
Date:   Wed, 24 Jul 2019 13:37:20 +0200
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com
Subject: Re: [Drbd-dev] [PATCH 2/2] block: drbd: Fix a possible null-pointer
 dereference in is_valid_state()
Message-ID: <20190724113720.gis6v2ziltmmv4zt@rck.sh>
References: <20190724034926.28755-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724034926.28755-1-baijiaju1990@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 24, 2019 at 11:49:26AM +0800, Jia-Ju Bai wrote:
> In is_valid_state(), there is an if statement on line 839 to check
> whether nc is NULL:
>     if (nc)
> 
> When nc is NULL, it is used on line 880:
>     (nc->verify_alg[0] == 0)
> 
> Thus, a possible null-pointer dereference may occur.
> 
> To fix this bug, nc is also checked on line 880.
> 
> This bug is found by a static analysis tool STCheck written by us.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/block/drbd/drbd_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
> index eeaa3b49b264..3cf477e9cf6a 100644
> --- a/drivers/block/drbd/drbd_state.c
> +++ b/drivers/block/drbd/drbd_state.c
> @@ -877,7 +877,7 @@ is_valid_state(struct drbd_device *device, union drbd_state ns)
>  		rv = SS_CONNECTED_OUTDATES;
>  
>  	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
> -		 (nc->verify_alg[0] == 0))
> +		 (nc && nc->verify_alg[0] == 0))
>  		rv = SS_NO_VERIFY_ALG;

AFAIK it is "impossible" to reach such a DRBD state without having a
valid net conf. Anyways, a check is a good idea, but the logic is wrong,
I would propose something like this:

 	else if ((ns.conn == C_VERIFY_S || ns.conn == C_VERIFY_T) &&
-		 (nc->verify_alg[0] == 0))
+		 (!nc || nc->verify_alg[0] == 0))
 		rv = SS_NO_VERIFY_ALG;

Regards, rck
