Return-Path: <SRS0=pYcy=YR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE73BCA9EAF
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6C4205F4
	for <linux-block@archiver.kernel.org>; Thu, 24 Oct 2019 17:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="JDElgzDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394020AbfJXR1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Oct 2019 13:27:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37786 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394016AbfJXR1n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Oct 2019 13:27:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id y5so15557616pfo.4
        for <linux-block@vger.kernel.org>; Thu, 24 Oct 2019 10:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BxP1cL6VQbmMqYHp3ibPVmUugc5Wzw3DmCG39KVxlU=;
        b=JDElgzDgumMkvHpM6LwmgcwlnDwm1lYF/FXZh6IeuafwxGNoPnDbDdbsdLGHUR3wCS
         usURHXYYYpyO3YLk6Q3bG3K81eVEqCydPJh0/8KJwHEqvmFIkLGSYeb6i5vkDi25UUjG
         kYOEdYw5x5r9TBtTHsjMyy1zrXBm8DFXgBN0VgGkRuwfVDd0SSfBm2JzmsnZJRXX4uEq
         LI6BdjAewi4FErfJ/4hCi/KOACcs6Veyqqbwlh9+VXKoNPMmnVAv2WxxQPuSjbHABocT
         iJaS0DpbkD2tXh5jkHLMuckzGnAol6vc6ezbD/Czkq36v7uXllNuZ2IasCfFNeqLnixl
         HnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BxP1cL6VQbmMqYHp3ibPVmUugc5Wzw3DmCG39KVxlU=;
        b=rR351+hw2tXldGO0FCZoRaHxwGSdUVin8O+5c2Cv5c3TLh1YaVY4/rguoRbCaab8hQ
         DAS0gLN9FZ49WnynkcSg733QHDvPuuLWMIUYf2MW87GKyjWikQwpcaUR7BY0xNfwogGF
         xjZWRLqci9Wd24Fu14yV5IpTXi9ghb8HLA8lznPEMYjs6fOIhbldHPOeAbuMTyvK/Hf/
         YXdqs1ahbzT9AVAwAYubf1VnVzEjbAzJzwkZaOIFNSVwipRib1lZPxJHMy9K8jWj1UnK
         nrhc3LucaeJKxwhk+0vBnPyCZRXO6CYInzUW28vhzuaU76h/b5K55Tn7zx+Fq2xQu0B2
         VBvA==
X-Gm-Message-State: APjAAAVkT2jzxrXtizcMJJFDm91oMTGr9CrXUKsqXPwNsa9D+KIxagPN
        AzHN014wpUuBy/h/CiNuRLhyNw==
X-Google-Smtp-Source: APXvYqxk8cc/Eyo3QSMlI4dY/nkQLzLXDXCr5R45TJEvYxtvVSeKnV4s/iNyJcKeOTDkHgv+Dj3GSw==
X-Received: by 2002:a17:90a:a417:: with SMTP id y23mr8286434pjp.126.1571938062747;
        Thu, 24 Oct 2019 10:27:42 -0700 (PDT)
Received: from vader ([2601:602:8b80:8e0:e6a7:a0ff:fe0b:c9a8])
        by smtp.gmail.com with ESMTPSA id w14sm29995486pge.56.2019.10.24.10.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 10:27:42 -0700 (PDT)
Date:   Thu, 24 Oct 2019 10:27:41 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH blktests 1/2] Move and rename uptime_s()
Message-ID: <20191024172741.GA137052@vader>
References: <20191021225719.211651-1-bvanassche@acm.org>
 <20191021225719.211651-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021225719.211651-2-bvanassche@acm.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 21, 2019 at 03:57:18PM -0700, Bart Van Assche wrote:
> Make it easy to use the uptime_s() function from block tests.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  common/multipath-over-rdma | 9 +--------
>  common/rc                  | 9 +++++++++
>  tests/nvmeof-mp/rc         | 2 +-
>  tests/srp/014              | 2 +-
>  tests/srp/rc               | 2 +-
>  5 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
> index 65ebb7b7f5f7..545a81e8c18e 100644
> --- a/common/multipath-over-rdma
> +++ b/common/multipath-over-rdma
> @@ -129,19 +129,12 @@ held_by() {
>  	done
>  }
>  
> -# System uptime in seconds.
> -uptime_s() {
> -	local a b
> -
> -	echo "$(</proc/uptime)" | { read -r a b && echo "${a%%.*}"; }
> -}
> -
>  # Sleep until either $1 seconds have elapsed or until the deadline $2 has been
>  # reached. Return 1 if and only if the deadline has been met.
>  sleep_until() {
>  	local duration=$1 deadline=$2 u
>  
> -	u=$(uptime_s)
> +	u=$(_uptime_s)
>  	if [ $((u + duration)) -le "$deadline" ]; then
>  		sleep "$duration"
>  	else
> diff --git a/common/rc b/common/rc
> index 41aee3aaa735..c00f2fe1f463 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -246,3 +246,12 @@ _test_dev_is_partition() {
>  _filter_xfs_io_error() {
>  	sed -e 's/^\(.*\)64\(: .*$\)/\1\2/'
>  }
> +
> +# System uptime in seconds.
> +_uptime_s() {
> +	local a b
> +
> +	echo "$(</proc/uptime)" | {

What's wrong with cat /proc/uptime? Or even better,

  { read ... } < /proc/uptime

> +		read -r a b && echo "$b" >/dev/null && echo "${a%%.*}";

What's the point of the echo "$b" here? Seems like this could all be
condensed to:

  { read -r s && echo "${s%%.*}" } < /proc/uptime

But that's more cryptic than it needs to be. Can we just do:

  awk '{ print int($1) }' /proc/uptime
