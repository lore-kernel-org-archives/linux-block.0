Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C1C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 07:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EA32171F
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 07:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="fhapWM5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfCMHIE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 03:08:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43131 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfCMHIE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 03:08:04 -0400
Received: by mail-pf1-f195.google.com with SMTP id q17so717067pfh.10
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 00:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gtgKwzDiU7i2q9F1y1Ic4n3rSDyXIp79a1l1/578zbA=;
        b=fhapWM5MarbwNDkji5Ar42nLL3k4n1PZet19xpvGl61g2urm1HIaa+7X4ROV4uE1IV
         HylWqCdo4z/Bck082kkhoA951ZZJrQjL0IC4FZHOCsDIK2LMYMIWJKNOs+9qnSmbZ3Et
         biKX5xwpAJMwOeLtQY/ibqnSqXD6QexByzzPguQ0RWl1n5J5eWQdt0BdN5rxQhS44zQZ
         8nsxvi/WsuAwTRRbCdqnwuWzam2UD9G7DORKQ6GUnq8acnwR4mego85z6WtTSm++Kr+j
         pCHhFv9raeYOPDyjApRqAOK2g2hIWDY7UNPCp7km9VhRPYUOmqVNwgmG3sMXdVNcY7iD
         962Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gtgKwzDiU7i2q9F1y1Ic4n3rSDyXIp79a1l1/578zbA=;
        b=a8AQVcmyE/8W2DPrgkjPuZkwGNu45p6Uk0G38WVQG/ge/df4lqHRbuuyF9psuhMcuY
         Kn/HX0npBPOcMWMdNJDsk0sW26w/Uxt+TaxtMOujY3gckt6+KjD/f9DCpp4ZqZuNClkr
         jMOaoo254qWgSTfj8phDTzeg8NEoxOpmOhk9mtFwA/eH4SQXxEXSuhtNHAnD587F9Bgx
         LL5Ul+txJdf9l6y030EwXT+QjaNZc9tQkVdjCAW2EjPzZDdLAOqKXFKCTN7uM9oowS5g
         frJ4IYPFBUREqr8HFD0VygS4q2H3Mmbv+4SwfQOQ8CZ0fc7Q4KxSYDQAdUNnqGobJLPu
         dnJQ==
X-Gm-Message-State: APjAAAXBIY6mZCgWWpfyufL/seLbrBieEAVb8xTWp82VhNVcGJ+/21vG
        0GBcVnUDASYhVLNp7LjQ2oWm+Q==
X-Google-Smtp-Source: APXvYqxrE0azRKGn/zUi7EtYOxMLVEcL0YqGkfoM01Eu6sIWZ7F624UkBgNb8xDeBGENNBTctUp67Q==
X-Received: by 2002:a63:4563:: with SMTP id u35mr14345942pgk.417.1552460882965;
        Wed, 13 Mar 2019 00:08:02 -0700 (PDT)
Received: from vader ([2601:602:8b00:55d3:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id s6sm14639115pfe.37.2019.03.13.00.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 00:08:02 -0700 (PDT)
Date:   Wed, 13 Mar 2019 00:08:00 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Xiao Liang <xiliang@redhat.com>
Cc:     linux-block@vger.kernel.org, osandov@fb.com
Subject: Re: [PATCH blktests] Fix checking multiple modules error in
 _have_modules()
Message-ID: <20190313070800.GB11825@vader>
References: <20190313070511.8283-1-xiliang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313070511.8283-1-xiliang@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Mar 13, 2019 at 03:05:11PM +0800, Xiao Liang wrote:

Applied, thanks!

> Signed-off-by: Xiao Liang <xiliang@redhat.com>
> ---
>  common/rc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 0c354a2..71e27c3 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -33,7 +33,7 @@ _have_modules() {
>  	local module
>  
>  	for module in "$@"; do
> -		if ! modprobe -n -q "$1"; then
> +		if ! modprobe -n -q "$module"; then
>  			missing+=("$module")
>  		fi
>  	done
> -- 
> 2.17.2
> 
